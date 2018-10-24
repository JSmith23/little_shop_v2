require_relative '../app/models/user'

users = [
  { name: "Ben Winch", address: "123 Main Street", city: "Denver", state: "CO", email: "benwinch@email.com", password: "BWinch123", password_confirmation: "BWinch123", role: 0 },
  { name: "Bill Kerwin", address: "123 Main Street", city: "Denver", state: "CO", email: "billkerwin@email.com", password: "BKerwin123", password_confirmation: "BKerwin123", role: 0 },
  { name: "Bob Bogle", address: "123 Main Street", city: "Denver", state: "CO", email: "bobbogle@email.com", password: "BBogle123", password_confirmation: "BBogle123", role: 0 },
  { name: "Brian James", address: "123 Main Street", city: "Denver", state: "CO", email: "brianjames@email.com", password: "BJames123", password_confirmation: "BJames123", role: 0 },
  { name: "Carol Brandon", address: "123 Main Street", city: "Denver", state: "CO", email: "carolbrandon@email.com", password: "CBrandon123", password_confirmation: "CBrandon123", role: 0 },
  { name: "Christina Rau", address: "123 Main Street", city: "Denver", state: "CO", email: "christinarau@email.com", password: "CRau123", password_confirmation: "CRau123", role: 0 },
  { name: "Cierra Fisher", address: "123 Main Street", city: "Denver", state: "CO", email: "cierrafisher@email.com", password: "CFisher123", password_confirmation: "CFisher123", role: 0 },
  { name: "Courtney Johnston", address: "123 Main Street", city: "Denver", state: "CO", email: "courtneyjohston@email.com", password: "CJohnston123", password_confirmation: "CJohnston123", role: 0 },
  { name: "Doug Cannon", address: "123 Main Street", city: "Denver", state: "CO", email: "dougcannon@email.com", password: "DCannon123", password_confirmation: "DCannon123", role: 1 },
  { name: "Glenn Russell", address: "123 Main Street", city: "Denver", state: "CO", email: "glennrussell@email.com", password: "GRussell123", password_confirmation: "GRussell123", role: 1 },
  { name: "Graham Shopshire", address: "123 Main Street", city: "Denver", state: "CO", email: "grahamshopshire@email.com", password: "GShopshire123", password_confirmation: "GShopshire123", role: 1 },
  { name: "James Thane", address: "123 Main Street", city: "Denver", state: "CO", email: "jamesthane@email.com", password: "JThane123", password_confirmation: "JThane123", role: 1 },
  { name: "Jeffrey Keeten", address: "123 Main Street", city: "Denver", state: "CO", email: "jeffreykeeten@email.com", password: "JKeeten123", password_confirmation: "JKeeten123", role: 1 },
  { name: "Jon Corelis", address: "123 Main Street", city: "Denver", state: "CO", email: "joncorelis@email.com", password: "JCorelis123", password_confirmation: "JCorelis123", role: 1 },
  { name: "Joseph Naus", address: "123 Main Street", city: "Denver", state: "CO", email: "josephnaus@email.com", password: "JNaus123", password_confirmation: "JNaus123", role: 2 },
  { name: "Michael Finocchiaro", address: "123 Main Street", city: "Denver", state: "CO", email: "michaelfinocchiaro@email.com", password: "MFinocchiaro123", password_confirmation: "MFinocchiaro123", role: 2 }
]

items = [
  
]

users.each do |u|
  User.create(u)
end
