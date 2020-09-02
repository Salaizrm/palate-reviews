users = [
  {username: "bob", email: "bob@gmail.com", password: "bob1234"},
  {username: "ted", email: "ted@gmail.com", password: "ted1234"}
]

users.each do |u|
  User.create(u)
end
