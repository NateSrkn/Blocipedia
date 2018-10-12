class AddSlugToWikis < ActiveRecord::Migration[5.2]
  def change
    add_column :wikis, :slug, :string
  end
end
