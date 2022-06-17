def search_song(song_name)
    puts RSpotify::Track.search("#{song_name}").map { |track| [track.name, track.artists.map {|artist| artist.name}.join(", ")].join(" | ") }.first(10)
end

def add_song(song_name)
    if @session_party == nil
        puts "Would you like to join a party first?"
        puts "\n"
        choice = gets.chomp
        if choice == "no"
            artist_create_helper(song_name)
            Song.find_or_create_by(
                name: RSpotify::Track.search("#{song_name}")[0].name, user_id: @session_user.id, 
                ob_id: RSpotify::Track.search("#{song_name}")[0].id,
                artist_id: Artist.find_or_create_by(art_id: RSpotify::Track.search("#{song_name}")[0].artists[0].id).id, 
                playlist_id: @session_playlist.id)
        elsif choice == "yes"
            create_party
            artist_create_helper(song_name)
            Song.find_or_create_by(
                name: RSpotify::Track.search("#{song_name}")[0].name, user_id: @session_user.id, 
                ob_id: RSpotify::Track.search("#{song_name}")[0].id,
                artist_id: Artist.find_or_create_by(art_id: RSpotify::Track.search("#{song_name}")[0].artists[0].id).id, 
                playlist_id: @session_playlist.id, 
                party_id: @session_party.id)
        end 
    elsif @session_party != nil 
        artist_create_helper(song_name)
        Song.find_or_create_by(
            name: RSpotify::Track.search("#{song_name}")[0].name, user_id: @session_user.id, 
            ob_id: RSpotify::Track.search("#{song_name}")[0].id,
            artist_id: Artist.find_or_create_by(art_id: RSpotify::Track.search("#{song_name}")[0].artists[0].id).id, 
            playlist_id: @session_playlist.id, 
            party_id: @session_party.id)
    end 
end 

def artist_create_helper(song_name)
    Artist.find_or_create_by(art_id: RSpotify::Track.search("#{song_name}")[0].artists[0].id, 
    name: RSpotify::Track.search("#{song_name}")[0].artists[0].name)
end 

def view_all_user_songs
    puts "\n"
    puts @session_user.songs.map {|song| song.name }.uniq
end 

