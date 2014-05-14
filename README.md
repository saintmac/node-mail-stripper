node-mail-stripper
==================

Strip signatures and previous emails from email bodies

# install
`npm install node-mail-stripper`

# use
## simple use
```javascript
    stripper = new MailStripper();
    message = stripper.parse(mail);
```

MailStripper will parse the mail line by line. Whenever a line matches one of the patterns, it will be treated as a signature and the parsing of the email will stop.
The output message will contain all the lines before that first 'signature' line

## add custom rules
```javascript
    stripper = new MailStripper({
        patterns: [
            /\d{7}/,
            /^####/,
        ]});
    message = stripper.parse(mail);
```

# contribute
If you find yourself adding rules that could be relevant to other projects, please add them directly to the source and send me a pull request or just create an issue and I'll add them myself

## test
`npm test`

## build
`coffee -c src/mail-stripper.coffee`




