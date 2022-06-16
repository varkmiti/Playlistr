def album_search_by_artist_name(artist_name) # Need to switch order of request and printout of artists 
    if RSpotify::Artist.search("#{artist_name}").map { |art| art.name }.include?(artist_name) == false
        puts RSpotify::Artist.search("#{artist_name}").map { |art| art.name }.uniq.first(5)

        puts "\n"
        puts "Which #{artist_name}? If there are multiple artists with the same name, your search will return the most popular artist with that name."

        real_name = gets.chomp
        puts "\n"
        puts "Albums by #{real_name}:"
        most_pop =  RSpotify::Artist.search("#{artist_name}").map { |art| art.popularity }.max { |art1, art2| art1 <=> art2 }
        art_name = RSpotify::Artist.search("#{artist_name}").filter { |art| art.popularity == most_pop }[0].name
        puts RSpotify::Artist.search("#{art_name}")[0].albums.map { |alb| alb.name }.uniq

    elsif RSpotify::Artist.search("#{artist_name}").map { |art| art.name }.include?(artist_name) == true
        puts "Albums by #{artist_name}:"
        most_pop =  RSpotify::Artist.search("#{artist_name}").map { |art| art.popularity }.max {|art1, art2| art1 <=> art2 }
        art_name = RSpotify::Artist.search("#{artist_name}").filter { |art| art.popularity == most_pop }[0].name
        puts RSpotify::Artist.search("#{art_name}")[0].albums.map { |alb| alb.name }.uniq
    end 

    puts "\n"
    puts "Would you like to see the songs one of these albums?"
    puts "\n"
    album = gets.chomp
    puts "\n"
    open_album(album)
end 


def open_album(album)
    puts RSpotify::Album.search("#{album}")[0].tracks.map { |alb| alb.name }.uniq
    puts "\n"
    puts "What song do you want to add to your playlist? If none, type 'none of these.'"
    puts "\n"
    choice = gets.chomp
    puts "\n"
    if choice == "none of these"
        return_home
    else 
        add_song(choice)
        puts "\n"
        puts "I love that song! Do you want to add another?"
        puts "\n"
        choice1 = gets.chomp
        puts "\n"
        if choice1 == "yes" or choice1 == "Yes" or choice1 == "y" or choice1 == "Y"
            open_album(album)
        else 
            return_home
        end 
    end 
end 

def view_all_artists
    binding.pry
    @session_user.artists
end 
