class AddViewsCounterToShortLinks < ActiveRecord::Migration[6.1]
  def change
    add_column :short_links, :views_counter, :integer, null: false, default: 0
    #Ex:- :default =>''
  end
end
