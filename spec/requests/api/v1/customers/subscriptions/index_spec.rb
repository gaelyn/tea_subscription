require 'rails_helper'

RSpec.describe 'See Customer Subscriptions' do
  describe 'happy paths' do
    it "can show all subscriptions for a customer" do
      customer = create(:customer)
      sub_1 = create(:subscription, status: 0, customer_id: customer.id)
      sub_2 = create(:subscription, status: 0, customer_id: customer.id)
      sub_3 = create(:subscription, status: 1, customer_id: customer.id)
      sub_4 = create(:subscription, status: 0, customer_id: customer.id)
      sub_5 = create(:subscription, status: 1, customer_id: customer.id)

      get "/api/v1/customers/#{customer.id}/subscriptions"
      subs = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(subs[:data]).to be_an(Array)
      expect(subs[:data].first[:attributes][:customer_id]).to eq(customer.id)
      expect(subs[:data].first[:type]).to eq("subscription")
      expect(subs[:data].first[:attributes]).to have_key(:tea_id)
      expect(subs[:data].first[:attributes]).to have_key(:title)
      expect(subs[:data].first[:attributes]).to have_key(:price)
      expect(subs[:data].first[:attributes]).to have_key(:status)
      expect(subs[:data][2][:attributes][:status]).to eq("inactive")
      expect(subs[:data].first[:attributes]).to have_key(:frequency)
    end
  end

  describe 'sad paths/edge cases' do
    it 'shows error if customer does not exist' do
      customer = create(:customer)
      customer.id = 1

      get "/api/v1/customers/2/subscriptions"
      subs = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect(subs[:errors]).to eq("Cannot find customer")
    end

    it 'shows message if customer has no subscriptions' do
      customer = create(:customer)

      get "/api/v1/customers/#{customer.id}/subscriptions"
      subs = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(subs[:message]).to eq("No subscriptions found")
    end
  end
end
