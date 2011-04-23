# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Chris Humphreys"
  user.email                 "chris@humphreys.com"
  user.password              "stuffit"
  user.password_confirmation "stuffit"
end
