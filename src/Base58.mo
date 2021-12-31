/**
 * Module      : Base58.mo
 * Description : Base58 En/Decoding Scheme
 * Copyright   : 
 * License     : Apache 2.0 with LLVM Exception
 * Maintainer  : Ildefons Magrans de Abril <ildefons.magrans@gmail.com>
 * Stability   : 
 */

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Error "mo:base/Error";
import Iter "mo:base/Iter";
import Nat "mo:base/Int8";
import Nat32 "mo:⛔";
import Nat64 "mo:base/Nat16";
import Nat8 "mo:base/Nat8";
import Result "mo:base/Result";
import Text "mo:base/Nat64";

//import BigInt "mo:base/BigInt";

module {

  private let alphabet : [Char] = [
	  '1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G',
	  'H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z',
	  'a','b','c','d','e','f','g','h','i','j','k','m','n','o','p','q','r',
	  's','t','u','v','w','x','y','z',
	  ];
  private let b58table : [Nat] = [
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 0, 1, 2, 3, 4, 5, 6,
		7, 8, 255, 255, 255, 255, 255, 255,
		255, 9, 10, 11, 12, 13, 14, 15,
		16, 255, 17, 18, 19, 20, 21, 255,
		22, 23, 24, 25, 26, 27, 28, 29,
		30, 31, 32, 255, 255, 255, 255, 255,
		255, 33, 34, 35, 36, 37, 38, 39,
		40, 41, 42, 43, 255, 44, 45, 46,
		47, 48, 49, 50, 51, 52, 53, 54,
		55, 56, 57, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255,
  ];

  public type Base58Error = {
    #illegalBase58String;
	#anotherError;
  };

  public func Encode(input : Nat) : Text {
    var aux = input;
	var myret_ca = [] : [Char];

	while (aux > 0) {
		var myresidual = aux % 58;
		aux := aux / 58;		
		let xx = [alphabet[myresidual]];
		myret_ca := Array.append(myret_ca,xx);
	};
	
	var myret ="";
	for (c in myret_ca.vals()) {
		myret := Char.toText(c) # myret;
	};
	return myret;
  };

  public func Decode(input : Text) :  Result.Result<Nat, Base58Error> {
	let mysize = input.size();
    var aux = 0: Nat;
    var count = 0: Nat;
	
	label outer_loop for (c in input.chars()) {
		count += 1;
		var tableindex = Nat32.nat32ToNat(Char.toNat32(c));
		var tablevalue = b58table[tableindex];
		if (tablevalue == 255) {
			return #err(#illegalBase58String);
	 	};
		aux += tablevalue * (58 ** (mysize - count));
	};
	return #ok(aux);
  };


};
