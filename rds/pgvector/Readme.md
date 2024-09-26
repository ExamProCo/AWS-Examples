```sql
SELECT * FROM pg_available_extensions WHERE name = 'vector';
```

```sql
CREATE EXTENSION IF NOT EXISTS vector;
```

```sql
CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    embedding vector(3)  -- a vector of dimension 3
);
```

```sql
INSERT INTO items (embedding) VALUES 
    ('[0.1, 0.2, 0.3]'),
    ('[0.4, 0.5, 0.6]'),
    ('[0.7, 0.8, 0.9]');
```

```sql
SELECT * FROM items;
```

Nearest Neighbor Search

```sql
SELECT id, embedding, embedding <-> '[0.2, 0.1, 0.4]' AS distance
FROM items
ORDER BY embedding <-> '[0.2, 0.1, 0.4]' LIMIT 5;
```