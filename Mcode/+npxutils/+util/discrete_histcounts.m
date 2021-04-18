function counts = discrete_histcounts(values, unique_values)

unique_values = npxutils.util.makecol(unique_values);
[sorted_unique_values, sort_idx] = sort(unique_values);
[~, inv_sort_idx] = ismember(1:numel(unique_values), sort_idx);
sorted_counts = histcounts(values, [sorted_unique_values; Inf]);

counts = sorted_counts(inv_sort_idx);
counts = npxutils.util.makecol(counts);
end
