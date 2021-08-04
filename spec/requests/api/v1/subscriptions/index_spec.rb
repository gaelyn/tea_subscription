require 'rails_helper'

RSpec.describe 'See Customer Subscriptions' do
  describe 'happy paths' do
    it "can show all subscriptions for a customer" do
      customer = create(:customer)
      5.times do
        create(:subscription, customer_id: customer.id)
      end

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
      expect(subs[:data].first[:attributes]).to have_key(:frequency)
    end
  end
end
