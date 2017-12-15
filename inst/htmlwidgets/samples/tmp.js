var data = [
{
    id: 1,
    val: 2
},{
    id: 2,
    val: 2
},{
    id: 3,
    val: 2
}, 
];

var values = data.filter(function (el){return el.id == 1})[0];
console.log(values)

var idsSelector = data.map(function(x){return(x.id)}).reverse().join(", ");
console.log(idsSelector)

