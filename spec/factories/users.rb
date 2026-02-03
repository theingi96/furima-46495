FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.first_name }
    email                 { Faker::Internet.email }
    password              { 'abc123' }
    password_confirmation { password }
    first_name            { '山田' }
    last_name             { '太郎' }
    first_name_kana       { 'ヤマダ' }
    last_name_kana        { 'タロウ' }
    birthday              { '1990-01-01' }
  end
end
