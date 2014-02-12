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

package org.gra.controller.Progress
{	

	/*import：Flash內建元件庫*/
	
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.puremvc.as3.interfaces.ICommand;

	public interface IProgress extends ICommand
	{		
		/*public function：對外公開函數*/		
		// 執行流程
		function ExecuteProgress( a_execute : IProgressController );
		// 增加流程
		function AddProgress( a_progressName :  String, a_function : Function, a_index : Number = -1 );
		/*public event function：公開事件函數*/
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		/*read/write：讀寫*/
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
	}
}