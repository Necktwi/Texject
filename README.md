# Texject
Fast C++ JSON parser; serves more than just JSON, with subscript operator in
C++. Texject mean text object. These are stored in files with extension 
`.txj`, `.obj.txj`, `.arr.txj`, `.set.txj`, `.oob.txj`, `.num.txj`, `.str.txj`
etc.

- Its fast, lite and thread safe!
- supported containers:
  - obj: Object, order of key value pairs not preserver, enclosure: `[]`
  - oob: OrderedOBject, order of pairs is preserverd, enclosure: `{}`
  - arr: Array, simple array of Texjects, enclosure: `[]`
  - set: Set, duplicate members is discarded, enclosure: `{}`
- Baic types: numbers, strings, boolean, binaray, xml, time stamps.
- When serialized to JSON, maximum features are put into JSON and remaining
  that can not be JSONed are cleanly discarded.

I recursively hacked it to extract as many features as I could and I will continue till it can!

## Parsing simple json:
- simple.json:
```JSON
{"employees": [
	{"firstName": "John", "lastName": "Doe"}, 
	{"firstName": "Anna", "lastName": "Smith"},
	{"firstName": "Peter", "lastName": "Jones"}
],
 "employeeCount": 3,
 "arePermanent": true
}
```
- C++:
```C++
#include <Texject.h>

int main () {
	Txj_ comp("file://tests/data/simple.json");
	Txj_& Emp1= comp["employees"][0];
	cout<< "Employee 1: "<< Emp1["firstName"]<< " "<< Emp1["lastName"]<< endl;
	
	//1st argument should be given 'true' for JSON string else it gives Texject
	string Emp2= comp["employees"][1].stringify(true);
	cout<< "Employee 2: "<< Emp2<< endl;

   string Emp3= comp["employees"][2].prettyString(true);
	cout<< "Employee 3: "<< Emp3<< endl;
	return 0;
}
```
- Output:
```
Employee 1: John Doe
Employee 2: {"firstName":"Anna","lastName":"Smith"}
Employee 3: {
	"firstName": "Peter",
	"lastName": "Jones"
}
```

## The Texject:
- Employee.oob.txj; oob: OrderedOBject; the order of members preserved
```JSON
name: "Gowtham",
"id": 1729,
isProgrammer: true,

#comment1: "It's a table; '|' inheritance operator",
favLang: [
	"C++", "Javascript", "lisp"
],
testScore: [[
	    8,            7,      6
], [
	    7,            8,      3
], [
	    9,            5,      8
]] | [favLang],

#comment2: "its oob enclosed in [] where as obj(object) is enclosed in {}"
"address": [
	"town": "KAKINADA",
	country: "Bharath"
],

"biography": "
	He is smart, brilliant, genius, empathetic, creative, connective, patient,
	handsome, valient, romantic;) After all he made JSON with multi line string!
",

#comment3: "its an obj; enclosed in {}; order not preserved"
physiology: {
	iris: "blue",
	height: "6 foot"
},

#comment2: "its a set! And comments are not stringified",
sports: {"cricket", "badminton", "tt"}
```
- C++:
```CPP
Txj_ emp("file://tests/data/Employee.oob.txj");
cout<< emp["name"]<< "'s C++ test 1 score: "<< emp["testScore"][0]["C++"]<<
endl;
int C++test2Score= emp["testScore"][1]["C++"];
emp["testScore"][1]["C++"]= ++langScore;
emp.save(); // saves to the file
emp["sports"][]= "tt"; //its already in set, so no effect! 
cout<< "Sports he play: "<< emp["sports"]<< endl;
cout<<
```
- Output on 1st run:
```
Gowtham's C++ test 1 score: 7
Sports he play: {"cricket", "badminton", "tt"}
```
- Output on 2nd run:
```
Gowtham's C++ test 1 score: 8
Sports he play: {"cricket", "badminton", "tt"}
```
- Texject can be stingified to JSON using `.stringfy(true)` or 
  `.prettyString(true)` upon which it removes ` | [favlang]` and
  quotes all strings.

## Installation
```
git clone https://github.com/gowthamkudupudi/Texject.git
cd Texject
mkdir build
cmake -G "Unix Makefiles" -DBUILD_TESTING=1 -B build
make -j`nproc`

# to run unit tests
./build/testUnits

# to install to /usr/local/
sudo make install
```

## Linker option
`-ltxj`

- It got lot many cool features; look https://github.com/necktwi/Texject/blob/master/nbproject/tests/ffjsonTest.cpp
- FFJSON acronym is "FerryFairJSON"
