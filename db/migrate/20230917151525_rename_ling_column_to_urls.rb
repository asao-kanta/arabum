class RenameLingColumnToUrls < ActiveRecord::Migration[7.0]
  def change
    rename_column :urls, :ling, :link
  end
end
