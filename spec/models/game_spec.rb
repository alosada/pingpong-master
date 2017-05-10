require "rails_helper"

RSpec.describe Game, :type => :model do
  it "orders by last name" do
    lindeman = Game.create!()
    chelimsky = Game.create!()

    expect(Game.ordered_by_last_name).to eq([chelimsky, lindeman])
  end
end