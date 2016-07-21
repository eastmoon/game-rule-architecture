/*
	Info:
		- The subject interface.
        - Observer container, if observer's has the same topic but different method need to execute. 
	Date:
		- 2016.07.18
		
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
    public interface ISubject : IObserver
    {
        #region Public Methods

        #region Subject Members
        /// <summary>
        /// Register observer in subject.
        /// </summary>
        bool Register(Action<INotification> _action);
        bool Register(string _method, object _context);
        bool Register(string _method, object _context, IObserver _observer);

        /// <summary>
        /// Remove observer in subject.
        /// </summary>
        bool Remove(Action<INotification> _action);
        bool Remove(string _method, object _context);

        /// <summary>
        /// Check observer in subject.
        /// </summary>
        bool Has(Action<INotification> _action);
        bool Has(string _method, object _context);

        /// <summary>
        /// Retrieve observer in subject.
        /// </summary>
        IObserver Retrieve(Action<INotification> _action);
        IObserver Retrieve(string _method, object _context);
        #endregion

        #endregion

        #region Accessors

        /// <summary>
        /// The notification name of the subject.
        /// </summary>
        string NotificaionName { get; }
        /// <summary>
        /// <P>[Read-only]Get the number of observer in subject.</P>
        /// </summary>
        int Count { get; }

        #endregion
    }
}
