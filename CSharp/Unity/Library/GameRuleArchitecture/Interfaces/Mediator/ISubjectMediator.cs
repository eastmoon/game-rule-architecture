/*
	Info:
		- Re design notification structure, use subject container to setting notify system. 
	
    Date:
		- 2016.07.25
		
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
    public interface ISubjectMediator : IMediator
    {
        #region Public method
        /// <summary>
        /// Register Subject in container.
        /// </summary>
        bool RegisterSubject(string _name, Action<INotification> _method);

        /// <summary>
        /// Remove Subject in container.
        /// </summary>
        bool RemoveSubject(string _name);
        #endregion

        #region Accessors
        /// <summary>
        /// <P>[Read-only] Get subject container.</P>
        /// </summary>
        ISubjectContainer Container { get; }
        #endregion
    }
}
