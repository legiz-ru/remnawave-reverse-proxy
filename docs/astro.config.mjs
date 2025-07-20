// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import starlightHeadingBadges from 'starlight-heading-badges';
import starlightScrollToTop from 'starlight-scroll-to-top';
import starlightCoolerCredit from 'starlight-cooler-credit'; // This plugin is not used in the current configuration

// https://astro.build/config
export default defineConfig({
	integrations: [
		starlight({
			plugins: [
				starlightHeadingBadges(),
				starlightScrollToTop({
					showTooltip: false,
					borderRadius: '25',
				}),
			],
			title: 'eGamesAPI',
			logo: {
				src: './src/assets/logo.png',
			},
			customCss: [
				'./src/styles/custom.css',
			],
			defaultLocale: 'root', // https://starlight.astro.build/guides/i18n/
			locales: {
				root: {
					label: 'English',
					lang: 'en', // lang is required for the root locales
				},
				'ru': {
					label: 'Русский',
					lang: 'ru',
				},
			},
			editLink: {
				baseUrl: "https://github.com/eGamesAPI/remnawave-reverse-proxy/edit/main/",
			},
			social: [
				{ icon: 'github', label: 'GitHub', href: 'https://github.com/eGamesAPI/remnawave-reverse-proxy/' },
				{ icon: 'telegram', label: 'Telegram', href: 'https://t.me/remnawave_reverse' },
				{ icon: 'seti:folder', label: 'Used resources', href: '../../contribution/resources' }
			],
			sidebar: [
				{
					label: 'Introduction',
					items: [
						{ label: 'Overview', slug: 'introduction/overview' },
					],
				},
				{
					label: 'Installation',
					items: [
						{ label: 'Requirements', slug: 'installation/requirements' },
						{ label: 'Panel and node', slug: 'installation/panel-and-node' },
						{ label: 'Panel only', slug: 'installation/panel-only' },
						{ label: 'Node only', slug: 'installation/node-only' },
					],
				},
				{
					label: 'Contribution',
					items: [
						{ label: 'Contributors', slug: 'contribution/contributors' },
						{ label: 'Contribution Guide', slug: 'contribution/guide', badge: {text: 'New', variant: 'success'} },
					],
				},
			],
		}),
	],
});
