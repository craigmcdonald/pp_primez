module PpPrimez 
  module Multiplication
    def rows(array)
      array.collect {|a| row(a,array)}
    end

    def row(int,array)
      [int] + array.collect {|a| int * a}
    end
  end
end