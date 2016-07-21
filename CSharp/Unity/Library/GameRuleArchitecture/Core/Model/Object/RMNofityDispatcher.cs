/*
	Info:
        - Game Rule Architecture model object.
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
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using PureMVC.Interfaces;
using GameRuleArchitecture.Interfaces;
using GameRuleArchitecture.Patterns;
using GameRuleArchitecture.Core.Model.Interface;

namespace GameRuleArchitecture.Core.Model.Object
{
    public class RMNofityDispatcher : RMObject, IRMNotifyDispatcher
    {
        #region Variable member
        private bool mIsEnabled;
        private ISubjectContainer mContainer;
        #endregion

        #region Constructor
        public RMNofityDispatcher(string _name = "", IRMModule _module = null)
        {
            // Initial variable
            this.RegisterInfo(_name, _module);
            this.mContainer = new SubjectContainer();
            // Initial notify
            this.AddNotify(RMNotify.ENABLED, this.onNotifyEnabled);
        }
        #endregion

        #region Public Method
        /**
     	 * <P>Add Notify in RMNotifyDispatcher.</P>
      	 */
        public void AddNotify(string _notifyName, Action<INotification> _function)
        {            
            // 1. Register notify in container.
            this.mContainer.Register(new Subject(_notifyName));

            // 2. Retrieve subject
            ISubject result = this.mContainer.Retrieve(_notifyName);

            // 3. Register function in subject
            result.Register(_function);
        }
        /**
         * <P>Remove Notify in RMNotifyDispatcher.</P>
         */
        public void RemoveNotify(string _notifyName, Action<INotification> _function)
        {
            // 1. Chekc notify exist or not
            if(this.mContainer.Has(_notifyName))
            { 
                // 2. Retrieve subject
                ISubject result = this.mContainer.Retrieve(_notifyName);

                // 3. Remove function in subject
                result.Remove(_function);
            }
        }
        /**
          * <P>Has Notify in RMNotifyDispatcher.</P>
          */
        public bool HasNofity(string _notifyName)
        {
            // check notify name is exist or not
            bool hasNotify = this.mContainer.Has(_notifyName);
            // if exist notify name, then check observer amount is big than 0.
            if (hasNotify)
                hasNotify = (this.mContainer.Retrieve(_notifyName).Count > 0);
            return hasNotify;
        }
        /**
         * <P>Send Notify in RMNotifyDispatcher.</P>
         */
        public void SendNotify(IRMNotification _notification = null)
        {
            // 若已經存在發送者，忽略此動作；若無，則儲存本身為發送者
            if (_notification.Notifier == null)
                _notification.Notifier = this;

            // 若無存在型別，儲存名稱為事件型別
            if (_notification.Type == null || (_notification.Type != null && _notification.Type.Equals("")))
                _notification.Type = _notification.Name;
            
            // 若無禁制功能且存在發送對向，傳送通告。
            if (this.mIsEnabled && this.HasNofity(_notification.Name))
            {
                IObserver result = this.mContainer.Retrieve(_notification.Name) as IObserver;
                if(result != null)
                    result.NotifyObserver(_notification);
            }
        }
        #endregion

        #region Accessors
        /**
     	 * <P>[Read-Write]get <code>RMNotifyDispatcher</code> notify Enabled or Disabled state.</P>
      	 */
        public bool EnabledNotify
        {
            set
            {
                
                // 訊號已經鎖定，先行解開在發送訊息
                if (value)
                    this.mIsEnabled = value;

                // 使用訊號發送，即使鎖定內容，仍就可發送一次Enabled Notify
                this.SendNotify(new Notifications.RMEnabledNotification().SetEnabled(value));
            }
            get { return this.mIsEnabled; }
        }
        #endregion

        #region Notify funcation
        private void onNotifyEnabled( INotification _notification )
		{
            // 取回變數
            bool isEnabled = this.mIsEnabled;
            Notifications.RMEnabledNotification notification = _notification as Notifications.RMEnabledNotification;

            if(notification != null)
            {
                // 取回資訊
                isEnabled = notification.Enabled;

                // 更換資訊
                if (this.mIsEnabled != isEnabled)
                    this.mIsEnabled = isEnabled;
            }
		}
    #endregion
}
}
