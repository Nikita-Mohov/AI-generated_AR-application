using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BtnManager : MonoBehaviour
{
    public void CallBtn()
    {
        Application.OpenURL("tel:+73473339850");
    }

    public void MailBtn()
    {
        Application.OpenURL("mailto:sf@struust.ru");
    }

    public void SiteBtn()
    {
        Application.OpenURL("https://strbsu.ru/");
    }
}
