class CreateLinks < ActiveRecord::Migration[7.2]
  def change
    create_table :links do |t|
      t.string :title
      t.string :url, default: "https://"
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
