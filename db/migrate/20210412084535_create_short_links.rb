class CreateShortLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :short_links do |t|
      t.string :slug, unique: true
      t.references :user, null: true, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
