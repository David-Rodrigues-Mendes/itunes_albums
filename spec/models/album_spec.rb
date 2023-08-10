require 'spec_helper'

RSpec.describe Album, type: :model do
  context "structure and validations" do
    it "has its required columns" do
      expect(subject).to have_db_column(:album_id)
      expect(subject).to have_db_column(:favorite)
    end

    it "validates its validatables" do
      expect(subject).to validate_presence_of(:album_id)
      expect(subject).to validate_uniqueness_of(:album_id)
    end
  end
end
