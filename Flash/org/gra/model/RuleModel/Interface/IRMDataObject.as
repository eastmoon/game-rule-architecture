/*
	Info:
		- Game Rule Architecture kernel code.
		
	Date:
		- 2014.04.17
		
	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
		
 	Copyright (c) 2013 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/

package org.gra.model.RuleModel.Interface
{	
	
	/*import：Flash內建元件庫*/
	/*external import：外部元件庫、開發人員自定元件庫*/
	
	public interface IRMDataObject extends IRMObject
	{		
		/**public function：對外公開函數*/
		/**
     	 * <P>Clone IRMDataObject itself, reference prototype pattern.</P>
      	 */
		function Clone() : IRMDataObject
		/**
     	 * <P>Parse input object and create <code>IRMData</code>. It should be overridden when the class inherit RMDataObject.</P>
      	 */
		function Parse( a_object : Object ) : void
		/**
     	 * <P>Check attributes and values is equal or not.</P>
      	 */
		function Equal( a_attributeName : String, a_values : Array ) : Boolean
		/**
     	 * <P>Check attributes and values is what compare type.</P>
      	 */
		function Compare( a_attributeName : String, a_value : Object ) : Number
		/**
     	 * <P>Register a <code>IRMData</code> in IRMDataObject. The <code>IRMData</code> register will change attributes index.</P>
      	 */
		function RegisterAttribute( a_attributeData : IRMData ) : void
		/**
     	 * <P>Remove a <code>IRMData</code> in IRMDataObject. The <code>IRMData</code> register will change attributes index.</P>
      	 */
		function RemoveAttribute( a_attributeName : String ) : IRMData
		/**public event function：公開事件函數*/
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**
     	 * <P>Get IRMDataObject attribute array that <code>IRMDataTable</code> could make filter index.</P>
      	 */
		function getAttributeIndex() : Array
		/**
     	 * <P>Get attribute value by input attribute name.</P>
      	 */
		function getValue( a_name : String ) : Object
		
		/**read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
	}
}