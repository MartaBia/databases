require 'account_repository'

RSpec.describe AccountRepository do

  def reset_accounts_table
    seed_sql = File.read('spec/seeds_account.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_accounts_table
  end

  it "returns one account from a list of all the records" do
    repo = AccountRepository.new

    accounts = repo.all

    expect(accounts.length).to eq 2

    expect(accounts.first.id).to eq '1'
    expect(accounts.first.email_address).to eq 'marta.bianchini@domain.com'
    expect(accounts.first.username).to eq 'user_1'
  end

  it "find the fist recod" do
    repo = AccountRepository.new

    account = repo.find(1)

    expect(account.id).to eq'1'
    expect(account.email_address).to eq 'marta.bianchini@domain.com'
    expect(account.username).to eq 'user_1'
  end

  it "adds one record" do
    repo = AccountRepository.new

    new_account = Account.new
    new_account.email_address = 'email_address@domain.com'
    new_account.username = 'user_3'

    repo.create(new_account)

    accounts = repo.all

    new_account = accounts.last
    expect(new_account.email_address).to eq 'email_address@domain.com'
    expect(new_account.username).to eq 'user_3'
  end

  it "deletes a record" do
    repo = AccountRepository.new

    repo.delete(1)

    accounts = repo.all
    expect(accounts.length).to eq 1
    expect(accounts.first.id).to eq "2"
  end
end