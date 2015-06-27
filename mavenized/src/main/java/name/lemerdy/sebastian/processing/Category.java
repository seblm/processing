package name.lemerdy.sebastian.processing;

import processing.core.PApplet;

import java.util.Map;

public enum Category {

    POP(200, 67, 67),
    SCIENCE(97, 142, 200),
    SPORTS(77, 188, 30),
    ROCK(51, 41, 51);

    public final int red;
    public final int green;
    public final int blue;

    Category(int red, int green, int blue) {
        this.red = red;
        this.green = green;
        this.blue = blue;
    }

    public void fill() {
        Thread next = Thread.getAllStackTraces().keySet().iterator().next();
        next.toString();
        for (java.util.Map.Entry stackTrace : Thread.getAllStackTraces().entrySet()) {
            System.out.println(stackTrace.getKey());
            for (StackTraceElement stackTraceElement : (StackTraceElement[]) stackTrace.getValue()) {
                System.out.println(stackTraceElement);
            }
        }
        PApplet.fill(red, green, blue);
    }

    public static Category fromIndex(int index) {
        return Category.values()[index % Category.values().length];
    }

}