# GitHub Copilot Instructions

## Table of Contents

### PART 1: Universal Best Practices
- [Encoding & Script Safety](#critical-encoding--script-safety)
- [Azure Account Management](#critical-azure-account-management)
- [AI Context Management](#ai-context-management-strategy)
- [Azure Services Inventory](#azure-services--capabilities-inventory)
- [Professional Component Architecture](#professional-component-architecture)
  - [DebugArtifactCollector](#implementation-debugartifactcollector)
  - [SessionManager](#implementation-sessionmanager)
  - [StructuredErrorHandler](#implementation-structurederrorhandler)
  - [ProfessionalRunner](#implementation-zero-setup-project-runner)
- [Professional Transformation](#professional-transformation-methodology)
- [Dependency Management](#dependency-management-with-alternatives)
- [Workspace Housekeeping](#workspace-housekeeping-principles)
- [Code Style Standards](#code-style-standards)

### PART 2: MS-InfoJP Project Specific
- [Project Context & Deployment Information](#project-context--deployment-information)
- [MS-InfoJP Architecture Context](#ms-infojp-architecture-context)
- [CanLII CDC Architecture](#canlii-cdc-architecture-change-data-capture)
- [Development Workflows](#development-workflows)
- [Critical Code Patterns](#critical-code-patterns)
- [Testing](#testing)
- [Deployment](#deployment)
- [Troubleshooting](#troubleshooting)
- [Professional Component Usage](#professional-component-usage)

---

## PART 1: UNIVERSAL BEST PRACTICES

> **Applicable to any project, any scenario**  
> Critical patterns, Azure inventory management, workspace organization principles

# GitHub Copilot Instructions

## Table of Contents

### PART 1: Universal Best Practices
- [Encoding & Script Safety](#critical-encoding--script-safety)
- [Azure Account Management](#critical-azure-account-management)
- [AI Context Management](#ai-context-management-strategy)
- [Azure Services Inventory](#azure-services--capabilities-inventory)
- [Professional Component Architecture](#professional-component-architecture)
  - [DebugArtifactCollector](#implementation-debugartifactcollector)
  - [SessionManager](#implementation-sessionmanager)
  - [StructuredErrorHandler](#implementation-structurederrorhandler)
  - [ProfessionalRunner](#implementation-zero-setup-project-runner)
- [Professional Transformation](#professional-transformation-methodology)
- [Dependency Management](#dependency-management-with-alternatives)
- [Workspace Housekeeping](#workspace-housekeeping-principles)
- [Code Style Standards](#code-style-standards)

### PART 2: EVA-JP-v1.2 Project Specific
- [Documentation Guide](#documentation-guide)
- [Architecture Overview](#architecture-overview)
- [Development Workflows](#development-workflows)
- [JP Automation](#jp-automation-project)
- [Critical Code Patterns](#critical-code-patterns)
- [Testing](#testing)
- [CI/CD Pipeline](#cicd-pipeline)
- [Troubleshooting](#troubleshooting)
- [Performance Optimization](#performance-optimization)

---

## Quick Reference

**Most Critical Patterns**:
1. **Encoding Safety** - Always use ASCII-only in scripts (prevents UnicodeEncodeError in Windows cp1252)
2. **Azure Account** - Professional account marco.presta@hrsdc-rhdcc.gc.ca required for AICOE resources
3. **Component Architecture** - DebugArtifactCollector + SessionManager + StructuredErrorHandler + ProfessionalRunner
4. **Session Management** - Checkpoint/resume capability for long-running operations (JP queries take 3-8 minutes)
5. **Evidence Collection** - Screenshots, HTML dumps, network traces at operation boundaries

**Professional Components** (Full Working Implementations):

| Component | Purpose | Key Methods |
|-----------|---------|-------------|
| **DebugArtifactCollector** | Capture HTML/screenshots/traces | `capture_state()`, `set_page()` |
| **SessionManager** | Checkpoint/resume operations | `save_checkpoint()`, `load_latest_checkpoint()` |
| **StructuredErrorHandler** | JSON error logging | `log_error()`, `log_structured_event()` |
| **ProfessionalRunner** | Zero-setup execution | `auto_detect_project_root()`, `validate_pre_flight()` |

**Where to Find Source**:
- Complete working system: `docs/eva-foundry/projects/06-JP-Auto-Extraction/`
- Best practices reference: `docs/eva-foundry/projects/07-copilot-instructions/02-design/best-practices-reference.md`
- Marco Framework: `docs/eva-foundry/projects/07-copilot-instructions/02-design/marco-framework-architecture.md`

---

## PART 1: UNIVERSAL BEST PRACTICES

> **Applicable to any project, any scenario**  
> Critical patterns, Azure inventory management, workspace organization principles

### Critical: Encoding & Script Safety

**ABSOLUTE BAN: No Unicode/Emojis Anywhere**
- **NEVER use in code**: Checkmarks, X marks, emojis, Unicode symbols, ellipsis
- **NEVER use in reports**: Unicode decorations, fancy bullets, special characters
- **NEVER use in documentation**: Unless explicitly required by specification
- **ALWAYS use**: Pure ASCII - "[PASS]", "[FAIL]", "[ERROR]", "[INFO]", "[WARN]", "..."
- **Reason**: Enterprise Windows cp1252 encoding causes silent UnicodeEncodeError crashes
- **Solution**: Set `PYTHONIOENCODING=utf-8` in batch files as safety measure

**Examples**:
```python
# [FORBIDDEN] Will crash in enterprise Windows
print(" Success")  # Unicode checkmark - NEVER
print("[x] Failed")   # Unicode X - NEVER
print(" Wait...")    # Unicode symbols - NEVER

# [REQUIRED] ASCII-only alternatives
print("[PASS] Success")
print("[FAIL] Failed")
print("[INFO] Wait...")
```

### Critical: Azure Account Management

**Multiple Azure Accounts Pattern**
- **Personal Account**: MarcoSub (c59ee575-eb2a-4b51-a865-4b618f9add0a) - personal sandbox
- **Professional Account**: marco.presta@hrsdc-rhdcc.gc.ca - ESDC/AICOE production access
- **AICOE Subscriptions** (require professional account):
  - EsDAICoESub (d2d4e571-e0f2-4f6c-901a-f88f7669bcba) - Dev+Stage environments
  - EsPAICoESub (802d84ab-3189-4221-8453-fcc30c8dc8ea) - Production environments

**When Azure CLI fails with "subscription doesn't exist"**:
1. Check current account: `az account show --query user.name`
2. Switch accounts: `az logout` then `az login --use-device-code --tenant bfb12ca1-7f37-47d5-9cf5-8aa52214a0d8`
3. Authenticate with professional email: marco.presta@hrsdc-rhdcc.gc.ca
4. Verify access: `az account list --query "[?contains(id, 'd2d4e571') || contains(id, '802d84ab')]"`

**Pattern**: If accessing AICOE resources, ALWAYS use professional account

### AI Context Management Strategy

**Pattern**: Systematic approach to avoid context overload

**5-Step Process**:
1. **Assess**: What context do I need? (Don't load everything)
2. **Prioritize**: What's most relevant NOW? (Focus on current task)
3. **Load**: Get specific context only (Use targeted file reads, grep searches)
4. **Execute**: Perform task with loaded context
5. **Verify**: Validate result matches intent

**Example**:
```python
# [AVOID] Bad: Load entire file when only need one function
with open('large_file.py') as f:
    content = f.read()  # Loads 10,000 lines

# [RECOMMENDED] Good: Targeted context loading
grep_search(query="def target_function", includePattern="large_file.py")
read_file(filePath="large_file.py", startLine=450, endLine=500)
```

**When to re-assess context**:
- Task scope changes
- Error requires different context
- User provides new information

### Azure Services & Capabilities Inventory

**Azure OpenAI**
- **Models**: GPT-4, GPT-4 Turbo, text-embedding-ada-002
- **Endpoints**: esdaicoe-ai-foundry-openai.openai.azure.com
- **Use Cases**: Chat completions, embeddings, content generation
- **Authentication**: API key or DefaultAzureCredential

**Azure AI Services (Cognitive Services)**
- **Capabilities**: Query optimization, content safety, content understanding
- **Use Cases**: Text analysis, translation, content moderation
- **Pattern**: Always implement fallback for private endpoint failures

**Azure Cognitive Search**
- **Capabilities**: Hybrid search (vector + keyword), semantic ranking
- **Use Cases**: Document search, RAG systems, knowledge bases
- **Pattern**: Use index-based access, implement retry logic

**Azure Cosmos DB**
- **Capabilities**: NoSQL database, session storage, change feed
- **Use Cases**: Session management, audit logs, CDC patterns
- **Pattern**: Use partition keys effectively, implement TTL

**Azure Blob Storage**
- **Capabilities**: Object storage, containers, metadata
- **Use Cases**: Document storage, file uploads, static assets
- **Pattern**: Use managed identity, implement lifecycle policies

**Azure Functions**
- **Capabilities**: Serverless compute, event-driven processing
- **Use Cases**: Document pipelines, webhook handlers, scheduled jobs
- **Pattern**: Use blob triggers, queue bindings

**Azure Document Intelligence**
- **Capabilities**: OCR, form recognition, layout analysis
- **Use Cases**: PDF processing, document extraction
- **Pattern**: Handle rate limits, implement retry logic

### Professional Component Architecture

**Pattern**: Enterprise-grade component design (from Project 06/07)

**Every professional component implements**:
- **DebugArtifactCollector**: Evidence at operation boundaries
- **SessionManager**: Checkpoint/resume capabilities
- **StructuredErrorHandler**: JSON logging with context
- **Observability Wrapper**: Pre-state, execution, post-state capture

**Usage Pattern - Combining Components**:

> **Note**: The following shows a conceptual pattern for combining components. For complete, production-ready implementations you can copy-paste directly, see the detailed sections below.
```python
from pathlib import Path
from datetime import datetime
import json

class ProfessionalComponent:
    """Base class for enterprise-grade components"""
    
    def __init__(self, component_name: str, base_path: Path):
        self.component_name = component_name
        self.base_path = base_path
        
        # Core professional infrastructure
        self.debug_collector = DebugArtifactCollector(component_name, base_path)
        self.session_manager = SessionManager(component_name, base_path)
        self.error_handler = StructuredErrorHandler(component_name, base_path)
    
    async def execute_with_observability(self, operation_name: str, operation):
        """Execute operation with full evidence collection"""
        # 1. ALWAYS capture pre-state
        await self.debug_collector.capture_state(f"{operation_name}_before")
        await self.session_manager.save_checkpoint("before_operation", {
            "operation": operation_name,
            "timestamp": datetime.now().isoformat()
        })
        
        try:
            # 2. Execute operation
            result = await operation()
            
            # 3. ALWAYS capture success state
            await self.debug_collector.capture_state(f"{operation_name}_success")
            await self.session_manager.save_checkpoint("operation_success", {
                "operation": operation_name,
                "result_preview": str(result)[:200]
            })
            return result
            
        except Exception as e:
            # 4. ALWAYS capture error state
            await self.debug_collector.capture_state(f"{operation_name}_error")
            await self.error_handler.log_structured_error(operation_name, e)
            raise
```

**When to use**: Any component that interacts with external systems, complex logic, or enterprise automation

---

### Implementation: DebugArtifactCollector

**Purpose**: Capture comprehensive diagnostic state at system boundaries for rapid debugging

**Working Implementation** (from Project 06):
```python
from pathlib import Path
from datetime import datetime
import json
import asyncio

class DebugArtifactCollector:
    """Systematic evidence capture at operation boundaries
    
    Captures HTML, screenshots, network traces, and structured logs
    for every significant operation to enable rapid debugging.
    """
    
    def __init__(self, component_name: str, base_path: Path):
        """Initialize collector for specific component
        
        Args:
            component_name: Name of component (e.g., "authentication", "data_extraction")
            base_path: Project root directory
        """
        self.component_name = component_name
        self.debug_dir = base_path / "debug" / component_name
        self.debug_dir.mkdir(parents=True, exist_ok=True)
        
        self.page = None  # Set by browser automation
        self.network_log = []  # Populated by network listener
    
    async def capture_state(self, context: str):
        """Capture complete diagnostic state
        
        Args:
            context: Operation context (e.g., "before_login", "after_submit", "error_state")
        """
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        
        # 1. Capture HTML snapshot
        if self.page:
            html_file = self.debug_dir / f"{context}_{timestamp}.html"
            html_content = await self.page.content()
            html_file.write_text(html_content, encoding='utf-8')
        
        # 2. Capture screenshot
        if self.page:
            screenshot_file = self.debug_dir / f"{context}_{timestamp}.png"
            await self.page.screenshot(path=str(screenshot_file), full_page=True)
        
        # 3. Capture network trace
        if self.network_log:
            network_file = self.debug_dir / f"{context}_{timestamp}_network.json"
            network_file.write_text(json.dumps(self.network_log, indent=2))
        
        # 4. Capture structured log with application state
        log_file = self.debug_dir / f"{context}_{timestamp}.json"
        log_file.write_text(json.dumps({
            "timestamp": timestamp,
            "context": context,
            "component": self.component_name,
            "url": self.page.url if self.page else None,
            "viewport": await self.page.viewport_size() if self.page else None
        }, indent=2))
        
        return {
            "html": str(html_file) if self.page else None,
            "screenshot": str(screenshot_file) if self.page else None,
            "network": str(network_file) if self.network_log else None,
            "log": str(log_file)
        }
    
    def set_page(self, page):
        """Attach to browser page for capture"""
        self.page = page
        
        # Enable network logging
        async def log_request(request):
            self.network_log.append({
                "timestamp": datetime.now().isoformat(),
                "type": "request",
                "url": request.url,
                "method": request.method
            })
        
        page.on("request", lambda req: asyncio.create_task(log_request(req)))
```

**Usage Pattern**:
```python
# In your automation component
collector = DebugArtifactCollector("my_component", project_root)
collector.set_page(page)

# Before risky operation
await collector.capture_state("before_submit")

try:
    await risky_operation()
    await collector.capture_state("success")
except Exception as e:
    await collector.capture_state("error")
    raise
```

---

### Implementation: SessionManager

**Purpose**: Enable checkpoint/resume capabilities for long-running operations

**Working Implementation** (from Project 06):
```python
from pathlib import Path
from datetime import datetime, timedelta
import json
import shutil
from typing import Dict, Optional

class SessionManager:
    """Manages persistent session state for checkpoint/resume operations
    
    Enables long-running automation to save progress and resume
    from last successful checkpoint if interrupted.
    """
    
    def __init__(self, component_name: str, base_path: Path):
        """Initialize session manager
        
        Args:
            component_name: Component identifier
            base_path: Project root directory
        """
        self.component_name = component_name
        self.session_dir = base_path / "sessions" / component_name
        self.session_dir.mkdir(parents=True, exist_ok=True)
        
        self.session_file = self.session_dir / "session_state.json"
        self.checkpoint_dir = self.session_dir / "checkpoints"
        self.checkpoint_dir.mkdir(exist_ok=True)
    
    def save_checkpoint(self, checkpoint_id: str, data: Dict) -> Path:
        """Save checkpoint with state data
        
        Args:
            checkpoint_id: Unique checkpoint identifier (e.g., "item_5_processed")
            data: State data to persist
            
        Returns:
            Path to saved checkpoint file
        """
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        checkpoint_file = self.checkpoint_dir / f"{checkpoint_id}_{timestamp}.json"
        
        checkpoint_data = {
            "checkpoint_id": checkpoint_id,
            "timestamp": datetime.now().isoformat(),
            "component": self.component_name,
            "data": data
        }
        
        checkpoint_file.write_text(json.dumps(checkpoint_data, indent=2))
        
        # Update session state to point to latest checkpoint
        self.update_session_state(checkpoint_id, str(checkpoint_file))
        
        return checkpoint_file
    
    def load_latest_checkpoint(self) -> Optional[Dict]:
        """Load most recent checkpoint if available
        
        Returns:
            Checkpoint data or None if no checkpoint exists
        """
        if not self.session_file.exists():
            return None
        
        try:
            session_data = json.loads(self.session_file.read_text())
            checkpoint_file = Path(session_data.get("latest_checkpoint"))
            
            if checkpoint_file.exists():
                return json.loads(checkpoint_file.read_text())
            
        except Exception as e:
            print(f"[WARN] Failed to load checkpoint: {e}")
        
        return None
    
    def update_session_state(self, checkpoint_id: str, checkpoint_path: str):
        """Update session state with latest checkpoint reference"""
        session_data = {
            "component": self.component_name,
            "last_updated": datetime.now().isoformat(),
            "latest_checkpoint": checkpoint_path,
            "checkpoint_id": checkpoint_id
        }
        
        self.session_file.write_text(json.dumps(session_data, indent=2))
    
    def clear_session(self):
        """Clear all session state and checkpoints"""
        if self.checkpoint_dir.exists():
            shutil.rmtree(self.checkpoint_dir)
            self.checkpoint_dir.mkdir()
        
        if self.session_file.exists():
            self.session_file.unlink()
```

**Usage Pattern**:
```python
# Initialize session manager
session_mgr = SessionManager("batch_processor", project_root)

# Try to resume from checkpoint
checkpoint = session_mgr.load_latest_checkpoint()
if checkpoint:
    start_index = checkpoint["data"]["last_processed_index"]
    print(f"[INFO] Resuming from checkpoint: item {start_index}")
else:
    start_index = 0

# Process items with checkpoints
for i in range(start_index, len(items)):
    process_item(items[i])
    
    # Save checkpoint every 10 items
    if i % 10 == 0:
        session_mgr.save_checkpoint(f"item_{i}", {
            "last_processed_index": i,
            "items_completed": i + 1,
            "timestamp": datetime.now().isoformat()
        })
```

---

### Implementation: StructuredErrorHandler

**Purpose**: Provide JSON-based error logging with full context for debugging

**Working Implementation** (from Project 06):
```python
from datetime import datetime
from typing import Dict, Any, Optional
from pathlib import Path
import json
import traceback

class StructuredErrorHandler:
    """Enterprise-grade error handling with structured logging
    
    Captures errors with full context in JSON format for easy parsing
    and analysis. All output is ASCII-safe for enterprise Windows.
    """
    
    def __init__(self, component_name: str, base_path: Path):
        """Initialize error handler
        
        Args:
            component_name: Component identifier
            base_path: Project root directory
        """
        self.component_name = component_name
        self.error_dir = base_path / "logs" / "errors"
        self.error_dir.mkdir(parents=True, exist_ok=True)
    
    def log_error(self, error: Exception, context: Optional[Dict[str, Any]] = None) -> Dict:
        """Log error with structured context
        
        Args:
            error: Exception object
            context: Additional context (operation name, parameters, etc.)
            
        Returns:
            Error report dictionary
        """
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        
        error_report = {
            "timestamp": datetime.now().isoformat(),
            "component": self.component_name,
            "error_type": type(error).__name__,
            "error_message": str(error),
            "traceback": traceback.format_exc(),
            "context": context or {}
        }
        
        # Save to timestamped file
        error_file = self.error_dir / f"{self.component_name}_error_{timestamp}.json"
        error_file.write_text(json.dumps(error_report, indent=2))
        
        # Print ASCII-safe error message
        print(f"[ERROR] {self.component_name}: {type(error).__name__}")
        print(f"[ERROR] Message: {str(error)}")
        print(f"[ERROR] Details saved to: {error_file}")
        
        return error_report
    
    def log_structured_event(self, event_type: str, data: Dict[str, Any]):
        """Log structured event (non-error)
        
        Args:
            event_type: Event type (e.g., "operation_start", "data_validated")
            data: Event data
        """
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        
        event_report = {
            "timestamp": datetime.now().isoformat(),
            "component": self.component_name,
            "event_type": event_type,
            "data": data
        }
        
        # Save to events log
        event_file = self.error_dir.parent / f"{self.component_name}_events_{timestamp}.json"
        event_file.write_text(json.dumps(event_report, indent=2))

class JPBaseException(Exception):
    """Base exception with structured error reporting
    
    All custom exceptions should inherit from this to ensure
    consistent error handling and reporting.
    """
    
    def __init__(self, message: str, context: Optional[Dict[str, Any]] = None):
        """Initialize exception with context
        
        Args:
            message: Error description (ASCII only)
            context: Additional error context
        """
        super().__init__(message)
        self.message = message
        self.context = context or {}
        self.timestamp = datetime.now().isoformat()
    
    def get_error_report(self) -> Dict[str, Any]:
        """Generate structured error report
        
        Returns:
            Dictionary with full error details
        """
        return {
            "error_type": self.__class__.__name__,
            "message": self.message,
            "context": self.context,
            "timestamp": self.timestamp
        }
```

**Usage Pattern**:
```python
# Initialize error handler
error_handler = StructuredErrorHandler("my_automation", project_root)

try:
    risky_operation()
except Exception as e:
    # Log with context
    error_handler.log_error(e, context={
        "operation": "data_processing",
        "input_file": "data.csv",
        "current_row": 42
    })
    raise

# Custom exception with automatic context
class DataValidationError(JPBaseException):
    pass

try:
    if not is_valid(data):
        raise DataValidationError(
            "Invalid data format",
            context={"expected": "CSV", "received": "JSON"}
        )
except DataValidationError as e:
    error_report = e.get_error_report()
    error_handler.log_error(e, context=error_report["context"])
```

---

### Implementation: Zero-Setup Project Runner

**Purpose**: Enable users to run project from anywhere without configuration

**Working Implementation** (from Project 06):
```python
#!/usr/bin/env python3
"""Professional project runner with zero-setup execution"""

import os
import sys
import argparse
from pathlib import Path
import subprocess
from typing import List

# Set UTF-8 encoding for Windows
os.environ.setdefault('PYTHONIOENCODING', 'utf-8')

class ProfessionalRunner:
    """Zero-setup professional automation wrapper"""
    
    def __init__(self):
        self.project_root = self.auto_detect_project_root()
        self.main_script = "scripts/main_automation.py"
    
    def auto_detect_project_root(self) -> Path:
        """Find project root from any subdirectory
        
        Searches for project markers in current and parent directories
        to enable running from any location within the project.
        """
        current = Path.cwd()
        
        # Project indicators (customize for your project)
        indicators = [
            "scripts/main_automation.py",
            "ACCEPTANCE.md",
            "README.md",
            ".git"
        ]
        
        # Check current directory
        for indicator in indicators:
            if (current / indicator).exists():
                return current
        
        # Check parent directories
        for parent in current.parents:
            for indicator in indicators:
                if (parent / indicator).exists():
                    return parent
        
        # Fallback to current directory
        print("[WARN] Could not auto-detect project root, using current directory")
        return current
    
    def validate_pre_flight(self) -> tuple[bool, str]:
        """Pre-flight checks before execution
        
        Validates environment, dependencies, and project structure.
        
        Returns:
            (success: bool, message: str)
        """
        checks = []
        
        # Check main script exists
        main_script_path = self.project_root / self.main_script
        if not main_script_path.exists():
            return False, f"[FAIL] Main script not found: {main_script_path}"
        checks.append("[PASS] Main script found")
        
        # Check required directories
        required_dirs = ["input", "output", "logs"]
        for dir_name in required_dirs:
            dir_path = self.project_root / dir_name
            if not dir_path.exists():
                dir_path.mkdir(parents=True)
                checks.append(f"[INFO] Created directory: {dir_name}")
            else:
                checks.append(f"[PASS] Directory exists: {dir_name}")
        
        # Check Python dependencies
        try:
            import pandas
            import asyncio
            checks.append("[PASS] Required Python modules available")
        except ImportError as e:
            return False, f"[FAIL] Missing Python module: {e}"
        
        return True, "\n".join(checks)
    
    def build_command(self, **kwargs) -> List[str]:
        """Build command with normalized parameters
        
        Converts user inputs to proper command structure.
        """
        cmd = [
            sys.executable,
            str(self.project_root / self.main_script)
        ]
        
        # Add parameters (customize for your project)
        for key, value in kwargs.items():
            if value is not None:
                if isinstance(value, bool):
                    if value:
                        cmd.append(f"--{key}")
                else:
                    cmd.extend([f"--{key}", str(value)])
        
        return cmd
    
    def execute_with_enterprise_safety(self, cmd: List[str]) -> int:
        """Execute with proper encoding and error handling"""
        # Set environment
        env = os.environ.copy()
        env['PYTHONIOENCODING'] = 'utf-8'
        
        # Change to project root
        original_cwd = os.getcwd()
        os.chdir(self.project_root)
        
        try:
            print(f"[INFO] Project root: {self.project_root}")
            print(f"[INFO] Command: {' '.join(cmd)}")
            print("-" * 60)
            
            result = subprocess.run(cmd, env=env)
            return result.returncode
            
        finally:
            os.chdir(original_cwd)
    
    def run(self, **kwargs) -> int:
        """Main execution entry point"""
        print("[INFO] Professional Runner - Zero-Setup Execution")
        print(f"[INFO] Detected project root: {self.project_root}")
        
        # Pre-flight validation
        success, message = self.validate_pre_flight()
        print("\n" + message)
        
        if not success:
            print("\n[FAIL] Pre-flight checks failed")
            return 1
        
        # Build and execute command
        cmd = self.build_command(**kwargs)
        return self.execute_with_enterprise_safety(cmd)

def main():
    """CLI entry point"""
    parser = argparse.ArgumentParser(
        description="Professional automation runner with zero-setup execution"
    )
    
    # Add your project-specific arguments here
    parser.add_argument("--input", help="Input file path")
    parser.add_argument("--output", help="Output file path")
    parser.add_argument("--headless", action="store_true", help="Run in headless mode")
    
    args = parser.parse_args()
    
    # Create runner and execute
    runner = ProfessionalRunner()
    sys.exit(runner.run(**vars(args)))

if __name__ == "__main__":
    main()
```

**Usage**:
```bash
# Run from anywhere in the project
python run_project.py --input data.csv --output results.csv

# Or create Windows batch wrapper
# run_project.bat:
@echo off
set PYTHONIOENCODING=utf-8
python run_project.py %*
```

---

### Professional Transformation Methodology

**Pattern**: Systematic 4-step approach to enterprise-grade development

**When refactoring or creating automation systems**:

1. **Foundation Systems** (20% of work)
   - Create `debug/`, `evidence/`, `logs/` directory structure
   - Establish coding standards and utilities
   - Implement ASCII-only error handling
   - Set up structured logging infrastructure

2. **Testing Framework** (30% of work)
   - Automated validation with evidence collection
   - Component-level unit tests
   - Integration tests with retry logic
   - Acceptance criteria validation

3. **Main System Refactoring** (40% of work)
   - Apply professional component architecture
   - Integrate validation and observability
   - Implement graceful error handling
   - Add session management and checkpoints

4. **Documentation & Cleanup** (10% of work)
   - Consolidate redundant code
   - Document patterns and decisions
   - Create runbooks and troubleshooting guides
   - Archive superseded implementations

**Quality Gate**: Each phase produces evidence before proceeding to next phase

### Dependency Management with Alternatives

**Pattern**: Handle blocked packages in enterprise environments

**Always provide fallback alternatives**:

```python
# Pattern 1: Try primary, fall back to alternative
try:
    from playwright.async_api import async_playwright
    BROWSER_ENGINE = "playwright"
except ImportError:
    print("[INFO] Playwright not available, using Selenium")
    from selenium import webdriver
    BROWSER_ENGINE = "selenium"

# Pattern 2: Feature detection
def get_available_http_client():
    """Return best available HTTP client"""
    if importlib.util.find_spec("httpx"):
        import httpx
        return httpx.AsyncClient()
    elif importlib.util.find_spec("aiohttp"):
        import aiohttp
        return aiohttp.ClientSession()
    else:
        import urllib.request
        return urllib.request  # Fallback to stdlib

# Pattern 3: Document alternatives in requirements
# requirements.txt:
# playwright>=1.40.0  # Primary choice
# selenium>=4.15.0    # Alternative if playwright blocked
# requests>=2.31.0    # Fallback for basic HTTP
```

**Document why alternatives chosen**: Add comments explaining enterprise constraints

### Workspace Housekeeping Principles

**Context Engineering - Keep AI context clean and focused**

**Best Practices**:
- **Root directory**: Active operations only (`RESTART_SERVERS.ps1`, `README.md`)
- **Context folder**: Use `docs/eva-foundry/` as AI agent "brain"
  - `projects/` - Active work with debugging artifacts
  - `workspace-notes/` - Ephemeral notes, workflow docs
  - `system-analysis/` - Architecture docs, inventory reports
  - `comparison-reports/` - Automated comparison outputs
  - `automation/` - Code generation scripts

**Pattern**: If referenced in copilot-instructions.md or used for AI context -> belongs in `docs/eva-foundry/`

**File Organization Rules**:
1. **Logs** -> `logs/{category}/`
   - `logs/deployment/terraform/` - Terraform logs
   - `logs/deployment/` - Deployment logs
   - `logs/tests/` - Test output

2. **Scripts** -> `scripts/{category}/`
   - `scripts/deployment/` - Deploy, build, infrastructure
   - `scripts/testing/` - Test runners, evidence capture
   - `scripts/setup/` - Installation, configuration
   - `scripts/diagnostics/` - Health checks, validation
   - `scripts/housekeeping/` - Workspace organization

3. **Documentation** -> `docs/{category}/`
   - Implementation docs -> `docs/eva-foundry/projects/{project-name}/`
   - Deployment guides -> `docs/deployment/`
   - Debug sessions -> `docs/eva-foundry/projects/{session-name}-debug/`

**Naming Conventions**:
- **Scripts**: `verb-noun.ps1` (lowercase-with-dashes)
  - [RECOMMENDED] Good: `deploy-infrastructure.ps1`, `test-environment.ps1`
  - [AVOID] Bad: `Deploy-MSInfo-Fixed.ps1`, `TEST_COMPLETE.ps1`
- **Docs**: `CATEGORY-DESCRIPTION.md` (UPPERCASE for status docs)
  - [RECOMMENDED] Good: `DEPLOYMENT-STATUS.md`, `IMPLEMENTATION-SUMMARY.md`
  - [AVOID] Bad: `Final-Status-Report.ps1.md`
- **Logs**: `{operation}-{timestamp}.log` or `{component}.log`

**Self-Organizing Rules for AI Agents**:
- **Before creating a file**: Check if similar file exists in `docs/eva-foundry/`
- **When debugging**: Create session folder `docs/eva-foundry/projects/{issue-name}-debug/`
- **After completing work**: Summarize findings in `docs/eva-foundry/workspace-notes/`
- **When context grows**: Create comparison report, archive superseded versions

**Housekeeping Automation**:
```powershell
# Daily cleanup
.\scripts\housekeeping\organize-workspace.ps1

# Weekly archival
.\scripts\housekeeping\archive-debug-sessions.ps1
```

### Evidence Collection at Operation Boundaries

**Goal**: Systematic evidence capture for rapid debugging

**MANDATORY: Every component operation must capture**:
- **Pre-state**: HTML, screenshots, network traces BEFORE execution
- **Success state**: Evidence on successful completion  
- **Error state**: Full diagnostic artifacts on failure
- **Structured logging**: JSON-based error context with timestamps

**Implementation Pattern**:
```python
class DebugArtifactCollector:
    def __init__(self, component_name: str, base_path: Path):
        self.component_name = component_name
        self.debug_dir = base_path / "debug" / component_name
        self.debug_dir.mkdir(parents=True, exist_ok=True)
    
    async def capture_state(self, context: str):
        """Capture complete diagnostic state"""
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        
        # Capture HTML snapshot
        if self.page:  # Browser automation
            html_file = self.debug_dir / f"{context}_{timestamp}.html"
            await self.page.content().write(html_file)
        
        # Capture screenshot
        if self.page:
            screenshot_file = self.debug_dir / f"{context}_{timestamp}.png"
            await self.page.screenshot(path=screenshot_file)
        
        # Capture network trace
        if self.network_log:
            network_file = self.debug_dir / f"{context}_{timestamp}_network.json"
            network_file.write_text(json.dumps(self.network_log, indent=2))
        
        # Capture structured log
        log_file = self.debug_dir / f"{context}_{timestamp}.json"
        log_file.write_text(json.dumps({


---

## PART 2: MS-INFOJP PROJECT SPECIFIC

### Project Lock

This file is the copilot-instructions for **11-ms-infojp** (11-ms-infojp).

The workspace-level bootstrap rule "Step 1 -- Identify the active project from the currently open file path"
applies **only at the initial load of this file** (first read at session start).
Once this file has been loaded, the active project is locked to **11-ms-infojp** for the entire session.
Do NOT re-evaluate project identity from editorContext or terminal CWD on each subsequent request.
Work state and sprint context are read from `STATUS.md` and `PLAN.md` at bootstrap -- not from this file.

---

> **MS-InfoJP: Microsoft PubSec-Info-Assistant Reference Implementation**  
> RAG-based Jurisprudence AI Assistant MVP


**Project Type**: RAG-based Jurisprudence AI Assistant MVP  
**Base Platform**: Microsoft PubSec-Info-Assistant (Fresh Clone - Commit 807ee181)  
**Deployment Root**: `base-platform/` subdirectory  
**Updated**: January 26, 2026  
**Based on**: EVA Professional Component Architecture Standards (Project 07)

**CRITICAL**: Read this ENTIRE file before generating ANY code for MS-InfoJP.

---

## Project Context & Deployment Information

**MS-InfoJP** is a reference implementation demonstrating Employment Insurance jurisprudence AI assistant capabilities using Azure OpenAI, Azure AI Search, and RAG architecture.

### Deployment Status (as of 2026-01-26)
- [x] **Infrastructure Complete**: Resource group `infojp-sandbox` (East US)
- [x] **GitHub Codespaces Approved**: $0/month compute (GitHub Pro 180 hrs/month)
- [x] **Azure OpenAI**: Reusing existing `ao-sandbox` (gpt-4o + text-embedding-3-small)
- [x] **Azure AI Services**: infojp-ai-svc (S0 pay-per-use)
- [x] **Azure Cognitive Search**: infojp-srch (Basic tier)
- [x] **Azure Cosmos DB**: infojp-cosmos (Serverless)
-  **Ready for Tonight's Deployment**: Remove misleading instructions first

### Critical Path Understanding

**What We Deploy**: `base-platform/` subdirectory - Fresh Microsoft clone  
**What We DON'T Deploy**: EVA-JP-v1.2 root (ESDC customizations, kept for reference only)

**Why Fresh Clone Strategy**:
- [x] EVA-JP-v1.2 has ESDC-specific: devval01 VNet, 50 indexes, hardcoded principal IDs
- [x] `base-platform/` is clean baseline with known-good deployment path
- [x] Cherry-pick ESDC improvements AFTER base deployment succeeds

### Azure Subscription Details
- **Subscription**: `c59ee575-eb2a-4b51-a865-4b618f9add0a` (PayAsYouGo Subs 1)
- **Tenant**: `bfb12ca1-7f37-47d5-9cf5-8aa52214a0d8` (marcoprestayahoo.onmicrosoft.com)
- **Resource Group**: `infojp-sandbox` (East US)
- **Monthly Cost**: $84-96/month (Azure services only)

**CRITICAL**: Read this ENTIRE file before generating ANY code for MS-InfoJP.

---

## MS-InfoJP Architecture Context

### System Overview
MS-InfoJP is a **Retrieval Augmented Generation (RAG) system** for Employment Insurance jurisprudence queries, built on Microsoft PubSec-Info-Assistant platform.

**MVP Goal**: "Deliver a working Jurisprudence AI assistant with clear answers, citations, and superior UX, using existing data and minimal new infrastructure."

**Key Components**:
1. **Backend**: Python/Quart async API (base-platform/app/backend/)
2. **Frontend**: React/TypeScript/Vite SPA (base-platform/app/frontend/)
3. **Document Pipeline**: Azure Functions for OCR, chunking, embedding (base-platform/functions/)
4. **Enrichment Service**: Flask API for embedding generation (base-platform/app/enrichment/)
5. **CanLII CDC**: Custom ingestion pipeline for case law documents (this project)

### MVP Success Criteria (Testable)

**Functional**:
1. Authentication via Entra ID
2. Query response within 30 seconds
3. 90% of answers include at least one valid case citation with link
4. Clickable citations access full case documents
5. Chat session persistence
6. 100+ EI cases successfully ingested
7. Deterministic re-runs of ingestion pipeline
8. Traceable CDC provenance (poll_run + change_event records)
9. All 26 CDC acceptance tests pass

**UX**:
10. Visual feedback during answer generation
11. Citations clearly distinguishable (bold, hyperlinked)
12. One-click navigation from answer to source

**Non-Functional**:
13. 90% of queries < 30 seconds
14. 95% uptime during test period
15. All endpoints require authentication

### CanLII CDC Architecture (Change Data Capture)

**Core Documentation** (see [cdc/CDC-INDEX.md](../cdc/CDC-INDEX.md) for navigation):
- [CDC MVP Design](../cdc/cdc-mvp-design.md) - Comprehensive CDC architecture
- [CDC MVP Artifacts](../cdc/cdc-mvp-artifacts.md) - Build-ready deliverables
- [CDC Change Policy](../cdc/change-policy.yaml) - Classification rules (v0.1.0)
- [CDC Acceptance Tests](../cdc/acceptance-tests.md) - 26 Given/When/Then specs
- [CDC Database Schema](../cdc/minimal-schema-ddl.md) - 11-table Cosmos DB schema

**Tiered CDC Approach** (Evidence-First, Minimal Recompute):

**Tier 1 - Registry Polling** (Metadata-based):
1. Poll CanLII metadata API for EI cases within scope_id (e.g., `SST-GD-EN-rolling-24mo`)
2. Detect changes via content-addressable hashing
3. Maintain Case Registry with stable internal case_id

**Tier 2 - Artifact Verification** (Content-based):
4. Conditionally download when: new case, metadata hash change, or missing artifact
5. Execute ingestion pipeline: parse -> enrich -> chunk -> embed -> index

**CDC Principles**:
- **Evidence-first**: Every poll produces poll_run + change_event for audit/replay
- **Minimal recompute**: Only reprocess changed cases/chunks
- **Versioned corpus**: Track case_version for every meaningful change
- **Language-aware**: Separate EN/FR outputs; deterministic bilingual handling
- **Cost control**: Immutability classes prevent unnecessary work

### Critical Architecture Patterns

#### 1. RAG Execution Flow
```python
# All RAG approaches follow this 5-step pattern:
async def run_rag_query(self, user_query: str):
    # 1. Query Optimization (with fallback)
    optimized_query = await self.optimize_query(user_query)
    
    # 2. Embedding Generation (with fallback)
    query_embedding = await self.enrichment.generate_embeddings([optimized_query])
    
    # 3. Hybrid Search (vector + keyword)
    results = await self.search_client.search(
        search_text=optimized_query,
        vector_queries=[VectorizedQuery(
            vector=query_embedding,
            k_nearest_neighbors=top_k,
            fields="embedding"
        )]
    )
    
    # 4. Context Assembly
    context = self.format_context_for_gpt(results)
    
    # 5. GPT Completion with Citation Enforcement
    async for chunk in self.generate_completion_streaming(context, query):
        yield chunk
```

#### 2. Fallback Pattern for Secure Mode
```python
# When private endpoints unreachable, degrade gracefully
optional_service = os.getenv("SERVICE_OPTIONAL", "false").lower() == "true"
try:
    result = await call_azure_service()
except Exception as e:
    if optional_service:
        print("[WARN] Service unavailable; degrading to fallback mode")
        result = fallback_implementation()
    else:
        raise
```

#### 3. Citation Enforcement Pattern
```python
# ALWAYS enforce citations in GPT responses
system_prompt = """
You are a jurisprudence assistant. CRITICAL: You MUST cite sources for all claims.

Citation Format:
- Case name and citation number (e.g., "2024 FC 679")
- Include clickable link to source document
- Place citations inline or at end of answer

NEVER make claims without citing a source from the retrieved documents.
"""
```

---

## Professional Component Architecture (MANDATORY)

### MS-InfoJP Component Structure

```python
from pathlib import Path
from datetime import datetime
import json
import asyncio
from typing import Any, Dict, List

class MSInfoJPComponent:
    """Base class for all MS-InfoJP components"""
    
    def __init__(self, component_name: str):
        self.component_name = component_name
        self.project_root = self._find_project_root()
        self.debug_collector = DebugArtifactCollector(component_name, self.project_root)
        self.session_manager = SessionManager(component_name, self.project_root)
        self.error_handler = StructuredErrorHandler(component_name, self.project_root)
        
    def _find_project_root(self) -> Path:
        """Auto-detect MS-InfoJP project root from any subdirectory"""
        current = Path.cwd()
        while current != current.parent:
            if (current / "11-MS-InfoJP").exists() or current.name == "11-MS-InfoJP":
                return current if current.name == "11-MS-InfoJP" else current / "11-MS-InfoJP"
            current = current.parent
        raise RuntimeError("[ERROR] MS-InfoJP project root not found")
        
    async def execute_with_observability(self, operation_name: str, operation):
        """Execute operation with full evidence collection"""
        print(f"[INFO] Executing {operation_name}...")
        
        # 1. ALWAYS capture pre-state
        await self.debug_collector.capture_state(f"{operation_name}_before")
        await self.session_manager.save_checkpoint("before_operation", {
            "operation": operation_name,
            "timestamp": datetime.now().isoformat()
        })
        
        try:
            # 2. Execute operation
            result = await operation()
            
            # 3. ALWAYS capture success state
            await self.debug_collector.capture_state(f"{operation_name}_success")
            await self.session_manager.save_checkpoint("operation_success", {
                "operation": operation_name,
                "result_preview": str(result)[:200] if result else "None",
                "timestamp": datetime.now().isoformat()
            })
            
            print(f"[PASS] {operation_name} completed successfully")
            return result
            
        except Exception as e:
            # 4. ALWAYS capture error state
            await self.debug_collector.capture_state(f"{operation_name}_error")
            await self.error_handler.log_structured_error(operation_name, e)
            await self.session_manager.save_checkpoint("operation_error", {
                "operation": operation_name,
                "error": str(e),
                "error_type": type(e).__name__,
                "timestamp": datetime.now().isoformat()
            })
            print(f"[ERROR] {operation_name} failed: {e}")
            raise
```

### CanLII CDC Component Pattern

```python
class CanLIICDCComponent(MSInfoJPComponent):
    """Professional CDC implementation for CanLII case law ingestion"""
    
    def __init__(self):
        super().__init__("canlii_cdc")
        self.metadata_cache = self.project_root / "input" / "metadata" / "canlii_metadata_cache.json"
        self.last_sync_file = self.project_root / "input" / "metadata" / "last_sync.json"
        
    async def poll_metadata(self, topics: List[str] = ["employment_insurance"]):
        """Poll CanLII for metadata changes with evidence preservation"""
        return await self.execute_with_observability(
            "poll_canlii_metadata",
            lambda: self._fetch_metadata(topics)
        )
    
    async def detect_changes(self, new_metadata: List[Dict], cached_metadata: List[Dict]):
        """Detect new/updated cases with state capture"""
        return await self.execute_with_observability(
            "detect_metadata_changes",
            lambda: self._compare_metadata(new_metadata, cached_metadata)
        )
    
    async def download_documents(self, case_ids: List[str]):
        """Download case documents with retry and evidence collection"""
        return await self.execute_with_retry(
            "download_case_documents",
            lambda: self._download_batch(case_ids),
            max_attempts=3
        )
```

### Azure Resource Validation Pattern

```python
class AzureResourceValidator(MSInfoJPComponent):
    """Pre-flight validation of Azure resources"""
    
    def __init__(self):
        super().__init__("azure_validator")
        
    async def validate_all_resources(self) -> Dict[str, bool]:
        """Validate all required Azure resources before execution"""
        validations = {
            "azure_openai": await self.validate_openai(),
            "azure_search": await self.validate_search(),
            "azure_cosmosdb": await self.validate_cosmosdb(),
            "azure_blob": await self.validate_blob_storage(),
            "enrichment_service": await self.validate_enrichment()
        }
        
        all_valid = all(validations.values())
        
        if not all_valid:
            failed = [k for k, v in validations.items() if not v]
            print(f"[ERROR] Resource validation failed: {', '.join(failed)}")
            print("[INFO] Check configuration in base-platform/app/backend/backend.env")
        else:
            print("[PASS] All Azure resources validated successfully")
            
        return validations
    
    async def validate_openai(self) -> bool:
        """Validate Azure OpenAI endpoint and deployment"""
        try:
            endpoint = os.getenv("AZURE_OPENAI_ENDPOINT")
            if not endpoint:
                print("[ERROR] AZURE_OPENAI_ENDPOINT not configured")
                return False
            
            # Test connectivity (implement actual test)
            print("[PASS] Azure OpenAI endpoint reachable")
            return True
        except Exception as e:
            print(f"[ERROR] Azure OpenAI validation failed: {e}")
            return False
```

---

## RAG-Specific Patterns (MANDATORY)

### 1. Hybrid Search Implementation
```python
async def execute_hybrid_search(self, query: str, embedding: List[float], top_k: int = 3):
    """Execute hybrid vector + keyword search"""
    
    search_results = await search_client.search(
        search_text=query,  # Keyword search
        vector_queries=[
            VectorizedQuery(
                vector=embedding,  # Vector search
                k_nearest_neighbors=top_k,
                fields="embedding"
            )
        ],
        select=["content", "title", "case_id", "court", "date", "url"],
        top=top_k
    )
    
    # ALWAYS preserve search evidence
    await self.debug_collector.capture_search_results(search_results)
    
    return [result async for result in search_results]
```

### 2. Citation Extraction and Validation
```python
def extract_citations(self, gpt_response: str, retrieved_docs: List[Dict]) -> List[Dict]:
    """Extract and validate citations from GPT response"""
    
    # Pattern: "2024 FC 679", "2021 SST 188"
    citation_pattern = r'\d{4}\s+[A-Z]{2,5}\s+\d+'
    found_citations = re.findall(citation_pattern, gpt_response)
    
    valid_citations = []
    for citation in found_citations:
        # Validate against retrieved documents
        matching_doc = self._find_matching_document(citation, retrieved_docs)
        if matching_doc:
            valid_citations.append({
                "citation": citation,
                "document_id": matching_doc["case_id"],
                "url": matching_doc.get("url"),
                "court": matching_doc.get("court")
            })
        else:
            print(f"[WARN] Citation not found in retrieved docs: {citation}")
    
    # Enforce minimum citation rate
    citation_rate = len(valid_citations) / max(len(found_citations), 1)
    if citation_rate < 0.9:
        print(f"[WARN] Low citation validation rate: {citation_rate:.1%}")
    
    return valid_citations
```

### 3. Document Chunking Strategy
```python
def chunk_case_document(self, case_text: str, metadata: Dict) -> List[Dict]:
    """Chunk case document with overlap for optimal retrieval"""
    
    CHUNK_SIZE = 1000  # tokens
    CHUNK_OVERLAP = 200  # tokens
    
    chunks = []
    
    # Use semantic chunking for legal documents
    sections = self._identify_legal_sections(case_text)  # e.g., Facts, Analysis, Decision
    
    for section_name, section_text in sections:
        section_chunks = self._create_overlapping_chunks(
            section_text, 
            chunk_size=CHUNK_SIZE,
            overlap=CHUNK_OVERLAP
        )
        
        for i, chunk_text in enumerate(section_chunks):
            chunks.append({
                "content": chunk_text,
                "metadata": {
                    **metadata,
                    "section": section_name,
                    "chunk_index": i,
                    "total_chunks": len(section_chunks)
                }
            })
    
    print(f"[INFO] Created {len(chunks)} chunks from case document")
    return chunks
```

---

## Anti-Patterns to NEVER Generate

### [x] FORBIDDEN Pattern #1: Silent Exception Swallowing
```python
# NEVER DO THIS
try:
    result = process_document()
except:
    pass  # Silent failure - no evidence, no logging
```

### [x] FORBIDDEN Pattern #2: Uncited GPT Claims
```python
# NEVER DO THIS
system_prompt = "Answer the user's question about jurisprudence."
# Missing citation enforcement!
```

### [x] FORBIDDEN Pattern #3: Unicode in Scripts
```python
# NEVER DO THIS
print(" Document indexed successfully")  # Will crash in cp1252
```

### [x] FORBIDDEN Pattern #4: Retry Without State Capture
```python
# NEVER DO THIS
for i in range(3):
    try:
        return operation()
    except:
        continue  # No evidence between attempts
```

---

## Quality Gates (MANDATORY)

### Before Code Generation Checklist:
- [ ] Windows encoding safety confirmed (ASCII only)
- [ ] Debug artifact collection implemented
- [ ] Session state management included
- [ ] Structured error handling with evidence preservation
- [ ] Citations enforced in GPT prompts
- [ ] Hybrid search properly configured
- [ ] Retry logic with state capture between attempts

### MS-InfoJP Success Criteria Alignment:
Every component must support these testable criteria:
1. Authentication via Entra ID
2. Query response within 30 seconds
3. 90% of answers include valid citations
4. Clickable links to source documents
5. Session persistence
6. 100+ EI cases ingested
7. Deterministic re-runs of ingestion

---

## Azure Service Configuration

### Required Environment Variables:
```bash
# Azure OpenAI
AZURE_OPENAI_ENDPOINT=https://your-openai.openai.azure.com/
AZURE_OPENAI_CHAT_DEPLOYMENT=gpt-4o
AZURE_OPENAI_EMBEDDING_DEPLOYMENT=text-embedding-ada-002
AZURE_OPENAI_API_VERSION=2024-02-15-preview

# Azure Cognitive Search
AZURE_SEARCH_ENDPOINT=https://your-search.search.windows.net
AZURE_SEARCH_INDEX=index-jurisprudence

# Azure Cosmos DB
AZURE_COSMOSDB_ENDPOINT=https://your-cosmosdb.documents.azure.com:443/
AZURE_COSMOSDB_DATABASE=conversations

# Fallback Flags (for local dev without VPN)
OPTIMIZED_KEYWORD_SEARCH_OPTIONAL=true
ENRICHMENT_OPTIONAL=true
```

---

## Delivery Phases & Timeline

### Phase 0: Baseline Setup (Week 1)
- Clone PubSec-Info-Assistant [x]
- Deploy Azure infrastructure [x]
- Verify base application end-to-end
- Document baseline capabilities

### Phase 1: JP Ingestion Pipeline (Weeks 2-3)
- **Week 1**: Create CDC policy pack (scope.yaml, change-policy.yaml, immutability.yaml, language-policy.yaml)
- **Week 1**: Define Cosmos DB schema (case, artifact, poll_run, change_event tables)
- **Week 2**: Build Case Registry and Artifact Index
- **Week 2**: Implement Tier 1 (metadata polling) and Tier 2 (artifact verification)
- **Week 2**: Create CDC evidence trail
- **Week 3**: Connect to existing pipeline with delta-only recompute
- **Exit Criteria**: 100+ EI cases indexed with full provenance, all 26 CDC tests pass

### Phase 2: RAG with Citations (Weeks 4-5)
- Tune prompt templates for jurisprudence
- Enforce citation generation in GPT
- Implement citation extraction/linking
- Test answer quality and accuracy
- **Exit Criteria**: 90% of answers include valid citations

### Phase 3: UX Polish (Week 6)
- Processing state indicators
- Enhanced citation presentation
- User feedback mechanism
- Prompt tuning based on tests
- **Exit Criteria**: All UX success criteria met

### Phase 4: APIM Integration (Post-MVP, First Priority)
- Deploy Azure API Management as gateway for InfoJP
- End-to-end cost attribution via standard headers (X-Run-Id, X-Variant, X-Correlation-Id)
- Header propagation: frontend -> APIM -> backend -> downstream services
- OpenAPI specification for InfoJP API surface
- APIM policies: governance, rate limiting, correlation tracking
- **See**: [APIM Feature README](../apim/README.md) for complete implementation guide
- **Exit Criteria**: All InfoJP calls route through APIM with full observability

### Phase 5: Hardening (Week 7)
- Architecture documentation
- Developer/user guides
- Security review
- Stakeholder handoff
- **Exit Criteria**: All criteria met; docs complete

---

## Risk Mitigations (Key Items)

### [x] MITIGATED: CanLII API Limitations
- **Status**: CanLII API key obtained; metadata-only API confirmed
- **Mitigation**: Tiered CDC (metadata-first, artifact-conditional) per CDC MVP Design
- **Fallback**: Use existing EVA-JP corpus as Day-0 bootstrap

### [x] MITIGATED: Azure OpenAI Quota
- **Status**: Using existing `ao-sandbox` with gpt-4o and text-embedding-3-small
- **Mitigation**: Monitor quota via Azure Portal; implement rate limiting

### [WARN] ACTIVE: Citation Accuracy
- **Risk**: GPT may hallucinate citations
- **Mitigation**: Strict citation format in prompts + post-process validation

### [WARN] ACTIVE: Response Time > 30 Seconds
- **Risk**: Complex queries may exceed target
- **Mitigation**: Optimize search (top-k, filters), streaming responses, complexity detection

---

## Developer Quickstart Paths

### Path 1: GitHub Codespaces (Recommended - $0/month)

```bash
# 1. Launch Codespace from base-platform/ in GitHub UI
# 2. Authenticate to Azure
az login --use-device-code
az account set --subscription c59ee575-eb2a-4b51-a865-4b618f9add0a

# 3. Configure backend.env (see README for full template)
# 4. Start servers
cd app/backend && python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt && python app.py  # Terminal 1

cd app/frontend && npm install && npm run dev     # Terminal 2

# 5. Access via forwarded ports (VS Code shows notification)
```

### Path 2: Local Development (Windows)

```powershell
# 1. Navigate to deployment root
cd 'I:\EVA-JP-v1.2\docs\eva-foundry\projects\11-MS-InfoJP\base-platform'

# 2. Configure app/backend/backend.env with Azure resource endpoints
# (See README for full template with Azure OpenAI, Search, Cosmos DB, Storage)

# 3. Start backend
cd app\backend
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python app.py  # Terminal 1

# 4. Start frontend
cd app\frontend
npm install
npm run dev  # Terminal 2

# 5. Access at http://localhost:5173
```

### Post-Deployment: Cherry-Picking from EVA-JP-v1.2

**ONLY after base system works end-to-end**, selectively adopt:
1. RAG approach enhancements from `../../../../app/backend/approaches/`
2. Jurisprudence-specific prompts
3. Citation formatting improvements

**Rule**: Test thoroughly after each cherry-pick; never batch-copy.

---

## References

- **Base Platform**: base-platform/ (Microsoft PubSec-Info-Assistant, commit 807ee181)
- **CDC Architecture**: [CDC Index](../cdc/CDC-INDEX.md) for complete navigation
- **APIM Integration**: [APIM README](../apim/README.md) - Phase 4 implementation guide
  - Header contract (X-Run-Id, X-Variant, X-Correlation-Id, X-Project-Id)
  - Cost attribution strategy
  - Governance policies and cutover plan
- **EVA Copilot Standards**: ../../07-copilot-instructions/
- **Project Documentation**: [README.md](../README.md), [DEPLOYMENT-PLAN.md](../DEPLOYMENT-PLAN.md)
- **Related Projects**: 
  - [Project 02](../../02-poc-agent-skills/) - Agent Skills Framework
  - [Project 04](../../04-OS-vNext/) - Predefined AI Workflows
  - [Project 07](../../07-copilot-instructions/) - Copilot Standards Baseline


---

### Skills in This Project

`powershell
Get-ChildItem ".github/copilot-skills" -Filter "*.skill.md" | Select-Object Name
`

Read `00-skill-index.skill.md` to see what agent skills are available for this project.
Match the user's trigger phrase to the skill, then read that skill file in full.
