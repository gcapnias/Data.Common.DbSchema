# Data.Common.DbSchema
DbSchema makes it easier for .NET programmers to extract a database's schema (tables, views, columns, procedures, procedures' parameters and relations). You'll no longer have to create your custom code in order to extract schema from your databases. It's developed in C#.

# Project Description
DbSchema makes it easier for .NET programmers to extract a database's schema (tables, views, columns, procedures, procedures' parameters and relations). You'll no longer have to create your custom code in order to extract schema from your databases. It's developed in C#.
General Information
More or less, every developer has the need to create custom code depending in a database's schema. Being involved in a project that created code depending on a database schema, using T4 templates, I had to find a way to recycle the schema retrieving code for various databases.

Contributing on T4 templates and schema retrieving code for [SubSonic3](http://code.google.com/p/subsonicthree), [Rob Conery](http://blog.wekeroad.com/) asked for a simple schema retrieving engine, with no hard references on database provider assemblies. This request gave me the idea to create this library.

Currently Data.Common.DbSchema offers support for:

- SQL Server (Beta quality)
- SQL Server Compact (Beta quality)
- MySQL (Beta quality)
- PostgreSQL (Alpha quality)
- SQLite (Alpha quality)
- Oracle (Alpha quality)

It has *no hard-references* to database provider assemblies. It uses **System.Data.Common** objects to access databases, and **System.Reflection** to access common database provider methods, which are not exposed via System.Data.Common - only for procedure parameter retrieving.

# Tables & Views
Using the library gives you the methods to easily retrieve tables and views (**DbSchema.GetSchemaTables()**), only tables (**DbSchema.GetTables()**), only views (**DbSchema.GetViews()**) or tables that are not part in ManyToMany relationships (**DbSchema.GetTablesLogical()**).

# Columns & Primary Keys
Passing the schema and name of a table, one can retrieve its columns (**DbSchema.GetTableColumns()**), columns that compose the primary key (**DbSchema.GetTablePrimaryKeyColumns()**) or the columns that are not part of the table's primary key, and are not part of foreign key definitions (**DbSchema.GetTableFields()**).

# Relations
Retrieving table relations (**DbSchema.GetConstraints()**), by passing the table schema and name, one can retrieve, the One-to-Many relations (**DbSchema.GetTableOneToManyRelations()**) and Many-to-One relations (**DbSchema.GetTableManyToOneRelations()**) a table is participating. Also the Many-To-Many relation tables (**DbSchema.GetTablesManyToManyRelations()**) can be retrieved.

# Store Procedures
One can retrieve the names of all store procedures (**DbSchema.GetProcedures()**), and their parameters (**DbSchema.GetProcedureParameters()**)

# Extensibility
Core functions needed for each database type, are implemented through interface **Data.Common.IDbSchemaProvider**. Implementing support for new databases is easy and fast.

# Support
Library comes in two versions:

- **Binary**: An assembly that can be used in .NET Applications
- **T4 Include Template**: An T4 template that can be included from other T4 templates, in order to provide Data.Common.DbSchema functionality in T4 templates tranformation.

In order to make the T4 include template compact, and include only data providers needed use the **MakeT4Template.vbs** utility.

# Use
Personally, I have used the library in T4 templates, creating classes that use SubSonic3 and NHibernate. Currently the source code in repository includes an example of using the library with NHibernate.
