/**
 * Created by ZhangBanXian on 2017/11/16.
 */

function canvas_config(){

        var max_width = $('input[name=max_width]').val()
        var max_height = $('input[name=max_height]').val()
        var left_blank = $('input[name=left_blank]').val()
        var top_blank = $('input[name=top_blank]').val()
        var right_blank = $('input[name=right_blank]').val()
        var buttom_blank = $('input[name=buttom_blank]').val()

        return {
            "max_width": max_width,
            "max_height": max_height,
            "left_blank": left_blank,
            "top_blank": top_blank,
            "right_blank": right_blank,
            "buttom_blank": buttom_blank
        }
    }


    function root(forms) {

        var canvas = document.getElementById('canvas');
        // 导入数据
        canvas.width = Number(forms["max_width"])
        canvas.height = Number(forms["max_height"])
        var max_width = canvas.width
        var max_height = canvas.height

        // 给出间隔其他留空(画布的宽度, 高度, 左空， 上空,  右空, 下空, squrt(data.length), )
        function getPositionsConfig(canvas_width, canvas_height, left_blank, top_blank, right_blank, buttom_blank, fang){
            var left_space = (canvas_width - left_blank - right_blank)/(fang-1)
            var top_space = (canvas_height - top_blank - buttom_blank)/(fang-1)
            return {
                "fang": fang,
                "left_space": left_space,
                "top_space": top_space,
                "left_blank": left_blank,
                "top_blank": top_blank
            }
        }

        // 假设传进来的告警IP信息为Json形式
        /***
        function setForgeData(fang) {
            var temp_data = []
            for (var i = 0; i < fang*fang - 3; i++) {
                if (i % 3 == 0)
                    temp_data.push({"ip": "192.168.0." + (i + 1), "stat": 0})
                else temp_data.push({"ip": "192.168.0." + (i + 1), "stat": 1})
            }
            return temp_data
        }
         **/

        function Main(dict, temp_data) {
            fang = dict["fang"]
            left_blank = dict["left_blank"]
            left_space = dict["left_space"]
            top_space = dict["top_space"]
            top_blank = dict["top_blank"]

            var Nodes = []
            for(var k = 0; k<temp_data.length; k++){
                var hang = parseInt(k / fang)
                var lie = k % fang
                var temp_node = node(left_blank + left_space* lie, top_blank + top_space* hang, 'server.png')
                temp_node.click(function(event){
                    // 点击后可以弹出表格或者栏目
                    $("#myModal").modal('show')
                });

                temp_node.text = temp_data[k]["ip"]
                if( temp_data[k]["stat"] == 1 ){
                    temp_node.alarm = temp_data[k]["ip"]
                }
                Nodes.push(temp_node)
            }
            /*****  红色告警消息 目前展示为 IP ******/
            setInterval(function(){
                for(var i =0; i< temp_data.length; i++){
                    if (temp_data[i]["stat"] == 0) continue;

                    node = Nodes[i]
                    if(node.alarm == temp_data[i]["ip"]){
                        node.alarm = null;
                    }else{
                        node.alarm = temp_data[i]["ip"]
                    }
                }
            }, 600);
        }

        // ## 基于最大长宽的基础画出方振 %fang 的除
        var stage = new JTopo.Stage(canvas);
        // 显示工具栏
        // showJTopoToobar(stage);

        var scene = new JTopo.Scene();
        scene.background = '/static/jtopot/img/bg.jpg';

        function node(x, y, img) {
            var node = new JTopo.Node();
            node.setImage('/static/jtopot/img/statistics/' + img, true);
            node.setLocation(x, y);
            scene.add(node);
            return node;
        }

        $.ajax({
            type:"GET",
            url:"/jtopo/jtopo_data/", //测试用,test_list
            dataType:"json",
            //data: {dat:dict},
            success:function(res){
                console.log("ajax-seccess")
                console.log(res)
                temp_data = res.data;
                fang = parseInt(res.fang)

                Main(getPositionsConfig(
                    Number(forms["max_width"]),
                    Number(forms["max_height"]),
                    Number(forms["left_blank"]),
                    Number(forms["top_blank"]),
                    Number(forms["right_blank"]),
                    Number(forms["buttom_blank"]),
                    fang), temp_data);
                // 画布舞台添加试图
                stage.add(scene);

                }
            });
    }

    // 按钮函数; 进口函数。
    function commit(){
        var canvas = document.getElementById('canvas');
        canvas.getContext("2d").clearRect(0,0,canvas.width,canvas.height);

        var forms = canvas_config()
        root(forms)
    }

    //commit()

/**
 * Created by ZhangBanXian on 2017/11/17.
 */
