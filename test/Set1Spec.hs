-- file Set1Spec.hs

import Data.Digest.Pure.SHA
import Data.ByteString.Lazy.UTF8 (fromString)
import Test.Hspec
import Test.QuickCheck
import MCPrelude
import Set1

main :: IO()
main = hspec $ do
  describe "fiveRands" $ do
    it "product of first five randoms check" $ do
      foldl (*) 1 fiveRands `shouldBe` (8681089573064486461641871805074254223660 :: Integer)
  describe "randString3" $ do
    it "SHA-256 hash of output of randString3 check" $ do
      (showDigest . sha256 . fromString) randString3 `shouldBe` "9d475eb78d3e38085220ed6ebde9d8f7d26540bb1c8f9382479c3acd4c8c94a3"

  describe "randEven" $ do
    it "returns the output of rand * 2" $ do
      property $ \x -> fst (randEven $ mkSeed x) == fst (rand $ mkSeed (x :: Integer)) * 2
  describe "randOdd" $ do
    it "returns the output of rand * 2 + 1" $ do
      property $ \x -> fst (randOdd $ mkSeed x) == fst (rand $ mkSeed (x :: Integer)) * 2 + 1
  describe "randTen" $ do
    it "returns the output of rand * 10" $ do
      property $ \x -> fst (randTen $ mkSeed x) == fst (rand $ mkSeed (x :: Integer)) * 10
  describe "randEven, randOdd, randTen" $ do
    it "product of functions check" $ do
      foldl (*) 1 (map fst [randEven $ mkSeed 1, randOdd $ mkSeed 1, randTen $ mkSeed 1]) `shouldBe` 189908109902700

  describe "randPair" $ do
    it "check (mkSeed 1)" $ do
      fst (randPair (mkSeed 1)) `shouldBe` ('l',282475249)
  describe "generalPair" $ do
    it "generalPair is equivalent to randpair when using randLetter and rand" $ do
      property $ \x -> fst (randPair (mkSeed (x :: Integer))) == fst (generalPair randLetter rand $ mkSeed x)
  describe "generalPair2" $ do
    it "generalPair2 is equivalent to randpair when using randLetter and rand" $ do
      property $ \x -> fst (randPair (mkSeed (x :: Integer))) == fst (generalPair2 randLetter rand $ mkSeed x)
    it "generalPair2 is equivalent to generalPair" $ do
      property $ \x -> fst (generalPair randLetter rand $ mkSeed x) == fst (generalPair2 randLetter rand $ mkSeed (x :: Integer))

