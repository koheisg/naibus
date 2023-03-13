class CreateRefUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :ref_urls do |t|
      t.references :chat_thread, null: false, foreign_key: true
      t.string :url
      t.text :title
      t.text :body

      t.timestamps
    end
  end
end
