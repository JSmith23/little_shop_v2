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

  describe "Methods" do
    it 'should reduce the inventory by the argument' do
      @merchant = create(:user, :merchant)
      @item = Item.create( name: "Oval Link Chain Belt",	description: "Add something a little unexpected with this oval link chain belt that takes your look from casual to chic in an instant.", price:	36.26, thumbnail: "http://s7d2.scene7.com/is/image/JCPenney/DP0625201317031085M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", enabled: true, inventory: 100, user_id: @merchant.id )
      @item.reduce_inventory(25)

      expect(@item.inventory).to eq(75)
    end
  end
end
