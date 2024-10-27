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

					initialPrompt.update((n) => (n = promptInput));

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
			>
				<div class="flex flex-col">
					<input
						class="twinput focus:shadow-outline"
						bind:value={promptInput}
						placeholder="Enter career path"
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
	{/if}

	{#if form?.groq}
		<div class="flex w-3/4 flex-col gap-6 mt-8">
			<div
				class="flex flex-row items-center justify-center border-4 border-dotted border-[#ff13f0] bg-[#41fdfe]"
			>
				<div>
					<img class="w-40" src="/dancecat.gif" alt="Dancing cat" />
				</div>
				<div class="my-10 flex flex-col px-4">
					<p class="term font-serif">Short Term</p>
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
					<img class="w-40" src="/banana.gif" alt="Dancing banana" />
				</div>
			</div>
			<div class="bg-white">
				<div class="flex h-12 bg-[#4A0001] px-4">
					<p class="term self-center text-white">Medium Term</p>
				</div>
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
				</div>
			</div>

			<div>
				<div class="rounded-3xl bg-gray-700 p-4">
					<p class="font-futura pb-4 text-center text-3xl text-white">Long Term</p>
					<div class="flex flex-col gap-4">
						{#each form.groq['longTerm'] as item}
							<div class="bg-primary flex flex-row gap-2 rounded-full px-6 py-4">
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
								<p class="font-futura text-xl text-white">{item}</p>
							</div>
						{/each}
					</div>
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
