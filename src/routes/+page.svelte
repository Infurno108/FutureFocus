<script>
	import { applyAction, enhance } from '$app/forms';
	import Groq from 'groq-sdk';

	export let form;

	let checklistStates = [];
</script>

<div>
	<div>
		<form action="?/submitPrompt" method="post">
			<label for="promptInput">
				Enter prompt
				<input placeholder="i just lost my dawg" type="text" name="promptInput" id="promptInput" />
			</label>
			<button>Submit</button>
		</form>
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
			use:enhance={({formData}) => {
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
