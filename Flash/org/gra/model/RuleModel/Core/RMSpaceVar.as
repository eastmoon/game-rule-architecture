/*
	Info:
		- Game Rule Architecture kernel code.
		
	Date:
		- 2013.09.04
		
	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
		
 	Copyright (c) 2013 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/

package org.gra.model.RuleModel.Core
{

	/*import：Flash內建元件庫*/
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.gra.model.RuleModel.Interface.*;
	 
    /**
     * <P><code>RMSpaceVar</code> is a variable object, that is store <code>RMSpace</code> infomation to <code>RMActor</code>.</P>
     */
	public class RMSpaceVar extends RMNotifyDispatcher implements IRMSpaceVar
	{
		/**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		private var m_space : IRMSpace;
		private var m_x : Number;
		private var m_y : Number;
		private var m_z : Number;
		private var m_width : Number;
		private var m_height : Number;
		private var m_depth : Number;
		/**constructor：建構值*/
		public function RMSpaceVar( a_x : Number = 0, a_y : Number = 0, a_z : Number = 0, a_width : Number = 0, a_height : Number = 0, a_depth : Number = 0, a_space : IRMSpace = null, a_name : String = "" )
		{
			// 儲存資訊
			this.setX( a_x );
			this.setY( a_y );
			this.setZ( a_z );
			this.setWidth( a_width );
			this.setHeight( a_height );
			this.setDepth( a_depth );
			// 儲存所屬 Space
			this.m_space = a_space;
			// 儲存事件(Event)名稱與模組(Module)資料
			if( a_space != null )
				this.RegisterInfo( a_name, a_space.getModule() );
			else
				this.RegisterInfo( a_name, null );
		}
		
		/**public function：對外公開函數*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**
    	 * <P>Take back <code>IRMSpace</code> object point.</P>
     	*/
		public function getSpace() : IRMSpace
		{
			return this.m_space;
		}
		/**read/write：讀寫*/
		/**
    	 * <P>Set and Get ths location.x .</P>
     	 */
		public function setX( a_value : Number ) : void
		{
			this.m_x = a_value;
		}
		public function getX() : Number
		{
			return this.m_x;
		}
		/**
    	 * <P>Set and Get ths location.y .</P>
     	 */
		public function setY( a_value : Number ) : void
		{
			this.m_y = a_value;
		}
		public function getY() : Number
		{
			return this.m_y;
		}
		/**
    	 * <P>Set and Get ths location.z .</P>
     	 */
		public function setZ( a_value : Number ) : void
		{
			this.m_z = a_value;
		}
		public function getZ() : Number
		{
			return this.m_z;
		}
		/**
    	 * <P>Set and Get ths Size.width .</P>
     	 */
		public function setWidth( a_value : Number ) : void
		{
			this.m_width = a_value;
		}
		public function getWidth() : Number
		{
			return this.m_width;
		}
		/**
    	 * <P>Set and Get ths Size.height .</P>
     	 */
		public function setHeight( a_value : Number ) : void
		{
			this.m_height = a_value;
		}
		public function getHeight() : Number
		{
			return this.m_height;
		}
		/**
    	 * <P>Set and Get ths Size.depth .</P>
     	 */
		public function setDepth( a_value : Number ) : void
		{
			this.m_depth = a_value;
		}
		public function getDepth() : Number
		{
			return this.m_depth;
		}
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
	}
}