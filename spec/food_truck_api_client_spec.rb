require 'rails_helper'

RSpec.describe FoodTruckApiClient do
  describe "#call" do
    let(:client) { FoodTruckApiClient.new }

    context "success" do
      it "returns a String that is JSON-parseable into an Array" do
        time = DateTime.parse('09 Aug 2020 11:02:03 PM')
        res = client.call(time: time)
        expect(res).to be_a(String)

        json = JSON.parse(res)
        expect(json).to be_an(Array)
      end
    end

    context "failure" do
      it "raises an error when passed an un-parseable Time argument" do
        time = 'this is not a valid time'
        expect {client.call(time: time) }.to raise_error  # TODO: create Exceptions module to define custom errors
      end
    end
  end
end
