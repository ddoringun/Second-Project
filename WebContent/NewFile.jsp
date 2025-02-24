<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>로드뷰 생성하기</title>
    
</head>
<body>
<!-- 로드뷰를 표시할 div 입니다 -->
<div id="roadview" style="width:50%;height:900px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3010ba59fe5cb4ef476a120272fd67f0"></script>
<script>
var roadviewContainer = document.getElementById('roadview'); //로드뷰를 표시할 div
var roadview = new kakao.maps.Roadview(roadviewContainer); //로드뷰 객체
var roadviewClient = new kakao.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체

var position = new kakao.maps.LatLng(33.450701, 126.570667);

// 특정 위치의 좌표와 가까운 로드뷰의 panoId를 추출하여 로드뷰를 띄운다.
roadviewClient.getNearestPanoId(position, 50, function(panoId) {
    roadview.setPanoId(panoId, position); //panoId와 중심좌표를 통해 로드뷰 실행
});
</script>
</body>
</html>