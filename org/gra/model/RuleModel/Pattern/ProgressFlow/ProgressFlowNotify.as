/*
//////////////////////////////////
//// 	 ProgressFlowNotify   ////
//////////////////////////////////
	Info:
		- Single Flow Framework State，單一流程架構的狀態物件。
		- 單一流程架構運作時各狀態列舉，此物件是供給SingleFlowFramework管理運作順序的物件。
		
	Usage:(有開放public 讓外部使用)
		- 
	static member:
		- DisappearPreparation : 退場準備
		- Disappear : 退場
		- DisappearCompletion : 退場完成
		- LoadingPreparation : 讀取準備
		- Loading : 讀取
		- LoadingCompletion : 讀取完成
		- DisplayPreparation : 進場準備
		- Display : 進場
		- DisplayCompletion : 進場完成
	Date:
		- 2012.05.08
		
	Author:
		- Name : EastMoon
		- Email : jacky_eastmoon@hotmail.com
*/

package org.gra.model.RuleModel.Pattern.ProgressFlow
{
	/*import*/
	/*external import*/
	public class ProgressFlowNotify extends Object
	{
		/*static const variable : 靜態常數變數*/
		public static const DISAPPEAR_PREPARATION = "PFNDisappearPreparation";
		public static const DISAPPEAR = "PFNDisappear";
		public static const DISAPPEAR_COMPLETE = "PFNDisappearComplete";
		public static const LOADING_PREPARATION = "PFNLoadingPreparation";
		public static const LOADING = "PFNLoading";
		public static const LOADING_COMPLETE = "PFNLoadingComplete";
		public static const DISPLAY_PREPARATION = "PFNDisplayPreparation";
		public static const DISPLAY = "PFNDisplay";
		public static const DISPLAY_COMPLETE = "PFNDisplayComplete";
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		/*display object variable：顯示物件變數，如MovieClip等*/
		/*constructor：建構值*/
		public function ProgressFlowNotify() 
		{
		}
		/**public function：對外公開函數*/
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
		
	}		
}
/*end of package*/