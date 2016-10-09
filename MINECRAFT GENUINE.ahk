FileEncoding, UTF-8 ; UTF-8 ENCODE TYPE
#NoEnv
#NoTrayIcon
#include lib/JSON.ahk
;
;	프로그램 설명 : MOJANG API를 이용하여 정품여부를 판별합니다.
;	작성자 : 김대현
;

main:
InputBox, MINECRAFT_ID, 마인크래프트 정품유저 판독기,마인크래프트 아이디를 입력하세요`n본 프로그램은 MOJANG API를 이용해`n정품여부를 판별합니다.,,300,200
if(MINECRAFT_ID == NULL){
	if ErrorLevel {
		;종료시 모션
		ExitApp
	}
	else {
		msgbox, 아무것도 입력되지 않았습니다 다시시도하세요.
		goto, main
	}
}
API := "https://api.mojang.com/users/profiles/minecraft/"
CHECKURL = %API%%MINECRAFT_ID% ;TARGET URL

;URL를 파일로 받아와서 변수에 저장한다
URLDownloadToFile, %CHECKURL%, temp.txt
Fileread, CHECK_GENUINE, temp.txt
FileDelete, temp.txt

;NULL값인지 확인후 정품 판별
if(CHECK_GENUINE == NULL){
	msgbox, API 정보를 불러올 수 없습니다.`n이 사람은 정품유저가 아닙니다.
}
else {
	;StringReplace, CHECK_GENUINE, CHECK_GENUINE, `{`"id`"`:`",,All
	;StringReplace, CHECK_GENUINE, CHECK_GENUINE, `"`,`"name`"`:`"%MINECRAFT_ID%`"`},,All
	;JSON 라이브러리를 이용하여 읽는것으로 변경
	CHECKJSON := JSON.Load(CHECK_GENUINE)
	ID_NAME := CHECKJSON.name
	ID_NUMBER := CHECKJSON.id
	
	msgbox, %ID_NAME%님은 정품유저가 맞습니다.`n고유번호 : %ID_NUMBER%
}