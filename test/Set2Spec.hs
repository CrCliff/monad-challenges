-- file Set2Spec.hs

import Test.Hspec
import Test.QuickCheck
import MCPrelude
import Set2

main :: IO()
main = hspec $ do
  describe "fiveRands" $ do
    it "product of first five randoms check" $ do

