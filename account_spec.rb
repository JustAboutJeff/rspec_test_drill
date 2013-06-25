require "rspec"
require_relative "account"

describe Account do
  let(:my_account) { Account.new("1023456789",100) }

  context "#initialize" do
    it "should be an instance of Account" do
      expect(my_account).to be_an_instance_of Account
    end

    it "should set account number" do
      expect(my_account.acct_number).to_not be_nil
    end

    it "should accept one argument" do
      expect { Account.new("4324324232") }.to_not raise_error
    end

    it "acct_number should be numeric" do
      expect { Account.new("abi") }.to raise_error InvalidAccountNumberError
    end
  end

  context "#transactions" do
    it "should default to zero" do
      expect(Account.new("4523456723").transactions).to eq [0]
    end

    it "should return all the transactions" do
      other_account = Account.new("4523356723",12)
      other_account.deposit!(20)
      expect(other_account.transactions).to eq [12,20]
    end
  end

  context "#balance" do
    it "should return correct balance sum" do
      other_account = Account.new("4523356723",12)
      other_account.deposit!(20)
      expect(other_account.balance).to eq 32
    end
  end

  context "#account_number" do
    it "should hide the account number" do
      expect(my_account.acct_number).to_not eq "1023456789" 
    end

  end

  context "deposit!" do
    it "should fail for negative deposits" do
      expect { my_account.deposit!(-10) }.to raise_error NegativeDepositError
    end
  end

  context "#withdraw!" do
    it "should raise error for overdraft" do
      expect { my_account.withdraw!(101) }.to raise_error OverdraftError
    end
  end

end
