/*
	Info:
		- Game Rule Architecture kernel code.
		
	Date:
		- 2013.02.08
		
	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
	
	
 	Copyright (c) 2013 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/

package org.gra.view.DynamicDetection
{	
	/*import：Flash內建元件庫*/
	/*external import：外部元件庫、開發人員自定元件庫*/

	public interface IDynamicDetection
	{		
		/*public function：對外公開函數*/		
		// 設定偵測演算法物件
		function DefinedAlgorithm( a_algorithm : IDynamicDetection ) : void
		// 計算演算
		function CalculateAlgorithm( a_param : Object = null ) : void
		// 傳送給專注目標
		function DispatchEventToTarget( a_event : Object, a_target : Array = null ) : void
		/*public event function：公開事件函數*/
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		// 取回演算物件
		function getAlgorithm() : IDynamicDetection
		// 專注目標
		function getFocus() : Array
		// 非專注目標
		function getUnfocus() : Array
		// 新選擇的專注目標
		function getAddationFocus() : Array
		// 新選擇的非專注目標
		function getAddationUnfocus() : Array
		/*read/write：讀寫*/
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
	}
}