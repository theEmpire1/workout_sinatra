class CreateWorkoutsTable < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string :name
      t.string :description
      t.integer :rating
      t.integer :upvotes
      t.integer :downvotes
    end
  end
end
