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
	import org.puremvc.as3.patterns.observer.Notification;

    /**
     * Create and register <code>Proxy</code>s with the <code>Model</code>.
	 * 掌管Progress目前狀態與下個狀態為何。
     */
    public class ProgressController extends Notification implements IProgressController 
    {
        /*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		private var m_step : Number;
		private var m_stepNames : Array;
		private var m_progress : IProgress;
		/*display object variable：顯示物件變數，如MovieClip等*/
		/*constructor：建構值*/
		public function ProgressController( a_progress : IProgress = null ) : void
		{
			super( "ProgressController", null, "ProgressController" );
			this.m_step = 0;
			this.m_stepNames = new Array();			
			this.m_progress = a_progress;
		}
		// 增加需要執行的流程
		public function AddProgress( a_progressName :  String, a_index : Number = -1 ) : void
		{
			// 放置最後
			this.m_stepNames.push( a_progressName );
			if( a_index >= 0 )
			{
				// 更換順序
				// 由更換點開始將既有資訊放至到下個空間，直到最後
				var nextName : String = a_progressName;
				var temp : String = null;
				for( var i = a_index ; i < this.m_stepNames.length ; i++ )
				{
					temp = this.m_stepNames[i];
					this.m_stepNames[i] = nextName;
					nextName = temp;
				}
			}
		}
		// 複製流程控制器
		public function Clone( a_clone : IProgressController = null ) : IProgressController
		{
			var clone : IProgressController = null;
			if( a_clone != null )
				clone = a_clone;
			else
				clone = new ProgressController( this.m_progress );
				
			// 複製執行順序
			for( var i = 0 ; i < this.m_stepNames.length ; i++ )
			{
				clone.AddProgress( this.m_stepNames[i] );
			}
			return clone;
		}
		// 移至指定步驟
		public function Step( a_step : Number ) : void
		{
			// 至下個步驟
			this.m_step = a_step;
			// 判斷是否超過長度
			if( this.m_step >= 0 && this.m_step < this.m_stepNames.length )
			{
				// 仍在範圍內，呼叫Progress執行
				if( this.m_progress != null )
					this.m_progress.ExecuteProgress( this );				
			}
			else if( this.m_step < 0 )
				this.m_step = 0;
			else if( this.m_step >= this.m_stepNames.length )
				this.m_step = this.m_stepNames.length - 1;
		}
		// 移至指定名稱的
		public function StepByName( a_stepName : String ) : void
		{
			// 設定名稱
			this.setCurrentStepName( a_stepName );
			// 執行
			this.Step( this.m_step );
		}
		// 移至下個步驟
		public function Next() : void
		{
			// 至下個步驟
			this.m_step++;
			// 判斷是否超過長度
			if( this.m_step < this.m_stepNames.length )
			{
				// 仍在範圍內，呼叫Progress執行
				if( this.m_progress != null )
					this.m_progress.ExecuteProgress( this );		
			}
			else
				this.m_step = this.m_stepNames.length - 1;
		}
		// 移至上個步驟
		public function Back() : void
		{
			// 至上個步驟
			this.m_step--;
			// 判斷是否超過長度
			if( this.m_step >= 0 )
			{
				// 仍在範圍內，呼叫Progress執行
				if( this.m_progress != null )
					this.m_progress.ExecuteProgress( this );						
			}
			else
				this.m_step = 0;
		}
		/*public event function：公開事件函數*/
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		public function getProgress() : IProgress
		{
			return this.m_progress;
		}
		/*read/write：讀寫*/
		public function getCurrentStep() : Number
		{
			return this.m_step;
		}
		public function setCurrentStep( a_step : Number ) : void
		{
			this.m_step = a_step;
		}
		
		public function getCurrentStepName() : String
		{
			if( this.m_stepNames.length > 0 && this.m_step >= 0 && this.m_step < this.m_stepNames.length )
				return this.m_stepNames[ this.m_step ]; 
			return null;
		}
		public function setCurrentStepName( a_stepName : String ) : void
		{
			for( var i = 0 ; i < this.m_stepNames.length ; i++ )
			{
				if( this.m_stepNames[i] == a_stepName )
				{
					this.m_step = i;
					break;
				}
			}
		}
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
    }
}