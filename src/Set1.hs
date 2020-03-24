{-# LANGUAGE MonadComprehensions #-}
{-# LANGUAGE RebindableSyntax  #-}

module Set1 where

import MCPrelude
import Data.Monoid (mconcat)

type Gen a = Seed -> (a, Seed)

fiveRands :: [Integer]
fiveRands = map fst [x1,x2,x3,x4,x5]
  where 
    x1 = rand $ mkSeed 1
    x2 = rand $ snd x1
    x3 = rand $ snd x2
    x4 = rand $ snd x3
    x5 = rand $ snd x4

randLetter   :: Gen Char 
randLetter s = (toLetter $ fst x, snd x)
  where
    x = rand s

randString3 :: String
randString3 = foldr (:) [] $ map fst [x1, x2, x3]
  where
    x1 = randLetter $ mkSeed 1
    x2 = randLetter $ snd x1
    x3 = randLetter $ snd x2


generalA     :: (Integer -> Integer) -> Gen Integer
generalA f s = (f $ fst x, snd x)
  where x = rand s

randEven :: Gen Integer
randEven = generalA (*2)

randOdd :: Gen Integer
randOdd = generalA ((+1) . (*2))

randTen :: Gen Integer
randTen = generalA (*10)

randPair :: Gen (Char, Integer)
randPair s = ((fst x, fst y), snd y)
  where
    x = randLetter s
    y = rand $ snd x

generalPair :: Gen a -> Gen b -> Gen (a,b)
generalPair g1 g2 s = ((fst x, fst y), snd y)
  where
    x = g1 s
    y = g2 $ snd x

generalB :: (a -> b -> c) -> Gen a -> Gen b -> Gen c
generalB f g1 g2 s = (f (fst x) (fst y), snd y)
  where
    x = g1 s
    y = g2 $ snd x

generalPair2 :: Gen a -> Gen b -> Gen (a,b)
generalPair2 = generalB (,)

repRandom :: [Gen a] -> Gen [a]
repRandom [g]     s = ( [fst x], snd x )
  where
    x = g s
repRandom (g:gs) s = ( (fst x) : (fst rest), snd x ) 
  where
    x = g s
    rest = repRandom gs (snd x)

