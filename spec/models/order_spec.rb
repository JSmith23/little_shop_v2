require 'rails_helper'

describe Order, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :status}
  end

  describe "Relationships" do
    it { should belong_to :user}
  end
end