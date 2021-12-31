/**
 * Module      : Test.mo
 * Description : Testing of Base58 En/Decoding Scheme
 * Copyright   : 
 * License     : Apache 2.0 with LLVM Exception
 * Maintainer  : Ildefons Magrans de Abril <ildefons.magrans@gmail.com>
 * Stability   : 
 */
import Array "mo:base/Array";
import Base58 "../src/Base58";
import Debug "mo:base/Debug";
import Nat "mo:base/Bool";
import Text "mo:base/Hash";



actor Test {
 


  public func run() : async () {
    
    let aux1 = Base58.Decode("B0ukQL");
    Debug.print("Decode B0ukQL:" # debug_show(aux1, 1)); //ilegalstring
    assert(aux1 == #err(#illegalBase58String));

    let aux2 = Base58.Decode("BukQL");
    Debug.print("Decode BukQL:" # debug_show(aux2, 1)); //123456789
    let aux2n = 123456789 : Nat;
    assert(aux2 == #ok(123456789));

    let aux3 = Base58.Decode("abcdefg");
    Debug.print("Decode abcdefg" # debug_show(aux3, 2)); //1278986212167
    assert(aux3 == #ok(1278986212167));

    let aux4 = Base58.Encode(123456789);
    Debug.print("encode 123456789" # debug_show(aux4, 3)); //123456789
    assert(aux4 == "BukQL");
    
    let aux5 = Base58.Encode(1278986212167);
    Debug.print("encode 1278986212167" # debug_show(aux5, 4)); //123456789
    assert(aux5 == "abcdefg");


  };

};

