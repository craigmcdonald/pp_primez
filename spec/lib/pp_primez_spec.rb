require 'spec_helper'
# require 'pry'

class Klass;end

describe PpPrimez do 

  context "PpPrimez::PrimeTable" do
    
    before(:each) do 
      @prime_table = PpPrimez::PrimeTable
    end

    it "should include PrimeNumbers and Multiplication modules" do
      expect(@prime_table).to respond_to(:fetch_primes)
      expect(@prime_table).to respond_to(:rows)
    end

    it "should raise an error with an invalid input" do 
      expect { @prime_table.print("a") }.to raise_error
    end

  end

  context "PpPrimez::PrimeNumbers" do 

    before(:each) do
      @klass = Klass.new.tap do |k|
        k.extend(PpPrimez::PrimeNumbers)
      end
    end
    context "responding to its methods" do
      [:fetch_primes, :upper_limit, :new_count, :primes_from_range, :primes].each do |method|

        it "should respond to #{method}" do
          expect(@klass).to respond_to(method)
        end
      end
    end

    context "returning the correct values" do 

      it "should return a valid upper limit for 2" do 
        expect(@klass.upper_limit(2)).to eq(8)
      end

      context "testing against list of primes from http://primes.utm.edu/lists/small/1000.txt" do
        before(:all) do
          @external_primes = File.open('./spec/fixtures/first_1000_primes.txt').
          read.split(",").map {|p| p.to_i}
        end

        it "should return the first 1000 primes correctly" do
          expect(@klass.fetch_primes(1000)).to eq(@external_primes)
        end

        it "should return the first 2 primes correctly" do 
          expect(@klass.fetch_primes(2)).to eq(@external_primes.first(2))
        end

        context "checking each count up to 1000", :slow do
          (1..1000).each do |count| 
            it "should return the first #{count} primes correctly" do
              expect(@klass.fetch_primes(count)).to eq(@external_primes.first(count))
            end
          end
        end

      end
    end
  end

  context "PpPrimez::Multiplication" do 

    before(:each) do
      @klass = Klass.new.tap do |k|
        k.extend(PpPrimez::Multiplication)
      end
    end

    context "responding to its methods" do 
      [:rows, :row].each do |method|

        it "should respond to #{method}" do
          expect(@klass).to respond_to(method)
        end
      end
    end

    context "returning the correct values" do

      before(:each) do
        @obj =double("prime_numbers")
        allow(@obj).to receive(:fetch_primes) {[2,3,5]}
      end

      it "should calculate the first row correctly" do
        row = @klass.row(2,@obj.fetch_primes(3))
        expect(row).to eq([2,4,6,10])
      end

      it "should calculate all rows correctly" do
        rows = @klass.rows(@obj.fetch_primes(3))
        result = [[2, 4, 6, 10], [3, 6, 9, 15], [5, 10, 15, 25]]
        expect(rows).to eq(result)
      end

    end

  end


end