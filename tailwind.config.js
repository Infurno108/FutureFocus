/** @type {import('tailwindcss').Config} */
export default {
	content: ['./src/**/*.{html,js,svelte,ts}'],

	theme: {
		extend: {
			fontFamily: {
				'futura': 'Futura',
			},
			colors: {
				'primary': '#323232',
			}
		},
	},

	plugins: []
};
