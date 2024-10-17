## Project Documentation

**25 September 2024**
| Time | Name | Explanation |
|---|---|---|
| 11.00 am | 410855315 Kenny | Set up github repository |
| 16.30 pm | 410855307 Nathan | Create use case diagram |
| 18.30 pm | 410855059 Levina | Design app wireframe (low fidelity) **tablet** format |

Summary:

Wireframe:
- Tablet format
  - Staff POS
  - Admin POS
  - Admin & staff POS(closed)**
  - Staff Inventory
  - Admin Inventory
  - Admin & staff Inventory(closed)**
  - Admin & staff Scanner
  - Admin staff report
  - Admin staff report(closed)
    
*Menu bar closed<br/>
*When menu bar is closed, Admin and staff's POS and inventory pages looks the same
    
Use Case Diagram:
Actors:
- Clerk
- Customer
- System Administrator (Admin)
- Inventory Stocker

System 
- Software

Use cases:
Clerk:
1. Receive Payment
2. Checkout process

Customer:
1. Login membership
2. Add product to cart 
3. Make payment

System Administrator:
1. Modify product detail
2. Open list of Stock
3. Receive Analytic report

Inventory Stocker:
1. Open list of Stock
2. Open product barcode scanner 
3. Input product 
4. Remove Expired item

Software:
1. Update list
2. Update report analytic
3. Sales processing 
- Updates all use cases into the database

**28 September 2024**
| Time | Name | Explanation |
|---|---|---|
| 19.00 pm | 410855059 Levina  | App name is decided=**Pulse** ; Design app [logo](https://github.com/BBBIJI/Finals_POS/tree/main/Logo) and icon |

For logo information = [logo explanation](https://github.com/BBBIJI/Finals_POS/blob/main/Logo/Logo_Explanation.pdf)

**30 September 2024**
| Time | Name | Explanation |
|---|---|---|
| 21.40 pm | 410855059 Levina & 410856057 Shanyu | Create flowchart & activity diagram |

Summary:

Flowchart
- Login page
  - for admin and staff
- Staff at store(Cashier)
  
UML Activity Diagram
- Admin dashboard
- Staff at warehouse(Inventory stocker)

**2 October 2024**
| Time | Name | Explanation |
|---|---|---|
| 21.00 pm | 410855059 Levina | Design app wireframe (low fidelity) **phone** format |

Summary:

Wireframe:
  - Phone format
     - Staff POS
     - Admin POS
     - Staff Inventory
     - Admin Inventory
     - Admin & Staff Checkout
     - Admin & staff Scanner
     - Admin staff report

**4 October 2024**
| Time | Name | Explanation |
|---|---|---|
| 19.00 pm | 410855059 Levina | Wireframe finished ; Start design UI/UX prototype based on wireframe **tablet** format|

Summary:

Prototype:
- Tablet format
    - Splash screen
    - Admin & staff Login
    - Staff POS
    - Admin POS
    - Admin & staff POS(closed)**
    - Staff Inventory
    - Admin Inventory
    - Admin & staff Inventory(closed)**
    - Admin & staff Scanner
    - Admin staff report
    - Admin staff report(closed)
 
*Menu bar closed<br/>
*When menu bar is closed, Admin and staff's POS and inventory pages looks the same

**5 October 2024**
| Time | Name | Explanation |
|---|---|---|
| 18.30 - 20:00 | 410856057 Tan Shan Yu & 410855315 Kenny | ERD diagram created |

Summary: <br/>
ERD (added):
- Order
- Product
- Storage
- Supplier
- Expiry Item
- Customer (membership)
  1. birthday: for birthday promotion 
- Staff
  1. Admin attributes, 0 or 1, indicating admin or not
- Cart
  1. will be implemented if there will be online shopping added
- Report
  1. status: deleted, incomplete, complete<br/>
  2. type: daily, weekly, etc...
- Payment (type)

**6 October 2024**
| Time | Name | Explanation |
|---|---|---|
| 18.30 - 20:00 | 410856057 Tan Shan Yu | ERD diagram modifications |

Summary:<br/>
ERD (added):
- Storage: "Name" attribute changed to "nickname"
- Supplier: "Name" attribute changed to "company"
- Supplier: "contact_person" attribute seperated into "firstName" and "lastName" attribute
- Customer, Staff: "name" attribute seperated into "firstName" and "lastName" attribute
- Added relations to the ERD
1. Category to Product:<br/>
One-to-Many: Each category can have many products, but each product belongs to only one category.

2. Product to Storage:<br/>
One-to-Many: Each product may have multiple entries in storage across different locations.

3. Supplier to Product:<br/>
One-to-Many: A supplier can supply many products, but each product typically comes from one supplier.

4. Storage to Order:<br/>
Many-to-Many: An order can come from many storage, and a storage can supply many orders

5. Storage to Expired:<br/>
One-to-Many: Each storage entry can have multiple or no expired items records, as different batches or lots of the same product can expire at different times.

6. Order to Cart:<br/>
One-to-One: Each order can be a cart for online shopping, but not all order has to have a cart, meaning it's a mortar-and-brick retail store

7. Payment to Order:<br/>
Many-to-One: There can be multiple payment type in an order, but each order can only have one payment type

8. Order to Report:<br/>
Many-to-One: Multiple orders are compiled into a single report. Each report summarizes or aggregates data from multiple orders.

9. Customer to Order:<br/>
One-to-Many: Each customer can have multiple orders, but each order is placed by one customer.
