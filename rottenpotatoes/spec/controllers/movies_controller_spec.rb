require 'rails_helper'
describe MoviesController do

   describe 'happy path' do
      before :each do
        @m=double(Movie, :title => "Star Wars", :director => "director", :id => "1")
        Movie.stub(:find).with("1").and_return(@m)
      end
      
      it 'should generate routing for Similar Movies' do
        { :post => movie_similar_path(1) }.
        should route_to(:controller => "movies", :action => "similar", :movie_id => "1")
      end
    
      it 'should call the model method that finds similar movies' do
        fake_results = [double('Movie'), double('Movie')]
        Movie.should_receive(:similar_directors).with('director').and_return(fake_results)
        get :similar, :movie_id => "1"
      end

    end
    
    describe 'sad path' do
       before :each do
         @m=double(Movie, :title => "Star Wars", :director => nil, :id => "1")
         Movie.stub(:find).with("1").and_return(@m)
       end
    
       it 'should select the Index template for rendering and generate a flash' do
          get :similar, :movie_id => "1"
          response.should redirect_to(movies_path)
          flash[:notice].should_not be_blank
       end
    end 

end