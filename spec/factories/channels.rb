FactoryBot.define do
  factory :channel do
    association :incident, factory: :incident
    slack_id { "C056JS9HXK7" }
    name { "login_issue" }
    team_id { "T055QNN4L7N" }
  end
end
