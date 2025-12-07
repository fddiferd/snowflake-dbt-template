# Snowflake dbt Template

## 1. Install Dependencies

```bash
uv sync
```

## 2. Initialize dbt Project

```bash
dbt init <project_name>
```

## 3. Create `profiles.yml`

Create `profiles.yml` in your dbt project folder:

```yaml
snowflake_intelligence_dbt_demo:
  target: "{{ env_var('DBT_TARGET', 'PROD') }}"
  outputs:
    PROD:
      type: snowflake
      account: "{{ env_var('DBT_SNOWFLAKE_ACCOUNT', 'placeholder') }}"
      user: "{{ env_var('DBT_SNOWFLAKE_USER', 'placeholder') }}"
      password: "{{ env_var('DBT_SNOWFLAKE_PASSWORD', 'placeholder') }}"
      database: <MY_DATABASE>
      schema: prod
      warehouse: <MY_WAREHOUSE>
      role: <MY_ROLE>
      threads: 4
    STAGING:
      type: snowflake
      account: "{{ env_var('DBT_SNOWFLAKE_ACCOUNT', 'placeholder') }}"
      user: "{{ env_var('DBT_SNOWFLAKE_USER', 'placeholder') }}"
      password: "{{ env_var('DBT_SNOWFLAKE_PASSWORD', 'placeholder') }}"
      database: <MY_DATABASE>
      schema: staging
      warehouse: <MY_WAREHOUSE>
      role: <MY_ROLE>
      threads: 4
    DEV:
      type: snowflake
      account: "{{ env_var('DBT_SNOWFLAKE_ACCOUNT', 'placeholder') }}"
      user: "{{ env_var('DBT_SNOWFLAKE_USER', 'placeholder') }}"
      password: "{{ env_var('DBT_SNOWFLAKE_PASSWORD', 'placeholder') }}"
      database: <MY_DATABASE>
      schema: "{{ env_var('DBT_DEV_SCHEMA', 'placeholder') }}"
      warehouse: <MY_WAREHOUSE>
      role: <MY_ROLE>
      threads: 4
```

## 4. Export Environment Variables

```bash
export DBT_SNOWFLAKE_ACCOUNT="<YOUR_ACCOUNT>"
export DBT_SNOWFLAKE_USER="<YOUR_USERNAME>"
export DBT_SNOWFLAKE_PASSWORD="<YOUR_PASSWORD>"
export DBT_TARGET="DEV"
export DBT_DEV_SCHEMA="<YOUR_SCHEMA>"
```
