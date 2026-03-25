# AGENTS.md - Karate QA Automation Framework

## Project Overview
This is a **Karate Framework 1.3.1** BDD testing project (`template-karate-qa-team`) for testing the QA Team Peru API (`https://api.qateamperu.com`). Uses Maven for builds and JUnit 5 for test execution with parallel test capability.

## Architecture & Key Patterns

### Test Organization Structure
```
src/test/java/bdd/
├── auth/           # Authentication scenarios (login, register, logout)
├── product/        # Product management scenarios
└── [module]/*.feature    # Feature files grouped by domain
```

**Pattern**: Each module (auth, product) contains `.feature` files organized by functionality. Tests are executed via:
- `TestRunner.java`: Individual test methods via `@Karate.Test` annotation
- `ConfigTest.java`: Bulk parallel execution (5 threads) via `Runner.path("classpath:bdd").parallel(5)`

### Feature File Pattern (Gherkin)
- **Hardcoded base URL in Background**: `Given url "https://api.qateamperu.com"`
- **JSON payloads stored separately**: `read('classpath:resources/json/auth/registerbody.json')`
- **Variable extraction from responses**: `* def tokendeacceso = response.access_token`
- **String type matching**: `And match response.message == "#string"` for flexible validation
- **Tag usage**: `@CP01`, `@CP02` for test case IDs

**Example from `loginAuth.feature`**:
```gherkin
@CP01
Scenario: CP01 - Login
* def body = read('classpath:resources/json/auth/bodyLogin.json')
And path "api/login"
And request body
When method post
Then status 200
And match response.access_token == "#string"
* def tokendeacceso = response.access_token
```

### Configuration & Environment Setup
- **Global config**: `karate-config.js` - Sets base URL and environment via `karate.env`
- **Logging**: `logback-test.xml` controls test output verbosity
- **Test resources encoding**: UTF-8 configured in Maven compiler
- **Resource directory**: Test data (JSON/CSV) loaded from `classpath:resources/` prefix in feature files

## Critical Workflows

### Running Tests
```bash
# Run all tests in parallel (ConfigTest - 5 threads)
mvn test -Dtest=ConfigTest

# Run individual module tests
mvn test -Dtest=TestRunner

# Run with specific environment
mvn test -Dkarate.env=staging -Dtest=ConfigTest
```

### Adding New Tests
1. **Create feature file**: `src/test/java/bdd/[module]/[feature].feature`
2. **Create test data**: `src/test/java/resources/json/[module]/[datafile].json`
3. **Register in TestRunner.java**: Add `@Karate.Test` method if using individual execution
4. **Pattern to follow**: Use `read('classpath:resources/...')` for data files, extract tokens/IDs into variables for chained requests

### Test Execution Layers
- **Unit execution**: `TestRunner.java` - Tests run individually via decorated methods
- **Batch execution**: `ConfigTest.java` - All features under `classpath:bdd` run in parallel
- **Reporting**: Auto-generates HTML/JSON reports in `target/karate-reports/` with timeline & tags

## Project-Specific Conventions

### Request/Response Flow
```
Feature File → (reads JSON body) → POST/GET request → (extracts response) → Variable for next step
```
**Example**: `loginAuth.feature` extracts `access_token` and uses it as Bearer token in `logout` request

### JSON Test Data Naming
- `registerbody.json` - Request payload
- `registerresponsevalidacion.json` - Expected response structure
- `bodyLogin.json` - Login credentials

### Assertion Patterns
- `match response == expectedJson` - Full response validation
- `match response.field == "#string"` - Type validation (flexible)
- `match response.status` - Status code checks in assertions
- Always use `status 200` (or expected code) after `When method`

### Tag Convention
Test cases tagged with `@CP##` (CP01, CP02, etc.) correlating to test case IDs. Used for filtering and reporting.

## Dependencies & Integration

### Core Dependencies
- **karate-junit5**: Karate test framework integrated with JUnit 5
- **Maven**: Build automation with surefire-plugin for test discovery

### External APIs
- **Primary API**: `https://api.qateamperu.com` (Auth, Product management)
- **Sample API**: `https://jsonplaceholder.typicode.com` (practice scenarios in addProduct.feature)

### Data File Locations
```
src/test/java/resources/
├── json/auth/
│   ├── registerbody.json
│   ├── bodyLogin.json
│   └── registerresponsevalidacion.json
└── csv/  (future CSV test data)
```

## When Adding Features
- **Modify paths/URLs**: Edit `karate-config.js` environment variables, not hardcoded in features
- **Add new request types**: Follow existing `read()` + `method post/get/put/delete` pattern
- **Extract sensitive data**: Always store in JSON files (classpath:resources/), never in feature files
- **Response validation**: Use `match` operator with type hints (`#string`, `#number`) for schema validation
- **Debugging**: Use `* print variable` statements in feature files; check `karate.log` in target/

## File Reference Guide
| File | Purpose |
|------|---------|
| `pom.xml` | Maven configuration, karate-junit5 v1.3.1, Java 1.8 target |
| `karate-config.js` | Environment config & base URL definition |
| `src/test/java/bdd/TestRunner.java` | Individual test case execution |
| `src/test/java/bdd/ConfigTest.java` | Parallel batch execution (5 threads) |
| `src/test/java/resources/json/` | Test data payloads and validations |
| `target/karate-reports/` | HTML/JSON test execution reports |

