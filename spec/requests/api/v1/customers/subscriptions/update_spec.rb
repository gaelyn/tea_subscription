require 'rails_helper'

RSpec.describe 'Update Subscriptions' do
  describe 'happy paths' do
    it "can cancel a customers subscription" do
      customer = create(:customer)
      sub_1 = create(:subscription, customer_id: customer.id)
      sub_2 = create(:subscription, customer_id: customer.id)
      sub_3 = create(:subscription, customer_id: customer.id)
      expect(sub_1.status).to eq("active")
      expect(sub_2.status).to eq("active")
      expect(sub_3.status).to eq("active")

      patch "/api/v1/customers/#{customer.id}/subscriptions/#{sub_2.id}", params: {status: 1}
      sub = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(sub[:data][:id].to_i).to eq(sub_2.id)
      expect(sub[:data][:attributes][:status]).to eq("inactive")
    end
  end
end
