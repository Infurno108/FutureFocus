<script>
	import { enhance } from '$app/forms';

	export let form;

	/**
	 * @type {any}
	 */
	let promptInput = '';
	let selectedCheckbox = '';

	let beginnerChecked = false,
		intermediateChecked = false,
		professionalChecked = false;

	/**
	 * @param {string} checkbox
	 */
	function checkboxChanged(checkbox) {
		if (checkbox == 'beginner') {
			beginnerChecked = true;
			intermediateChecked = false;
			professionalChecked = false;
		} else if (checkbox == 'intermediate') {
			beginnerChecked = false;
			intermediateChecked = true;
			professionalChecked = false;
		} else if (checkbox == 'professional') {
			beginnerChecked = false;
			intermediateChecked = false;
			professionalChecked = true;
		}
	}
</script>

<div>
	<!-- Header -->
	<div class="flex flex-row items-center">
		<img class="w-28" src="/favicon.png" alt="FutureFocus logo" />
		<p class="text-6xl">FutureFocus</p>
	</div>
	<!-- Main page content -->
	<div class="grid justify-center justify-items-center gap-4">
		<!-- Prompt input -->
		<div>
			<form
				use:enhance={({ formData }) => {
					formData.append('promptInput', promptInput);

					if (beginnerChecked) formData.append('checked', 'beginner');
					else if (intermediateChecked) formData.append('checked', 'intermediate');
					else if (professionalChecked) formData.append('checked', 'professional');
				}}
				id="submitPromptForm"
				action="?/submitPrompt"
				method="post"
			>
				<label for="promptInput"> </label>
				<input
					bind:value={promptInput}
					class="twinput focus:shadow-outline"
					id="promptInput"
					placeholder="i just lost my dawg"
					type="text"
				/>
			</form>
		</div>
		<!-- Checkboxes -->
		<div class="grid">
			<div>
				<input
					on:change={() => {
						checkboxChanged('beginner');
					}}
					checked={beginnerChecked}
					type="checkbox"
					name="beginner"
					id="beginner"
				/>
				<label class="text-2xl" for="beginner">Beginner</label>
			</div>
			<div>
				<input
					on:change={() => {
						checkboxChanged('intermediate');
					}}
					checked={intermediateChecked}
					type="checkbox"
					name="intermediate"
					id="intermediate"
				/>
				<label class="text-2xl" for="intermediate">Intermediate</label>
			</div>
			<div>
				<input
					on:change={() => {
						checkboxChanged('professional');
					}}
					checked={professionalChecked}
					type="checkbox"
					name="professional"
					id="professional"
				/>
				<label class="text-2xl" for="professional">Professional</label>
			</div>
		</div>
		<!-- Submit button -->
		<div>
			<button class="twbutton" type="submit" form="submitPromptForm">Generate</button>
		</div>
	</div>

	{#if form?.success}
		<p>{form?.message}</p>
	{/if}
</div>

<style lang="postcss">
	.twinput {
		@apply w-full appearance-none rounded border px-3 py-2 leading-tight text-gray-700 shadow focus:outline-none;
	}

	.twbutton {
		@apply rounded bg-blue-500 px-4 py-2 font-bold text-white hover:bg-blue-700;
	}
</style>
