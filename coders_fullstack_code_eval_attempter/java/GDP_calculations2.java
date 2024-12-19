import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class GDPAnalysis {

    // Lists to hold each column's data
    private ArrayList<String> country = new ArrayList<>();
    private ArrayList<Double> consumption = new ArrayList<>();
    private ArrayList<Double> investment = new ArrayList<>();
    private ArrayList<Double> governmentSpending = new ArrayList<>();
    private ArrayList<Double> exports = new ArrayList<>();

    public void fileReading(String fileName) {
        try {
            File file = new File(fileName);
            Scanner scanner = new Scanner(file);
            while (scanner.hasNextLine()) {
                String[] line = scanner.nextLine().split(" ");
                country.add(line[0]);
                consumption.add(Double.parseDouble(line[1]));
                investment.add(Double.parseDouble(line[2]));
                governmentSpending.add(Double.parseDouble(line[3]));
                exports.add(Double.parseDouble(line[4]));
            }
            scanner.close();
        } catch (FileNotFoundException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        }
    }

    public ArrayList<String> calculateGDP() {
        ArrayList<String> GDP = new ArrayList<>();
        for (int i = 0; i < country.size(); i++) {
            double total = consumption.get(i) + investment.get(i) + governmentSpending.get(i) + exports.get(i);
            GDP.add(country.get(i) + ": " + total);
        }
        return GDP;
    }

    public static void main(String[] args) {
        GDPAnalysis analysis = new GDPAnalysis();
        String fileName = "/uploads/GDP.txt";
        analysis.fileReading(fileName);
        ArrayList<String> GDP = analysis.calculateGDP();
        for (String entry : GDP) {
            System.out.println(entry);
        }
    }
}
