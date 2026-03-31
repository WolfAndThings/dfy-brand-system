#!/bin/bash
# ============================================
# GA4 + Search Console Setup for services.loopworker.com
# Run: bash setup_analytics.sh
# ============================================

echo ""
echo "=== Step 1: Create GA4 Property ==="
echo "Opening Google Analytics. Create a new property for services.loopworker.com"
echo ""
open "https://analytics.google.com/analytics/web/#/provision/create"
echo ""
echo "After creating the property, copy the Measurement ID (starts with G-)"
echo ""
read -p "Paste your GA4 Measurement ID here (e.g. G-XXXXXXXXXX): " GA_ID

if [[ ! "$GA_ID" =~ ^G- ]]; then
  echo "ERROR: Measurement ID should start with G-. Got: $GA_ID"
  exit 1
fi

echo ""
echo "=== Step 2: Replacing GA_MEASUREMENT_ID with $GA_ID across all files ==="
find . -name "*.html" -exec sed -i '' "s/GA_MEASUREMENT_ID/$GA_ID/g" {} +
echo "Done. $(grep -rl "$GA_ID" --include="*.html" . | wc -l | tr -d ' ') files updated."

echo ""
echo "=== Step 3: Pushing to GitHub ==="
git add -A
git commit -m "Activate GA4 tracking: $GA_ID across all pages"
git push origin main
echo "Deployed."

echo ""
echo "=== Step 4: Google Search Console ==="
echo "Opening Search Console. Add services.loopworker.com as a URL-prefix property."
echo "Verification should be automatic (Google site verification tag is already on all pages)."
echo ""
open "https://search.google.com/search-console/welcome"

echo ""
echo "After adding the property, submit these sitemaps:"
echo ""
echo "  https://services.loopworker.com/sitemap-index.xml"
echo "  https://services.loopworker.com/junk-removal-tacoma-wa/sitemap.xml"
echo "  https://services.loopworker.com/concrete-des-moines-ia/sitemap.xml"
echo "  https://services.loopworker.com/garage-door-repair-reno-nv/sitemap.xml"
echo "  https://services.loopworker.com/pressure-washing-greenville-sc/sitemap.xml"
echo "  https://services.loopworker.com/roofing-chattanooga-tn/sitemap.xml"
echo "  https://services.loopworker.com/tree-service-boise-id/sitemap.xml"
echo ""
echo "Opening sitemap submission page..."
open "https://search.google.com/search-console/sitemaps?resource_id=https%3A%2F%2Fservices.loopworker.com%2F"

echo ""
echo "=== Done! ==="
echo "GA4 is live. Search Console will start indexing within 24-48 hours."
echo "Check analytics at: https://analytics.google.com"
echo ""
