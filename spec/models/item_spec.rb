require 'rails_helper'

describe Item, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :price}
    it { should validate_presence_of :inventory}
    it { should validate_presence_of :description}
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_numericality_of(:inventory).is_greater_than(0) }
  end

  describe "Relationships" do
    it { should belong_to(:user)}
    it { should have_many(:orders).through(:order_items)}
    it { should have_many(:order_items)}
  end
end
