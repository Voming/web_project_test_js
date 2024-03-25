<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 선택 / 반대 선택</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
.checkboxs {
	overflow: hiddenl
}

.checkedItems {
	clear: both;
	border: 1px solid black;
}

.checkboxs>div {
	float: left;
	margin-right: 20px;
}
</style>
<script>
const itemCount = 10;
$(loadHandler);
function loadHandler(){
	/* 화면 구성 */
	var htmlValue ='';
	for(var i=1; i<=itemCount;i++){
		htmlValue+=`
		<div>
			<label for="item-\${i}">메뉴-\${i}</label> 
			<input type="checkbox" id="item-\${i}" data-itemcode="\${i}" class="item">
		</div>
		`;
	} /* lable은 id를 for로 부여한다  */
	/* 반목문으로 생성된 코드로 checkboxs에 넣어주기 */
	$(".checkboxs").html(htmlValue);
	
	/* 2. 전체 선택 이벤트 등록 */
	$("#allCheck").on("click", allCheckHandler);
	
	/* 4. item(item)들 이벤트 등록 */
	$(".item").on("click", itemCheckHandler);
	
	/* 6. 반대선택 이벤트 등록 */
    $("#revCheck").on("click", revCheckHandler);
	
	
}

/* 3. 전체선택 이벤트 처리 CB Handler */
function allCheckHandler(){ /* #allCheck */
	/* attr - 동적페이지 변화인지 되지 않음
	attr 은 엘리먼트의 속성 값을 가져오거나 변경할수있음 */
	//console.log($(this).attr("checked"));  /* 아이디가 allCheck인 것의 체크된 것 가져옴 */
	/* prop - 동적 페이지 변화를 인지하고 그 결과 값을 true/falsefh 로 줌 */
	//console.log($(this).prop("checked")); /* 아이디가 allCheck인것이 체크되었는지 반환 */

	/* 10개 elements */
	//console.log($(".item"));
	
	var allchecked = $(this).prop("checked");  /* T/F 값으로 반환됨 */
	
	/* 10개 elements 변경*/
	$(".item").prop("checked", allchecked); /* 전체 선택을 했다면 레이블에 전체 선택했음을 알림 */
	
	/* 10. 전체 선택 처리후 checkItems에도 전체 적용 */
	if(allchecked){
		$(".item").each(function(){
			console.log($(this).data("itemcode"));
			//checkedItems에 들어있는
			var temp = ".checkedItems > div[data-itemcode="+$(this).data("itemcode")+"]";
			console.log($(temp).length); //checkItems에 하나라도 들어있으면 1이상이 뜸
			if(!$(temp).length){/* 0이었다면 */
				var label = $(this).parent().children("label").html(); /* label을 텍스트를 가지고 와서 */
				var htmlVal = '';
				htmlVal +='<div data-itemcode="'+$(this).data("itemcode")+'">';
				htmlVal +='	<span>'+label+'</span>';
				htmlVal +='</div>';
				//추가할 문장을 만들어서 checkedItems에 넣어줌
				$(".checkedItems").append(htmlVal);
			}
		});
	}else{
		$(".checkedItems").html("");
	}
	
}

function itemCheckHandler(){ //방금 채크누른 곳에서 이벤트 발생
	/* 8. checkedItems 이벤트 발생 바로 그 item의 div로 생성 */
	var label = $(this).parent().children("label").html(); /* label에 있는 문자 값 가져옴 */
	
	if($(this).prop("checked") == true){
		var htmlVal='';
		htmlVal += '<div data-itemcode="' +$(this).data("itemcode")+'">';
		htmlVal += '	<span>' + label + '<span>';
		htmlVal += '</div>';
		$(".checkedItems").append(htmlVal);
	} /* 9. 체크 제거 (item의 div제거) */
	else{
		var checkedElement = this;
		//console.log(checkedElement.innerHTML);
		//checkedElement.innerHTML = '';
		var $checkedElement = $(this); /* 클릭한 this를  jQury형태로 담음 */
		//console.log($checkedElement);
		//jQuery.fn.init {0: input#item-1.item, length: 1}
		//$를 넣으면 jQury형태의 this가 들어있구나라고 확인가능 
		//$checkedElement.html('');
		
		$(".checkedItems").children().each(function(index, element){  //체크된 리스트 전체가 나와서 반복
			/* checkedItems에 있는 element들 조회 */
			console.log(element);
			/*  */
			console.log("this와 element같음");
			console.log(this); //반복문을 돌고있는 것
			console.log($checkedElement); //실제 체크 해제한 것

			console.log($(this).data("itemcode")); //this가 클릭한게 몇번인지 알려줌
			console.log($checkedElement.data("itemcode")); //jQuery로 담은 this가 몇번인지 알려줌
			
			/* 체크된 것안에서 반복문을 돌리면서 해제한 것을 찾아 없앰 */
			if($(this).data("itemcode") == $checkedElement.data("itemcode")){
				$(this).remove();
				// for 문은 아니므로 break; 사용 불가.
				return; 
			}
		});
	}	
	/* 100.  item 이벤트, 반대선택 이벤트 처리시 공통 부분 함수를 호출 - 전체선택체크 */
	updateCheckAllByCheckedItem();
}

/* 7. 반대선택 이벤트 처리 CB Handler */
function revCheckHandler(){
	console.log(this);
	
	/* $(".item").each(function(idx, element){
		console.log(this);
		console.log(element);
		console.log($element.prop("checked"));
		$(element).prop("checked", !$(element).prop("checked"));
	}); */
	
	//
	$(".item").each(function(idx, checkedValue){
		//each외 xxx(prop) 메소드의 cb funciton들은 each기능 내포되어있음
		//2번째 매개인자는 each는 elemnet하나 그외 메소드들은 checked된 값이 전달되어 옴
		console.log(this); //반복문 도는 this
		//console.log(checkedValue); //this와 동일 - 그 중 하나의 checked 의 getter 값(??안가져와짐)
		//console.log($(checkedValue).prop("checked")); 이렇게 사용하면 checked확인 가능
		console.log($(this).prop("checked")); 
		$(this).prop("checked", !$(this).prop("checked")); //반복문 돌면서 뒤집어주기
		
		var index = $(this).data("itemcode");  //idx로 했을 때 예상치 못한 오류가 발생할 수 있으므로 index를 변수에 넣어주기
		/* checkedItems에 반대로 넣어주기 */
		var temp = ".checkedItems > div[data-itemcode="+$(this).data("itemcode")+"]";
		console.log($(temp).length);
		if( !$(temp).length ){ /* 0이었다면 */
			var label = $(this).parent().children("label").html();
			var htmlVal = '';
			htmlVal +='<div data-itemcode="'+$(this).data("itemcode")+'">';
			htmlVal +='	<span>'+label+'</span>';
			htmlVal +='</div>';
			$(".checkedItems").append(htmlVal);
		}else{ /* 리스트에 이미 있었다면 */
			$(".checkedItems").children().each(function(){  //체크된 리스트 전체가 나와서 반복
				/* 체크된 것안에서 반복문을 돌리면서 해제한 것을 찾아 없앰 */
				if($(this).data("itemcode") == index){
					$(this).remove();
					// for 문은 아니므로 break; 사용 불가.
					return; 
				}
			});
		}
	});
	
	
	
	updateCheckAllByCheckedItem();
}

/* 100.  item 이벤트, 반대선택 이벤트 처리시 공통 부분 함수로 만들기 - 전체선택체크 */
function updateCheckAllByCheckedItem(){
	//체크된 item개수가 max와 같다면 전체 선택 버튼 체크
	/* console.log($(".item:checked").length); */
	if($(".item:checked").length == itemCount){
		$("#allCheck").prop("checked", true); //allCheck는 아이디값으로 구별
	}else{
		$("#allCheck").prop("checked",false);
	}
}


</script>

</head>
<body>
	<h1>전체 선택 / 반대 선택</h1>
	<div class="wrap-check">
		<label for="allCheck">전체선택</label><input type="checkbox" id="allCheck">
		| <label for="revCheck">반대선택</label> <input type="checkbox"
			id="revCheck">
	</div>
	<div class="checkboxs">
		<!-- <div>
			<label for="item-n">메뉴item-n<input type="checkbox"
				id="item-n" data-itemcode="n" class="item"></label>
		</div>
		<div>
			<label for="item-n">메뉴item-n<input type="checkbox"
				id="item-n" data-itemcode="n" class="item"></label>
		</div> -->
	</div>
	<div class="checkedItems">
		<!-- <div data-itemcode="n">
			<span>메뉴item-n</span>
		</div>
		<div data-itemcode="n">
			<span>메뉴item-n</span>
		</div> -->
	</div>

</body>
</html>