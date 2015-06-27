package name.lemerdy.sebastian.maven.pde;

import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.TemporaryFolder;

import java.io.File;
import java.net.URISyntaxException;

import static org.assertj.core.api.Assertions.assertThat;

public class GenerateSketchTest {

    @Rule
    public TemporaryFolder temporaryFolder = new TemporaryFolder();

    @Test
    public void should_generate_sketch_folder() {
        File mavenSourceFolder = mavenSourceFolder();
        File processingDestinationFolder = temporaryFolder.getRoot();
        GenerateSketch generateSketch = new GenerateSketch(new ConsoleLogger());

        generateSketch.generate(mavenSourceFolder, processingDestinationFolder);

        assertThat(new File(temporaryFolder.getRoot(), "MySketch")).as("generated sketch folder").isDirectory();
    }

    @Test
    public void should_generate_main_sketch_file() {
        File mavenSourceFolder = mavenSourceFolder();
        File processingDestinationFolder = temporaryFolder.getRoot();
        GenerateSketch generateSketch = new GenerateSketch(new ConsoleLogger());

        generateSketch.generate(mavenSourceFolder, processingDestinationFolder);

        assertThat(new File(new File(temporaryFolder.getRoot(), "MySketch"), "MySketch.pde")).as("generated sketch main file")
                .isFile()
                .hasContent("" +
                        "void setup() {\n" +
                        "  size(640, 480);\n" +
                        "}\n" +
                        "\n" +
                        "void draw() {\n" +
                        "  text(\"hello world\", 0, 10);\n" +
                        "}\n" +
                        "\n");
    }

    private File mavenSourceFolder() {
        try {
            return new File(getClass().getResource("/src/main/java").toURI());
        } catch (URISyntaxException e) {
            throw new RuntimeException(e);
        }
    }

    private static class ConsoleLogger implements Logger {
        public void info(String message) {
            System.out.println(message);
        }
    }
}
