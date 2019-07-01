<html>
<head>
    <meta charset="UTF-8">
    <style type="text/css">
        em {
            color: red;
            font-size: large;
        }
    </style>
</head>
<body>
<h1>检索结果列表:</h1>
<hr>
<#list poetries as p>
    编号：${p.id}  | 作者：${p.poets.name} | 诗名：${p.title} | 诗的内容： ${p.content}
    <hr>
</#list>
</body>
</html>