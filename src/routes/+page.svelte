<div>
	<div class="flex flex-row items-center">
		<img class="w-28" src="/favicon.png" alt="FutureFocus logo" />
		<p class="text-6xl">FutureFocus</p>
	</div>
	<div class="grid justify-center justify-items-center gap-4">
		<div>
			<form
				class="mb-4 rounded bg-white px-8 pb-8 pt-6 shadow-md"
				action="?/submitPrompt"
				method="post"
			>
				<label for="">
					<input
						class="focus:shadow-outline w-full appearance-none rounded border px-3 py-2 leading-tight text-gray-700 shadow focus:outline-none"
						placeholder="i just lost my dawg"
						type="text"
					/>
				</label>
				<button
					class="focus:shadow-outline rounded bg-blue-500 px-4 py-2 font-bold text-white hover:bg-blue-700 focus:outline-none"
					>Submit</button
				>
			</form>
		</div>
		<div class="grid">
			<div>
				<input type="checkbox" name="" id="" />
				<label for="">Small</label>
			</div>
			<div>
				<input type="checkbox" name="" id="" />
				<label for="">Medium</label>
			</div>
			<div>
				<input type="checkbox" name="" id="" />
				<label for="">Large</label>
			</div>
		</div>
		<div>
			<form action="?/regenerateList" method="post">
				<button
					class="focus:shadow-outline rounded bg-blue-500 px-4 py-2 font-bold text-white hover:bg-blue-700 focus:outline-none"
					>Generate</button
				>
			</form>
		</div>
	</div>
</div>
