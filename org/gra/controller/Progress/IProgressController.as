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
	import org.puremvc.as3.interfaces.INotification;

	public interface IProgressController extends INotification
	{		
		/*public function：對外公開函數*/		
		// 增加需要執行的流程
		function AddProgress( a_progressName :  String, a_index : Number = -1 ) : void
		// 複製流程控制器
		function Clone( a_clone : IProgressController = null ) : IProgressController
		// 移至指定步驟
		function Step( a_step : Number ) : void
		// 移至指定名稱的步驟
		function StepByName( a_stepName : String ) : void
		// 移至下個步驟
		function Next() : void
		// 移至上個步驟
		function Back() : void
		/*public event function：公開事件函數*/
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		// 所屬的Progress
		function getProgress() : IProgress
		/*read/write：讀寫*/
		// 當前步驟
		function getCurrentStep() : Number
		function setCurrentStep( a_step : Number ) : void
		
		// 當前步驟的名稱
		function getCurrentStepName() : String
		function setCurrentStepName( a_stepName : String ) : void
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
	}
}