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
		
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.gra.view.WindowSection.Interface.IWindow;
	import org.gra.view.WindowSection.Interface.IDecorator;

	public class Decorator extends Window implements IDecorator
	{		
		/*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		private var m_windows : Array;
		/*display object variable：顯示物件變數，如MovieClip等*/
		private var mc_windowStage : Sprite;
		
		/*constructor：建構值*/
		public function Decorator( a_name : String = "" ) : void
		{
			// 執行父類別建構元
			super( a_name );
			// 建立儲存矩陣
			this.m_windows = new Array();
			// 建立顯示元件
			this.mc_windowStage = new Sprite();
			this.addChild( this.mc_windowStage );
		}
		/*public function：對外公開函數*/
		
		/*public event function：公開事件函數*/
		// 時間軸更新
		public override function onEnterFrame( a_event : Object = null ) : void
		{
			// 執行父層行為
			super.onEnterFrame( a_event );
			
			// 若存有功能組件且親物件為顯示，呼叫功能組件行為
			if( this.getCurrentVisible() && this.m_windows.length > 0 )
			{
				for( var i = 0 ; i < this.m_windows.length ; i++ )
				{
					// 若Window未註冊，則無需發送訊息
					if( ( this.m_windows[i] as IWindow ).getApplication() == null )
						(this.m_windows[i] as IWindow ).onEnterFrame( a_event );
				}
			}
		}
		
		// 註冊至View
		public override function onRegister() : void
		{
			// 執行父層行為
			super.onRegister();
			
			// 若存有功能組件協助註冊
			for( var i = 0 ; i < this.m_windows.length ; i++ )
			{
				// 若存有名稱，註冊
				if( ( this.m_windows[i] as IWindow ).getName() != "" && this.getApplication() != null )
					this.getApplication().registerWindow( this.m_windows[i] as IWindow );
			}
		}
		
		// 移除至View
		public override function onRemove() : void
		{
			// 執行父層行為
			super.onRegister();
			
			// 若存有功能組件協助刪除
			for( var i = 0 ; i < this.m_windows.length ; i++ )
			{
				// 若存有名稱，刪除
				if( ( this.m_windows[i] as IWindow ).getName() != "" && this.getApplication() != null )
					this.getApplication().removeWindow( ( this.m_windows[i] as IWindow ).getName() );
			}
		}
		
		// 新增功能組件
		public function AddWindow( a_window : IWindow, a_depth : Number = -1 ) : void
		{
			var isExist : Boolean = false;
			var i : Number = 0;
			
			if( a_window != null && this.m_windows != null )
			{
				// 避免重複物件存在
				for( i = 0 ; i < this.m_windows.length ; i++ )
				{
					if( this.m_windows[i] == a_window )
						isExist = true;
				}
				
				if( !isExist )
				{
					// 放置位置
					this.SwitchWindowDepth( a_window, a_depth );
					
					// 設定主從關係
					a_window.setParentWindow( this );
				}
			}
		}
		
		// 移除功能組件
		public function RemoveWindow( a_window : IWindow ) : void
		{
			for( var i = 0 ; i < this.m_windows.length ; i++ )
			{
				if( this.m_windows[i] == a_window )
				{
					// 保存指標
					var temp : IWindow = this.m_windows[i];
					// 移除矩陣內容
					this.m_windows.splice( i, 1 );
					// 移除介面
					this.mc_windowStage.removeChild( temp as DisplayObject );
					// 清除指標
					temp.setDepth( 0 );
					temp = null;
					// 重新指定深度
					this.ResetWindowsDepth();
				}
			}
		}
		
		// 擁有功能組件
		public function HasWindow( a_window : IWindow ) : Boolean
		{
			for( var i = 0 ; i < this.m_windows.length ; i++ )
			{
				if( this.m_windows[i] == a_window )
				{
					return true;
				}
			}
			return false;
		}
		
		// 指定功能組件深度
		public function SwitchWindowDepth( a_window : IWindow, a_depth : Number ) : void
		{
			// 依據不同語言的效率規範，此部分使用的演算法皆有不同
			// 此處採用矩陣重新分割的方式。
			
			// 1. 若depth小於0，直接放置在最後尾
			if( a_depth < 0 )
			{
				// 儲存功能組件
				this.m_windows.push( a_window );
			}
			// 2. 若Depth大於0，計算其存在位置後再重組矩陣。
			else
			{
				// 若已經存在於組件列表中
				if( this.HasWindow( a_window ) )
				{
					// 先從列表移除
					this.RemoveWindow( a_window );
				}
				
				// 2.1 依據深度資訊重建矩陣
				var newWindows : Array = null;
				
				// 2.1.1 分隔出前半，若深度為0，前半段為新矩陣；若否，則切割出前段
				if( a_depth == 0 )
					newWindows = new Array();
				else
					newWindows = this.m_windows.slice(0, a_depth);
				
				// 2.1.2 放入組件
				newWindows.push( a_window );
				
				// 2.1.3 放入後半段組件群
				newWindows = newWindows.concat( this.m_windows.slice( a_depth, this.m_windows.length ) );
				
				// 2.1.4 清除舊矩陣
				this.m_windows.splice(0, this.m_windows.length);
				this.m_windows = null;
				
				// 2.1.5 指定新矩陣
				this.m_windows = newWindows;
			}
			
			// 建置於舞台
			this.mc_windowStage.addChild( a_window as DisplayObject );
			// 重新指定深度
			this.ResetWindowsDepth();
		}
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		/*read/write：讀寫*/
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
		
		// 重設視窗相對深度
		private function ResetWindowsDepth() : void
		{
			// 重新指定組件深度
			for( var i = 0 ; i < this.m_windows.length ; i++ )
			{
				(this.m_windows[i] as IWindow).setDepth( i );
				this.mc_windowStage.setChildIndex( (this.m_windows[i] as DisplayObject), i );
			}
		}
	}
}