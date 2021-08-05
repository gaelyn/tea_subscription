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

      headers = {
        'Content-Type': "application/json"
      }

      body = {
        "status": 1
      }

      patch "/api/v1/customers/#{customer.id}/subscriptions/#{sub_2.id}", headers: headers, params: body.to_json
      sub = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(sub[:data][:id].to_i).to eq(sub_2.id)
      expect(sub[:data][:attributes][:status]).to eq("inactive")
    end
  end

  describe 'sad paths/edge cases' do
    it "shows error if invalid status given" do
      customer = create(:customer)
      sub_1 = create(:subscription, customer_id: customer.id)
      sub_2 = create(:subscription, customer_id: customer.id)
      sub_3 = create(:subscription, customer_id: customer.id)

      headers = {
        'Content-Type': "application/json"
      }

      body = {
        "status": 10
      }

      patch "/api/v1/customers/#{customer.id}/subscriptions/#{sub_2.id}", headers: headers, params: body.to_json
      sub = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(sub[:errors]).to eq("'10' is not a valid status")
    end
  end
end
