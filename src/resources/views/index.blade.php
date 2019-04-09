<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>workflow-view</title>
    <style>
        html, body {
            width: 100%;
            height: 100%;
        }

        body {
            font: 300 14px 'Helvetica Neue',
            Helvetica;
        }

        .node rect {
            stroke: #333;
            fill: #999;
        }

        .edgePath path {
            stroke: #333;
            fill: #333;
            stroke-width: 1.5px;
        }
    </style>
</head>
<body>
<svg width=1900 height=600>
    <g/>
</svg>
</body>
<script src="{{asset('vendor/yiche/workflow/js/jquery-latest.js')}}"></script>
<script src="{{asset('vendor/yiche/workflow/js/d3.v3.min.js')}}"></script>
<script src="{{asset('vendor/yiche/workflow/js/dagre-d3.min.js')}}"></script>
<script>
    // Create a new directed graph
    var g = new dagreD3.graphlib.Graph().setGraph({});

    // States and transitions from RFC 793
    var states = <?php echo json_encode(array_values(array_column($item_map, 'title_id')))?>;
    // Automatically label each of the nodes
    states.forEach(function (state) {
        g.setNode(state, {label: state});
    });

    // Set up the edges
    <?php foreach($links as $k=>$v) {?>
    g.setEdge("<?php echo $item_map[$v['current_id']]['title_id']?>", "<?php echo $item_map[$v['next_id']]['title_id']?>", {label: "<?php echo $show_condition && $item_map[$v['current_id']]['node_type'] == 'gateway' && $item_map[$v['next_id']]['condition'] ? substr(str_replace('"', '\\"', $item_map[$v['next_id']]['condition']), 0, 30) . (strlen(str_replace('"', '\\"', $item_map[$v['next_id']]['condition'])) > 30 ? '...' : '') : ''?>"});
    <?php }?>

    // Set some general styles
    g.nodes().forEach(function (v) {
        var node = g.node(v);
        node.rx = node.ry = 5;
    });

    // Add some custom colors based on state
    <?php foreach($item_map as $k=>$v) {?>
    <?php if($v['node_type'] == 'gateway') {?>
    g.node('<?php echo $v['title_id']?>').style = "fill: #B3EE3A";
    <?php }?>
    <?php if($v['node_type'] == 'event') {?>
    g.node('<?php echo $v['title_id']?>').style = "fill: #4169E1";
    <?php }?>
    <?php if($v['node_type'] == 'end') {?>
    g.node('<?php echo $v['title_id']?>').style = "fill: #EE2C2C";
    <?php }?>
    <?php }?>
    //g.node('ESTAB').style = "fill: #347";

    var svg = d3.select("svg"),
        inner = svg.select("g");

    // Set up zoom support
    var zoom = d3.behavior.zoom().on("zoom", function () {
        inner.attr("transform", "translate(" + d3.event.translate + ")" +
            "scale(" + d3.event.scale + ")");
    });
    svg.call(zoom);

    // Create the renderer
    var render = new dagreD3.render();

    // Run the renderer. This is what draws the final graph.
    render(inner, g);

    // Center the graph
    var initialScale = 0.75;
    zoom
        .translate([(svg.attr("width") - g.graph().width * initialScale) / 2, 20])
        .scale(initialScale)
        .event(svg);
    svg.attr('height', g.graph().height * initialScale + 40);
</script>
</html>