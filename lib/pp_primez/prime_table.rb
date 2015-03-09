require 'terminal-table'
require 'highline/import'

module PpPrimez
  module PrimeTable
    class << self
      include PrimeNumbers
      include Multiplication

      def print(count)
        table = Terminal::Table.new.tap do |t|
          t.headings = table_headings(count)
          t.rows = table_rows(count)
        end
        puts table
      end

      def validate_and_print(count)
        return error_table(:no_opt) unless count
        return error_table(:zero) if count.to_i == 0
        return are_you_serious(count) if count.to_i > 30
        return print(count.to_i)
      end

      def are_you_serious(count)
        exit unless HighLine.agree(too_many_primes)
        return print(count.to_i)
      end

      def error_table(type)
        error = type == :zero ? zero_error : type == :no_opt ? no_opt_error : generic_error
        table = Terminal::Table.new.tap do |t|
          t.headings = ["Error!"]
          t.rows = [[error]]
        end
        puts table
      end

      def too_many_primes
        String.new(<<-EOT).gsub(/^\s*/,"")
          This might be too many primes to fit on your screen! 
          Do you want to proceed?
          [Y/y/N/n]
        EOT
      end

      def zero_error
        String.new(<<-EOT).gsub(/^\s*/,"")
          Please include a number of primes to run this script with.
          This should be an integer >= 1. i.e. --count 10
        EOT
      end

      def no_opt_error
        String.new(<<-EOT).gsub(/^\s*/,"")
          Please include a number of primes to run this script with.
          You can do this by appending '--count <n>' to the file name.
        EOT
      end

      def generic_error
        "Oops something went wrong!"
      end

      def table_headings(count)
        [""]+fetch_primes(count)
      end

      def table_rows(count)
        rows(fetch_primes(count))
      end

    end
  end
end