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

	public interface IDecorator extends IWindow
	{		
		/*public function：對外公開函數*/		
		// 新增功能組件
		function AddWindow( a_window : IWindow, a_depth : Number = -1 ) : void
		
		// 移除功能組件
		function RemoveWindow( a_window : IWindow ) : void
		
		// 擁有功能組件
		function HasWindow( a_window : IWindow ) : Boolean
		
		// 指定功能組件深度
		function SwitchWindowDepth( a_window : IWindow, a_depth : Number ) : void
		/*public event function：公開事件函數*/
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		/*read/write：讀寫*/
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
	}
}