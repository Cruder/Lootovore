# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :equipments do
      primary_key :id
      column :name, String, null: true
      column :image, String, null: true
      column :quality, String, null: true

      column :item_id, Integer, null: false, unique: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
