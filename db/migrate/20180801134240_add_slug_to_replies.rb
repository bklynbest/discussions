class AddSlugToReplies < ActiveRecord::Migration[5.0]
  def change
    add_column :replies, :slug, :string
  end
end
