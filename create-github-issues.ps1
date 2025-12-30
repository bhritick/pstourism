# PowerShell Script to Create All SEO GitHub Issues for PSTourism
# Run this after installing GitHub CLI and authenticating with: gh auth login

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "PSTourism SEO Issues Creator" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

# Check if GitHub CLI is installed
try {
    $ghVersion = gh --version
    Write-Host "✓ GitHub CLI is installed" -ForegroundColor Green
} catch {
    Write-Host "✗ GitHub CLI is not installed" -ForegroundColor Red
    Write-Host "  Install with: winget install --id GitHub.cli" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "Creating labels..." -ForegroundColor Yellow

# Create labels (suppress errors if they already exist)
$labels = @(
    @{name="seo"; description="SEO related tasks"; color="0075ca"},
    @{name="critical"; description="Critical priority"; color="d73a4a"},
    @{name="high-priority"; description="High priority"; color="ff6b6b"},
    @{name="medium-priority"; description="Medium priority"; color="ffa500"},
    @{name="low-priority"; description="Low priority"; color="ffeb3b"},
    @{name="phase-1"; description="Phase 1 tasks (Weeks 1-2)"; color="1e90ff"},
    @{name="phase-2"; description="Phase 2 tasks (Weeks 3-4)"; color="4169e1"},
    @{name="phase-3"; description="Phase 3 tasks (Weeks 5-6)"; color="00008b"},
    @{name="phase-4"; description="Phase 4 tasks (Weeks 7-8)"; color="191970"},
    @{name="phase-5"; description="Phase 5 tasks (Future)"; color="2c003e"},
    @{name="technical"; description="Technical tasks"; color="5319e7"},
    @{name="content"; description="Content related"; color="c5def5"},
    @{name="content-creation"; description="Content creation needed"; color="bfdadc"},
    @{name="performance"; description="Performance optimization"; color="fbca04"},
    @{name="ux"; description="User experience"; color="006b75"},
    @{name="analytics"; description="Analytics & tracking"; color="0e8a16"},
    @{name="ongoing"; description="Ongoing maintenance"; color="ededed"},
    @{name="on-page"; description="On-page SEO"; color="84b6f4"},
    @{name="refactoring"; description="Code refactoring"; color="d4c5f9"},
    @{name="trust"; description="Trust signals"; color="c2e0c6"},
    @{name="conversion"; description="Conversion optimization"; color="ff9800"},
    @{name="local-seo"; description="Local SEO"; color="009688"},
    @{name="off-page"; description="Off-page SEO"; color="795548"},
    @{name="marketing"; description="Marketing related"; color="e91e63"},
    @{name="engagement"; description="User engagement"; color="9c27b0"},
    @{name="international"; description="International/multi-language"; color="607d8b"},
    @{name="future"; description="Future enhancement"; color="bdbdbd"},
    @{name="maintenance"; description="Maintenance task"; color="fafafa"}
)

foreach ($label in $labels) {
    gh label create $label.name --description $label.description --color $label.color 2>$null
}

Write-Host "✓ Labels created/verified" -ForegroundColor Green
Write-Host ""
Write-Host "Creating issues... (This will take a few minutes)" -ForegroundColor Yellow
Write-Host ""

$issueCount = 0

# Issue #1
gh issue create --title "Fix Meta Titles and Descriptions for All Pages" `
--body "**Priority:** High  
**Estimated Time:** 2-3 days  

### Description
Meta titles and descriptions are missing or inadequate on most pages. This is critical for SEO and search engine visibility.

### Tasks
- [ ] Update homepage title from 'PS Tourism' to 'Best Tour Packages in India 2025 | Sikkim, Darjeeling, Kashmir | PSTourism'
- [ ] Add meta descriptions to index.html (155-160 characters)
- [ ] Add meta descriptions to packages.html
- [ ] Add meta descriptions to sikkim.html
- [ ] Add meta descriptions to all 150+ pages
- [ ] Add meta keywords to all pages (5-10 relevant keywords per page)
- [ ] Optimize all page titles with format: 'Primary Keyword | Secondary Keyword | PSTourism'
- [ ] Keep all titles under 60 characters
- [ ] Add Open Graph image tags (og:image) to all pages
- [ ] Verify Twitter Card meta tags on all pages

### Affected Pages
All 150+ HTML pages

### Acceptance Criteria
- Every page has unique, keyword-optimized title (max 60 chars)
- Every page has unique meta description (155-160 chars)
- Every page has relevant meta keywords
- All pages have og:image tags
- No duplicate titles or descriptions

### Reference
See \`SEO-ISSUES.md\` for full details" `
--label "seo,critical,phase-1,on-page" 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan

Start-Sleep -Seconds 1

# Issue #2
gh issue create --title "Implement Canonical URLs Site-Wide" `
--body "**Priority:** High  
**Estimated Time:** 1-2 days  

### Description
Canonical tags are missing from many pages, leading to potential duplicate content issues.

### Tasks
- [ ] Add canonical tags to packages.html
- [ ] Add canonical tags to sikkim.html
- [ ] Add canonical tags to about-us.html
- [ ] Add canonical tags to contact-us.html
- [ ] Add canonical tags to all destination hub pages
- [ ] Add canonical tags to all package pages
- [ ] Standardize canonical URL format (decide on www vs non-www)
- [ ] Fix inconsistent canonical URLs across existing pages
- [ ] Ensure all canonicals use HTTPS

### Files to Update
All HTML files (150+)

### Acceptance Criteria
- Every page has a canonical URL
- All canonical URLs use consistent format (www or non-www)
- All canonical URLs use HTTPS
- No canonical conflicts

### Reference
See \`SEO-ISSUES.md\` for full details" `
--label "seo,critical,phase-1,technical" 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan

Start-Sleep -Seconds 1

# Issue #3
gh issue create --title "Restructure URL Architecture and File Naming" `
--body "**Priority:** High  
**Estimated Time:** 5-7 days  

### Description
Current URL structure is inconsistent with multiple naming conventions causing SEO issues.

### Current Problems
- Inconsistent naming: '4n-5d', '4-night-5-days', '4night-5days'
- No folder hierarchy
- .html extensions visible
- Duplicate packages with different URLs

### Tasks
- [ ] Create destination-based folder structure
- [ ] Remove .html extensions using .htaccess rewrite rules
- [ ] Standardize naming convention
- [ ] Identify and merge duplicate pages
- [ ] Set up 301 redirects for old URLs
- [ ] Update sitemap.xml with new structure
- [ ] Update all internal links

### Duplicate Pages to Resolve
- 4n-5d-silk-route-package.html and 4n-5d-silk-route-package-trip-1.html
- andaman-5d-6n.html and andaman-5n-6d.html
- Other duplicates (TBD)

### Acceptance Criteria
- Consistent URL structure across all pages
- No .html extensions in URLs
- All duplicates merged with 301 redirects
- Proper folder hierarchy implemented

### Reference
See \`SEO-ISSUES.md\` for full details" `
--label "seo,critical,phase-1,refactoring" 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan

Start-Sleep -Seconds 1

# Issue #4
gh issue create --title "Build Comprehensive Internal Linking Structure" `
--body "**Priority:** High  
**Estimated Time:** 3-4 days  

### Description
Improve site architecture and SEO through strategic internal linking.

### Tasks
- [ ] Add breadcrumb navigation to all pages
- [ ] Create 'Related Packages' section on each package page (3-5 links)
- [ ] Add 'You May Also Like' section at bottom of pages
- [ ] Link from longer packages to shorter packages of same destination
- [ ] Link between related destinations
- [ ] Link from package pages to destination hub pages
- [ ] Add contextual links in package descriptions
- [ ] Link from gallery pages to related package pages
- [ ] Create footer links organized by category
- [ ] Add 'Back to [Category]' links on package pages

### Acceptance Criteria
- Every page has breadcrumbs
- Every package page has 3-5 related package links
- Footer has organized category links
- All orphan pages are linked from at least 3 other pages

### Reference
See \`SEO-ISSUES.md\` for full details" `
--label "seo,high-priority,phase-2,content" 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan

Start-Sleep -Seconds 1

# Issue #5
gh issue create --title "Create Destination Hub Pages" `
--body "**Priority:** High  
**Estimated Time:** 7-10 days  

### Description
Create comprehensive landing pages for each major destination to improve SEO and user experience.

### Hub Pages to Create/Optimize
- [ ] Sikkim Tours & Packages (main hub)
- [ ] North Bengal Tours & Packages (main hub)
- [ ] Kashmir Tours & Packages (main hub)
- [ ] Himachal Pradesh Tours & Packages (main hub)
- [ ] Andaman Tours & Packages (main hub)
- [ ] Ladakh Tours & Packages (main hub)
- [ ] Bhutan Tours & Packages (main hub)
- [ ] Meghalaya Tours & Packages (main hub)
- [ ] Sundarban Tours & Packages (main hub)

### Each Hub Page Must Include
- Comprehensive content (800-1500 words)
- Links to all related package pages
- Destination overview
- Best time to visit
- FAQs section (10+ questions)
- Gallery section
- Related destinations section

### Acceptance Criteria
- Minimum 800 words of unique content per hub
- All package links organized by duration/type
- FAQs with schema markup
- Optimized meta tags and headers

### Reference
See \`SEO-ISSUES.md\` for full details" `
--label "seo,high-priority,phase-2,content-creation" 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan

Start-Sleep -Seconds 1

# Issue #6
gh issue create --title "Optimize Header Tags (H1, H2, H3) Site-Wide" `
--body "**Priority:** Medium  
**Estimated Time:** 2-3 days  

### Description
Ensure proper header tag hierarchy and keyword optimization across all pages.

### Tasks
- [ ] Audit all pages for header tag usage
- [ ] Ensure single H1 tag per page with primary keyword
- [ ] Add H2 tags for main sections
- [ ] Add H3 tags for subsections
- [ ] Maintain proper hierarchy (H1 → H2 → H3, no skipping)
- [ ] Include target keywords naturally in headers

### Acceptance Criteria
- Single H1 per page with primary keyword
- Logical H2 and H3 structure
- No skipped header levels
- Keywords naturally integrated

### Reference
See \`SEO-ISSUES.md\` for full details" `
--label "seo,medium-priority,phase-2,on-page" 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan

Start-Sleep -Seconds 1

# Issue #7
gh issue create --title "Implement Comprehensive Schema Markup" `
--body "**Priority:** High  
**Estimated Time:** 4-5 days  

### Description
Enhance rich snippets and search appearance with comprehensive schema markup.

### Tasks
- [ ] Add Product schema to all package pages with pricing
- [ ] Add TourPackage schema for each package
- [ ] Add BreadcrumbList schema for navigation
- [ ] Add FAQPage schema for FAQ sections
- [ ] Add Review/AggregateRating schema for testimonials
- [ ] Add LocalBusiness schema to contact page
- [ ] Verify all schema with Google Rich Results Test
- [ ] Fix any schema validation errors

### Acceptance Criteria
- All package pages have Product/TourPackage schema
- All pages have BreadcrumbList schema
- FAQ pages have FAQPage schema
- All schemas pass Rich Results Test
- No validation errors

### Reference
See \`SEO-ISSUES.md\` for full details" `
--label "seo,high-priority,phase-3,technical" 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan

Start-Sleep -Seconds 1

# Issue #8
gh issue create --title "Image Optimization and Alt Text" `
--body "**Priority:** High  
**Estimated Time:** 3-4 days  

### Description
Optimize all images for SEO and page speed.

### Tasks
- [ ] Audit all images across site
- [ ] Compress all images (target: max 200KB per image)
- [ ] Convert images to WebP format
- [ ] Add descriptive alt text to every image
- [ ] Rename image files with descriptive, keyword-rich names
- [ ] Add width and height attributes
- [ ] Implement lazy loading for images
- [ ] Create image sitemap
- [ ] Use srcset for responsive images

### Acceptance Criteria
- All images compressed (<200KB)
- 100% of images have descriptive alt text
- Descriptive file names for all images
- Lazy loading implemented
- Image sitemap created

### Reference
See \`SEO-ISSUES.md\` for full details" `
--label "seo,high-priority,phase-2,performance" 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan

Start-Sleep -Seconds 1

# Issue #9
gh issue create --title "Page Speed Optimization" `
--body "**Priority:** High  
**Estimated Time:** 3-5 days  

### Description
Improve page load speed for better SEO and user experience.

### Tasks
- [ ] Minify all CSS files
- [ ] Minify all JavaScript files
- [ ] Enable Gzip compression on server
- [ ] Configure browser caching in .htaccess
- [ ] Defer non-critical JavaScript
- [ ] Inline critical CSS
- [ ] Reduce server response time
- [ ] Eliminate render-blocking resources
- [ ] Test with PageSpeed Insights
- [ ] Achieve score of 85+ on mobile and desktop

### Target Metrics
- First Contentful Paint: <1.8s
- Largest Contentful Paint: <2.5s
- Total Blocking Time: <200ms
- PageSpeed score 85+

### Acceptance Criteria
- PageSpeed score 85+ (mobile and desktop)
- All Core Web Vitals in green
- CSS and JS minified
- Browser caching enabled
- Gzip compression active

### Reference
See \`SEO-ISSUES.md\` for full details" `
--label "seo,critical,phase-3,performance" 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan

Start-Sleep -Seconds 1

# Issue #10
gh issue create --title "Mobile Optimization and Responsive Design" `
--body "**Priority:** High  
**Estimated Time:** 3-4 days  

### Description
Ensure perfect mobile experience across all pages.

### Tasks
- [ ] Test all 150+ pages on mobile devices
- [ ] Fix any responsive design issues
- [ ] Ensure touch elements are min 48x48px
- [ ] Optimize forms for mobile input
- [ ] Adjust font sizes for mobile readability (min 16px)
- [ ] Test on multiple devices and screen sizes
- [ ] Test with Google Mobile-Friendly Test
- [ ] Fix any mobile usability issues in Search Console

### Acceptance Criteria
- 100% pages pass Mobile-Friendly Test
- All touch targets minimum 48x48px
- Forms work perfectly on mobile
- No horizontal scrolling
- Readable font sizes

### Reference
See \`SEO-ISSUES.md\` for full details" `
--label "seo,high-priority,phase-2,ux" 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan

Start-Sleep -Seconds 1

# Continue with remaining issues...
# Issues #11-32 follow the same pattern

# Issue #11
gh issue create --title "XML Sitemap and Robots.txt Optimization" `
--label "seo,critical,phase-1,technical" `
--body "See SEO-ISSUES.md for full details. Tasks include sitemap verification, robots.txt optimization, and Search Console submission." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #12
gh issue create --title "Create Blog Section for Content Marketing" `
--label "seo,medium-priority,phase-4,content-creation" `
--body "See SEO-ISSUES.md for full details. Create /blog/ section with 20-30 comprehensive travel guides." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #13
gh issue create --title "Implement Breadcrumb Navigation" `
--label "seo,high-priority,phase-2,ux" `
--body "See SEO-ISSUES.md for full details. Add breadcrumb navigation with schema markup to all pages." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #14
gh issue create --title "Fix Duplicate Content Issues" `
--label "seo,critical,phase-1,content" `
--body "See SEO-ISSUES.md for full details. Identify and resolve duplicate pages with 301 redirects." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #15
gh issue create --title "Add Comprehensive Meta Keywords" `
--label "seo,medium-priority,phase-1,on-page" `
--body "See SEO-ISSUES.md for full details. Add 5-10 relevant keywords to all pages." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #16
gh issue create --title "Improve Navigation Menu Structure" `
--label "seo,medium-priority,phase-2,ux" `
--body "See SEO-ISSUES.md for full details. Redesign navigation with dropdown categories." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #17
gh issue create --title "Create Location-Specific Landing Pages" `
--label "seo,high-priority,phase-2,content-creation" `
--body "See SEO-ISSUES.md for full details. Create dedicated pages for major cities (Gangtok, Darjeeling, etc.)." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #18
gh issue create --title "Implement Package Type Category Pages" `
--label "seo,medium-priority,phase-2,content-creation" `
--body "See SEO-ISSUES.md for full details. Create category pages (Honeymoon, Group Tours, etc.)." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #19
gh issue create --title "Add FAQ Sections with Schema Markup" `
--label "seo,high-priority,phase-2,content" `
--body "See SEO-ISSUES.md for full details. Add FAQs to all major pages with FAQPage schema." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #20
gh issue create --title "Optimize Call-to-Actions (CTAs)" `
--label "ux,conversion,medium-priority,phase-2" `
--body "See SEO-ISSUES.md for full details. Improve CTAs with WhatsApp buttons, forms, and tracking." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #21
gh issue create --title "Add Customer Reviews and Testimonials" `
--label "seo,trust,medium-priority,phase-3,content" `
--body "See SEO-ISSUES.md for full details. Add reviews with schema markup and star ratings." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #22
gh issue create --title "Implement Trust Signals and Certifications" `
--label "trust,conversion,medium-priority,phase-2" `
--body "See SEO-ISSUES.md for full details. Display ISO certification and trust badges prominently." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #23
gh issue create --title "Create .htaccess for SEO and Performance" `
--label "seo,critical,phase-1,technical" `
--body "See SEO-ISSUES.md for full details. Configure .htaccess for URL rewriting, HTTPS, compression, and caching." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #24
gh issue create --title "Create Custom 404 Error Page" `
--label "ux,seo,medium-priority,phase-2" `
--body "See SEO-ISSUES.md for full details. Design helpful 404 page with search and navigation." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #25
gh issue create --title "Set Up Google Search Console" `
--label "seo,critical,phase-1,analytics" `
--body "See SEO-ISSUES.md for full details. Verify site, submit sitemap, monitor performance, fix errors." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #26
gh issue create --title "Implement Conversion Tracking in Google Analytics" `
--label "analytics,conversion,high-priority,phase-1" `
--body "See SEO-ISSUES.md for full details. Set up Goals, GTM, and track all conversions." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #27
gh issue create --title "Implement Social Media Integration" `
--label "marketing,engagement,medium-priority,phase-3" `
--body "See SEO-ISSUES.md for full details. Add sharing buttons, embed feeds, enhance OG tags." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #28
gh issue create --title "Google My Business Optimization" `
--label "local-seo,high-priority,phase-2" `
--body "See SEO-ISSUES.md for full details. Optimize GMB profile with photos, posts, and reviews." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #29
gh issue create --title "Build Link Building Strategy" `
--label "seo,off-page,medium-priority,phase-4,ongoing" `
--body "See SEO-ISSUES.md for full details. Guest posting, directory listings, and backlink acquisition." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #30
gh issue create --title "Conduct Monthly SEO Audits" `
--label "seo,ongoing,maintenance" `
--body "See SEO-ISSUES.md for full details. Establish monthly audit schedule with tools and checklists." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #31
gh issue create --title "Update Seasonal Content and Packages" `
--label "content,ongoing,maintenance,medium-priority" `
--body "See SEO-ISSUES.md for full details. Quarterly updates for pricing, seasons, and content freshness." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan
Start-Sleep -Seconds 1

# Issue #32
gh issue create --title "Implement Hreflang Tags (Multi-Language Support)" `
--label "seo,international,future,low-priority,phase-5" `
--body "See SEO-ISSUES.md for full details. Future implementation for Hindi and Bengali support." 2>$null
$issueCount++
Write-Host "  Created issue #$issueCount" -ForegroundColor Cyan

Write-Host ""
Write-Host "==================================================" -ForegroundColor Green
Write-Host "✓ Successfully created $issueCount issues!" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Visit your GitHub repository to view all issues" -ForegroundColor White
Write-Host "2. Assign issues to team members" -ForegroundColor White
Write-Host "3. Set milestones for each phase" -ForegroundColor White
Write-Host "4. Start with Phase 1 (Critical) issues" -ForegroundColor White
Write-Host ""
Write-Host "For full details on each issue, refer to:" -ForegroundColor Yellow
Write-Host "  - SEO-ISSUES.md (comprehensive documentation)" -ForegroundColor White
Write-Host "  - GITHUB-ISSUES-GUIDE.md (creation guide)" -ForegroundColor White
Write-Host ""
