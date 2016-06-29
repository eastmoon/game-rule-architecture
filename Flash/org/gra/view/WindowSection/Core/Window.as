/*
	Info:
		- Game Rule Architecture kernel code.
		
	Date:
		- 2014.05.25
		
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
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.gra.view.WindowSection.Interface.IWindow;
	import org.gra.view.WindowSection.Interface.IDecorator;
	import org.gra.view.WindowSection.Interface.ISection;
	import org.gra.ApplicationFacade;

	public class Window extends Sprite implements IWindow
	{		
		/*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		private var m_name : String;
		private var m_section : ISection;
		private var m_parentWindow : IDecorator;
		// 深度
		private var m_depth : Number;
		// 視區
		private var m_viewportWidth : Number;
		private var m_viewportHeight : Number;
		// 關注
		private var m_isActive : Boolean;
		// Application Facade
		private var m_application : ApplicationFacade;
		/*display object variable：顯示物件變數，如MovieClip等*/
		// Section 顯示元
		private var mc_section : DisplayObject;
		// Viewport mask 顯示元
		private var mc_viewport : Sprite;
		
		/*constructor：建構值*/
		public function Window( a_name : String = "" ) : void
		{
			// 儲存名稱
			this.m_name = a_name;
			// 預設內容
			this.m_section = null;
			// 預設父視窗
			this.m_parentWindow = null;
			// 預設深度
			this.m_depth = 0;
			// 預設關注
			this.m_isActive = false;
			
			// 建立顯示元件
			this.mc_section = null;
			this.mc_viewport = new Sprite();
			
			// 放置舞台並設定關係
			this.addChild( this.mc_viewport );
			
			// 預設遮罩影像
			this.mc_viewport.graphics.beginFill( 0x000000, 1 );
			this.mc_viewport.graphics.drawRect( 0, 0, 1, 1 );
			this.mc_viewport.graphics.endFill();
			
			// 設定遮罩關係
			this.mask = this.mc_viewport;
		}
		
		/*public function：對外公開函數*/
		
		/*public event function：公開事件函數*/
		// 時間軸更新
		public function onEnterFrame( a_event : Object = null ) : void
		{
			// 若存有Section且親物件為顯示，呼叫Section
			if( this.getCurrentVisible() && this.m_section != null )
			{
				// 取得當前可視區
				// 考量受限於上層視窗範圍導致的可視區範圍變化
				var rect : Rectangle = this.getCurrentViewport();
				if( rect != null )
				{
					// 判斷游標位置，確認仍在可視區範圍內
					if( !this.m_isActive && 
					   (this.mouseX >= 0 && this.mouseX <= rect.width) && 
					   (this.mouseY >= 0 && this.mouseY <= rect.height))
					{
						// 若非關注，且游標在視區內，標示為關注
						this.m_isActive = true;
						this.m_section.Active();
					}
					else if( this.m_isActive && 
							(this.mouseX < 0 || this.mouseX > rect.width ||
							 this.mouseY < 0 || this.mouseY > rect.height))
					{
						// 若為關注，且游標在視區外，標示為非關注
						this.m_isActive = false;
						this.m_section.Unactive();
					}
				}
				
				// 更新
				this.m_section.Update();
				
				// 繪製
				this.m_section.Draw();
			}
		}
		
		// 註冊至View
		public function onRegister() : void
		{
			// store application pointer
			this.m_application = ApplicationFacade.getInstance();
			// if window not in application than pointer will be null.
			if( !this.m_application.hasWindow( this.getName() ) )
				this.m_application = null;
		}
		
		// 移除至View
		public function onRemove() : void
		{
			// if window not in application than pointer will be null.
			if( !this.m_application.hasWindow( this.getName() ) )
				this.m_application = null;
		}
		
		// 設定Section
		public function onSetSection() : void
		{
			
		}
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		// 取得父親視窗的顯示狀態。
		public function getCurrentVisible() : Boolean
		{
			// 若自身為顯示且有親視窗，且親視窗仍為顯示，詢問親視窗的上層。
			if( this.visible && this.m_parentWindow != null && this.m_parentWindow is Sprite && (this.m_parentWindow as Sprite).visible )
				return this.m_parentWindow.getCurrentVisible();
			// 若自身為顯示且無親視窗，判斷父層元件是否為顯示。
			else if( this.visible && this.m_parentWindow == null && this.parent != null )
				return this.parent.visible;
			return false;
		}
		
		// 取得當前的可視區。
		public function getCurrentViewport() : Rectangle
		{
			var rect : Rectangle = null;
			// 若無親視窗，依照自身可視區
			if( this.m_parentWindow == null )
				rect = this.getViewport();
			// 若有親視窗
			else
			{
				// 依據親視窗的當前可視區判斷新的視區
				rect = this.m_parentWindow.getCurrentViewport();
				// 處理相對位置
				rect.x = 0;
				rect.y = 0;
				rect.width = rect.width - this.x;
				rect.height = rect.height - this.y;
				// 不可小於 0，亦不可大於本身視區
				if( rect.width < 0 )
					rect.width = 0;
				else if( rect.width > this.m_viewportWidth )
					rect.width = this.m_viewportWidth;
					
				if( rect.height < 0 )
					rect.height = 0;
				else if( rect.height > this.m_viewportHeight )
					rect.height = this.m_viewportHeight;
			}
			
			return rect;
		}
		
		// 存取名稱
		public function getName() : String
		{
			return this.m_name;
		}
		/*read/write：讀寫*/
		// 存取操作
		// 父級視窗
		public function getParentWindow() : IDecorator
		{
			return this.m_parentWindow;
		}
		
		public function setParentWindow( a_parent : IDecorator ) : void
		{
			// 不可與自己相同
			if( a_parent != this && a_parent.HasWindow( this ) )
			{
				this.m_parentWindow = a_parent;
			}
		}
		
		// 顯示內容
		public function getSection() : ISection
		{
			return this.m_section;
		}
		
		public function setSection( a_section : ISection ) : void
		{
			// 不可與已有的相同
			if( this.m_section != a_section )
			{
				var temp : DisplayObject = null;
				// 若之前已經存在，遺除顯示關係
				if( this.m_section != null 
				   && this.m_section.getViewComponent() != null 
				   && ( this.m_section.getViewComponent() as DisplayObject ).parent == this )
				{
					this.removeChild( this.m_section.getViewComponent() as DisplayObject );
					var oldSection : ISection= this.m_section;
					this.m_section = null;
					oldSection.setWindow( null );
				}
				
				// 保存
				this.m_section = a_section;
			
				// 若內容不為空，設訂其相關連動參數
				if( this.m_section != null )
				{
					temp = this.m_section.getViewComponent() as DisplayObject;
					if( temp != null )
					{
						// 1. 放置於舞台
						this.addChildAt( temp , 0 );
				
						// 2. 顯示區域等於元件 ?
						// 此功能應為Section自行設定
						// this.setViewport( temp.width, temp.height );
						
						// 指定內容的所屬視窗
						this.m_section.setWindow( this );
						
						// 更新
						this.m_section.Update();
				
						// 繪製
						this.m_section.Draw();
					}
				}
				
				// 執行內容設定相關
				this.onSetSection();
			}
		}
		
		
		// 位置操作
		// x : use the attribute x in DisplayObject.
		// y : use the attribute y in DisplayObject.
		public function getLoacl() : Point
		{
			return new Point( this.x, this.y );
		}
		public function setLocal( a_x, a_y ) : void
		{
			this.x = a_x;
			this.y = a_y;
		}
		
		// 深度操控
		public function getDepth() : Number
		{
			return this.m_depth;
		}
		public function setDepth( a_depth : Number ) : void
		{
			if( a_depth < 0 )
				a_depth = 0;
				
			this.m_depth = a_depth;
		}
		
		// 視區操控
		// 設定視區長寬。
		// 回傳完整的視區資訊。
		public function getViewport() : Rectangle
		{
			return new Rectangle( this.x, this.y, this.m_viewportWidth, this.m_viewportHeight );
		}
		public function setViewport( a_width : Number, a_height : Number ) : void
		{
			// 數值不可為負值
			if( a_width < 0 )
				a_width = 0;
			
			if( a_height < 0 )
				a_height = 0;
				
			// 保存數值
			this.m_viewportWidth = a_width;
			this.m_viewportHeight = a_height;
			
			// 修改顯示元件
			this.mc_viewport.width = this.m_viewportWidth;
			this.mc_viewport.height = this.m_viewportHeight;
		}
		
		// 存取操作，Window當前註冊的ApplicationFacade
		public function getApplication() : ApplicationFacade
		{
			return this.m_application;
		}
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
	}
}