
processTags = (j) ->
  tags = {}
  untagged = []
  for h in j
    if h.tags
      for t in h.tags
        if tags[t]
          tags[t].push h
        else
          tags[t] = [h]
    else
      untagged.push h
  tags["untagged"] = untagged
  tags

clicker = (e) ->
  console.log e
  d = processTags e.value
  draw d
filter = []
colors = ["#fafafa","rgb(255, 118, 118)","rgb(243,243,133)","rgb(134, 204, 79)"]


d3.json "hosts.json", (e, json) ->
  freq = d3.entries(processTags(json.items)).sort((a,b) -> b.value.length - a.value.length)
  draw freq

draw = (data) ->
  container = d3.select(".container")
  container.selectAll(".tagbox").data(data).enter()
     .append("div")
     .classed("tagbox",true)
     .style("background-color",(d) -> colors[Math.floor(Math.random() * 4)])
     .on("click",clicker)
     .append("p")
     .text((d) -> d.key)
     .insert("p")
     .classed("count",true)
     .text((d) -> d.value.length)
  container.selectAll(".tagbox").data(data).exit().remove()
