<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카페 계산기</title>
<!-- js 추가 -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(loadedHandler); //함수 호출 방법

function loadedHandler(){
	console.log("loaded 이벤트 발생시 호출, 주로 event 등록하는 행동을 함");
	//event등록
	console.log($("[type=button]"));
	$("[type=button]").on("click", calcClickHandler);
	//메뉴마다 합계 가격 blur- 포커스를 잃을 때 이벤트 발생
	$(".c").on("blur", cntBlurHandler);
	
}

//수량 입력시 바로 합계 구함
function cntBlurHandler(e){  
	//여기서 this는 입력한 빈칸
	//메뉴마다 합계 가격
	$(this).parent().next().children('input.p').val(
			$(this).parent().prev().text() * $(this).val());
	updateTotal();
}


// 버튼 클릭 이벤트
function calcClickHandler(e){
	$(".c.in").each(
			function(idx, item){
				//this=item
				console.log("item");
				console.log(item);
				// 메뉴마다 합계가격
				// 하나씩 반복문을 돌면서 가격과 입력한 개수를 곱해서 클래스 p인 곳에 담아줌
				//사이에 주석 쓰지 않기
				$(this).parent().next().children('input.p').val(
						$(this).parent().prev().text() * $(this).val());
			});
		updateTotal();
}

function updateTotal(){
	var sum = 0;
	//메뉴 총 개수 합계
	$(".c.in").each(function(idx, item){
		//each - for문을 대신함. event에 handler를 등록함
		//each function 에서의 this 사용시 위 this와 헷갈릴 수 있음
		//console.log(price);
		//item = this
		console.log("this");
		console.log(this);
		//if(idx != ($(".c").length-1)){
		var i = Number($(item).val()); 
		//Number - 문자열을 숫자로 변환하는 함수 
		//val - form의 값을 가져오거나 설정하는 함수
		if (isNaN(i)){ //만약 i에 값이 없으면 0으로 설정
			i=0;
		}
		sum += i; // 총 합은 i(수량) 의 합
	});
	console.log("sum");
	console.log(sum);
	//총 개수에 sum넣어주기
	$("#cTotalCnt").val(sum);
	
	sum=0;
	//합계 계산
	$(".p").each(function(idx, item){
		console.log(item);
		if(idx != ($(".p").length-1)){
			var i = $(item).val() * 1; //숫자로 형태 변경
			if(isNaN(i)){
				i=0; 
			}
			sum += i;
		}
	});
	console.log(sum);
	$("#cTotalPrice").val(sum);
}



</script>

</head>
<body>
	<script>
		console.log("맨위");
		var elem = $("td");
		//아직 아래 부분이 로드 되지 않아서 0으로 나타남
		console.log(elem);
	</script>
	<form>
		<table border=1>
			<tr>
				<td>메뉴</td>
				<td>가격</td>
				<td>수량</td>
				<td>합계</td>
			</tr>
			<tr>
				<td>아메리카노</td>
				<td>2500</td>
				<td><input type=text name="c1" class="c in"></td>
				<td><input type=text name="c1Price" class="p" readonly></td>
			</tr>
			<tr>
				<td>라떼</td>
				<td>3000</td>
				<td><input type=text name="c2" class="c in"></td>
				<td><input type=text name="c2Price" class="p" readonly></td>
			</tr>
			<tr>
				<td>생강라떼</td>
				<td>4500</td>
				<td><input type=text name="c2" class="c in"></td>
				<td><input type=text name="c2Price" class="p" readonly></td>
			</tr>
			<tr>
				<td>딸기바나나라떼</td>
				<td>4500</td>
				<td><input type=text name="c2" class="c in"></td>
				<td><input type=text name="c2Price" class="p" readonly></td>
			</tr>
			<tr>
				<th>합계</th>
				<th></th>
				<th><input type="text" name="cTotalCont" id="cTotalCnt"
					class="c" readonly></th>
				<th><input type="text" name="cTotalPrice" id="cTotalPrice"
					class="c" readonly></th>
			</tr>
			<tr>
				<td colspan="4"><input type="button" value="계산하기"><input
					type="reset"></td>
			</tr>

		</table>
	</form>

	<script>
		console.log("맨밑");
		var elem = $(".in");
		console.log(elem);
	</script>

</body>
</html>