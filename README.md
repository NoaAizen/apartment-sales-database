# Apartment Sales Database

A relational database system for managing apartments, buyers, sellers, agents, property visits, and sales.

It is built on Oracle Database with SQL and PL/SQL. The repository has the schema and its constraints, sample data and import definitions, analytical and parameterized queries, and PL/SQL programs for apartment matching and agent management. It also includes integration scripts and views that merge the schema with an external flower-shop ordering database.

## Data Model

| Table | Description |
|---|---|
| `Seller` | Apartment owners |
| `Buyer` | Prospective buyers |
| `City` | Cities and their rating |
| `Agent_Person` | Agents, with visit rate, sale rate, active status and exit date |
| `Apartment` | Size, floor, rooms, price and sold flag; linked to a seller and a city |
| `Visit` | A buyer viewing an apartment with an agent at a given date and hour |
| `Apartment_Sale` | The final cost, agent fee and signing date of a sale that resulted from a visit |

Relationships:

- Each apartment belongs to one seller and one city.
- Each visit links one apartment, one buyer and one agent.
- Each sale is linked to the visit it came from.

Constraints include primary and foreign keys, a non-null apartment price, a positive agent fee, and a sale rate between 0 and 1.

Diagrams are in [`docs/diagrams/`](docs/diagrams/):

- `erd-apartment-sales.jpeg`, `dsd-apartment-sales.jpeg`: the core apartment sales schema
- `erd-flower-shop.png`, `dsd-flower-shop.png`: the external flower-shop schema
- `erd-integrated.png`, `dsd-integrated.png`: the combined schema after integration

## Components

### Schema
- `CreateTable.sql`, `DropTable.sql`: create and drop the core tables.
- `AlterTablesPresentStatus.sql`, `Constraints.sql`: add a `Present_Status` column to visits, plus the price, agent-fee and default-value constraints.
- `AlterTablesAgentManagement.sql`: adds the agent columns (visit rate, sale rate, active status, exit date), an apartment `Sold` flag, and a wider seller phone number.

### Data management
- `InsertTables.sql`: sample data for every table.
- `InsertBuyerValues.sql`: extra sample buyer rows.
- `SelectAll.sql`: row listings and row counts for checking the loaded data.
- `data/import/`: PL/SQL Developer Text Importer definitions (`.def`) with matching synthetic CSV data for buyers, sellers and cities.

### SQL queries
- `Queries.sql`:
  - Joins and grouped subqueries, such as frequently visited apartments in highly rated cities, visit counts per agent, and sales with visit counts.
  - Data-maintenance statements: removing duplicate sales, removing unused cities, a city-based price update, and correcting sign dates that fall before the visit.
- `ParamsQueries.sql`: parameterized queries that filter by minimum city rating, visit date and present status, city and minimum price, or seller name.

### PL/SQL: apartment matching and seller updates
- `find` (function): returns a ref cursor of unsold apartments in a given city within a room range and a price range.
- `UpdateSellerPhoneNumbers` (procedure): prefixes each seller's phone number with the ID of the city where the seller's apartment is located.
- `FindApartmentAndUpdateSeller.sql`: an interactive block that runs the seller update, calls `find` with the search criteria you enter, and prints the matching apartments.

### PL/SQL: agent management and salary calculation
- `calc_visit_salary1` (procedure): calculates an agent's visit-based pay for a date range (number of visits × visit rate) and returns the visits as a ref cursor.
- `calc_sale_salary` (function): sums agent fee × sale rate over the sales an agent signed in a date range.
- `calc_salary` (function): combines visit and sale pay into a total.
- `Update_Agent_Exit` (procedure): marks an agent inactive with an exit date and, if the replacement agent is active, reassigns the agent's later visits to them.
- `PayAndRetireAgent.sql`: an interactive block that calculates a retiring agent's salary for a period and then runs the exit and reassignment.
- `SelectAllVisitsForAgent.sql`: lists a sample agent's visits in a date range, with any resulting sales.

### Integration and views
- `Integration.sql`:
  - Merges the external flower-shop database into this schema: widens agent columns, imports flower-shop clients into `Agent_Person`, and rebuilds `Invitation` so it references `Agent_Person`.
  - Adds foreign keys to the flower-shop `Designer` and `Pakcage` tables, and adds a `FlowersID` column to `Visit`.
- `Views.sql`:
  - `Full_Details_View_AP`: a denormalized view of visits with their agent, buyer, apartment, seller, city and sale details.
  - `Full_New_Details_View_FL`: flower-shop orders with their package, designer, client, equipment, stock and supplier.
  - Example queries over both views.

## Repository Structure

```
apartment-sales-database/
├── schema/                    # Table creation, alterations, constraints
├── data/                      # Sample data inserts and data checks
│   └── import/                # Text Importer definitions + synthetic CSV data
├── queries/                   # SQL queries and parameterized queries
├── plsql/
│   ├── apartment-matching/    # Apartment search and seller phone update
│   └── agent-management/      # Salary calculation, agent exit, visit reassignment
├── integration/               # Integration with the flower-shop schema, views
└── docs/
    └── diagrams/              # ERD and DSD diagrams
```

## Running the Scripts

The scripts target Oracle Database and were written in PL/SQL Developer. A typical order is:

1. `schema/CreateTable.sql`
2. `data/InsertTables.sql`
3. `schema/AlterTablesPresentStatus.sql`, then `schema/Constraints.sql`
4. `schema/AlterTablesAgentManagement.sql`
5. The PL/SQL objects in `plsql/`: functions and procedures first, then the interactive blocks
6. `integration/Integration.sql` and `integration/Views.sql`

Notes:

- **Present_Status column:** `AlterTablesAgentManagement.sql` adds `Present_Status` again. If step 3 has already been applied, that statement fails because the column exists and can be skipped.
- **Integration scripts:** they expect the flower-shop tables (`Client`, `Invitation`, `Pakcage`, `Designer`, `Equipment`, `InStock`, `Supplier_`, `Containing`) to exist already. Those tables are not created by this repository; their structure is shown in the flower-shop diagrams.
- **Substitution variables:** the interactive scripts use `&` variables. `ParamsQueries.sql` uses PL/SQL Developer's `&<name=...>` variable syntax.
- **Sample data:** all sample data in the repository is synthetic.

## Technologies

- Oracle Database
- SQL
- PL/SQL

## Credits

Developed collaboratively by Noa Aizen and Nechama B.
