Factory.define :user do |u|
  u.sequence(:fb_uid){ |n| n.to_s }
  u.sequence(:name){ |n| "User #{n}" }
  u.sequence(:email){ |n| "email#{n}@test.com" }
  u.sequence(:fb_username){ |n| "user#{n}" }
end
