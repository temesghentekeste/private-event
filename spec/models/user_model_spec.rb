require 'rails_helper' 


RSpec.describe "User Model Tests", type: :model  do
  subject { User.new }
  
  describe "validations" do
    it "should validate presence of name" do
      subject.username =  Faker::Name.name
      expect(subject.valid?).to be false 
    end
    it { should validate_presence_of (:name) }
    it { should validate_presence_of (:username) }
    it { should validate_presence_of (:email) }
    it { should validate_presence_of (:password) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:username).case_insensitive }

    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_length_of(:username).is_at_most(50) }
    it { is_expected.to validate_length_of(:email).is_at_most(105) }
  end

  describe "associations" do
    it { should have_many(:events).class_name("Event") }
    it { should have_many(:event_attendances).class_name("EventAttendance") }
    it { should have_many(:attended_events).through(:event_attendances) }
  end

end
