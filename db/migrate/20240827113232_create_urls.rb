class CreateUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :urls do |t|
      t.string :output_url, unique: true, null: false, index: true
      t.string :source_url, null: false

      t.timestamps
    end
  end
end
