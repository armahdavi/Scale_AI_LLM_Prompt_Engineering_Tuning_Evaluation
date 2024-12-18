#include <iostream>
#include <string>
#include <vector>
#include <iomanip>  

using namespace std;

class Medication {
private:
    int medication_id;          // Primary Key
    string name;                // Medication name
    string dosage;              // Dosage information
    double price;               // Medication price
    int stock;                  // Stock quantity

public:
    Medication(int id, const string& n, const string& d, double p, int s)
        : medication_id(id), name(n), dosage(d), price(p), stock(s) {}

    // Getters
    int getMedicationId() const { return medication_id; }
    string getName() const { return name; }
    string getDosage() const { return dosage; }
    double getPrice() const { return price; }
    int getStock() const { return stock; }

    // Setters
    void setName(const string& n) { name = n; }
    void setDosage(const string& d) { dosage = d; }
    void setPrice(double p) { price = p; }
    void setStock(int s) { stock = s; }
};

class Customer {
private:
    int customer_id;            // Primary Key
    string first_name;          // Customer's first name
    string last_name;           // Customer's last name
    string phone_number;        // Phone number
    string email;               // Email address

public:
    Customer(int id, const string& fn, const string& ln, const string& phone, const string& email)
        : customer_id(id), first_name(fn), last_name(ln), phone_number(phone), email(email) {}

    // Getters
    int getCustomerId() const { return customer_id; }
    string getFirstName() const { return first_name; }
    string getLastName() const { return last_name; }
    string getPhoneNumber() const { return phone_number; }
    string getEmail() const { return email; }

    // Setters
    void setFirstName(const string& fn) { first_name = fn; }
    void setLastName(const string& ln) { last_name = ln; }
    void setPhoneNumber(const string& phone) { phone_number = phone; }
    void setEmail(const string& email) { this->email = email; }
};

class Sale {
private:
    int sale_id;                // Primary Key
    int customer_id;            // Foreign Key
    double total_amount;        // Total sale amount
    string sale_date;           // Sale date

public:
    Sale(int id, int cid, double amount, const string& date)
        : sale_id(id), customer_id(cid), total_amount(amount), sale_date(date) {}

    // Getters
    int getSaleId() const { return sale_id; }
    int getCustomerId() const { return customer_id; }
    double getTotalAmount() const { return total_amount; }
    string getSaleDate() const { return sale_date; }

    // Setters
    void setCustomerId(int cid) { customer_id = cid; }
    void setTotalAmount(double amount) { total_amount = amount; }
    void setSaleDate(const string& date) { sale_date = date; }
};

class SaleItem {
private:
    int sale_item_id;           // Primary Key
    int sale_id;                // Foreign Key
    int medication_id;          // Foreign Key
    int quantity;               // Quantity sold
    double price;               // Sale price per unit

public:
    SaleItem(int id, int sid, int mid, int qty, double p)
        : sale_item_id(id), sale_id(sid), medication_id(mid), quantity(qty), price(p) {}

    // Getters
    int getSaleItemId() const { return sale_item_id; }
    int getSaleId() const { return sale_id; }
    int getMedicationId() const { return medication_id; }
    int getQuantity() const { return quantity; }
    double getPrice() const { return price; }

    // Setters
    void setSaleId(int sid) { sale_id = sid; }
    void setMedicationId(int mid) { medication_id = mid; }
    void setQuantity(int qty) { quantity = qty; }
    void setPrice(double p) { price = p; }
};

class PharmacyDatabase {
public:
    vector<Medication> medications;
    vector<Customer> customers;
    vector<Sale> sales;
    vector<SaleItem> sale_items;

    void addMedication(const Medication& med) {
        medications.push_back(med);
    }

    void addCustomer(const Customer& cust) {
        customers.push_back(cust);
    }

    void addSale(const Sale& sale) {
        sales.push_back(sale);
    }

    void addSaleItem(const SaleItem& item) {
        sale_items.push_back(item);
    }

    void displayMedications() {
        cout << "Medications:\n";
        for (const auto& med : medications) {
            cout << "ID: " << med.getMedicationId() << ", Name: " << med.getName() 
                 << ", Dosage: " << med.getDosage() << ", Price: " << fixed << setprecision(2) 
                 << med.getPrice() << ", Stock: " << med.getStock() << '\n';
        }
    }

    void displayCustomers() {
        cout << "Customers:\n";
        for (const auto& cust : customers) {
            cout << "ID: " << cust.getCustomerId() << ", Name: " << cust.getFirstName() << " " << cust.getLastName() 
                 << ", Phone: " << cust.getPhoneNumber() << ", Email: " << cust.getEmail() << '\n';
        }
    }

    void displaySales() {
        cout << "Sales:\n";
        for (const auto& sale : sales) {
            cout << "ID: " << sale.getSaleId() << ", Customer ID: " << sale.getCustomerId() 
                 << ", Total Amount: " << fixed << setprecision(2) 
                 << sale.getTotalAmount() << ", Date: " << sale.getSaleDate() << '\n';
        }
    }

    void displaySaleItems() {
        cout << "Sale Items:\n";
        for (const auto& item : sale_items) {
            cout << "ID: " << item.getSaleItemId() << ", Sale ID: " << item.getSaleId() 
                 << ", Medication ID: " << item.getMedicationId() << ", Quantity: " << item.getQuantity() 
                 << ", Price: " << fixed << setprecision(2) << item.getPrice() << '\n';
        }
    }
};

int main() {
    PharmacyDatabase db;

    // Adding sample data
    db.addMedication(Medication(1, "Paracetamol", "500mg", 5.99, 100));
    db.addMedication(Medication(2, "Ibuprofen", "200mg", 7.50, 50));
    db.addCustomer(Customer(1, "John", "Doe", "123-456-7890", "john.doe@example.com"));
    db.addSale(Sale(1, 1, 15.99, "2024-09-01"));
    db.addSaleItem(SaleItem(1, 1, 1, 2, 5.99));

    // Displaying the data
    db.displayMedications();
    db.displayCustomers();
    db.displaySales();
    db.displaySaleItems();

    return 0;
}