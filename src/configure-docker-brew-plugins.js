#!/usr/bin/env node

import childProcess from 'node:child_process';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import process from 'node:process';

const configFilepath = path.join(os.homedir(), '.docker', 'config.json');
const brewPrefix = childProcess.execSync('brew --prefix').toString().trim();
const pluginsFilepath = path.join(brewPrefix, 'lib', 'docker', 'cli-plugins');

if (!fs.existsSync(configFilepath)) {
  console.error('No Docker config file found.');
  process.exit(1);
}

const source = fs.readFileSync(configFilepath, 'utf-8');
const config = JSON.parse(source);

if (Array.isArray(config.cliPluginsExtraDirs)) {
  if (config.cliPluginsExtraDirs.includes(pluginsFilepath)) {
    process.exit(0);
  } else {
    config.cliPluginsExtraDirs.push(pluginsFilepath);
  }
} else {
  config.cliPluginsExtraDirs = [pluginsFilepath];
}

fs.writeFileSync(configFilepath, JSON.stringify(config, null, 4));

