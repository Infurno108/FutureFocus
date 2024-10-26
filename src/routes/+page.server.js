import Groq from 'groq-sdk';
import fs from 'fs';

const groq = new Groq({ apiKey: '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' });

export const _groqCall = async (carreer, checked) => {
	return groq.chat.completions.create({
		//
		// Required parameters
		//
		messages: [
			// Set an optional system message. This sets the behavior of the
			// assistant and can be used to provide specific instructions for
			// how it should behave throughout the conversation.
			{
				role: 'system',
				content:
					'You are a model designed to tell the user the future steps they should take in order to be more successful in their chosen career path. They will provide the career they want, and the level they are currently at.\nSplit up the steps into three categories short term (1 - 2 years), mid term (3 - 5 years), and long term (5+ years) in that order.\nBetween each step put a a •, and between each category put the character ★\nDo not include any information regarding the prompt, only the steps the user should take.'
			},
			// Set a user message for the assistant to respond to.
			{
				role: 'user',
				content: carreer + ', ' + checked + 'level'
			}
		],

		// The language model which will generate the completion.
		model: 'llama3-8b-8192',

		//
		// Optional parameters
		//

		// Controls randomness: lowering results in less random completions.
		// As the temperature approaches zero, the model will become deterministic
		// and repetitive.
		temperature: 1,

		// The maximum number of tokens to generate. Requests can use up to
		// 2048 tokens shared between prompt and completion.
		max_tokens: 1024,

		// Controls diversity via nucleus sampling: 0.5 means half of all
		// likelihood-weighted options are considered.
		top_p: 1,

		// A stop sequence is a predefined or user-specified text string that
		// signals an AI to stop generating content, ensuring its responses
		// remain focused and concise. Examples include punctuation marks and
		// markers like "[end]".
		stop: null,

		// If set, partial message deltas will be sent.
		stream: false
	});
};

function splitResponse(response) {}

export const actions = {
	submitPrompt: async ({ request }) => {
		const data = await request.formData();
		const promptInput = data.get('promptInput');
		const checked = data.get('checked');

		console.log(promptInput);
		console.log(checked);

		const response = await _groqCall(promptInput, checked);

		let message = response.choices[0].message.content;

		console.log(message);

		return { success: true, message: message };
	}
};
