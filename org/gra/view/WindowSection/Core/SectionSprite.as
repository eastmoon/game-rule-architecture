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

package org.gra.view.WindowSection.Core
{	
	/*import：Flash內建元件庫*/
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.geom.Point;
		
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.gra.controller.Progress.IProgressController;
	import org.gra.controller.WSProgressFlow.IWSPFSection;
	import org.gra.view.DynamicDetection.IDynamicDetection;
	import org.gra.model.RuleModel.Core.RMNotifyDispatcher;
	import org.gra.model.RuleModel.Core.RMNotification;
	import org.gra.view.WindowSection.Interface.IWindow;
	import org.gra.view.WindowSection.Interface.ISection;

	public class SectionSprite extends Sprite implements ISection, IWSPFSection, IDynamicDetection
	{		
		/*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		// 中繼者
		private var m_mediator : Mediator;
		// 演算物件
		private var m_algorithm : IDynamicDetection;
		private var m_focus : Array;
		private var m_unfocus : Array;
		private var m_addationFocus : Array;
		private var m_addationUnfocus : Array;
		// 所屬視窗
		private var m_window : IWindow;
		
		/*display object variable：顯示物件變數，如MovieClip等*/
		
		/*constructor：建構值*/
		public function SectionSprite( a_name : String = "" ) : void
		{
			// 初始中繼訊息物件
			this.m_mediator = new Mediator( a_name, this );
			// 初始所屬視窗
			this.m_window = null;
			// 演算物件預設
			this.m_focus = new Array();
			this.m_unfocus = new Array();
			this.m_addationFocus = new Array();
			this.m_addationUnfocus = new Array();
			this.DefinedAlgorithm( null );
		}
		/*public function：對外公開函數*/
		
		/*
		IMediator 介面實做
		*/
		// 登入Mediator事件。
		// 事件登記過程為 Facade.registerMediator 中呼叫 listNotificationInterests，並以此建立observer儲存。
		public function listNotificationInterests() : Array
		{
			return [];
		}
		// 處理Mediator事件
		public function handleNotification( notification : INotification ):void
		{
		}
		public function getMediatorName() : String
		{
			return this.m_mediator.getMediatorName();
		}
		public function getViewComponent() : Object
		{
			return this.m_mediator.getViewComponent();
		}
		public function onRegister() : void
		{
			return this.m_mediator.onRegister();
		}
		public function onRemove() : void
		{
			return this.m_mediator.onRemove();
		}
		public function setViewComponent( a_viewComponent : Object ) : void
		{
			this.m_mediator.setViewComponent( this );
		}
		
		/*
		IProgressSection 介面實做
		*/
		
		// 顯示內容進場，Progress Flow 控制函數
		public function Display( a_flow : IProgressController = null ) : void
		{
			if( a_flow != null )
				a_flow.Next();
		}
		
		// 顯示內容退場，Progress Flow 控制函數
		public function Disappear( a_flow : IProgressController = null ) : void
		{
			if( a_flow != null )
				a_flow.Next();
		}
		
		// 載入處理，Progress Flow 控制函數
		public function Loading( a_flow : IProgressController = null ) : void
		{
			if( a_flow != null )
				a_flow.Next();
		}
		
		// 初始化數據，Progress Flow 控制函數
		public function Initial( a_flow : IProgressController = null ) : void
		{
			if( a_flow != null )
				a_flow.Next();
		}
		
		// 關閉內容，Progress Flow 控制函數
		public function Close( a_flow : IProgressController = null ) : void
		{
			if( a_flow != null )
				a_flow.Next();
		}
		
		// 前置處理，Progress Flow 控制函數
		public function PreProcess( a_flow : IProgressController = null ) : void
		{
			if( a_flow != null )
				a_flow.Next();
		}
		
		// 完成處理，Progress Flow 控制函數
		public function CompleteProcess( a_flow : IProgressController = null ) : void
		{
			if( a_flow != null )
				a_flow.Next();
		}
		
		/*
		IDynamicDetection 介面實做
		*/
		// 設定偵測演算法物件
		public function DefinedAlgorithm( a_algorithm : IDynamicDetection ) : void
		{
			// 1. 若傳入演算物件存在
			if( a_algorithm != null )
			{
				// 2. 取代現有演算物件
				this.m_algorithm = a_algorithm;
				this.removeEventListener(Event.ENTER_FRAME, this.CalculateAlgorithm);
			}
			else
			{
				// 3. 不存在演算法，以時間軸處發演算
				this.m_algorithm = null;
				this.addEventListener( Event.ENTER_FRAME, this.CalculateAlgorithm );
			}
		}
		
		// 計算演算
		public function CalculateAlgorithm( a_param : Object = null ) : void
		{
			// 若存在演算法，依演算法為主
			if( this.m_algorithm != null )
				this.m_algorithm.CalculateAlgorithm( a_param );
			else
				this.CalculateSelfAlgorithm( a_param );
		}
		
		private function CalculateSelfAlgorithm( a_param : Object = null ) : void
		{
			var i : Number = 0, j : Number = 0, k : Number = 0;
			// 1. copy focus, unfocus
			var oldFocus : Array = new Array();
			var oldUnfocus : Array = new Array();
			
			for( i = 0 ; i < this.m_focus.length ; i++ )
				oldFocus.push( this.m_focus );
				
			for( i = 0 ; i < this.m_unfocus.length ; i++ )
				oldUnfocus.push( this.m_unfocus );

			// 2. clear 
			this.m_focus.splice( 0, this.m_focus.length );
			this.m_unfocus.splice( 0, this.m_unfocus.length );
			this.m_addationFocus.splice( 0, this.m_addationFocus.length );
			this.m_addationUnfocus.splice( 0, this.m_addationUnfocus.length );
			
			// 3. calculate focus、unfocus
			var local : Point = this.localToGlobal( new Point( this.mouseX, this.mouseY ) );
			var point : DisplayObject = null;
			for( i = 0 ; i < this.numChildren ; i++ )
			{
				point = this.getChildAt( i );
				if( point.hitTestPoint( local.x, local.y, true ) )
					this.m_focus.push( point );
				else
					this.m_unfocus.push( point );
			}
			
			// 4. calculate addationFocus, addationUnfocus
			var isExist : Boolean = false;
			for( i = 0 ; i < this.m_focus.length ; i++ )
			{
				isExist = false;
				// if new focus not in old focus, than it is addation
				for( j = 0 ; j < oldFocus.length ; j++ )
				{
					if( this.m_focus[i] == oldFocus[j] )
						isExist = true;
				}
				
				if( !isExist )
					this.m_addationFocus.push( this.m_focus[i] );
			}
			
			for( i = 0 ; i < this.m_unfocus.length ; i++ )
			{
				isExist = false;
				// if new unfocus not in old unfocus, than it is addation
				for( j = 0 ; j < oldUnfocus.length ; j++ )
				{
					if( this.m_unfocus[i] == oldUnfocus[j] )
						isExist = true;
				}
				
				if( !isExist )
					this.m_addationUnfocus.push( this.m_unfocus[i] );
			}
		}
				
		// 取回演算物件
		public function getAlgorithm() : IDynamicDetection
		{
			if( this.m_algorithm != null )
				return this.m_algorithm;
			return this;
		}
		
		// 傳送給專注目標
		public function DispatchEventToTarget( a_event : Object, a_target : Array = null ) : void
		{
			// 1. 若無輸入目標，取得當前專注目標
			var target : Array = a_target;
			if( target == null )
				target = this.getFocus();
			
			// 2. 依據專注目標判斷來發送物件
			for( var i = 0 ; target != null && i < target.length ; i++ )
			{
				// 專注目標為Flash事件物件
				if( target[i] is EventDispatcher && a_event is Event )
				{
					(target[i] as EventDispatcher).dispatchEvent( a_event as Event );
				}
				// 專注目標為RuleModel事件物件
				if( target[i] is RMNotifyDispatcher && a_event is RMNotification )
				{
					(target[i] as RMNotifyDispatcher).SendNotify( a_event as RMNotification );
				}
			}
		}
		
		// 專注目標
		public function getFocus() : Array
		{
			// 1. 若存有演算物件，以演算物件的為主。
			var objects : Array = null;
			if( this.m_algorithm != null )
				objects = this.m_algorithm.getFocus();
			else if( this.stage != null )
			{
				objects = this.m_focus;
			}
			return objects;
		}
		
		// 非專注目標
		public function getUnfocus() : Array
		{
			// 1. 若存有演算物件，以演算物件的為主。
			var objects : Array = null;
			if( this.m_algorithm != null )
				objects = this.m_algorithm.getUnfocus();
			else if( this.stage != null )
			{
				objects = this.m_unfocus;
			}
			return objects;
		}
		
		// 新選擇的專注目標
		public function getAddationFocus() : Array
		{
			// 1. 若存有演算物件，以演算物件的為主。
			var objects : Array = null;
			if( this.m_algorithm != null )
				objects = this.m_algorithm.getAddationFocus();
			else if( this.stage != null )
			{
				objects = this.m_addationFocus;
			}
			return objects;
		}
		
		// 新選擇的非專注目標
		public function getAddationUnfocus() : Array
		{
			// 1. 若存有演算物件，以演算物件的為主。
			var objects : Array = null;
			if( this.m_algorithm != null )
				objects = this.m_algorithm.getAddationUnfocus();
			else if( this.stage != null )
			{
				objects = this.m_addationUnfocus;
			}
			return objects;
		}
		
		/*
		ISection 介面實做
		*/
		// 啟用，Window 控制函數
		public function Active() : void
		{
			
		}
		
		// 不啟用，Window 控制函數
		public function Unactive() : void
		{
			
		}
		
		// 更新數據，依據時間軸來源設定其動作
		// 若為SectionSprite，此為 Window 控制函數
		// 若為SectionBitmap，此為 RuleModel 控制函數
		public function Update() : void
		{
			
		}
		
		// 繪製顯示內容，依據時間軸來源設定其動作
		// 若為SectionSprite，此為 Window 控制函數
		// 若為SectionBitmap，此為 RuleModel 控制函數
		public function Draw() : void
		{
		
		}
		
		/*public event function：公開事件函數*/
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		/*read/write：讀寫*/
		/*
		ISection 介面實做
		*/
		// 存取操作，所屬視窗
		public function getWindow() : IWindow
		{
			return this.m_window;
		}
		public function setWindow( a_window : IWindow ) : void
		{
			// 若指定視窗的內容為自己，且傳入與當前視窗不重複。
			if( a_window.getSection() == this && a_window != this.m_window )
			{
				// 原始視窗的內容清空
				if( this.m_window != null )
					this.m_window.setSection( null );
				
				// 儲存當前視窗
				this.m_window = a_window;
			}
		}
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
	}
}