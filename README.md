# OTT Platform DMS

This project is a beginner-friendly Data Management System (DMS) for an OTT (Over-The-Top) streaming platform.

It is designed for a 2nd-year diploma student who wants to understand:
- database design
- SQL tables and relationships
- insert sample data
- query reports
- basic business logic

## Project Objective
Create a small but realistic OTT platform database that stores:
- users
- subscription plans
- payments
- content catalog
- watch history
- favorites
- devices used for streaming

## Main Tables
- users
- plans
- subscriptions
- content
- genres
- content_genres
- watch_history
- favorites
- devices

## File Structure
- `schema.sql` - create tables
- `seed.sql` - insert example data
- `queries.sql` - reporting queries
- `views.sql` - SQL views
- `procedures.sql` - stored procedures
- `README.md` - project documentation

## Instructions
Run the SQL files in this order:

```bash
psql -d ott_dms -f schema.sql
psql -d ott_dms -f seed.sql
psql -d ott_dms -f views.sql
psql -d ott_dms -f procedures.sql
psql -d ott_dms -f queries.sql
```

## Example Features This System Handles
- User registration and account details
- Plan selection and subscription expiry
- Content listing by category
- Watching behavior tracking
- Favorite movies/series
- Device-based viewing activity
- Popular content reporting

## Easy Learning Outcome
By the end of this project, you will know how to:
- design tables
- use foreign keys
- write SELECT queries
- use aggregates like COUNT(), SUM(), AVG()
- create simple views and procedures

## Suggested Future Upgrades
- Add login table
- Add payment history table
- Add recommendation algorithm
- Add admin dashboard
- Add reports by month and genre
