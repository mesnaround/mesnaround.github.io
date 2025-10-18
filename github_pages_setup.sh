# Add GitHub remote
git remote add origin https://github.com/mesnaround/mesnaround.github.io.git

# Create .gitignore
cat > .gitignore << EOF
# Hugo
/public/
/resources/_gen/
/assets/jsconfig.json
hugo_stats.json
.hugo_build.lock

# OS
.DS_Store
Thumbs.db
EOF

# Commit initial site
git add .
git commit -m "Initial Hugo site"
git push -u origin main
