class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string     :code
      t.text       :description
      t.string      :name,     :limit => 64, :null => false, :default => ""
      t.string      :manufacturer,     :limit => 64, :null => false, :default => ""
      t.decimal     :price,   :precision => 12, :scale => 2
      t.decimal     :price_3x, :precision => 12, :scale => 2
      t.decimal     :price_30_days, :precision => 12, :scale => 2
      t.decimal     :price_cash, :precision => 12, :scale => 2
      t.decimal     :rev_icms18, :precision => 12, :scale => 2
      t.decimal     :rev_icms12, :precision => 12, :scale => 2
      t.integer     :stock_in
      t.integer     :stock_out
      t.timestamps
      t.datetime   :deleted_at
    end

    add_index :products, :deleted_at
  end

  def self.down
    drop_table :products
  end
end
