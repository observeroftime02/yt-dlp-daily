#!/usr/bin/env python3

# This script was borrowed from here, credit to Pukkandan:
# https://github.com/yt-dlp/yt-dlp/issues/5859#issuecomment-1363938900
# It converts CLI arguments to yt-dlp compatible API options

import yt_dlp


def cli_to_api(*opts):
    default = yt_dlp.parse_options([]).ydl_opts
    diff = {k: v for k, v in yt_dlp.parse_options(opts).ydl_opts.items() if default[k] != v}
    if 'postprocessors' in diff:
        diff['postprocessors'] = [pp for pp in diff['postprocessors'] if pp not in default['postprocessors']]
    return diff


from pprint import pprint

pprint(cli_to_api('-4', '--downloader', 'http,m3u8:aria2c', '--embed-thumb'))  # Change according to your need
