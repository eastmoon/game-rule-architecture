/*
	Info:
		- The subject container interface.
        - Subject container, register, remove, check, retrieve difference subject.
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

namespace GameRuleArchitecture.Interfaces
{
    public interface ISubjectContainer
    {
        #region Public Method
        /// <summary>
        /// Register Subject in container.
        /// </summary>
        bool Register(ISubject _subject);

        /// <summary>
        /// Remove Subject in container.
        /// </summary>
        bool Remove(string _name);

        /// <summary>
        /// Check Subject in container.
        /// </summary>
        bool Has(string _name);

        /// <summary>
        /// Retrieve Subject in container.
        /// </summary>
        ISubject Retrieve(string _name);
        #endregion

        #region Accessors
        
        /// <summary>
        /// <P>[Read-only]Get the number of subject in container.</P>
        /// </summary>
        int Count { get; }

        #endregion
    }
}
