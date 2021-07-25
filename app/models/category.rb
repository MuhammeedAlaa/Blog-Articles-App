class Category < ApplicationRecord
    before_save { self.name = name.downcase}
    validates :name, presence: true, length: { minimum: 3, maximum: 25 }, uniqueness: { case_sensitive: false }
end