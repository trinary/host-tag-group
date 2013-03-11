
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
  d = d3.entries(processTags e.value).sort((a,b) -> b.value.length - a.value.length)
  draw d
colors = ["#fafafa","rgb(255, 118, 118)","rgb(243,243,133)","rgb(134, 204, 79)"]


d3.json "hosts.json", (e, json) ->
  freq = d3.entries(processTags(json.items)).sort((a,b) -> b.value.length - a.value.length)
  draw freq

draw = (data) ->
  console.log data
  container = d3.select(".container")
  boxes = container.selectAll(".tagbox").data(data, (d) -> d.key)
  boxes.enter()
     .append("div")
     .classed("tagbox",true)
     .style("background-color",(d) -> colors[Math.floor(Math.random() * 4)])
     .on("click",clicker)
     .append("p")
     .text((d) -> d.key)
     .insert("p")
     .classed("count",true)
     .text((d) -> d.value.length)
     .transition()
     .duration(500)
     .style("opacity",1)
  boxes.exit().transition().duration(500).style("opacity",0).remove()
