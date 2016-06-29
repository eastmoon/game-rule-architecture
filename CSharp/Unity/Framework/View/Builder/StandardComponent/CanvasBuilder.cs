using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using UnityEngine;
using UnityEngine.UI;

namespace Game.Framework.View.Builder.StandardComponent
{
    class CanvasBuilder : ViewComponentsBuilder
    {
        // Static Enum
        public static String ID = "";
        // Constructor
        public CanvasBuilder()
        {
            CanvasBuilder.ID = this.GetType().Namespace + "." + this.GetType().Name;
            this.SetComponentID(CanvasBuilder.ID);
        }
        // Build component
        public override GameObject Build(object[] _args)
        {
            String name = "";
            if(_args.Length > 0)
            {
                name = _args[0] as String;
            }

            GameObject obj = this.GetTarget();
            // 
            obj.AddComponent<RectTransform>();
            obj.AddComponent<CanvasRenderer>();
            //
            obj.AddComponent<Canvas>().renderMode = RenderMode.ScreenSpaceOverlay;
            // RWD Setting, reference : http://docs.unity3d.com/Manual/HOWTO-UIMultiResolution.html
            CanvasScaler cs = obj.AddComponent<CanvasScaler>();
            cs.referencePixelsPerUnit = 100;
            cs.uiScaleMode = CanvasScaler.ScaleMode.ScaleWithScreenSize;
            cs.referenceResolution = new Vector2(950, 550);
            //
            obj.AddComponent<GraphicRaycaster>();
            obj.name = name;
            //
            if (this.GetStage() != null && this.GetStage() != obj)
                obj.transform.SetParent(this.GetStage().transform);
            return obj;
        }
    }
}
