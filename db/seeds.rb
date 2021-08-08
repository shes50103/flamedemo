if Post.count == 0
  10.times {
    a = Post.create(
      name: Faker::Name.unique.name,
      body: Faker::Lorem.paragraphs
    )
    a.comments.create(body: Faker::Lorem.paragraphs)
  }
end
