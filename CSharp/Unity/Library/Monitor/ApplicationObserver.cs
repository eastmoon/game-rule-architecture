using UnityEngine;
using UnityEngine.UI;
using System.Collections;

namespace Library.Monitor
{
    public class ApplicationObserver : MonoBehaviour
    {
        // Member variable : UI Component
        private Text mcFPS;
        private Text mcMEM;
        private Text mcPaltform;
        private Text mcCPU;
        private Text mcRAM;
        private Text mcGraphics;
        private Text mcGraphicsAPI;
        private Text mcScreenSize;
        private Text mcCameraSize;
        // Member variable
        private int mFrameCounter = 0;
        private float mTimeCounter = 0.0f;
        private float mLastFramerate = 0.0f;
        private float mRefreshTime = 0.5f;
        private int mLastFramerateListPointer = 0;
        private float[] mLastFramerateList = new float[30];
        private float mAvgFramerate = 0.0f;
        // Use this for initialization
        void Start()
        {
            // Initial
            this.InitialCanvas("ApplicationMonitor");
            // Create UI
            RectTransform rect = null;
            // Create FPS Text
            this.mcFPS = this.CreateText("AM_FPS_Text");
            rect = this.mcFPS.GetComponent<RectTransform>();
            rect.sizeDelta = new Vector2(300, 30);
            rect.anchoredPosition = new Vector2(0, 0);
            // Create MEM Text
            this.mcMEM = this.CreateText("AM_MEM_Text");
            rect = this.mcMEM.GetComponent<RectTransform>();
            rect.sizeDelta = new Vector2(300, 30);
            rect.anchoredPosition = new Vector2(0, -15);
            // Create Paltform Text
            this.mcPaltform = this.CreateText("AM_Paltform_Text");
            rect = this.mcPaltform.GetComponent<RectTransform>();
            rect.sizeDelta = new Vector2(500, 30);
            rect.anchoredPosition = new Vector2(0, -30);
            this.mcPaltform.text = "OS : " + SystemInfo.operatingSystem + " ," + Application.platform;
            // Create CPU Text
            this.mcCPU = this.CreateText("AM_CPU_Text");
            rect = this.mcCPU.GetComponent<RectTransform>();
            rect.sizeDelta = new Vector2(500, 30);
            rect.anchoredPosition = new Vector2(0, -45);
            this.mcCPU.text = "CPU : " + SystemInfo.processorType + " ( Core " + SystemInfo.processorCount + " )";
            // Create RAM Text
            this.mcRAM = this.CreateText("AM_RAM_Text");
            rect = this.mcRAM.GetComponent<RectTransform>();
            rect.sizeDelta = new Vector2(500, 30);
            rect.anchoredPosition = new Vector2(0, -60);
            this.mcRAM.text = "RAM : " + SystemInfo.systemMemorySize + " MB";
            // Create Graphic Text
            this.mcGraphics = this.CreateText("AM_Graphic_Text");
            rect = this.mcGraphics.GetComponent<RectTransform>();
            rect.sizeDelta = new Vector2(500, 30);
            rect.anchoredPosition = new Vector2(0, -75);
            this.mcGraphics.text = "Graphic : " + SystemInfo.graphicsDeviceName + " ( " + SystemInfo.graphicsMemorySize + " MB )";
            // Create Graphic API Text
            this.mcGraphicsAPI = this.CreateText("AM_Graphic_API_Text");
            rect = this.mcGraphicsAPI.GetComponent<RectTransform>();
            rect.sizeDelta = new Vector2(500, 30);
            rect.anchoredPosition = new Vector2(0, -90);
            this.mcGraphicsAPI.text = "Graphic API : " + SystemInfo.graphicsDeviceType;
            // Create RAM Text
            this.mcScreenSize = this.CreateText("AM_Screen_Size_Text");
            rect = this.mcScreenSize.GetComponent<RectTransform>();
            rect.sizeDelta = new Vector2(500, 30);
            rect.anchoredPosition = new Vector2(0, -105);
            this.mcScreenSize.text = "Screen size : " + Screen.currentResolution + " , DPI : " + Screen.dpi;
            // Create RAM Text
            Camera cam = GameObject.Find("Main Camera").GetComponent<Camera>();
            this.mcCameraSize = this.CreateText("AM_Camera_Size_Text");
            rect = this.mcCameraSize.GetComponent<RectTransform>();
            rect.sizeDelta = new Vector2(500, 30);
            rect.anchoredPosition = new Vector2(0, -120);
            this.mcCameraSize.text = "Camera size : " + cam.pixelRect.width + " x " + cam.pixelRect.height;
        }

        // Update is called once per frame
        void Update()
        {
            int i = 0;
            // Calculate FPS
            this.mTimeCounter += Time.deltaTime;
            //this.mLastFramerate = 1.0f / Time.deltaTime;
            this.mFrameCounter++;
            if (this.mTimeCounter > this.mRefreshTime)
            {
                //This code will break if you set your m_refreshTime to 0, which makes no sense.
                this.mLastFramerate = (float)this.mFrameCounter / this.mTimeCounter;
                this.mFrameCounter = 0;
                this.mTimeCounter = 0.0f;
                // Saving framerate record
                this.mLastFramerateList[mLastFramerateListPointer] = (int) this.mLastFramerate;
                if (++this.mLastFramerateListPointer >= this.mLastFramerateList.Length)
                    this.mLastFramerateListPointer = 0;
                // Calculate AVG FPS
                for (i = 0; i < this.mLastFramerateList.Length && this.mLastFramerateList[i] > 0; i++)
                    this.mAvgFramerate += this.mLastFramerateList[i];
                this.mAvgFramerate /= (i);
            }
            // Show information
            //#if ENABLE_PROFILER
                System.GC.Collect();
                this.mcFPS.text = "FPS : " + (int)this.mLastFramerate + ", AVG : " + (int)this.mAvgFramerate;
                this.mcMEM.text = "MEM : " + Profiler.GetTotalAllocatedMemory() / 1024 / 1024 + "MB ( MAX : " + Profiler.GetTotalReservedMemory() / 1024 / 1024 + "MB )";
            
            //Debug.Log("FPS : " + this.mLastFramerate + ", AVG : " + this.mAvgFramerate);
            //Debug.Log("Mono MEM : " + Profiler.GetMonoUsedSize() / 1024 / 1024 + "MB ( MAX : " + Profiler.GetMonoHeapSize() / 1024 / 1024 + "MB )");
            //#endif
        }
        private void InitialCanvas(string _name)
        {
            // Setting Application Observer
            this.gameObject.AddComponent<RectTransform>();
            //
            this.gameObject.AddComponent<Canvas>().renderMode = RenderMode.ScreenSpaceOverlay;
            // RWD Setting, reference : http://docs.unity3d.com/Manual/HOWTO-UIMultiResolution.html
            CanvasScaler cs = this.gameObject.AddComponent<CanvasScaler>();
            cs.referencePixelsPerUnit = 1;
            cs.uiScaleMode = CanvasScaler.ScaleMode.ScaleWithScreenSize;
            cs.referenceResolution = new Vector2(950, 550);

            this.gameObject.AddComponent<GraphicRaycaster>();
            this.gameObject.name = _name;
        }
        private Text CreateText(string _name)
        {
            GameObject obj = new GameObject();
            obj.name = _name;
            RectTransform rect = obj.AddComponent<RectTransform>();
            rect.anchorMin = new Vector2(0, 1);
            rect.anchorMax = new Vector2(0, 1);
            rect.pivot = new Vector2(0, 1);
            Text text = obj.AddComponent<Text>();
            text.font = Resources.GetBuiltinResource(typeof(Font), "Arial.ttf") as Font;
            text.transform.SetParent(this.gameObject.transform);
            text.color = new Color(.75f, .75f, .75f, 1);
            return text;
        }
    }
}

