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
	import org.puremvc.as3.patterns.observer.Notification;
	import org.gra.controller.Progress.*;
	import org.gra.view.WindowSection.Interface.IWindow;
	import org.gra.view.WindowSection.Interface.ISection;
	import org.gra.ApplicationFacade;

    /**
     * Create and register <code>Proxy</code>s with the <code>Model</code>.
	 * 掌管Progress目前狀態與下個狀態為何。
     */
    public class WSPFController extends ProgressController
    {
        /*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		// 控制稱呼 
		private var m_windowName : String;
		private var m_sourceName : String;
		private var m_targetName : String;
		private var m_loaderName : String;
		
		// 控制項參數
		private var m_window : IWindow;
		private var m_source : IWSPFSection;
		private var m_target : IWSPFSection;
		private var m_loader : IWSPFSection;
		private var m_params : Array;
		
		// GRA Facade
		private var m_app : ApplicationFacade;
		
		/*display object variable：顯示物件變數，如MovieClip等*/
		/*constructor：建構值*/
		public function WSPFController( a_windowName : String = "", 
									   a_targetName : String = "",
									   a_sourceName : String = "",
									   a_loaderName : String = "",
									   a_params : Array = null, 
									   a_progress : IProgress = null ) : void
		{
			// 取得Application Facade
			this.m_app = ApplicationFacade.getInstance();
			// 父層宣告
			super( a_progress );
			// 通告型態
			this.setType("WSProgressFlowController");
			
			// 儲存參數
			this.setWindowName( a_windowName );
			this.setTargetName( a_targetName );
			this.setSourceName( a_sourceName );
			this.setLoaderName( a_loaderName );
			this.m_params = a_params;	
			
		}
	
		/**public function：對外公開函數*/
		public override function Clone( a_clone : IProgressController = null ) : IProgressController
		{
			var clone : WSPFController = new WSPFController( this.m_windowName,
															this.m_targetName,
															this.m_sourceName,
															this.m_loaderName,
															this.m_params,
															this.getProgress() );
			
			// 複製父層資訊
			super.Clone( clone );
			
			// 複製本層資訊			
			
			// 回傳複製體
			return clone;
		}
		/*public event function：公開事件函數*/
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		public function setWindowName( a_name : String ) : void
		{
			this.m_windowName = a_name;
			// 取得Window實體
			if( this.m_app != null )
			{
				this.m_window = this.m_app.retrieveWindow( this.m_windowName );
			}
		}
		
		public function setSourceName( a_name : String ) : void
		{
			this.m_sourceName = a_name;
			// 取得Source實體
			if( this.m_app != null )
			{
				this.m_source = this.m_app.retrieveSection( this.m_sourceName ) as IWSPFSection;
				
				// 若Source為空，而Window有Source，將原有Source設為移除
				if( this.m_source == null && this.m_window != null && this.m_window.getSection() != null )
					this.m_source = this.m_window.getSection() as IWSPFSection;
			}
		}
		
		public function setTargetName( a_name : String ) : void
		{
			this.m_targetName = a_name;
			// 取得Target實體
			if( this.m_app != null )
			{
				this.m_target = this.m_app.retrieveSection( this.m_targetName ) as IWSPFSection;
			}
		}
		
		public function setLoaderName( a_name : String ) : void
		{
			this.m_loaderName = a_name;
			// 取得Loader實體
			if( this.m_app != null )
			{
				this.m_loader = this.m_app.retrieveSection( this.m_loaderName ) as IWSPFSection;
			}
		}
		
		public function setParams( a_params : Array ) : void
		{
			this.m_params = a_params;
		}
		/*read only：唯讀*/
		public function getWindow() : IWindow
		{
			return this.m_window;
		}
		public function getSource() : IWSPFSection
		{
			return this.m_source;
		}
		public function getTarget() : IWSPFSection
		{
			return this.m_target;
		}
		public function getLoader() : IWSPFSection
		{
			return this.m_loader;
		}
		public function getParams() : Array
		{
			return this.m_params;
		}
		/*read/write：讀寫*/
		
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
    }
}