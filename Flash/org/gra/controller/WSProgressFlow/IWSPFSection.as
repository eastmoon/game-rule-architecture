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

package org.gra.controller.WSProgressFlow
{	
	/*import：Flash內建元件庫*/
	import flash.display.Sprite;
	
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.puremvc.as3.interfaces.IMediator;
	import org.gra.controller.Progress.IProgressController;

	public interface IWSPFSection extends IMediator
	{		
		/*public function：對外公開函數*/
		// 顯示內容進場，Progress Flow 控制函數
		function Display( a_flow : IProgressController = null ) : void
		// 顯示內容退場，Progress Flow 控制函數
		function Disappear( a_flow : IProgressController = null ) : void
		// 載入處理，Progress Flow 控制函數
		function Loading( a_flow : IProgressController = null ) : void
		// 初始化數據，Progress Flow 控制函數
		function Initial( a_flow : IProgressController = null ) : void
		// 關閉內容，Progress Flow 控制函數
		function Close( a_flow : IProgressController = null ) : void
		// 前置處理，Progress Flow 控制函數
		function PreProcess( a_flow : IProgressController = null ) : void
		// 完成處理，Progress Flow 控制函數
		function CompleteProcess( a_flow : IProgressController = null ) : void
		/*public event function：公開事件函數*/
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		/*read/write：讀寫*/
	}
}