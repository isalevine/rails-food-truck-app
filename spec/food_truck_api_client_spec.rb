require 'rails_helper'

RSpec.describe FoodTruckApiClient do
  describe "#call" do
    let(:client) { FoodTruckApiClient.new }
    let(:time)   { DateTime.parse('09 Aug 2020 11:02:03 PM') }

    context "success" do
      it "returns a JSON-parseable res.body String" do
        res = client.call(time: time)
        expect(res).to be_a(String)

        json = JSON.parse(res)
        expect(json).to be_an(Array)
      end
    end
  end
end
