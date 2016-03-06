Given /the following movies exist:/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |movie, director|
  expect(page).to have_content(movie)
  expect(page).to have_content(director)
end

# Add a declarative step here for populating the DB with movies.



# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  regexp = /#{e1}.*#{e2}/m
  page.body.should =~ regexp
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"
When /I check the following ratings: (.*)/ do |rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  @rating_list = rating_list.split(",")
  #prefix = "ratings_"

  @rating_list.each do |rating|
    #check(prefix + rating)
    #@movies = Movie.where(:rating => rating_list)
    check("ratings[#{rating}]")
  end
   #flunk "Unimplemented"
end
When /I uncheck the following ratings: (.*)/ do|unchecked_rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  @unchecked_rating_list = unchecked_rating_list.split(",")
  #prefix = "ratings_"

  @unchecked_rating_list.each do |rating|
    #uncheck(prefix + rating)
      #@movies = Movie.where(:rating => rating_list)
    uncheck("ratings[#{rating}]")
  end
   #flunk "Unimplemented"
end

Then /I should see the movies of selected_ratings/ do
  movies = Movie.where(:rating => @rating_list)
  movies.each do |movie|
    title = movie.title
    if page.respond_to? :should
       page.should have_content(title)
    else
       assert page.has_content?(title)
    end
  end
end

Then /I should not see the movies of non_selected ratings/ do
  movies = Movie.where(:rating => @unchecked_rating_list)
  movies.each do |movie|
    title = movie.title
    if page.respond_to? :should
       page.should have_no_content(title)
    else
       assert page.has_no_content?(title)
    end
  end
end

Then /I should see all the movies/ do
  movies = Movie.all
  movies.each do |movie|
    title = movie.title
    if page.respond_to? :should
       page.should have_content(title)
    else
       assert page.has_content?(title)
    end
  end

end






