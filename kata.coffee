
fs = require 'fs'
yaml = require 'js-yaml'
argv = require('yargs')
          .alias('f', 'form')
          .argv


randomMemberOf = (a) ->
  a[Math.floor(Math.random() * a.length)] 

randomKeyOf = (o) ->
  randomMemberOf(k for k of o)

loadYml = (what) -> 
  yaml.load(fs.readFileSync("#{__dirname}/seeds/#{what}.yml", 'utf8'))

artifacts = loadYml 'artifacts'
forms = loadYml 'forms'
nouns = loadYml 'nouns'
verbs = loadYml 'verbs'

if argv.form
  chosenForm = argv.form
else
  chosenForm = randomMemberOf(forms)
chosenArtifactType = randomKeyOf artifacts
chosenArtifact = randomMemberOf artifacts[chosenArtifactType]
chosenNoun = randomMemberOf nouns
chosenVerb = randomMemberOf verbs

katas = [
  -> "Write #{chosenForm} about #{chosenNoun} and #{chosenArtifact}"
  -> "Write #{chosenForm} about #{chosenNoun} and #{chosenArtifact} using the verb '#{chosenVerb}'"
]

console.log  randomMemberOf(katas)()