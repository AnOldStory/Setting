let result="";
document.querySelectorAll("td.song").forEach(i=>{
Array.from(i.children).map((j,idx)=>result+=idx?j.innerText.replace("\n아티스트명","")+"\n":j.innerText+" - ")
})
