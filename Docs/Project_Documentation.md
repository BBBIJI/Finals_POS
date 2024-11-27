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

**24 October 2024**
| Time | Name | Explanation |
|---|---|---|
| 09.00 am | 410855059 Levina | Finalize UI prototype |

Summary:

UI Prototype: [Figma Prototype](https://github.com/BBBIJI/Finals_POS/blob/main/UI_Design/Ui_prototype.md)

**Prototype:**
- Staff
- Admin*

*Admin prototype : staff prototype + create category, create product, staffreport

**Prototype staff (Tablet format):**
- Splash screen
- Login
- Menubar -> Can navigate to: POS, inventory, Receiptscash
- POS
- Camera
- POS2
- Cash -> Frame Cash will pop out
- Cash1 -> Frame Cash1 will pop out
- Card -> Frame Card will pop out
- Card1 -> Frame Card1 will pop out
- POSclear
- Inventory
- Shelfcamera -> Frame 9 will pop out
- Inventorycategory
- Inventorycamera
- Inventoryproduct1 -> Frame 6 will pop out
- Inventoryproductnext -> Frame 10 will pop out
- Inventoryproduct2 -> Frame 7 will pop out
- Inventoryproductaddnext -> Frame 7 will pop out
- Receiptscash
- Receiptscard
- Userprofile
- Userpassword
- Usersessions
- Userschedule -> Can pop out Frame: 13nov, 7nov, 5nov, 9nov, 23nov, 15nov, 3nov

**Prototype Admin (Tablet format):**
- Splash screen
- Login
- Menubar -> Can navigate to: POS, inventory, Receiptscash
- POS
- Camera
- POS2
- Cash -> Frame Cash will pop out
- Cash1 -> Frame Cash1 will pop out
- Card -> Frame Card will pop out
- Card1 -> Frame Card1 will pop out
- POSclear
- Inventory
- Createproducteach -> Frame 10 will pop out
- Createproductweight -> Frame 10 will pop out
- Shelfcamera -> Frame 9 will pop out
- Inventorycategory
- Create category -> Can pop out frame product list then Frame 11 will pop out
- Inventorycamera
- Inventoryproduct1 -> Frame 6 will pop out
- Inventoryproductnext -> Frame 10 will pop out
- Inventoryproduct2 -> Frame 7 will pop out
- Inventoryproductaddnext -> Frame 7 will pop out
- Receiptscash
- Receiptscard
- Userprofile
- Userpassword
- Usersessions
- Userschedule -> Can pop out Frame: 13nov, 7nov, 5nov, 9nov, 23nov, 15nov, 3nov
- Staffreport
  
**26 October 2024**
| Time | Name | Explanation |
|---|---|---|
| 04.00 pm | 410855356 Ramon | Start to Implement figma design into flutter |

Summary:<br/>
Splash screen + Login page created

**29 October 2024**
| Time | Name | Explanation |
|---|---|---|
| 08.00 pm | 410855356 Ramon | Continue Implementing figma design into flutter |

Summary:

Create reusable widgets:
- app navigator class for pushreplacement
- app main colors
- image

**5 November 2024**
| Time | Name | Explanation |
|---|---|---|
| 06.00 pm | 410855356 Ramon | Continue Implementing figma design into flutter |

Summary:

Create reusable widgets:
- custom side navigation rail
- custom drawer
- custom app bar

**13 November 2024**
| Time | Name | Explanation |
|---|---|---|
| 07.00 pm | 410855356 Ramon & 410855059 Levina | Implement APP's functionality + design |

Summary:<br/>
- Create POS, Inventory, Inventorycategory, and checkout page(cash&card)
  - Products in the POS page can be added to cart
  - Before checkout must choose payment method then will be directed to checkout page
 
**18 November 2024**
| Time | Name | Explanation |
|---|---|---|
| 09.30 pm | 410855356 Ramon | Implement APP's  design |

Summary:<br/>
- Continue developing POS, inventory, and inventorycategory page
    - Editing the pages UI design
    - Create createproduct & createcategory page 
 
**20 November 2024**
| Time | Name | Explanation |
|---|---|---|
| 10.00 pm | 410855059 Levina | Implement APP's functionality |

Summary:<br/>
- Create Sales (receipt) page
  - After checkout will be directed to sales page
  - Checkout receipt history will be listed on the sales page

- Receipt history:
  - Cash: Total amount, payment method, date
  - Card: Total amount, payment method, date, card holder name
  
  
**22 November 2024**
| Time | Name | Explanation |
|---|---|---|
| 16.30 - 17.30 | 410856057 Tan Shan Yu | MySQL database modifications |

Summary:<br/>
final_pos database:
1. Added dataset for the database
2. renamed 'order' table to 'customer_order' because order is a keyword...<br/>
   *REMARK:* add DROP TABLE IF EXISTS `order`; if you have already run the database before DROP TABLE IF EXISTS `customer_order`;<br/>
Check [Dump20241122.sql](https://github.com/BBBIJI/Finals_POS/blob/main/Database/Dump20241122.sql) for full changes

**23 November 2024**
| Time | Name | Explanation |
|---|---|---|
| 17.00 - 19.00 | 410856057 Tan Shan Yu | MySQL database Integration |
| 08.00 pm | 410855356 Ramon | Implement APP's functionality |

Summary:<br/>
MySQL database Integration:
1. Created [Direct MySQL connection](https://github.com/BBBIJI/Finals_POS/blob/main/src/flutter_application_1/lib/services/mysql_conn.dart) 
2. Created basic connect, fetch, and insert method to use in widgets

Implement APP's functionality:
- continue developing createproduct & createcategory page
  - start implementing the pages functionality

**24 November 2024**
| Time | Name | Explanation |
|---|---|---|
| 15.00 - 15.30 | 410856057 Tan Shan Yu | Combine WIP (front & backend) |
| 16.15 - 16.45 | 410856057 Tan Shan Yu | Migrate from mysql_client pkg to mysql1 pkg |

Summary: <br/>
1. Combining front end code from Ramon with MySQL connection, further testing needed after migration
2. Migration from mysql_client to mysql1 for SQL injections features

**25 November 2024**
| Time | Name | Explanation |
|---|---|---|
| 16.00 - 16.15 | 410856057 Tan Shan Yu | Debugging |

Summary: <br/>
1. Fixed error: Another exception was thrown: Unable to load asset: "assets/profile.png".
    - Changed "pubspec.yaml" - assets/image to assests/ - since profile.png is in assests/ not assests/image
  
**27 November 2024**
| Time | Name | Explanation |
|---|---|---|
| 06.45 pm | 410855356 Ramon | Implement APP's functionality |

Summary:<br/>
- continue developing createproduct & createcategory page
  - creating state managament and model for assigining product and category to the product and category list 
