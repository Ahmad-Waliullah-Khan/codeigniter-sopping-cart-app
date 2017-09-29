<?php 

class Cart extends CI_Controller {

	public $paypal_data;
	public $tax;
	public $shipping;
	public $toal = 0;
	public $grand_total;

	/*
	* Cart Index
	*/

	public function index ()

	{
		$data['main_content'] = 'cart';
		$this->load->view('layouts/main', $data);
	}

	/*
	* Add To Cart
	*/

	public function add() {
		//Item Data
		$data=array (
				'id' => $this->input->post('item_number'),
				'qty' => $this->input->post('qty'),
				'price' => $this->input->post('price'),
				'name' => $this->input->post('title')
			);

		//print_r($data);die;

		/*
		* Insert into Cart
		*/

		$this->cart->insert($data);

		redirect('products');
	}

	/*
	* Update Cart
	*/

	public function update($in_cart=null) {
		$data = $_POST;
		$this->cart->update($data);
 
		//Show Cart Page
		redirect('cart','refresh');
	}



	/*
	* Process Form (Paypal)
	*/

	
	public function process() {

		if($_POST) {

			//print_r($this->input->post('item_name')); die(); 
			foreach ($this->input->post('item_name') as $key => $value) {

				//Get tax & shipping from config
				$this->tax = $this->config->item('tax');
				$this->shipping = $this->config->item('shipping');

				$item_id = $this->input->post('item_code') [$key];
				$product = $this->Product_model->get_product_details($item_id);

				//Asssign Data to PayPal
				$this->paypal_data .= '&L_PAYMENTREQUEST_0_NAME'.$key.'='.urlencode($product->title);
				$this->paypal_data .= '&L_PAYMENTREQUEST_0_NUMBER'.$key.'='.urlencode($item_id);
				$this->paypal_data .= '&L_PAYMENTREQUEST_0_AMT'.$key.'='.urlencode($product->price);
				$this->paypal_data .= '&L_PAYMENTREQUEST_0_QTY'.$key.'='.urlencode($$this->input->post('item_qty') [$key]);

				//Price x Quantity

				$subtotal = ($product->price * $this->input->post('item_qty') [$key]);
				$this->total = $this->total + $subtotal;

				$paypal_product['items'][] = array(
								'itm_name' =>$product->title,
								'itm_price' =>$product->price,
								'itm_code' => $item_id,
								'itm_qty' => $this->input->post('item_qty') [$key]

					);

				//Create Order Array
				$order_data = array(
					'product_id' => $item_id,
					'user_id' => $this->session->userdata('user_id'),
					'transaction_id' => 0,
					'qty' => $this->input->post('item_qty')[$key],
					'price' => $subtotal,
					'address' =>$this->input->post('address'),
					'address2' =>$this->input->post('address2'),
					'city' => $this->input->post('city'),
					'state' => $this->input->post('state'),
					'zipcode' => $this->input->post('zipcode')
					);

				//Add Order Data
				$this->Product_model->add_order($order_data);
			}

			//Get Grand Total
			$this->grand_total = $this->total + $this->tax + $this->shipping;

			//Create Array of Costs
			$paypal_product['assets'] = array (
				'tax_total' 	=> $this->tax,
				'shipping_cost' => $this->shipping,
				'grand_total' 	=> $this->total
				);

			//Session Array for Later

			$_SESSION["paypal_products"] = $paypal_products;

			//Send Paypal Params
			$padata = '&METHOD=SetExpressCheckOut'.
					'&RETURNURL='.urlencode($this->config->item('paypal_return_url')).
					'&CANCELURL='.urlencode($this->config->item('paypal_cancel_url')).
					'&PAYMENTREQUEST_0_PAYMENTACTION='.urlencode("SALE").
					$this->paypal_data.
					'&NOSHIPPING=0'.
					'&PAYMENTREQUEST_0_ITEMAMT='.urlencode($this->total).
					'&PAYMENTREQUEST_0_TAXAMT'.urlencode($this->tax).
					'&PAYMENTREQUEST_0_SHIPPINGAMT'.urlencode($this->shipping).
					'&PAYMENTREQUEST_0_AMT'.urlencode($this->grand_total).
					'&PAYMENTREQUEST_0_CURRENCYCODE'.urlencode($this->config->item('paypal_currency_code')).
					'&LOCALECODE=GB'. //Paypal pages to math the language on your website.
					'&LOGOING=http://www.deviantart.com/crazy4sunshine/avatar.png'. //Custom Logo
					'&CARTBORDERCOLOR=FFFFFF' .
					'&ALLOWNOTE=1'

			//Execute "SetExpressCheckOut"
			$httpparsedResponseAr = $this->paypal->PPHttpPost('SetExpressCheckOut', $padata, $this->config->item('paypal_api_username'), $this->config->item('paypal_api_password'), $this->config->item(''));

			//Respond according to message we receive from Paypal
			if("SUCESS" == strtoupper($httpparsedResponseAr["ACK"]) || "SUCCESSWITHWARNING" == s)
				//Redirect user to PayPal store with Token Received.
				$paypal_url = 'http://www.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token='.$httpparsedResponseAr
		}else {
			//Show error message
			print_r($httpparsedResponseAr);
			die(urlencode($httpparsedResponseAr["L_LONGMESSAGE0"]));
		}
		
	}
	


}