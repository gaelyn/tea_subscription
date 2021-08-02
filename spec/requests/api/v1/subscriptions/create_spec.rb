require 'rails_helper'

RSpec.describe 'Subscribe a Customer' do
  describe 'happy paths' do
    it "can create a new subscription for a customer" do
      customer = create(:customer)
      tea = create(:tea)

      headers = {
        'Content-Type': "application/json",
        'Accept': "application/json"
      }

      body = {
        "customer_id": customer.id,
        "tea_id": tea.id,
        "title": "#{customer.first_name}'s Subscription for #{tea.name}",
        "price": 12.05,
        "status": 0,
        "frequency": 1
      }

      post "/api/v1/customers/#{customer.id}/subscriptions", headers: headers, params: body.to_json
      sub = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      # expect(customer_subs[:data]).to be_a Hash
    end
  end
end