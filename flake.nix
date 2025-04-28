{
  description = "Development environment for Django and React";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, gitignore, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        pythonEnv = pkgs.python3.withPackages (ps: with ps; [
          virtualenv
          # pytest
          # # pytest-django
          pip
        ]);
      in {

        devShells = {
          # default = pkgs.mkShell {
          #   buildInputs = with pkgs; [

          #     # Python environment
          #     pythonEnv

          #     # Only include project-specific tools not globally installed
          #     pre-commit
          #     # Add any other project-specific tools here
          #   ];
            
          #   shellHook = ''
          #     echo "🚀 Setting up Django + React development environment..."

          #     # Check if core_frontend directory exists
          #     if [ ! -d "core_frontend" ]; then
          #       echo "❌ Error: core_frontend directory not found"
          #       return 1
          #     fi

          #     # Install Node.js dependencies
          #     echo "📦 Installing Node.js dependencies..."
          #     (cd core_frontend && pnpm install) || echo "⚠️ Warning: Failed to install Node.js dependencies"
              
          #     # Check if core_backend directory exists
          #     if [ ! -d "core_backend" ]; then
          #       echo "❌ Error: core_backend directory not found"
          #       return 1
          #     fi

          #     # Ensure the virtual environment exists
          #     if [ ! -d "core_backend/.venv" ]; then
          #       echo "🐍 Creating Python virtual environment..."
          #       ${pythonEnv}/bin/python -m venv core_backend/.venv
          #     fi

          #     # Activate the virtual environment
          #     source core_backend/.venv/bin/activate

          #     # Install Django if not installed
          #     if ! python -c "import django" 2>/dev/null; then
          #       echo "🎯 Installing Django..."
          #       pip install django
          #     fi

          #     # Create Django project if it doesn't exist
          #     if [ ! -f "core_backend/manage.py" ]; then
          #       echo "🎯 Creating Django project structure..."
          #       cd core_backend && django-admin startproject api_root . && cd ..
          #     fi

          #     # # Install Python dependencies from pyproject.toml if not already installed
          #     # if ! pip show core-backend >/dev/null 2>&1; then
          #     #   echo "📦 Installing Python dependencies..."
          #     #   pip install -e core_backend
          #     # fi

          #     echo "📦 Installing Python dependencies..."
          #       pip install -e core_backend
              
          #     echo ""
          #     echo "📝 Django (backend): cd core_backend"
          #     echo "🎨 React (frontend): cd core_frontend"
              
          #     echo "✅ Development environment ready!"
          #     echo ""
          #   '';
          # };

                    # Frontend-specific shell
          frontend = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs
              pnpm
            ];

            shellHook = ''
              echo "🚀 Starting React development environment..."
              
              if [ ! -d "core_frontend" ]; then
                echo "❌ Error: core_frontend directory not found"
                return 1
              fi

              echo "📦 Installing Node.js dependencies..."
              (cd core_frontend && pnpm install) || echo "⚠️ Warning: Failed to install Node.js dependencies"
              
              echo "⚡ Starting development server..."
              cd core_frontend && pnpm run dev

              echo ""
              echo "🎨 React (frontend): cd core_frontend"
              echo ""
            '';
          };

                    # Backend-specific shell
          backend = pkgs.mkShell {
            buildInputs = with pkgs; [
              pythonEnv
              pre-commit
            ];

            shellHook = ''
              echo "🚀 Starting Django development environment..."
              
              # Check if core_backend directory exists
              if [ ! -d "core_backend" ]; then
                echo "❌ Error: core_backend directory not found"
                return 1
              fi

              # Ensure the virtual environment exists
              if [ ! -d "core_backend/.venv" ]; then
                echo "🐍 Creating Python virtual environment..."
                ${pythonEnv}/bin/python -m venv core_backend/.venv
              fi

              # Activate the virtual environment
              source core_backend/.venv/bin/activate

              # Install Django if not installed
              if ! python -c "import django" 2>/dev/null; then
                echo "🎯 Installing Django..."
                pip install django
              fi

              # Create Django project if it doesn't exist
              if [ ! -f "core_backend/manage.py" ]; then
                echo "🎯 Creating Django project structure..."
                cd core_backend && django-admin startproject api_root . && cd ..
              fi

              # # Install Python dependencies from pyproject.toml if not already installed
              # if ! pip show core-backend >/dev/null 2>&1; then
              #   echo "📦 Installing Python dependencies..."
              #   pip install -e core_backend
              # fi

              echo "📦 Installing Python dependencies..."
                pip install -e core_backend
              
              echo ""
              echo "✅ Django backend ready!"
              echo ""
            '';
          };

        };
      }
    );
}
