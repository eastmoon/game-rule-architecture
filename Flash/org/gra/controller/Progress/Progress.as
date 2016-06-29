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
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.command.*;
    import org.puremvc.as3.patterns.observer.Observer;

    /**
     * Create and register <code>Proxy</code>s with the <code>Model</code>.
	 * 管理與登記事件行為，並記錄其流程給Progress Controller
     */
    public class Progress extends SimpleCommand implements IProgress
    {
		/*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		private var m_controller : IProgressController;
		private var m_execute : IProgressController;
		private var m_functionList : Object;
		/*display object variable：顯示物件變數，如MovieClip等*/
		/*constructor：建構值*/
		public function Progress() : void
		{
			// 建立控制器
			this.m_controller = new ProgressController( this );
			// 建立功能列表
			this.m_functionList = new Object();
		}
		/*public function：對外公開函數*/
		override public function execute( note:INotification ) : void    
		{
			if( note.getBody() != null && note.getBody() is ProgressController )
			{
				// 取得指定的起始狀態。
				this.m_controller.setCurrentStep( (note.getBody() as ProgressController).getCurrentStep() );
			}				
			else
				this.m_controller.setCurrentStep( 0 );
			
			// 複製控制器
			this.m_execute = null;
			this.m_execute = this.m_controller.Clone();
			
			// 執行進度
			this.ExecuteProgress( this.m_execute );			
        }
		public function ExecuteProgress( a_execute : IProgressController )
		{
			// 若當前的執行者與傳入參數不同，忽略執行
			//if( this.m_execute != null && a_execute == this.m_execute && this.m_execute.currentStepName != null )
			// 依當前傳入參數，執行
			if( this.m_execute != null && this.m_execute.getCurrentStepName() != null )
			{
				// 依據當前控制器所指定的單位發送執行命令
				(this.m_functionList[ this.m_execute.getCurrentStepName() ] as Observer).notifyObserver( this.m_execute );
			}
		}
		public function AddProgress( a_progressName :  String, a_function : Function, a_index : Number = -1 )
		{
			// 登記進度流程至控制器
			this.m_controller.AddProgress( a_progressName, a_index );
			
			// 登記進度行為
			var observer : Observer = new Observer( a_function, a_progressName );
			// 清除舊有Observer
			this.m_functionList[a_progressName] = null;
			// 登記新建Observer
			this.m_functionList[a_progressName] = observer;
		}
		/*public event function：公開事件函數*/
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		/*read/write：讀寫*/
		// 控制器存取，僅提供給子物件修改
		protected function getController() : IProgressController
		{
			return this.m_controller;
		}
		
		protected function setController( a_controller : IProgressController ) : void
		{
			this.m_controller = a_controller;
		}
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
    }
}