import json

let jsonNode = parseJson("""{"key": 3.14}""")

doAssert jsonNode.kind == JObject
doAssert jsonNode["key"].kind == JFloat
