class AddNoticeTitleToNotice < ActiveRecord::Migration[7.0]
  def change
    add_column :notices, :notice_title, :string
  end
end
