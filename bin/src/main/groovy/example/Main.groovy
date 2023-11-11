package example;

import groovy.transform.CompileStatic
/*
 @CompileStatic should be used judiciously and only when you are absolutely sure you are not using any of Groovy's dynamic features.
*/

@CompileStatic
class Main{
    public static void main(String[] args) {
        System.out.println("Hello World from groovy");
    }
}