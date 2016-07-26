/*
	Info:
        - Game Rule Architecture model object interface.
        - RMNofityDispatcher is the event dispatcher in Rule Model.
		
	Date:
		- 2016.07.11
		
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

using PureMVC.Interfaces;

namespace GameRuleArchitecture.Interfaces
{
    public interface IRMNotifyDispatcher : IRMObject
    {
        #region Public Method
        /**
     	 * <P>Add Notify in RMNotifyDispatcher.</P>
      	 */
        void AddNotify(string _notifyName, Action<INotification> _function);
        /**
         * <P>Remove Notify in RMNotifyDispatcher.</P>
         */
        void RemoveNotify(string _notifyName, Action<INotification> _function);
        /**
          * <P>Has Notify in RMNotifyDispatcher.</P>
          */
        bool HasNofity(string _notifyName);
        /**
         * <P>Send Notify in RMNotifyDispatcher.</P>
         */
        void SendNotify(IRMNotification _notification = null);
        #endregion

        #region Accessors
        /**
     	 * <P>[Read-Write]get <code>RMNotifyDispatcher</code> notify Enabled or Disabled state.</P>
      	 */
        bool EnabledNotify { get; set; }
        #endregion
    }
}
