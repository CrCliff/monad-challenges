-- file Set1Spec.hs
import Test.Hspec
import Set1

main :: IO()
main = hspec $ do
  describe "fiveRands" $ do
    it "product of first five randoms check" $ do
      foldl (*) 0 fiveRands `shouldBe` (8681089573064486461641871805074254223660 :: Integer)

