class AddIndexToShortLinksSlug < ActiveRecord::Migration[6.1]
  def change
    add_index :short_links, :slug
    #Ex:- add_index("admin_users", "username")
  end
end
