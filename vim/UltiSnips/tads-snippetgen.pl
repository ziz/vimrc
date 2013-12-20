#!/usr/bin/perl
# Fragile and single-purpose: it works for the adv3lite advlite.h templates.

$in_snippet = 0;
@snippet = ();
while (<>) {
  next if (/^string template /);
  if (/^\s*\S+\s+template\s+/ || $in_snippet) {
    chomp;
    if (!$in_snippet) {
      s/^\s*(\S+)\s+template\s*(.*)/\2/;
      $template_name = $1;
      $snippet_desc = $2;
      $snippet_desc =~ s#;\s*(//.*|/\*.*)?$##;
      $snippet_desc =~ s#"#''#g;
    }
    push(@snippet, $_);
    $in_snippet = 1;
    if (m#;\s*(//.*|/\*.*)?$#) {
      $snippet[$#snippet] =~ s#;\s*(//.*|/\*.*)?$##;
      $snippet_desc = "$template_name " . join(" ", @snippet);
      $snippet_desc =~ s#  +# #g;
      $snippet_desc =~ s#"#''#g;
      print "snippet $template_name \"$snippet_desc\"\n";
      print "$template_name ";
      $tabstop = 1;
      foreach (@snippet) {
        @chunks = split(/(\s+(?:(?:\||\?)\s*)?)/);
        @tabstops = ();
        $doing_alternatives = 0;
        $did_alternatives = 0;
        while (my ($index, $elem) = each @chunks) {
          if ($elem =~ /\|/) {
            $tabstops[$#tabstops] .= $elem;
            $doing_alternatives = 1;
          }
          elsif ($doing_alternatives) {
            $tabstops[$#tabstops] .= $elem;
            $doing_alternatives = 0;
            $did_alternatives = 1;
          }
          elsif ($elem =~ /\?/ && $did_alternatives) {
            $tabstops[$#tabstops] .= $elem;
            $did_alternatives = 0;
          }
          else {
            push(@tabstops, $elem);
          }
        }
        foreach (@tabstops) {
          if (! /\S/) {
            print;
          }
          else {
            print '${' . $tabstop . ':' . $_ . '}';
            $tabstop += 1;
          }
        }
        print "\n";
      }
      print '$0' . "\n";
      print "endsnippet\n\n";
      @snippet = ();
      $in_snippet = 0;
    }
  }
}
