class RemoveCategoryNameAttribute < ActiveRecord::Migration
  def change
  	remove_column :categories, :category_name, :string
  end
end
