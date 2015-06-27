private final Logger logger;
public GenerateSketch(Logger logger) {
this.logger = logger;
}
public void generate(File mavenSourceFolder, File processingDestinationFolder) {
File sketchFolder = extractSketchFolder(mavenSourceFolder);
File sketchMainFile = sketchFolder.listFiles(new FileFilter() {
public boolean accept(File pathname) {
return pathname.isFile() && pathname.getName().endsWith(".java");
}
})[0];
File generatedSketchFolder = new File(processingDestinationFolder, sketchMainFile.getName().substring(0, sketchMainFile.getName().length() - ".java".length()));
if (!generatedSketchFolder.exists()) {
if (!generatedSketchFolder.mkdir()) {
throw new RuntimeException("Creation of folder " + generatedSketchFolder + " failed");
}
}
File generatedSketchMainFile = new File(generatedSketchFolder, generatedSketchFolder.getName() + ".pde");
if (!generatedSketchMainFile.exists()) {
try {
generatedSketchMainFile.createNewFile();
} catch (IOException e) {
throw new RuntimeException(e);
}
}
FileWriter out = null;
BufferedReader in = null;
int indents = 0;
try {
in = new BufferedReader(new FileReader(sketchMainFile));
out = new FileWriter(generatedSketchMainFile);
String currentLine;
boolean skipNewLine = true;
while ((currentLine = nextLine(in, skipNewLine, "^package .+;", "^import .+;", "^public class .+", "^\\s*@Override.*", "^}.*")) != null) {
Matcher matcher = Pattern.compile("^(\\s*)public\\s+void\\s+(setup|draw)\\(\\)\\s+\\{\\s*$").matcher(currentLine);
if (matcher.matches()) {
indents = matcher.group(1).length();
logger.info("indents = " + indents + " because of this line \"" + currentLine + "\"");
skipNewLine = false;
currentLine = "void " + matcher.group(2) + "() {";
}
matcher = Pattern.compile("^(\\s*)(.+)$").matcher(currentLine);
if (matcher.matches()) {
currentLine = "";
if (indents > 0) {
for (int indent = 0; indent < matcher.group(1).length() / indents - 1; indent++) {
currentLine += "  ";
}
}
currentLine += matcher.group(2);
}
out.write(currentLine + "\n");
}
} catch (IOException e) {
throw new RuntimeException(e);
} finally {
if (out != null) {
try {
out.close();
} catch (IOException e) {
e.printStackTrace();
}
}
if (in != null) {
try {
in.close();
} catch (IOException e) {
e.printStackTrace();
}
}
}
}
private String nextLine(BufferedReader in, boolean skipNewLine, String... filters) {
try {
String line = in.readLine();
if (line == null) {
return null;
}
if (skipNewLine && line.isEmpty()) {
return nextLine(in, skipNewLine, filters);
}
for (String filter : filters) {
if (line.matches(filter)) {
return nextLine(in, filter.equals("^}.*") || skipNewLine, filters);
}
}
return line;
} catch (IOException e) {
throw new RuntimeException(e);
}
}
private File extractSketchFolder(File folder) {
File[] folders = folder.listFiles(new OnlyFolders());
if (folders.length == 0) {
return folder;
}
return extractSketchFolder(folders[0]);
}
private static class OnlyFolders implements FileFilter {
public boolean accept(File pathname) {
return pathname.isDirectory();
}
}
