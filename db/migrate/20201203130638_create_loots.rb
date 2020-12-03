# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :loots do
      primary_key :id
      column :date, DateTime, null: false
      column :nb_vote, Integer, null: false
      column :note, String, null: false

      foreign_key :character_id, :characters, null: false
      foreign_key :equipment_id, :equipments, null: false
      foreign_key :wish_id, :wishes, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
