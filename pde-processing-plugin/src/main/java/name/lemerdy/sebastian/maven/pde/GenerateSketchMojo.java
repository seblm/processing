package name.lemerdy.sebastian.maven.pde;

import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugin.MojoFailureException;
import org.apache.maven.plugins.annotations.Mojo;
import org.apache.maven.project.MavenProject;

import java.io.File;

@Mojo(name = "generatesketch")
public class GenerateSketchMojo extends AbstractMojo {

    public void execute() throws MojoExecutionException, MojoFailureException {
        MavenProject project = (MavenProject) getPluginContext().get("project");
        File processingDestinationFolder = new File(project.getBasedir(), "src/main/processing");
        if (!processingDestinationFolder.exists()) {
            if (!processingDestinationFolder.mkdir()) {
                throw new MojoExecutionException("Creation of folder src/main/processing failed");
            }
        }
        GenerateSketch generateSketch = new GenerateSketch(new MojoLogger());

        generateSketch.generate(new File(project.getCompileSourceRoots().get(0)), processingDestinationFolder);
    }
    
    private class MojoLogger implements Logger {
        public void info(String message) {
            getLog().info(message);
        }
    }
    
}
