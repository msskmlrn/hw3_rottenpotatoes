# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
	Movie.create(movie)
  end
  assert Movie.count == 10
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  e1_location = page.body.index(e1)
  e2_location = page.body.index(e2)
  assert !e1_location.nil?
  assert !e2_location.nil?
  assert e1_location < e2_location, "#{e1} does not appear before #{e2}"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
	rating_list.split(", ").each do |rating|
		rating_id = "ratings_#{rating}"
		uncheck ? uncheck(rating_id) : check(rating_id)
	end
end

Then /^I should see (all|none) of the movies$/ do |display|
  	movie_table = page.find('#movies')
  	row_count = movie_table.all('tr').length
	if	display == 'all'
		expected_rows = 11
	else
		expected_rows = 1
	end
  	assert row_count == expected_rows
end
