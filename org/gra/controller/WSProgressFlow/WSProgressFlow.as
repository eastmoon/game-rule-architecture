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

    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.command.*;
    import org.puremvc.as3.patterns.observer.Observer;
	
	import org.gra.controller.Progress.*;
	import org.gra.view.WindowSection.Interface.ISection;

    /**
     * 
     */
    public class WSProgressFlow extends Progress
    {
		/*static const variable : 靜態常數變數*/
		// 流程名稱
		public static const DISAPPEAR_PREPARATION = "PFNDisappearPreparation";
		public static const DISAPPEAR = "PFNDisappear";
		public static const DISAPPEAR_COMPLETE = "PFNDisappearComplete";
		public static const LOADING_PREPARATION = "PFNLoadingPreparation";
		public static const LOADING = "PFNLoading";
		public static const LOADING_COMPLETE = "PFNLoadingComplete";
		public static const DISPLAY_PREPARATION = "PFNDisplayPreparation";
		public static const DISPLAY = "PFNDisplay";
		public static const DISPLAY_COMPLETE = "PFNDisplayComplete";
		
		// 事件稱呼
		public static const EVENT_PROGRESS_FLOW = "WSProgressFlowCommand";
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		/*display object variable：顯示物件變數，如MovieClip等*/
		/*constructor：建構值*/
		public function WSProgressFlow() : void
		{
			// 重建立控制器
			this.setController( new WSPFController( "", "", "", "", null, this ) );
			
			// 設定流程
			this.AddProgress(WSProgressFlow.DISAPPEAR_PREPARATION, this.DisappearPreparation);
			this.AddProgress(WSProgressFlow.DISAPPEAR, this.Disappear);
			this.AddProgress(WSProgressFlow.DISAPPEAR_COMPLETE, this.DisappearComplete);
			this.AddProgress(WSProgressFlow.LOADING_PREPARATION, this.LoadingPreparation);
			this.AddProgress(WSProgressFlow.LOADING, this.Loading);
			this.AddProgress(WSProgressFlow.LOADING_COMPLETE, this.LoadingComplete);
			this.AddProgress(WSProgressFlow.DISPLAY_PREPARATION, this.DisplayPreparation);
			this.AddProgress(WSProgressFlow.DISPLAY, this.Display);
			this.AddProgress(WSProgressFlow.DISPLAY_COMPLETE, this.DisplayComplete);
		}
		/*public function：對外公開函數*/
		override public function execute( note:INotification ) : void    
		{
			// 處理程序
			// 依據傳入參數取得相對的Window與Section關聯
			if( note.getBody() != null && note.getBody() is WSPFController )
			{
				var info : WSPFController = note.getBody() as WSPFController;
				// 複製資訊 Window
				if( info.getWindow() != null )
					(this.getController() as WSPFController).setWindowName( info.getWindow().getName() );
				// 複製資訊 Source
				if( info.getSource() != null )
					(this.getController() as WSPFController).setSourceName( info.getSource().getMediatorName() );
				// 複製資訊 Target
				if( info.getTarget() != null )
					(this.getController() as WSPFController).setTargetName( info.getTarget().getMediatorName() );
				// 複製資訊 Loader
				if( info.getLoader() != null )
					(this.getController() as WSPFController).setLoaderName( info.getLoader().getMediatorName() );
				// 複製資訊 Params
				if( info.getParams() != null )
					(this.getController() as WSPFController).setParams( info.getParams() );
					
				//trace( info.window.getName(), info.source.getMediatorName(), info.target.getMediatorName(), info.loader.getMediatorName(), info.params );
			}
			// 父層執行
			super.execute( note );
        }
		
		/**public event function：公開事件函數*/
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		/*read/write：讀寫*/
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
		protected function DisappearPreparation( a_controller : WSPFController ) : void
		{
			// 退場準備
			//trace( a_controller.currentStepName );
			// 有退場對象，執行前置處理；若無則不予理會。
			if( a_controller.getSource() != null )
			{
				a_controller.getSource().PreProcess( a_controller );
			}
			else
				a_controller.Next();
		}
		protected function Disappear( a_controller : WSPFController ) : void
		{
			// 退場
			//trace( a_controller.currentStepName );
			// 有退場對象，執行退場；若無則不予理會。
			if( a_controller.getSource() != null )
			{
				a_controller.getSource().Disappear( a_controller );
			}
			else
				a_controller.Next();
		}
		protected function DisappearComplete( a_controller : WSPFController ) : void
		{
			// 退場完成
			//trace( a_controller.currentStepName );
			// 清除視窗內的內容
			if( a_controller.getWindow() != null )
				a_controller.getWindow().setSection( null );
			
			// 有退場對象，執行關閉；若無則不予理會。
			if( a_controller.getSource() != null )
			{
				a_controller.getSource().Close( a_controller );
			}
			else
				a_controller.Next();
		}
		protected function LoadingPreparation( a_controller : WSPFController ) : void
		{
			// 載入準備
			//trace( a_controller.currentStepName );
			// 有載入對象，執行載入入場；若無則不予理會。
			if( a_controller.getLoader() != null )
			{
				// 若存有視窗，放置
				if( a_controller.getWindow() != null )
					a_controller.getWindow().setSection( a_controller.getLoader() as ISection);
					
				a_controller.getLoader().Display( a_controller );
			}
			else
				a_controller.Next();
		}
		protected function Loading( a_controller : WSPFController ) : void
		{
			// 載入資訊
			//trace( a_controller.currentStepName );
			// 有載入對象，執行載入；若無則不予理會。
			if( a_controller.getLoader() != null )
			{
				a_controller.getLoader().Loading( a_controller );
			}
			else
				a_controller.Next();
		}
		protected function LoadingComplete( a_controller : WSPFController ) : void
		{
			// 載入完成
			//trace( a_controller.currentStepName );
			// 有載入對象，執行載入退場；若無則不予理會。			
			if( a_controller.getLoader() != null )
			{
				a_controller.getLoader().Disappear( a_controller );
			}
			else
				a_controller.Next();
		}
		protected function DisplayPreparation( a_controller : WSPFController ) : void
		{
			// 進場準備
			//trace( a_controller.currentStepName );
			// 若存有視窗，移除舊資訊
			if( a_controller.getWindow() != null )
				a_controller.getWindow().setSection( null );
					
			// 有進場對象，執行初始；若無則不予理會。			
			if( a_controller.getTarget() != null )
			{
				// 若存再視窗，設定置設窗中
				if( a_controller.getWindow() != null )
					a_controller.getWindow().setSection( a_controller.getTarget() as ISection );
					
				a_controller.getTarget().Initial( a_controller );
			}
			else
				a_controller.Next();
		}
		protected function Display( a_controller : WSPFController ) : void
		{
			// 進場
			//trace( a_controller.currentStepName );
			// 有進場對象，執行進場；若無則不予理會。			
			if( a_controller.getTarget() != null )
			{
				a_controller.getTarget().Display( a_controller );
			}
			else
				a_controller.Next();
		}
		protected function DisplayComplete( a_controller : WSPFController ) : void
		{
			// 進場完成
			//trace( a_controller.currentStepName );
			// 有進場對象，執行處理完成；若無則不予理會。			
			if( a_controller.getTarget() != null )
			{
				a_controller.getTarget().CompleteProcess( a_controller );
			}
			else
				a_controller.Next();
		}
    }
}