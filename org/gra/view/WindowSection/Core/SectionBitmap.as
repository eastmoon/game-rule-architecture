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
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.gra.controller.Progress.IProgressController;
	import org.gra.controller.WSProgressFlow.IWSPFSection;
	import org.gra.view.DynamicDetection.IDynamicDetection;
	import org.gra.model.RuleModel.Core.RMNotifyDispatcher;
	import org.gra.model.RuleModel.Core.RMNotification;
	import org.gra.view.WindowSection.Interface.IWindow;
	import org.gra.view.WindowSection.Interface.ISection;
		

	public class SectionBitmap extends Mediator implements ISection, IWSPFSection, IDynamicDetection
	{		
		/*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		// 演算物件
		private var m_algorithm : IDynamicDetection;
		/*display object variable：顯示物件變數，如MovieClip等*/
		// 繪圖面板
		private var m_bitmap : Bitmap;
		// 所屬視窗
		private var m_window : IWindow;
		/*constructor：建構值*/
		public function SectionBitmap( a_name : String = "" ) : void
		{
			super( a_name );
			
			// 初始繪圖區域
			this.m_bitmap = new Bitmap();
			this.m_bitmap.smoothing = true;
			
			// 初始所屬視窗
			this.m_window = null;
			
			// 演算物件預設
			this.m_algorithm = null;
		}
		/*public event function：公開事件函數*/
		
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
				// SectionBitmap的設計主要來自於自訂或外掛的演算，本身並沒有可以偵測的資料結構。
				// 因此，若無演算法物件，表示DynamicDetection餘下功能皆無用。
				this.m_algorithm = a_algorithm;
			}
		}
		
		// 計算演算
		public function CalculateAlgorithm( a_param : Object = null ) : void
		{
			if( this.m_algorithm != null )
				this.m_algorithm.CalculateAlgorithm( a_param );
		}
		
		// 傳送給專注目標
		public function DispatchEventToTarget( a_event : Object, a_target : Array = null ) : void
		{
			if( this.m_algorithm != null )
				this.m_algorithm.DispatchEventToTarget( a_event, a_target );
		}
		
		// 取回演算物件
		public function getAlgorithm() : IDynamicDetection
		{
			if( this.m_algorithm != null )
				return this.m_algorithm;
			return null;
		}
		
		// 專注目標
		public function getFocus() : Array
		{
			if( this.m_algorithm != null )
				return this.m_algorithm.getFocus();
			return null;
		}
		
		// 非專注目標
		public function getUnfocus() : Array
		{
			if( this.m_algorithm != null )
				return this.m_algorithm.getUnfocus();
			return null;
		}
		
		// 新選擇的專注目標
		public function getAddationFocus() : Array
		{
			if( this.m_algorithm != null )
				return this.m_algorithm.getAddationFocus();
			return null;
		}
		
		// 新選擇的非專注目標
		public function getAddationUnfocus() : Array
		{
			if( this.m_algorithm != null )
				return this.m_algorithm.getAddationUnfocus();
			return null;
		}
		
		/*
		ISection 介面實做
		*/
		
		// 啟用，Window 控制函數
		public function Active() : void
		{
			trace( "SectionBitmap Active" );
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
		
		
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		protected function set bitmap( a_bitmap : BitmapData ) : void
		{
			this.m_bitmap.bitmapData = a_bitmap;
			this.setViewComponent( this.m_bitmap );
		}
		protected function get bitmap() : BitmapData
		{
			return this.m_bitmap.bitmapData;
		}
		
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