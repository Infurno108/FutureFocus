<div>
	<div class="flex flex-row items-center">
		<img class="w-28" src="/favicon.png" alt="FutureFocus logo" />
		<p class="text-6xl">FutureFocus</p>
	</div>
	<div class="grid justify-center justify-items-center gap-4">
		<div>
			<form id="submitPromptForm" action="?/submitPrompt" method="post">
				<label for="">
					<input class="twinput focus:shadow-outline" placeholder="i just lost my dawg" type="text" />
				</label>
			</form>
		</div>
		<div class="grid">
			<div>
				<input type="checkbox" name="" id="" />
				<label class="text-2xl" for="">Beginner</label>
			</div>
			<div>
				<input type="checkbox" name="" id="" />
				<label class="text-2xl" for="">Intermediate</label>
			</div>
			<div>
				<input type="checkbox" name="" id="" />
				<label class="text-2xl" for="">Professional</label>
			</div>
		</div>
		<div>
			<button class="twbutton" type="submit" form="submitPromptForm">Generate</button>
		</div>
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
