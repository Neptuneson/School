def crank(str)
    for i in 0..str.length
      for j in 0..i
        print(" ")
      end
      print(str[i].upcase())
      print("\n")
    end
end
crank("sock")