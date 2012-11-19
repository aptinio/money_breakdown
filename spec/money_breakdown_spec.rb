require 'spec_helper'
require 'money_breakdown'

describe '#MoneyBreakdown' do
  describe 'convenience method' do
    before do
      flexmock(MoneyBreakdown).should_receive(:new).
        with(:amount, :denominations).once.
        and_return(flexmock breakdown: :breakdown)
    end

    it 'instantiates a MoneyBreakdown, passing along the arguments' do
      MoneyBreakdown(:amount, :denominations)
    end

    it 'returns MoneyBreakdown#breakdown' do
      assert { MoneyBreakdown(:amount, :denominations) == :breakdown }
    end
  end

  it 'returns a denomination matching the amount' do
    assert { MoneyBreakdown(2, [1, 2, 5]) == { 2 => 1 } }
  end

  it 'returns the largest denomination matching the amount' do
    assert { MoneyBreakdown(10, [1, 2, 5, 10, 20]) == { 10 => 1 } }
  end

  it 'returns a multiple of a denomination equal to the amount' do
    assert { MoneyBreakdown(4, [1, 2, 5]) == { 2 => 2 } }
  end

  it 'returns denominations equal to the amount' do
    assert { MoneyBreakdown(7, [1, 2, 5, 10]) == { 5 => 1, 2 => 1 } }
  end

  it 'returns multiples of denominations equal to the amount' do
    assert { MoneyBreakdown(9, [1, 2, 5, 10]) == { 5 => 1, 2 => 2 } }
  end

  it "works even if denominations are'nt sorted" do
    assert { MoneyBreakdown(9, [2, 10, 1, 5]) == { 5 => 1, 2 => 2 } }
  end

  it 'works with fractional denominations' do
    mb = MoneyBreakdown(5.12, [0.01, 0.1, 2, 5])
    assert { mb == { 5 => 1, 0.1 => 1, 0.01 => 2 } }
  end

  xit 'works with weird denominations' do
    mb = MoneyBreakdown(8,  [1, 2, 4, 5])
    assert { mb == { 4 => 2 } }
  end
end
