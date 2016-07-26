/*
	Info:
        - Game Rule Architecture model object interface.
        - RMNotification is information object.
        - Include new information, who send this notification. 
		
	Date:
		- 2016.07.12
		
	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
		
 	Copyright (c) 2016 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GameRuleArchitecture.Interfaces
{
    public interface IRMNotification : PureMVC.Interfaces.INotification
    {
        #region Accessors
        /**
     	 * <P>[Read-Write]Get / Set notifier who send the <code>RMNotification</code> instance.</P>
      	 */
        IRMNotifyDispatcher Notifier { get; set; }
        #endregion 
    }
}
