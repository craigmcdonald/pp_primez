 module PpPrimez 
  module PrimeNumbers
    def fetch_primes(count)
      primes_from_count(count).first(count)
    end

    #First step is to convert n primes into a range to use as a sieve. 
    # I just multiplied the count * 4 which is fine for small numbers of primes.
    # Above that this clearly wouldn't work as the gap between primes increases.
    # I last thought about PNT a long time ago, so I Googled to find an 
    # acceptable approximatation for the number of numbers required to 
    # return n primes (expressed in pnt()).

    def upper_limit(count)
      count < 20 ? count * 4 : pnt(count)
    end

    def pnt(count)
      Integer(count * (Math.log(count) + Math.log(Math.log(count - 1))))
    end

    # Given that the upper_limit is an approximation, and I did not spend too 
    # much time looking for a more accurate approximation, I wrote primes_from_count()
    # as a recurisive method (only called if the result of the call to primes_from_range()
    # is not greater or equal to the number of primes required (it can be greater because
    # we can just limit the response from fetch_primes above)

    def primes_from_count(count)
      primes = primes_from_range(2..upper_limit(count),count)
      return primes if primes.count >= count
      primes_from_count(new_count(count))
    end

    # To get a new_count value to use in the recursion, I just added a bit to the original 
    # count. Doing it this way will mean that it is never likely to require
    # more than a couple of recusions (if any).

    def new_count(count)
      Integer(count + (count / Math.log(count))) rescue (count +1)** 2
    end

    # Here I set an instance variable for primes and make sure that I know what sort of object
    # I am working with by forcing the array-like input (which in this case is actually a range)
    # to be an array. I then call primes() to actually do the work.


    def primes_from_range(array,count)
      @primes = []
      primes(array.to_a,count)
      @primes
    end

    # Again I've made use of recurison, with each pass working on a smaller array of possible primes
    # until there are none left. In irb this hit my stack level after about ~8000 primes, which is
    # fine for this use case (since we are printing to a screen and as such are constrained
    # by screen real-estate well before the program starts to consume too much resources on a normal laptop.

    def primes(array,count)
      @primes << array[0]
      new_array = array.select {|a| a % array[0] != 0 }
      return unless new_array.any? && (@primes.count <= count)
      primes(new_array,count) 
    end

  end
end