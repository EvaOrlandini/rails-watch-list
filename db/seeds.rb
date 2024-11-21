require 'open-uri'
require 'json'

# Movies seed
puts "Cleaning up database..."
Movie.destroy_all
puts "Database cleaned"
puts "Seeding movies..."
# URL de l'API via le proxy Le Wagon
url = 'https://tmdb.lewagon.com/movie/top_rated'
response = URI.open(url).read
movies = JSON.parse(response)["results"]
movies.each do |movie|
  Movie.create!(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
    rating: movie["vote_average"]
  )
  puts "Created #{movie['title']}"
end
puts "Seeding done!"


# Seeding Lists

puts "Seeding lists..."
list1 = List.create!(name: "Action Movies")
list2 = List.create!(name: "Comedy Movies")
list3 = List.create!(name: "Top Rated Movies")

# Seeding Bookmarks (associating movies with lists)
puts "Seeding bookmarks..."
movies_sample = Movie.limit(5)

# Associer des films aux listes
movies_sample.each do |movie|
  Bookmark.create!(
    movie_id: movie.id,
    list_id: list1.id,
    comment: "Great action movie!"
  )
  Bookmark.create!(
    movie_id: movie.id,
    list_id: list2.id,
    comment: "Super funny movie!"
  )
  Bookmark.create!(
    movie_id: movie.id,
    list_id: list3.id,
    comment: "Must watch movie!"
  )
  puts "Created bookmarks for movie: #{movie.title}"
end
puts "Seeding done!"
