FactoryBot.define do
  factory :app do
    slack_id { "A056YTMCC1X" }
    auth_user_id  { 'U055N4M9GCT' }
    scope  { "commands,channels:manage,channels:join" }
    team_id { "T055QNN4L7N" }
    team_name {  "Rootly incidents" }
    access_token { "xoxb-5194770156260-5224183030611-F2Mytl5uo8WalwDH4kbdKSyh" }
  end
end 