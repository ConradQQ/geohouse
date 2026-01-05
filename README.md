# GeoHouse 

Interactive geospatial web application analyzing urban tree density and neighborhood-level environmental context in South Philadelphia.

## Stack
- PostGIS (spatial database)
- FastAPI (backend API)
- React + Vite (frontend)
- MapLibre GL JS (interactive mapping)

## Features (in progress)
- Interactive map with neighborhood boundaries
- Kernel density heatmap of tree locations
- Clickable neighborhoods with summary statistics
- Attribute-based filtering (DBH, year planted, condition)

## Project Structure
- `api/` – FastAPI backend and spatial queries
- `web/` – React frontend with MapLibre
- `data/` – raw inputs, processed datasets, tile outputs
- `scripts/` – ETL and tile generation scripts

## Status
🚧 Active development

