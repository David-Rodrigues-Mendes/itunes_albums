# Itunes Album Search

## Introduction
Itunes Album Search is a full-stack Ruby on Rails app that provides albums returned from the iTunes Search API, based on the search terms used by the user

In that input field the user can type the name of an album or an artist.
Submitting it will show all the iTunes albums that match the submitted name and the albums of the artists that match the submitted name.

The following is the album information provided by the application:

- Album Cover: a thumbnail 100*100 with the cover of the album
- Album Name: the title of the album provided
- Artist Name: the name of the artist(s) of the album provided
- Favorite: an star icon indicating the favourite state of an album by the user

Itunes Album Search follows the MVC (Model-View-Controller) architecture to render code on its pages, and utlizes RESTful API conventions for serving the album data needed in the frontend.

## Functionality
Itunes Albums consumes the [Search iTunes API](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/Searching.html) that allows you to use search fields in your website to search for content within the iTunes Store, App Store, iBooks Store and Mac App Store. You can search for a variety of content; including apps, iBooks, movies, podcasts, music, music videos, audiobooks, and TV shows. You can also call an ID-based lookup request to create mappings between your content library and the digital catalog.
Additionally, there is a "favorite" icon that allows the user to see the albums that 
he selected from previous searches

## Deployment
Hotel Booking has not yet been deployed to production as I'm going to use it as an opportunity to learn and use infrastructure as code tools, CI/CD tools, and containerization tools (Terraform, Kafka, Docker, Kubernetes), and apply software architecture design principles to make a higly-available and higly-scalable system in the cloud. 

## Developing Locally
To run the app in your machine, first make sure you have Rails installed. Then: 
1. Clone the repo to your local machine:
``` ruby
$ git clone https://github.com/david-rodrigues-mendes/itunes_albums.git
```

2. Install the needed gems:
``` ruby
$ bundle install
```

3. Run the application migrations's through:
``` ruby
$ rails db:migrate
```

4. Finally, on the root path run a local server:
``` ruby
$ rails server
```

5. Open your browser at `http://localhost:3000` to run the app.