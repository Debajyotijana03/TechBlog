/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tech.blog.helper;

/**
 *
 * @author DEBAJYOTI
 */
public class HelperDot {
    public static String get10Words(String desc){
    
       String[]str= desc.split(" ");
       if(str.length>20){
           String res="";
           for(int i=0;i<20;i++){
               res+=str[i] +" ";
           }
           return  (res+"....");
       }else{
           return (desc+"...");
       }
    }
}
