HTMLWidgets.widget({

    name: "imteractive",
    type: "output",

    initialize: function(el, width, height) {
        return {}
    },

    resize: function(el, width, height, instance) {
    },

    renderValue: function(el, x, instance) {

        var vizId = el.id;


        var data = HTMLWidgets.dataframeToD3(x.data);
        var debug = x.settings.debug;
        var clickable = x.settings.clickable;
        var fill = x.settings.fill;
        var pointer = x.settings.pointer;
        var modal = x.settings.modal;


        if (debug) {
            console.log("x", x)
            console.log("data", data)
            console.log("settings", x.settings)
            console.log("vizId", vizId)
        }

        //Styles
        d3.select("#" + el.id)
            .append("style")
            .html(x.settings.styles);

        // Modal + Tpl Container Div
        var modalContainer = '<div id="modal"><div id="content"></div>' +
            '<button id="modalClose" onclick="d3.select(\'#modal\').style(\'display\',\'none\');">X</button>' +
            '</div></div>\n';
        var tplContainer = '<script id="main-tpl" type="text/html"></script>';
        d3.select("#" + el.id).append("div").html(modalContainer + tplContainer);
        var template = x.settings.template || "id: {id}";
        d3.select("#main-tpl").html(template)

        var maxWidth = x.settings.maxWidth || "100%";
        var width = Math.min(el.offsetWidth, maxWidth);
        var height = el.offsetHeight;
        console.log(width, height)

        d3.select("#svgContainer").remove();
        var svgContainer = d3.select("#" + el.id)
            .append('div')
            .attr("id", "svgContainer")
            .attr("width", width)
            .attr("height", height);

        if (x.type == "vector") {
            svgContainer.html(x.image);
            svgContainer.select("svg")
                .attr("width", width)
                // .attr("height", height)
                .attr("x", 0)
                .attr("y", 0);
        }
        if (x.type == "image") {
            var svg = svgContainer.append("svg")
                .attr("width", width)
                .attr("height", height);

            var g = svg.append("g")
                .attr("width", width)
                .attr("height", height)
                .append("image")
                .attr("width", "100%")
                // .attr("height", "100%")
                .attr("x", 0)
                .attr("y", 0)
                .attr("xlink:href", x.image);
        }

        // Template

        var compileTemplate = function(_template, _values) {
            return [].concat(_values).map(function(d, i) {
                return _template.replace(/{([^}]*)}/g, function(s, key) { return d[key] || ''; });
            }).join('\n');
        };

        var showModal = function(id, values) {
            var newContent = compileTemplate(d3.select('#main-tpl').html(), values);
            d3.select("#modal")
                .style("display", "block")
                .select("#content").html(newContent);
            console.log("Hello Modal")
        }

        var svgimg = d3.select("svg");
        var idsSelector = data.map(function(x) { return ("#" + x.id) }).reverse().join(", ");
        if(debug){console.log(idsSelector)}
        var svgimgsel = svgimg.selectAll(idsSelector)
            .data(data, function(d) { return d ? d.id : this.id; });

        if(fill)
            svgimgsel.style("fill",function(d){
                console.log(d)
                return(d.color)
            })
        if(pointer){
            d3.selectAll(idsSelector).style("cursor", "pointer");
        }
        if(clickable){
            d3.selectAll(idsSelector).style("cursor", "pointer");
            svgimgsel.on("click", function(d, i) {
                console.log("d on click", d)
                if (typeof Shiny != "undefined") {
                    Shiny.onInputChange(vizId + '_clicked_id', d.id)
                    var now = new Date().getTime();
                    Shiny.onInputChange('imteractive_clicked', { id: d.id, timestamp: now })
                    console.log("CLICKED REGION", { id: d.id, time: now })
                }
                var id = this.id;
                var values = data.filter(function(d) { return d.id == 1 })[0];
                console.log("values", d)
                if(modal){
                    showModal(id, d);                
                }
                console.log("Hello Click", id)
            })
        }

    }
});