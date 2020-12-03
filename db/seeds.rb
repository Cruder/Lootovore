# frozen_string_literal: true

require_relative '../config/application'

Loot::Application.finalize!

wishes = Loot::Repos::WishRepo.new
equpments = Loot::Repos::EquipmentRepo.new

raw_items = JSON.parse(File.read('./data/items.json'))

current_time = Time.now

[
  { name: '+1 need', rank: 1, created_at: current_time, updated_at: current_time },
  { name: '+2 up mineur', rank: 2, created_at: current_time, updated_at: current_time },
  { name: '+3 autre spec.', rank: 3, created_at: current_time, updated_at: current_time },
  { name: '+3 autre spec', rank: 3, created_at: current_time, updated_at: current_time },
  { name: '+3 autres spec', rank: 3, created_at: current_time, updated_at: current_time },
  { name: 'Désenchantement', rank: 4, created_at: current_time, updated_at: current_time },
  { name: 'Hors ligne ou RCLootCouncil n\'est pas installé', rank: 5, created_at: current_time, updated_at: current_time },
  { name: 'Le candidat est en train de répondre, veuillez patienter.', rank: 5, created_at: current_time, updated_at: current_time },
  { name: 'Passer', rank: 5, created_at: current_time, updated_at: current_time },
  { name: 'Passer automatiquement', rank: 5, created_at: current_time, updated_at: current_time },
  { name: 'La banque', rank: 5, created_at: current_time, updated_at: current_time },
].then { |raw_wishes| wishes.upsert_many(raw_wishes) }

items = raw_items.map do |row|
  {
    name: row['name'],
    image: row['icon'],
    item_id: row['itemId'],
    quality: row['quality'].downcase,
    created_at: current_time,
    updated_at: current_time
  }
end

equpments.upsert_many(items)
