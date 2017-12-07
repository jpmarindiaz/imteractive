HTMLWidgets.widget({

    name: "imteractive",
    type: "output",

    initialize: function(el, width, height) {
        return ({})
    },

    resize: function(el, width, height, instance) {
        // instance.draw();
    },

    renderValue: function(el, x, instance) {

        var imteractive = instance;
        var vizId = el.id;

        // Modal Container Div
        var modalContainer = '<div id="modal"><div id="content"></div>' + 
        '<button id="modalClose" onclick="d3.select(\'#modal\').style(\'display\',\'none\');">X</button>' +
        '</div></div>';
        d3.select("#" + el.id).html(modalContainer);
        // tpl Container Div
        var tplContainer = '<script id="main-tpl" type="text/html"></script>';
        d3.select("#" + el.id).html(tplContainer);
        var template = x.settings.template || "id: {id}";
        d3.select("#main-tpl").html(template)

        var maxWidth = x.settings.maxWidth || 400;
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

        var svgimg = d3.select("svg")
        svgimg.selectAll("[id^=info]")
            .on("click", function(d, i) {
                id = this.id;
                showModal(id, values);
                console.log("Hello Click", id)
            })

    }
});