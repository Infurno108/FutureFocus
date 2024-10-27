<script>
	import { applyAction, enhance } from '$app/forms';
	import { get } from 'svelte/store';
	import { initialPrompt } from '$lib/store.js';

	export let form;

	let promptInput = '';

	let beginnerChecked = true;
	let intermediateChecked = false;
	let professionalChecked = false;

	let checklistStates = [];

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

<div class="flex flex-row items-center">
	<img class="w-28" src="/favicon.png" alt="FutureFocus logo" />
	<p class="text-4xl">FutureFocus</p>
</div>

<div class="flex flex-col items-center gap-y-4">
	<div class="">
		<form
			use:enhance={({ formData }) => {
				formData.append('promptInput', promptInput);

				initialPrompt.update((n) => (n = promptInput));

				if (beginnerChecked) formData.append('checked', 'beginner');
				else if (intermediateChecked) formData.append('checked', 'intermediate');
				else formData.append('checked', 'professional');

				checklistStates = [];
			}}
			action="?/submitPrompt"
			method="post"
		>
			<div class="flex flex-col">
				<p>Enter prompt</p>
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
		<label for="">
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
		<label for="">
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
		<label for="">
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
			<p>Short Term</p>
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
			<p>Mid Term</p>
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
			<p>Long Term</p>
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
				checklistStates = [];
			}}
			action="?/regenerateList"
			method="post"
		>
			<button class="twbtn">Regenerate</button>
		</form>
	</div>
</div>

<style lang="postcss">
	.twbtn {
		@apply rounded bg-blue-500 px-4 py-2 font-bold text-white hover:bg-blue-700;
	}

	.twinput {
		@apply w-full appearance-none rounded border px-3 py-2 leading-tight text-gray-700 shadow focus:outline-none;
	}
</style>
