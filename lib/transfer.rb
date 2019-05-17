'require pry'

class Transfer
attr_accessor  :status
attr_reader :sender, :receiver, :amount

  def initialize(sender, receiver, amount=50)
      @sender = sender
      @receiver = receiver
      @status = "pending"
      @amount = amount
  end

  def valid?
  sender.valid? && receiver.valid?
    #binding.pry
  end


  def execute_transaction
    if self.status == "pending"
        if self.valid? && self.sender.balance >= self.amount
           self.sender.balance -= self.amount
           self.receiver.balance += self.amount
           self.status = "complete"
       else
         self.status = "rejected"
         "Transaction rejected. Please check your account balance."
       end
    end
  end

  def reverse_transfer
      if self.status == "complete"
        if self.valid? && self.receiver.balance >= amount
          self.sender.balance += self.amount
          self.receiver.balance -= self.amount
          self.status = "reversed"
        end
      end
    end

end
