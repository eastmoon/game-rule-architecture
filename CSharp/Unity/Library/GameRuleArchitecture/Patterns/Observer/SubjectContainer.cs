/*
	Info:
		- The subject container.
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
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using GameRuleArchitecture.Interfaces;

namespace GameRuleArchitecture.Patterns
{
    class SubjectContainer : ISubjectContainer
    {
        #region Member variable
        private Hashtable mSubjects;
        #endregion

        #region Constructors

        public SubjectContainer()
        {
            // Initial member variable
            this.mSubjects = new Hashtable();
        }

        #endregion
        #region Public Method
        /// <summary>
        /// Register Subject in container.
        /// </summary>
        public bool Register(ISubject _subject)
        {
            // 1. Make sure subject don't duplicate.
            if(!this.Has(_subject.NotificaionName))
            {
                // 2. Saving subject.
                this.mSubjects.Add(_subject.NotificaionName, _subject);
                return true;
            }
            return false;
        }

        /// <summary>
        /// Remove Subject in container.
        /// </summary>
        public bool Remove(string _name)
        {
            // 1. Make sure subject exist.
            if (this.Has(_name))
            {
                // 2. Remove subject
                this.mSubjects.Remove(_name);
            }
            return false;
        }

        /// <summary>
        /// Check Subject in container.
        /// </summary>
        public bool Has(string _name)
        {
            return this.mSubjects.ContainsKey(_name);
        }

        /// <summary>
        /// Retrieve Subject in container.
        /// </summary>
        public ISubject Retrieve(string _name)
        {
            // 0. Declare variable
            ISubject result = null;
            // 1. Make sure subject exist.
            if (this.Has(_name))
            {
                // 2. Take back subject
                result = this.mSubjects[_name] as ISubject;
            }
            return result;
        }
        #endregion

        #region Accessors

        /// <summary>
        /// <P>[Read-only]Get the number of subject in container.</P>
        /// </summary>
        public int Count {
            get {
                return this.mSubjects.Count;
            }
        }

        #endregion
    }
}
