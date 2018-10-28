require 'rails_helper'

describe Cart do
  subject { Cart.new({"1" => 2, "2" => 3}) }

  describe "#count_all" do
    it "calculates the total number of items it holds" do
      expect(subject.count_all).to eq(5)
    end
  end

  describe "#count_of" do 
    it "calculates the total number of an individual items" do 
        expect(subject.count_of("1")).to  eq(2)
    end 
end 

  describe "#add_item" do
    it "adds an item to its contents" do
      subject.add_item(1)
      subject.add_item(2)

      expect(subject.contents).to eq({"1" => 3, "2" => 4})
    end
  end
end