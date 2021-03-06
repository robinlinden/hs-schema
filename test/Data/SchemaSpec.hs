module Data.SchemaSpec (spec) where

import           Control.Applicative ((<$>))
import           Data.Proxy          (Proxy (..))
import           Test.Hspec
import           Test.QuickCheck

import           Data.Schema


data MyRecord = MyRecord
  { recordField1 :: Int
  , recordField2 :: Double
  , recordField3 :: String
  }
  deriving (Eq, Show, Read)


instance HasSchema MyRecord where
  schema p = Type
    { typeName = "MyRecord"
    , typeSchema = SchemaRecord
        [ Field "recordField1" $ schema $ recordField1 <$> p
        , Field "recordField2" $ schema $ recordField2 <$> p
        , Field "recordField3" $ schema $ recordField3 <$> p
        ]
    }


spec :: Spec
spec = do
  describe "schemas" $ do
    it "can be printed to stdout" $
      print (schema (Proxy :: Proxy MyRecord))
