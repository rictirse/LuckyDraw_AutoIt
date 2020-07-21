#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Array.au3>

Dim $input = "List.txt"
Dim $i, $tmpStr, $Num = 0
Dim $ArraySize, $Data[1]
Dim $a, $b,$tmp

$File = FileOpen ( $input, 0)
If $File = -1 Then
	MsgBox (16,"","OPEN ERROR",16)
	Exit
EndIf
While 1
	$tmpStr = FileReadLine($File)
	if @error=-1 Then ExitLoop
	If $tmpStr <> "" Then
		$ArraySize +=1
	EndIf
	ReDim $Data[$ArraySize]
WEnd
FileClose($File)

$File = FileOpen ( $input, 0)
For $i=0 to UBound ($Data)-1
	$tmpStr = FileReadLine ($File)
	$Data[$i] = $tmpStr
Next
FileClose ($File)

_ArrayDisplay ( $Data, "List")

$Form = GUICreate ( "Shuffle", 241, 194, 490, 133)

GUICtrlCreateLabel ("Amount", 8, 11, 55, 20)
	GUICtrlSetFont (-1, 11, 800)

$txtAmount = GUICtrlCreateInput ( "", 70, 10, 80, 21)

$btnRun = GUICtrlCreateButton ( "Run", 159, 8, 75, 25)

$txtResult = GUICtrlCreateEdit ( "", 8, 40, 225, 140)
GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $btnRun
			btnRun_Click()
	EndSwitch
WEnd

Func btnRun_Click()
	If GUICtrlRead ($txtAmount) = "" Then
		MsgBox ( 16, "ERROR", "請輸入完整資料",1)
	Else
		Dim $i,$j,$s
		For $i = UBound ($Data)-1 To 1 Step -1
			$j = Random ( 0, UBound ($Data)-1, 1)
			Swap ($Data[$i], $Data[$j])
		Next
		For $i = 0 To GUICtrlRead ($txtAmount)-1
			$j = Random ( 0, GUICtrlRead ($txtAmount), 1)
			if StringInStr (Chr(10)&$s,Chr(10)&$Data[$j]&@CRLF) <> 0 then
				$i -=1
				ContinueLoop
			EndIf
			$s = $s&$Data[$j]&@CRLF
		Next
		GUICtrlSetData ( $txtResult, $s)
	EndIf
EndFunc

Func Swap( ByRef $a, ByRef $b)
	Local $Tmp = $a
	$a = $b
	$b = $Tmp
EndFunc

;~ 	Local $Pos
;~ 	For $i=0 to UBound($data)-2
;~ 		$Pos = FindMinIndex($data, $i)
;~ 		; Swap($data[$i], $data[$pos])
;~ 		If $Pos<> $i Then
;~ 			Swap($data[$i], $data[$pos])
;~ 		EndIf
;~ 	Next