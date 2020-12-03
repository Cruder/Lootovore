# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :characters do
      primary_key :id
      column :name, String, null: false, unique: true
      column :klass, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
