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
	import org.gra.model.RuleModel.Core.RMSpace;

	/*import*/
	/*external import*/
	public class ProgressFlowParams extends Object
	{
		/*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		private var m_step : String;
		private var m_nextStep : String;
		private var m_sourceSpace : RMSpace;
		private var m_targetSpace : RMSpace;
		private var m_loaderSpace : RMSpace;
		private var m_progressFlow : ProgressFlow;
		/*display object variable：顯示物件變數，如MovieClip等*/
		/*constructor：建構值*/
		public function ProgressFlowParams( a_progressFlow : ProgressFlow = null ) 
		{
			this.m_progressFlow = a_progressFlow;
			this.m_step = ProgressFlowNotify.DISAPPEAR_PREPARATION;
			this.m_nextStep = ProgressFlowNotify.DISAPPEAR;
			this.m_sourceSpace = null;
			this.m_targetSpace = null;
			this.m_loaderSpace = null;
		}
		/**public function：對外公開函數*/
		public function NextStep( a_step : String = "" ) : void
		{
			// 驗證指令是否有誤。
			this.step = a_step;
			// 若驗證通過，執行當前狀態。
			// 反之若驗證未通過，執行原始的下個狀態。
			if( a_step != "" && a_step == this.m_step )
				this.m_progressFlow.NextStep( this.m_step );
			else
				this.m_progressFlow.NextStep( this.m_nextStep );
		}
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**read/write：讀寫*/
		public function set step( a_step : String ) : void
		{
			var isException : Boolean = false;
			switch( a_step )
			{
				case ProgressFlowNotify.DISAPPEAR_PREPARATION : 
					this.m_nextStep = ProgressFlowNotify.DISAPPEAR;
				break;
				case ProgressFlowNotify.DISAPPEAR : 
					this.m_nextStep = ProgressFlowNotify.DISAPPEAR_COMPLETE;
				break;
				case ProgressFlowNotify.DISAPPEAR_COMPLETE : 
					this.m_nextStep = ProgressFlowNotify.LOADING_PREPARATION;
				break;
				case ProgressFlowNotify.LOADING_PREPARATION : 
					this.m_nextStep = ProgressFlowNotify.LOADING;
				break;
				case ProgressFlowNotify.LOADING : 
					this.m_nextStep = ProgressFlowNotify.LOADING_COMPLETE;
				break;
				case ProgressFlowNotify.LOADING_COMPLETE : 
					this.m_nextStep = ProgressFlowNotify.DISPLAY_PREPARATION;
				break;
				case ProgressFlowNotify.DISPLAY_PREPARATION : 
					this.m_nextStep = ProgressFlowNotify.DISPLAY;
				break;
				case ProgressFlowNotify.DISPLAY : 
					this.m_nextStep = ProgressFlowNotify.DISPLAY_COMPLETE;
				break;
				case ProgressFlowNotify.DISPLAY_COMPLETE : 
					this.m_nextStep = "";
				break;
				default :
					isException = true;
				break;
			}
			if( !isException )
				this.m_step = a_step;
		}
		public function get step() : String
		{
			return this.m_step;
		}
		
		public function set soruce( a_space : RMSpace ) : void
		{
			if( a_space != this.m_sourceSpace )
				this.m_sourceSpace = a_space;
		}
		public function get soruce() : RMSpace
		{
			return this.m_sourceSpace;
		}
		
		public function set target( a_space : RMSpace ) : void
		{
			if( a_space != this.m_targetSpace )
				this.m_targetSpace = a_space;
		}
		public function get target() : RMSpace
		{
			return this.m_targetSpace;
		}
		
		public function set loader( a_space : RMSpace ) : void
		{
			if( a_space != this.m_loaderSpace )
				this.m_loaderSpace = a_space;
		}
		public function get loader() : RMSpace
		{
			return this.m_loaderSpace;
		}
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
		
	}		
}
/*end of package*/