User.create(name: "Admin", password: "adminpassword", password_confirmation: "adminpassword", admin: true)
User.create(name: "First User", password: "firstpassword", password_confirmation: "firstpassword")
User.create(name: "Second User", password: "secondpassword", password_confirmation: "secondpassword")


User.first.articles << Article.create(title: "Hejsan hoppsan", body: "Jag gillar katter dom är mycket söta. Hejdå")
User.find(2).articles << Article.create(title: "Lorem Ipsum", body: "Hej hej hejsan hejsan hej hej hejsan hejsan")
