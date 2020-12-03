# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :wishes do
      primary_key :id
      column :name, String, null: false, unique: true
      column :rank, Integer, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
