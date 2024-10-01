# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
puts "Clearing existing data..."
Vote.destroy_all
Comment.destroy_all
Link.destroy_all
User.destroy_all

# Create the first user
puts "Creating the first user..."
first_user = User.create!(
  email: 'user@example.com'
)

# Create links
puts "Creating links..."
links = [
  { title: "The Great Pyramid of Giza", url: "https://en.wikipedia.org/wiki/Great_Pyramid_of_Giza" },
  { title: "The Hanging Gardens of Babylon", url: "https://en.wikipedia.org/wiki/Hanging_Gardens_of_Babylon" },
  { title: "The Colosseum", url: "https://en.wikipedia.org/wiki/Colosseum" },
  { title: "Machu Picchu", url: "https://en.wikipedia.org/wiki/Machu_Picchu" },
  { title: "The Great Wall of China", url: "https://en.wikipedia.org/wiki/Great_Wall_of_China" },
  { title: "Petra", url: "https://en.wikipedia.org/wiki/Petra" },
  { title: "The Parthenon", url: "https://en.wikipedia.org/wiki/Parthenon" },
  { title: "Angkor Wat", url: "https://en.wikipedia.org/wiki/Angkor_Wat" },
  { title: "Stonehenge", url: "https://en.wikipedia.org/wiki/Stonehenge" },
  { title: "Easter Island", url: "https://en.wikipedia.org/wiki/Easter_Island" }
]

created_links = links.map { |link_data| Link.create!(link_data.merge(user: first_user)) }

# Add comments to links
puts "Adding comments..."
comments = [
  "Fascinating piece of ancient engineering!",
  "I've always wanted to visit this place.",
  "The historical significance is mind-blowing.",
  "It's amazing how well-preserved this site is.",
  "I wonder how they built this without modern technology.",
  "The cultural impact of this site cannot be overstated.",
  "This is definitely on my bucket list.",
  "The mysteries surrounding this place are intriguing.",
  "I learned so much from this article!",
  "It's crucial that we preserve these historical sites."
]

created_links.each do |link|
  2.times do
    Comment.create!(
      content: comments.sample,
      link: link,
      user: first_user
    )
  end
end

# Add votes to links and comments
puts "Adding votes..."
created_links.each do |link|
  Vote.create!(
    votable: link,
    value: [-1, 1].sample,
    user: first_user
  )

  link.comments.each do |comment|
    Vote.create!(
      votable: comment,
      value: [-1, 1].sample,
      user: first_user
    )
  end
end

# Create additional users and their votes
5.times do |i|
  user = User.create!(email: "user#{i+2}@example.com")
  
  created_links.sample(5).each do |link|
    Vote.create!(
      votable: link,
      value: [-1, 1].sample,
      user: user
    )
  end

  Link.all.sample(3).each do |link|
    comment = link.comments.sample
    if comment
      Vote.create!(
        votable: comment,
        value: [-1, 1].sample,
        user: user
      )
    end
  end
end

puts "Seed data created successfully!"
