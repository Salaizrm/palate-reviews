class CreateReview < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :users, index: true
      t.string :title
      t.string :rating
      t.string :content

      t.timestamps
    end
  end
end
