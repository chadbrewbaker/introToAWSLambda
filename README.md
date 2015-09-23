# introToAWSLambda
Introduction to AWS Lambda

# What is Lambda

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


Hello world lambda function
```javascript
var exec = require('child_process').exec;

exports.handler = function(event, context) {
    exec('echo Hello World', function(error, stdout) {
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



//into Gateway -> Lambda -> DB https://snowulf.com/2015/08/05/tutorial-aws-api-gateway-to-lambda-to-dynamodb/

$ aws lambda invoke \
--invocation-type RequestResponse \
--function-name helloworld \
--region us-west-2 \
--log-type Tail \
--payload '{"key1":"value1", "key2":"value2", "key3":"value3"}' \
--profile adminuser \
outputfile.txt 
If you want you can save the payload to a file (say "input.txt") and provide the file name as a parameter.

$aws lambda invoke
--function-name somefunction
--payload file://input.txt  //Give it a file as a payload
--payload 'Give the lambda func a string'    //AWS Java funcs must have a fromstring method




* Compiling for Lambda
Set up an EC2 instance on AWS Linux
Generate a key pair so you can ssh into it
For C++/Haskell download/build static libraries to link with
[See stack discussion](https://github.com/commercialhaskell/stack/issues/1032)


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

ghc -O2 FastFib.hs -o FastFib
```




* API Gateway trigger for AWS Lambda



