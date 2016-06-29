/*
 Game Rule Architure Demo - Flex Application Skeleton 
 Copyright (c) 2013 EastMoon<jacky_eastmoon@hotmail.com>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
		
	Date:
		- 2012.05.08
		
	Author:
		- Name : EastMoon
		- Email : jacky_eastmoon@hotmail.com
*/

package org.gra.model.RuleModel.Pattern.ProgressFlow
{	
	
	/*import：Flash內建元件庫*/
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.gra.model.RuleModel.Core.ASEEvent;
	import org.gra.model.RuleModel.Core.ASENotifyDispatcher;
	import org.puremvc.as3.patterns.observer.Notification;
	
	public class ProgressFlow extends RMEvent
    {
        /**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		private var m_step : Number;
		private var m_params : ProgressFlowParams;
		/**member variable：物件內部操作變數*/
		/**display object variable：顯示物件變數，如MovieClip等*/
		
		/**constructor：建構值*/
        public function ProgressFlow()
		{
            trace("ProgressFlow");
			
			this.AddNotify(ProgressFlowNotify.DISAPPEAR_PREPARATION, this.DisappearPreparation, this);
			this.AddNotify(ProgressFlowNotify.DISAPPEAR, this.Disappear, this);
			this.AddNotify(ProgressFlowNotify.DISAPPEAR_COMPLETE, this.DisappearComplete, this);
			this.AddNotify(ProgressFlowNotify.LOADING_PREPARATION, this.LoadingPreparation, this);
			this.AddNotify(ProgressFlowNotify.LOADING, this.Loading, this);
			this.AddNotify(ProgressFlowNotify.LOADING_COMPLETE, this.LoadingComplete, this);
			this.AddNotify(ProgressFlowNotify.DISPLAY_PREPARATION, this.DisplayPreparation, this);
			this.AddNotify(ProgressFlowNotify.DISPLAY, this.Display, this);
			this.AddNotify(ProgressFlowNotify.DISPLAY_COMPLETE, this.DisplayComplete, this);
        }
		/**public function：對外公開函數*/
		override public function Execute( a_params : Object ) : void    
		{
			if( a_params is ProgressFlowParams )
			{
				//trace("execute ProgressFlow");
				var step : String = (a_params as ProgressFlowParams).step;
				this.m_params = new ProgressFlowParams(this);
				this.m_params.step = (a_params as ProgressFlowParams).step;
				this.m_params.soruce = (a_params as ProgressFlowParams).soruce;
				this.m_params.target = (a_params as ProgressFlowParams).target;
				this.m_params.loader = (a_params as ProgressFlowParams).loader;
				this.NextStep(step);
			}				
        }
		public function NextStep( a_step : String ) : void
		{
			switch( a_step )
			{
				case ProgressFlowNotify.DISAPPEAR_PREPARATION :
				case ProgressFlowNotify.DISAPPEAR :
				case ProgressFlowNotify.DISAPPEAR_COMPLETE :
				case ProgressFlowNotify.LOADING_PREPARATION :
				case ProgressFlowNotify.LOADING :
				case ProgressFlowNotify.LOADING_COMPLETE :
				case ProgressFlowNotify.DISPLAY_PREPARATION :
				case ProgressFlowNotify.DISPLAY :
				case ProgressFlowNotify.DISPLAY_COMPLETE :
				{
					trace("Step : ", a_step);
					if( this.m_params.step != a_step )
						this.m_params.step = a_step;
					this.SendNotify(this.m_params.step, this.m_params);
				}
				break;

				default:
					trace("Do not thing");
				break;
			}
		}
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		public function get params() : ProgressFlowParams
		{
			return this.m_params;
		}
		/**read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		protected function DisappearPreparation( a_notify : Notification ) : void
		{
			this.m_params.NextStep();
		}
		protected function Disappear( a_notify : Notification ) : void
		{
			this.m_params.NextStep();
		}
		protected function DisappearComplete( a_notify : Notification ) : void
		{
			this.m_params.NextStep();
		}
		protected function LoadingPreparation( a_notify : Notification ) : void
		{
			this.m_params.NextStep();
		}
		protected function Loading( a_notify : Notification ) : void
		{
			this.m_params.NextStep();
		}
		protected function LoadingComplete( a_notify : Notification ) : void
		{
			this.m_params.NextStep();
		}
		protected function DisplayPreparation( a_notify : Notification ) : void
		{
			this.m_params.NextStep();
		}
		protected function Display( a_notify : Notification ) : void
		{
			this.m_params.NextStep();
		}
		protected function DisplayComplete( a_notify : Notification ) : void
		{
			this.m_params.NextStep();
		}
		/**javascript const variable：JavaScript 常數變數*/
    }
}