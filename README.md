#introToAWSLambda
Introduction to AWS Lambda

# What is Lambda
* 60 seconds or less
* NodeJS, Java8, Bash, Awk, Python2.7, or static binary
* More RAM = more CPU slice
* Around 100 concurrent jobs allowed

# The Lambda environment

See [LambdaSh] (https://github.com/alestic/lambdash) if you want to explore the AWS Lambda environment with interactive shell commands.


* Running Bash scripts on Lambda

Doug McIlroy's word frequency program in response to Knuth's 10 pages of Pascal.
```bash
#!/bin/bash
#Doug McIlroy 1986
tr -cs A-Za-z '\n' |
tr A-Z a-z |
sort |
uniq -c |
sort -rn |
sed ${1}q
```

Let run this on Mark Twain's "A Connecticut Yankee in King Arthur's Court".

```bash
$ cat yankee.txt | ./wordFreq.sh
6093 the
```

Our wordfreq lambda function:
```javascript
console.log('Loading function');

var exec = require('child_process').exec;

exports.handler = function(event, context) {
 exec('echo '+ event.key1 + '| sh ./wordFreq.sh', function(error, stdout) {
        context.done(error, stdout);
    });
};
```

* event is the JSON we pass our AWS Lambda function. 
* Usually call your main handler file index.js

```bash
#Don't do this
zip -r mylamda.zip mylambda
#Do this
cd mylambda
zip -r mylambda.zip ./*
```

I build my lambdas on ec2 then copy them to my box before uploading
```bash
 scp -i "apair.pem" ec2-user@54.56.333.229:mylambda.zip mylambda.zip
```

# Compiling for Lambda
* Set up an EC2 instance on AWS Linux
* Generate a key pair so you can ssh into it
* For C++/Haskell download/build static libraries to link with
* Use the ldd command to find your grocery list of static libraries. Example: ldd a.out
* [See stack discussion](https://github.com/commercialhaskell/stack/issues/1032)
* [See GHC discussion](https://ghc.haskell.org/trac/ghc/ticket/10912)

```bash
sudo yum update
sudo yum install nodejs npm --enablerepo=epel
```

```bash
ghc hello.hs 
./hello 
du -h hello
strip hello
du -h hello
```

#Fast Fibbonaci
* Take Fib Finite State Automata where 'b' may not repeat and each word must start 'a' and end 'a': 
* ()|a|aa|aba,aba|aaaa,aaba,abaa|aaaaa,aaaba,aabaa,abaaa,ababa|...  

* Take that adjacency matrix and take it to the nth power with binary doubling

* Use GNU MP for large Integers

* The i,j entry is now words of length n that start at letter i and end at letter j

* Optimize: 0 x thing = 0; 1 x thing = thing 

```haskell
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

```

```bash
ghc FastFib.hs -O2 -o FastFib -threaded -static -optl-static
strip FastFib
```

```javascript
console.log('Loading function');

var exec = require('child_process').exec;

exports.handler = function(event, context) {
 exec('./FastFib '+ event.key1 , function(error, stdout) {
        context.done(error, stdout);
    });
};
```

# API Gateway trigger for AWS Lambda
```bash
curl -H "Content-Type: application/json" -X POST -d "{\"key1\": \"30\"}" https://pekdudne7d.execute-api.us-east-1.amazonaws.com/prod
```

The two zip files have been precompiled on AWS Linux. Enjoy.


## Update
I now compile locally using the lambci/lambda Docker container. To move files out use:
```bash
docker cp <containerId>:/file/path/within/container /host/path/target
```


