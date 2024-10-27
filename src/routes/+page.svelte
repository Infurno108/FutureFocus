<script>
	import { applyAction, enhance } from '$app/forms';

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

<div>
	<div>
		<form
			use:enhance={({ formData }) => {
				formData.append('promptInput', promptInput);

				if (beginnerChecked) formData.append('checked', 'beginner');
				else if (intermediateChecked) formData.append('checked', 'intermediate');
				else formData.append('checked', 'professional');
			}}
			action="?/submitPrompt"
			method="post"
		>
			<label for="promptInput">
				Enter prompt
				<input
					bind:value={promptInput}
					placeholder="i just lost my dawg"
					type="text"
					name=""
					id=""
				/>
			</label>
			<button>Submit</button>
		</form>
	</div>

	<div>
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
	{/if}
	<div>
		<form
			use:enhance={({ formData }) => {
				formData.append('checklist', JSON.stringify(checklistStates));
				checklistStates = [];
			}}
			action="?/regenerateList"
			method="post"
		>
			<button>Regenerate</button>
		</form>
	</div>
</div>

<style lang="postcss">
	.twinput {
		@apply w-full appearance-none rounded border px-3 py-2 leading-tight text-gray-700 shadow focus:outline-none;
	}

	.twbutton {
		@apply rounded bg-blue-500 px-4 py-2 font-bold text-white hover:bg-blue-700;
	}
</style>
