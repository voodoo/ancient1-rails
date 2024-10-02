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
users = [
    { email: 'user@ancient.com' },
    { email: 'user2@ancient.com' },
    { email: 'user3@ancient.com' },
    { email: 'user4@ancient.com' },
    { email: 'user5@ancient.com' },
    { email: 'user6@ancient.com' },
    { email: 'user7@ancient.com' },
    { email: 'user8@ancient.com' },
    { email: 'user9@ancient.com' },
    { email: 'user10@ancient.com' },
]
created_users = users.map { |user| User.create!(email: user[:email]) }

time_ago = [
    2.hours.ago,
    6.hours.ago,
    24.hours.ago,
    1.week.ago,
    1.month.ago,
    1.year.ago
]

# Create links
puts "Creating links..."
links = [
  { title: "The Great Pyramid of Giza", url: "https://en.wikipedia.org/wiki/Great_Pyramid_of_Giza", description: "Ancient Egyptian wonder and the oldest of the Seven Wonders of the Ancient World." },
  { title: "The Hanging Gardens of Babylon", url: "https://en.wikipedia.org/wiki/Hanging_Gardens_of_Babylon", description: "Legendary tiered gardens said to have been in ancient Mesopotamia." },
  { title: "The Colosseum", url: "https://en.wikipedia.org/wiki/Colosseum", description: "Iconic amphitheater in Rome, symbol of the Roman Empire's power and engineering." },
  { title: "Machu Picchu", url: "https://en.wikipedia.org/wiki/Machu_Picchu", description: "15th-century Inca citadel set high in the Andes Mountains of Peru." },
  { title: "The Great Wall of China", url: "https://en.wikipedia.org/wiki/Great_Wall_of_China", description: "Series of fortifications spanning thousands of miles, built over centuries to protect Chinese states and empires." },
  { title: "Petra", url: "https://en.wikipedia.org/wiki/Petra", description: "Ancient city carved into rose-colored rock faces in southern Jordan." },
  { title: "The Parthenon", url: "https://en.wikipedia.org/wiki/Parthenon", description: "Former temple on the Athenian Acropolis, dedicated to the goddess Athena." },
  { title: "Angkor Wat", url: "https://en.wikipedia.org/wiki/Angkor_Wat", description: "Massive temple complex in Cambodia, originally constructed as a Hindu temple dedicated to Vishnu." },
  { title: "Stonehenge", url: "https://en.wikipedia.org/wiki/Stonehenge", description: "Prehistoric monument in Wiltshire, England, consisting of a ring of standing stones." },
  { title: "Easter Island", url: "https://en.wikipedia.org/wiki/Easter_Island", description: "Remote Chilean island famous for its colossal stone statues called moai." }
]

created_links = links.map { |link_data| Link.create!(link_data.merge(user: created_users.sample, created_at: time_ago.sample)) }

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
  5.times do
    Comment.create!(
      content: comments.sample,
      link: link,
      user: created_users.sample,
      created_at: time_ago.sample
    )
  end
end

# Add votes to links and comments
puts "Adding votes..."
created_links.each do |link|
  Vote.create!(
    votable: link,
    value: [-1, 1].sample,
    user: created_users.sample
  )

  link.comments.each do |comment|
    Vote.create!(
      votable: comment,
      value: [-1, 1].sample,
      user: created_users.sample
    )
  end
end

# Create additional users and their votes
5.times do |i|
  user = created_users.sample
  
  created_links.sample(5).each do |link|
    Vote.create!(
      votable: link,
      value: [-1, 1].sample,
      user: user
    ) rescue nil
  end

  Link.all.sample(3).each do |link|
    comment = link.comments.sample
    if comment
      Vote.create!(
        votable: comment,
        value: [-1, 1].sample,
        user: user
      ) rescue nil
    end
  end
end

puts "Seed data created successfully!"
