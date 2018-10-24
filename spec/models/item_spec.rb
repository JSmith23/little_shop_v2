require 'rails_helper'

describe Item, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :thumbnail}
    it { should validate_presence_of :price}
    it { should validate_presence_of :inventory}
    it { should validate_presence_of :description}
  end

  describe "Relationshios" do 
    it { should belong_to(:user)}
  end 
end