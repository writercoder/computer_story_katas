
fs = require 'fs'
yaml = require 'js-yaml'

randomMemberOf = (a) ->
  a[Math.floor(Math.random() * a.length)] 

randomKeyOf = (o) ->
  randomMemberOf(k for k of o)

loadYml = (what) -> 
  yaml.load(fs.readFileSync("#{__dirname}/seeds/#{what}.yml", 'utf8'))

artifacts = loadYml 'artifacts'
outputs = loadYml 'outputs'
nouns = loadYml 'nouns'

# console.log randomMemberOf(outputs)

chosenOutput = randomMemberOf outputs
chosenArtifactType = randomKeyOf artifacts
chosenArtifact = randomMemberOf artifacts[chosenArtifactType]
chosenNoun = randomMemberOf nouns

kata = "Write a #{chosenOutput} about a #{chosenNoun} and #{chosenArtifact}"

console.log kata