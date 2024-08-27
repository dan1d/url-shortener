class CreateUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :urls do |t|
      t.string :output_url, null: false
      t.string :source_url, null: false
      t.integer :visits, default: 0
      t.string :title

      t.timestamps
    end

    add_index :urls, :output_url, unique: true
  end
end
