FactoryBot.define do
  factory :resume do
    title { Faker::Job.title }
    active { true }
    association :user
  end
end