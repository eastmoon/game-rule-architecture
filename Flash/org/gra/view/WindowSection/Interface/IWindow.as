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

package org.gra.view.WindowSection.Interface
{	
	/*import：Flash內建元件庫*/
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.gra.ApplicationFacade;

	public interface IWindow
	{		
		/*public function：對外公開函數*/		
		/*public event function：公開事件函數*/
		// 時間軸更新
		function onEnterFrame( a_event : Object = null ) : void
		// 註冊至View
		function onRegister() : void;
		// 移除至View
		function onRemove() : void;
		// 設定Section
		function onSetSection() : void;
		/*public get/set function：變數存取介面*/
		/*read only：唯讀*/
		// 取得父親視窗的顯示狀態。
		function getCurrentVisible() : Boolean
		// 取得當前的可視區。
		function getCurrentViewport() : Rectangle
		// 存取名稱
		function getName() : String
		/*read/write：讀寫*/
		
		// 存取操作，父級視窗
		function getParentWindow() : IDecorator
		function setParentWindow( a_parent : IDecorator ) : void
		
		// 存取操作，顯示內容
		function getSection() : ISection
		function setSection( a_section : ISection ) : void
		
		// 存取操作，位置
		function getLoacl() : Point
		function setLocal( a_x, a_y ) : void

		// 存取操作，深度
		function getDepth() : Number
		function setDepth( a_depth : Number ) : void
		
		// 存取操作，視區
		function getViewport() : Rectangle
		function setViewport( a_width : Number, a_height : Number ) : void
		
		// 存取操作，Window當前註冊的ApplicationFacade
		function getApplication() : ApplicationFacade
		
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
	}
}