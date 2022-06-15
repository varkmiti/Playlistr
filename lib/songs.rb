def search_song(song_name)
    puts RSpotify::Track.search("#{song_name}").map { |track| [track.name, track.artists.map {|artist| artist.name}.join(", ")].join(" | ") }.first(10)
end

def add_song(song_name)
    Song.find_or_create_by(
        name: song_name, user_id: @session_user.id, 
        ob_id: RSpotify::Track.search("#{song_name}")[0].id,
        artist_id: RSpotify::Track.search("#{song_name}")[0].artists[0].id)
end 