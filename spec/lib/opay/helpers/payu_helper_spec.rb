require 'spec_helper'

module Opay
  describe Helpers::PayuHelper, type: :helper do

    before do
      # stub(request).env { {"HTTP_USER_AGENT" => "Some String"} }
    end

    context 'form tag' do
      it 'creates form tag' do
        order = Order.create! name: 'first order', amount: 1000 # 10 zł

        # helper.payu_form_for(order) do |f|
        #   f.payment_info first_name: 'Jan', last_name: 'Kowalski', email: 'kowalski@gmail.com', desc: 'Test payment', client_ip: '127.0.0.1'
        # end.should be true

        html = helper.payu_form_for(order) do |f|
          f.payment_info first_name: 'Jan', last_name: 'Kowalski', email: 'kowalski@gmail.com', desc: 'Test payment', client_ip: '127.0.0.1'
        end

        html.should have_css('form[action="https://www.platnosci.pl/paygw/UTF/NewPayment"]')
        html.should have_css('form[method="post"]')

        html.should have_css('input[name="first_name"]')
        html.should have_css('input[name="last_name"]')
        html.should have_css('input[name="email"]')

        html.should have_css('input[name="pos_id"]')
        html.should have_css('input[name="pos_auth_key"]')
        html.should have_css('input[name="session_id"]')

        html.should have_css('input[name="amount"]')
        html.should have_css('input[name="desc"]')
        html.should have_css('input[name="client_ip"]')
        html.should have_css('input[name="js"]')
      end
    end

  end
end