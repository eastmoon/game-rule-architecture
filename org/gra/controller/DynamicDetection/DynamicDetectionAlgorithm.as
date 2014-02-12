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

package org.gra.controller.DynamicDetection
{
	/*import*/
	/*import：Flash內建元件庫*/
	
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.gra.controller.DynamicDetection.IDynamicDetection;
	import org.gra.model.RuleModel.Core.RMNotification;
	import org.gra.model.RuleModel.Core.RMNotifyDispatcher;
	
	/*external import*/
	public dynamic class DynamicDetectionAlgorithm implements IDynamicDetection
	{
		/*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		private var m_algorithm : IDynamicDetection;
		private var m_focus : Array;
		private var m_unfocus : Array;
		private var m_addationFocus : Array;
		private var m_addationUnfocus : Array;
		/*display object variable：顯示物件變數，如MovieClip等*/
		/*constructor：建構值*/
		public function DynamicDetectionAlgorithm() : void
		{
			this.m_algorithm = null;
			this.m_focus = new Array();
			this.m_unfocus = new Array();
			this.m_addationFocus = new Array();
			this.m_addationUnfocus = new Array();			
		}
		
		/*public function：對外公開函數*/
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
			}
		}
		
		// 計算演算
		public function CalculateAlgorithm( a_param : Object = null ) : void
		{
			if( this.m_algorithm != null )
			{
				// 1. if have an algoritm than calculate by that
				this.m_algorithm.CalculateAlgorithm( a_param );
			}
			else
			{
				// 2. if don't, calculate by class itself.
				var i : Number = 0, j : Number = 0, k : Number = 0;
				// 3. copy focus, unfocus
				var oldFocus : Array = new Array();
				var oldUnfocus : Array = new Array();
			
				for( i = 0 ; i < this.m_focus.length ; i++ )
					oldFocus.push( this.m_focus );
				
				for( i = 0 ; i < this.m_unfocus.length ; i++ )
					oldUnfocus.push( this.m_unfocus );
				
				// 4. clear old focus
				this.m_focus.splice( 0, this.m_focus.length );
				this.m_unfocus.splice( 0, this.m_unfocus.length );
				this.m_addationFocus.splice( 0, this.m_addationFocus.length );
				this.m_addationUnfocus.splice( 0, this.m_addationUnfocus.length );
			
				// 5. calculate new focus
				this.CalculateDetection( a_param );
			
				// 6. calculate addationFocus, addationUnfocus
				this.CalculateAddation( oldFocus, oldUnfocus, a_param );
			}
		}
		public function CalculateDetection( a_param : Object = null ) : void
		{
			
		}
		public function CalculateAddation( a_oldFocus : Array, a_oldUnfocus : Array, a_param : Object = null ) : void
		{
			var i : Number = 0, j : Number = 0, k : Number = 0;
			var isExist : Boolean = false;
			for( i = 0 ; i < this.m_focus.length ; i++ )
			{
				isExist = false;
				// if new focus not in old focus, than it is addation
				for( j = 0 ; j < a_oldFocus.length ; j++ )
				{
					if( this.m_focus[i] == a_oldFocus[j] )
						isExist = true;
				}
				
				if( !isExist )
					this.m_addationFocus.push( this.m_focus[i] );
			}
			
			for( i = 0 ; i < this.m_unfocus.length ; i++ )
			{
				isExist = false;
				// if new unfocus not in old unfocus, than it is addation
				for( j = 0 ; j < a_oldUnfocus.length ; j++ )
				{
					if( this.m_unfocus[i] == a_oldUnfocus[j] )
						isExist = true;
				}
				
				if( !isExist )
					this.m_addationUnfocus.push( this.m_unfocus[i] );
			}
		}
		
		// 取得專注目標
		public function DispatchEventToTarget( a_event : Object, a_target : Array = null ) : void
		{
			if( this.m_algorithm != null )
				this.m_algorithm.DispatchEventToTarget( a_event, a_target );
		}
		/*public event function：公開事件函數*/
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		
		// 取回演算物件
		public function getAlgorithm() : IDynamicDetection
		{
			if( this.m_algorithm != null )
				return this.m_algorithm;
			return this;
		}
		// 專注目標
		public function getFocus() : Array
		{
			if( this.m_algorithm != null )
				return this.m_algorithm.getFocus();
			return this.m_focus;
		}
		
		// 非專注目標
		public function getUnfocus() : Array
		{
			if( this.m_algorithm != null )
				return this.m_algorithm.getUnfocus();
			return this.m_unfocus;
		}
		
		// 新選擇的專注目標
		public function getAddationFocus() : Array
		{
			if( this.m_algorithm != null )
				return this.m_algorithm.getAddationFocus();
			return this.m_addationFocus;
		}
		
		// 新選擇的非專注目標
		public function getAddationUnfocus() : Array
		{
			if( this.m_algorithm != null )
				return this.m_algorithm.getAddationUnfocus();
			return this.m_addationUnfocus;
		}
		
		/*read/write：讀寫*/
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
	}
}
/*end of package*/