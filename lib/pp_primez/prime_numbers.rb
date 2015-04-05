 module PpPrimez 
  module PrimeNumbers
    def fetch_primes(count)
      (1..Float::INFINITY).lazy.select {|n| is_prime(n)}.first(count)
    end

    def is_prime(n)
      return false if n == 1
      return true if n == 2
      (2..Math.sqrt(n)).none? {|i| n % i == 0 }
    end
  end
end


