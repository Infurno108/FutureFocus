<script>
	import { applyAction, enhance } from '$app/forms';
	import { get } from 'svelte/store';
	import { initialPrompt } from '$lib/store.js';
	import { initialFile } from '$lib/store.js';
	import { onMount } from 'svelte';
	export let form;

	let promptInput = '';
	let file ='';

	let beginnerChecked = true;
	let intermediateChecked = false;
	let professionalChecked = false;

	let checklistStates = [];

	let showInput = true;

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

<div class="bg-primary flex h-24 flex-row items-center">
	<img class="mx-2 w-20" src="/icon.png" alt="FutureFocus logo" />
	<p class=" mx-4 text-4xl text-white">FutureFocus</p>
</div>

<div class="flex flex-col items-center gap-y-4">
	{#if formLoading}
		<p>Loading...</p>
	{/if}

	{#if showInput}
		<div class="p-4">
			<form
				use:enhance={({ formData }) => {
					formData.append('promptInput', promptInput);
					formData.append('file', file);

					initialPrompt.update((n) => (n = promptInput));
					initialFile.update((n) => (n = file));

					if (beginnerChecked) formData.append('checked', 'beginner');
					else if (intermediateChecked) formData.append('checked', 'intermediate');
					else formData.append('checked', 'professional');

					formLoading = true;

					showInput = false;

					checklistStates = [];

					return ({ update }) => {
						update({ invalidateAll: true }).finally(async () => {
							formLoading = false;
						});
					};
				}}
				action="?/submitPrompt"
				method="post"
				enctype="multipart/form-data"
			>
				<div class="flex flex-col">
					<input
						class="twinput focus:shadow-outline"
						bind:value={promptInput}
						placeholder="Enter career path"
						type="text"
						required
					/>
					<input
						type="file"
						name="file"
						id="file"
						accept="application/pdf"
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
	{/if}

	{#if form?.groq}
		<div class="flex w-full flex-col mt-8">
			<div
				class="flex: 1 0 100% flex-row items-center justify-center border-4 border-dotted border-[blue] bg-[black]  w-full h-250 text-white">
				<div class="flex flex-rows justify-between">
					<img class="w-40 display-flex" src="/banana.gif" alt="Dancing banana" />
					<img class="w-40" src="/dancecat.gif" alt="Dancing cat" />
				</div>
				<div class="my-10 flex flex-col px-4">
					<h1 class="term font-serif">Short Term (1 - 2 Years)</h1>
					<div>
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
								<p class="font-serif">{item}</p>
							</div>
						{/each}
					</div>
				</div>
				<div>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
				</div>
			</div>
			<div class="bg-white">
				<div class="flex h-16 bg-[#4A0001] px-4">
					<p class="term self-center text-white">Medium Term (3 - 5 Years)</p>
				</div>
				<br>
				<div class="my-8 flex flex-col gap-1 px-4">
					{#each form.groq['midTerm'] as item}
						<div class="my-1 flex flex-row">
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
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
				</div>
			</div>

			<div>
				<div class="rounded-3xl from-white bg-gradient-to-r from-slate-500 to-slate-700 p-4">
					<p class="font-futura pb-4 text-center h-20 text-3xl text-white">Long Term (5+ Years)</p>
					<div class="flex flex-col gap-4">
						{#each form.groq['longTerm'] as item}
							<div class="bg-opacity-65 hover:bg-opacity-100 bg-slate-800 flex flex-row gap-2 rounded-full px-6 py-4">
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
									id="teal-checkbox"
								/>
								<p class="font-futura text-xl text-white">{item}</p>
							</div>
						{/each}
					</div>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
				</div>
			</div>
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
			<button class="twbtn mb-4">Regenerate</button>
		</form>
	</div>
</div>

<footer class="bg-primary mt-auto p-4">
	<a href="https://groq.com" target="_blank" rel="noopener noreferrer">
		<img
			class="bottom-0 h-16"
			id="groq-logo"
			src="https://groq.com/wp-content/uploads/2024/03/PBG-mark1-color.svg"
			alt="Powered by Groq for fast inference."
		/>
	</a>
</footer>

<style lang="postcss">
	.twbtn {
		@apply bg-primary rounded px-4 py-2 font-bold text-white hover:bg-[#161616];
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
