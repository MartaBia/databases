require 'post_repository'

RSpec.describe PostRepository do

  def reset_posts_table
    seed_sql = File.read('spec/seeds_post.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_posts_table
  end

  it "returns one post from a list of all the records" do
    repo = PostRepository.new
    
    posts = repo.all
    
    expect(posts.length).to eq 3
    
    expect(posts.first.id).to eq '1'
    expect(posts.first.title).to eq 'Title_1'
    expect(posts.first.content).to eq 'Some content'
    expect(posts.first.views_count).to eq '3'
    expect(posts.first.account_id).to eq '1'
  end

  it "returns the second record" do 
    repo = PostRepository.new

    post = repo.find(2)

    expect(post.id).to eq '2'
    expect(post.title).to eq 'Title_2'
    expect(post.content).to eq 'Some other content'
    expect(post.views_count).to eq '5'
    expect(post.account_id).to eq '1'
  end

  it "adds one record" do
    repo = PostRepository.new

    new_post = Post.new
    new_post.title = 'New title'
    new_post.content = 'There is a new content'
    new_post.views_count = 100
    new_post.account_id = '1'


    repo.create(new_post)

    posts = repo.all

    new_post = posts.last
    expect(new_post.title).to eq 'New title'
    expect(new_post.content).to eq 'There is a new content'
    expect(new_post.views_count).to eq '100'
    expect(new_post.account_id).to eq '1'
  end

  it "deletes a record" do
    repo = PostRepository.new

    repo.delete(1)

    posts = repo.all
    expect(posts.length).to eq 2
    expect(posts.first.id).to eq "2"
  end
end