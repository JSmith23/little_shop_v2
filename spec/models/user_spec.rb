require 'rails_helper'

describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip}
    it { should validate_presence_of :email}
    it { should validate_uniqueness_of :email}
    it { should validate_presence_of :password}
    it { should validate_confirmation_of :password}
    it { should validate_presence_of :role}
  end

  describe "Relationships" do
    it { should have_many(:items)}
    it { should have_many(:orders)}
  end

  describe "Methods" do

    it 'can toggle the enabled attribute' do
      user = create(:user)
      expect(user.enabled).to eq(true)
      user.toggle_enabled
      expect(user.enabled).to eq(false)
    end

  end
end
