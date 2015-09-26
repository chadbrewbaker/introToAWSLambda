import System.Environment

fastFib' :: Integer -> (Integer, Integer)
fastFib' 0 = (0, 1)
fastFib' n =
  let (a, b) = fastFib' (div n 2)
      c = a * (b * 2 - a)
      d = a * a + b * b
  in if mod n 2 == 0
    then (c, d)
    else (d, c + d)

fastFib :: Integer -> Integer
fastFib n = fst (fastFib' n)

main = do 
    args <- getArgs
    let numberStr = head args
    let number = read numberStr :: Integer
    print (fastFib number)




