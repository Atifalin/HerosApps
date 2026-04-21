// Hand-curated synonym & intent map for service search.
// Maps common customer words (and misspellings) -> canonical service keywords
// that Fuse can then match against service/variant names & descriptions.
//
// Rules:
//   - All keys lower-cased.
//   - Values are additional tokens that will be appended to the query
//     when any of the keys is present.
//   - Keep this file in sync with the actual service catalog in Supabase.

const SYNONYMS: Record<string, string[]> = {
  // Maid / Cleaning family
  cleaner: ['cleaning', 'maid', 'housekeeping'],
  cleaning: ['maid', 'housekeeping', 'deep clean'],
  maid: ['cleaning', 'housekeeping'],
  housekeeping: ['cleaning', 'maid'],
  housekeeper: ['cleaning', 'maid', 'housekeeping'],
  clean: ['cleaning', 'maid'],
  tidy: ['cleaning', 'maid'],
  vacuuming: ['cleaning', 'maid'],
  dusting: ['cleaning', 'maid'],
  laundry: ['cleaning', 'maid'],
  window: ['window cleaning', 'cleaning'],
  windows: ['window cleaning', 'cleaning'],
  carpet: ['deep cleaning', 'cleaning'],
  fridge: ['fridge cleaning', 'kitchen', 'cleaning'],

  // Cook / Chef
  cook: ['chef', 'cooks', 'cooking', 'meal prep'],
  cooking: ['chef', 'cooks', 'meal prep'],
  chef: ['cook', 'cooks', 'meal prep'],
  meal: ['chef', 'cook', 'meal prep'],
  meals: ['chef', 'cook', 'meal prep'],
  food: ['chef', 'cook'],
  dinner: ['chef', 'cook', 'meal prep'],
  diet: ['chef', 'special diet', 'meal prep'],

  // Handymen -> DB title "Handyman" (singular)
  handyman: ['handyman'],
  handymen: ['handyman'],
  repair: ['handyman'],
  fix: ['handyman'],
  electric: ['handyman'],
  electrical: ['handyman'],
  electrician: ['handyman'],
  plumb: ['handyman'],
  plumbing: ['handyman'],
  plumber: ['handyman'],
  outlet: ['handyman'],
  light: ['handyman'],
  fixture: ['handyman'],
  furniture: ['handyman'],
  assembly: ['handyman'],
  leak: ['handyman'],
  drain: ['handyman'],
  toilet: ['handyman'],
  shower: ['handyman'],

  // Auto -> DB title "Car Detailing"
  auto: ['car detailing'],
  car: ['car detailing'],
  driver: ['car detailing', 'travel services'],
  drive: ['car detailing', 'travel services'],
  detail: ['car detailing'],
  detailing: ['car detailing'],
  wash: ['car detailing'],
  vehicle: ['car detailing'],

  // Moving -> DB title "Moving Service"
  moving: ['moving service'],
  movers: ['moving service'],
  mover: ['moving service'],
  relocation: ['moving service'],
  packing: ['moving service'],
  truck: ['moving service'],
  boxes: ['moving service'],

  // Personal Care
  massage: ['personal care'],
  salon: ['personal care'],
  haircut: ['personal care', 'salon'],
  hair: ['personal care', 'salon'],
  nails: ['personal care', 'salon'],
  manicure: ['personal care', 'salon'],
  pedicure: ['personal care', 'salon'],
  spa: ['personal care'],

  // Travel / Events
  tour: ['travel services', 'travel'],
  travel: ['travel services'],
  guide: ['travel services'],
  event: ['event planning'],
  events: ['event planning'],
  party: ['event planning'],
  wedding: ['event planning'],

  // Childcare / seniors (not in catalog yet -> point to closest)
  nanny: ['personal care'],
  babysitter: ['personal care'],
  kids: ['personal care'],
  elderly: ['personal care'],
  senior: ['personal care'],
};

/**
 * Expand a raw query into a Fuse extended-search expression that OR's
 * the original phrase together with any synonym-expanded terms.
 *
 * Fuse's extended search treats space-separated tokens as logical AND,
 * so we join alternatives with ` | ` (the extended-search OR operator)
 * to get "match any of these" behaviour.
 */
export function expandQuery(raw: string): string {
  const q = raw.trim().toLowerCase();
  if (!q) return q;

  const tokens = q.split(/\s+/);
  const extras = new Set<string>();

  tokens.forEach((tok) => {
    const syns = SYNONYMS[tok];
    if (syns) syns.forEach((s) => extras.add(s));
  });

  // Build the set of alternatives: the full original phrase + each synonym.
  const alternatives: string[] = [q, ...Array.from(extras)];
  // De-duplicate while preserving order.
  const seen = new Set<string>();
  const unique = alternatives.filter((a) => {
    if (seen.has(a)) return false;
    seen.add(a);
    return true;
  });

  // Fuse extended-search OR operator is ` | ` with spaces on both sides.
  return unique.join(' | ');
}

/**
 * Given a raw query, return a short human-readable hint string like
 * "Did you mean Cleaning, Maid?" when the query had synonym hits.
 * Returns null if there is nothing to suggest.
 */
export function didYouMean(raw: string): string | null {
  const q = raw.trim().toLowerCase();
  if (!q) return null;

  const tokens = q.split(/\s+/);
  const suggestions = new Set<string>();

  tokens.forEach((tok) => {
    const syns = SYNONYMS[tok];
    if (syns) syns.slice(0, 2).forEach((s) => suggestions.add(s));
  });

  if (suggestions.size === 0) return null;

  const pretty = Array.from(suggestions)
    .slice(0, 3)
    .map((s) => s.replace(/\b\w/g, (c) => c.toUpperCase()));
  return `Did you mean ${pretty.join(', ')}?`;
}
