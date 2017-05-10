class AddScoreAndRankToUser < ActiveRecord::Migration
  def change
    add_column :users, :score, :integer, default: 0
    add_column :users, :rank, :string, default: 'N/A'
  end
end
