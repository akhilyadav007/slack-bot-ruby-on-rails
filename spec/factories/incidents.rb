FactoryBot.define do
  factory :incident do
    title { "login_issue" }
    description { "fail_to_login" }
    severity { "sev0" }
    status {"open"}
    association :app, factory: :app
    association :reporter, factory: :user
    association :resolver, factory: :user
  end
end
