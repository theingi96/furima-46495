class Prefecture < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '北海道' },
    { id: 3, name: '青森県' },
    { id: 4, name: '岩手県' },
    # ...
    { id: 48, name: '沖縄県' }
  ]

  include ActiveHash::Associations
  has_many :items
end
