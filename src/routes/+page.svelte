<script>
	import { applyAction, enhance } from '$app/forms';
	import { get } from 'svelte/store';
	import { initialPrompt } from '$lib/store.js';
	import { onMount } from 'svelte';

	export let form;

	let promptInput = '';

	let beginnerChecked = true;
	let intermediateChecked = false;
	let professionalChecked = false;

	let checklistStates = [];

	let formLoading = false;

	function experienceChecked(experience) {
		if (experience === 'beginner') {
			beginnerChecked = true;
			intermediateChecked = false;
			professionalChecked = false;
		} else if (experience === 'intermediate') {
			beginnerChecked = false;
			intermediateChecked = true;
			professionalChecked = false;
		} else {
			beginnerChecked = false;
			intermediateChecked = false;
			professionalChecked = true;
		}
	}
</script>

<div class="flex flex-row items-center h-24 bg-primary">
	<img class="w-20" src="/favicon.png" alt="FutureFocus logo" />
	<p class="text-4xl text-white">FutureFocus</p>
</div>

<div class="flex flex-col items-center gap-y-4">
	{#if formLoading}
		<p>Loading...</p>
	{/if}
	<div class="p-4">
		<form
			use:enhance={({ formData }) => {
				formData.append('promptInput', promptInput);

				initialPrompt.update((n) => (n = promptInput));

				if (beginnerChecked) formData.append('checked', 'beginner');
				else if (intermediateChecked) formData.append('checked', 'intermediate');
				else formData.append('checked', 'professional');

				formLoading = true;

				checklistStates = [];

				return ({ update }) => {
					update({ invalidateAll: true }).finally(async () => {
						formLoading = false;
					});
				};
			}}
			action="?/submitPrompt"
			method="post"
		>
			<div class="flex flex-col">
				<p class="font-futura text-white pb-4 text-center text-4xl">Profession:</p>
				<input
					class="twinput focus:shadow-outline"
					bind:value={promptInput}
					placeholder="i just lost my dawg"
					type="text"
				/>
				<button class="twbtn mt-4">Generate</button>
			</div>
		</form>
	</div>

	<div class="flex flex-col">
		<label class="check" for="">
			<input
				on:change={() => {
					experienceChecked('beginner');
				}}
				checked={beginnerChecked}
				type="checkbox"
				name=""
				id=""
			/>
			Beginner
		</label>
		<label class="check" for="">
			<input
				on:change={() => {
					experienceChecked('intermediate');
				}}
				checked={intermediateChecked}
				type="checkbox"
				name=""
				id=""
			/>
			Intermediate
		</label>
		<label class="check" for="">
			<input
				on:change={() => {
					experienceChecked('professional');
				}}
				checked={professionalChecked}
				type="checkbox"
				name=""
				id=""
			/>
			Professional
		</label>
	</div>

	{#if form?.groq}
		<div>
			<p class="term">Short Term</p>
			{#each form.groq['shortTerm'] as item}
				<div class="flex flex-row">
					<input
						on:change={(e) => {
							if (e.target.checked) {
								if (!checklistStates.includes(item)) checklistStates.push(item);
							} else {
								checklistStates = checklistStates.filter((it) => it !== item);
							}
						}}
						type="checkbox"
						name=""
						id=""
					/>
					<p>{item}</p>
				</div>
			{/each}
			<p class="term">Mid Term</p>
			{#each form.groq['midTerm'] as item}
				<div class="flex flex-row">
					<input
						on:change={(e) => {
							if (e.target.checked) {
								if (!checklistStates.includes(item)) checklistStates.push(item);
							} else {
								checklistStates = checklistStates.filter((it) => it !== item);
							}
						}}
						type="checkbox"
						name=""
						id=""
					/>
					<p>{item}</p>
				</div>
			{/each}
			<p class="term">Long Term</p>
			{#each form.groq['longTerm'] as item}
				<div class="flex flex-row">
					<input
						on:change={(e) => {
							if (e.target.checked) {
								if (!checklistStates.includes(item)) checklistStates.push(item);
							} else {
								checklistStates = checklistStates.filter((it) => it !== item);
							}
						}}
						type="checkbox"
						name=""
						id=""
					/>
					<p>{item}</p>
				</div>
			{/each}
		</div>
	{/if}
	<div>
		<form
			use:enhance={({ formData }) => {
				formData.append('checklist', JSON.stringify(checklistStates));
				formData.append('initialPrompt', get(initialPrompt));

				formLoading = true;

				checklistStates = [];

				return ({ update }) => {
					update({ invalidateAll: true }).finally(async () => {
						formLoading = false;
					});
				};
			}}
			action="?/regenerateList"
			method="post"
		>
			<button class="twbtn">Regenerate</button>
		</form>
	</div>
</div>

<footer class="p-4 bg-primary mt-auto">
	<a href="https://groq.com" target="_blank" rel="noopener noreferrer">
		<img class="bottom-0 h-16" id="groq-logo"
		  src="https://groq.com/wp-content/uploads/2024/03/PBG-mark1-color.svg"
		  alt="Powered by Groq for fast inference."
		/>
	  </a>
</footer>

<style lang="postcss">
	.twbtn {
		@apply rounded bg-primary px-4 py-2 font-bold text-white hover:bg-[#161616];
	}

	.twinput {
		@apply w-full appearance-none rounded border px-3 py-2 leading-tight text-gray-700 shadow focus:outline-none;
	}

	.check {
		@apply text-xl text-white;
	}

	.term {
		@apply text-xl;
	}
</style>
