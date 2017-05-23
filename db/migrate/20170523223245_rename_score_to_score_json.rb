class RenameScoreToScoreJson < ActiveRecord::Migration
  def change
    rename_column :games, :score, :score_json
  end
end
