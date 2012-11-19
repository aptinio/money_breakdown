def MoneyBreakdown(*args)
  mb = MoneyBreakdown.new(*args)
  mb.breakdown
end

class MoneyBreakdown
  attr_reader :amount, :denominations

  def initialize(amount, denominations)
    @amount = amount
    @denominations = denominations
  end

  def breakdown
    return @breakdown if @breakdown

    @breakdown = {}
    remaining_amount = amount

    denominations.sort.reverse.each do |denomination|
      count = (remaining_amount / denomination).to_i

      if count > 0
        @breakdown[denomination] = count
        remaining_amount -= denomination * count
      end

      break unless remaining_amount > 0
    end

    @breakdown
  end
end
