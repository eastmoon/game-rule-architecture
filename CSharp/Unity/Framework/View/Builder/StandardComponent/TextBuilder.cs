using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using UnityEngine;
using UnityEngine.UI;

namespace Game.Framework.View.Builder.StandardComponent
{
    class TextBuilder : ViewComponentsBuilder
    {
        // Static Enum
        public static String ID = "";
        // Constructor
        public TextBuilder()
        {
            TextBuilder.ID = this.GetType().Namespace + "." + this.GetType().Name;
            this.SetComponentID(TextBuilder.ID);
        }
        // Build component
        public override GameObject Build(object[] _args)
        {
            String name = "";
            String text = "";
            if (_args.Length > 0)
                name = _args[0] as String;
            if (_args.Length > 1)
                text = _args[1] as String;

            GameObject obj = this.GetTarget();
            // Defined text in button
            obj.name = name;
            // Set local
            obj.AddComponent<RectTransform>();
            // Set text
            Text content = obj.AddComponent<Text>();
            content.text = text;
            content.alignment = TextAnchor.MiddleCenter;
            content.color = new Color(0, 0, 0, 1);
            content.font = Resources.GetBuiltinResource(typeof(Font), "Arial.ttf") as Font;

            //
            if (this.GetStage() != null && this.GetStage() != obj)
                obj.transform.SetParent(this.GetStage().transform);
            return obj;
        }
    }
}
