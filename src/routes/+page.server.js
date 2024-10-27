import Groq from 'groq-sdk';
import fs from 'fs';
// import { PdfReader } from 'pdfreader';

const tokenCount = 8192;

const config = JSON.parse(fs.readFileSync('config.json', 'utf8'));

const groq = new Groq({ apiKey: config.GROQ_API_KEY });


export const _groqCall = async (career, checked) => {
	return groq.chat.completions.create({
		//
		// Required parameters
		response_format: {
			type: 'json_object'
		},
		//
		messages: [
			// Set an optional system message. This sets the behavior of the
			// assistant and can be used to provide specific instructions for
			// how it should behave throughout the conversation.
			{
				role: 'system',
				content:
					'You are a model designed to tell the user the future steps they should take in order to be more successful in their chosen career path. You will split up your advice into three categories: short term (1 - 2 years), mid term (3 - 5 years(, long term (5+ years). They will provide the career they want, and the level they are currently at.\nRespond in the form of a json file with three separate arrays, one for each category of advice. The arrays keys should be: shortTerm, midTerm, and longTerm.\nDo not include any information regarding the prompt, only the steps the user should take. Do not use any other keys in the json file then the ones provided.'
			},
			// Set a user message for the assistant to respond to.
			{
				role: 'user',
				content: career + ', ' + checked + 'level'
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
		max_tokens: tokenCount,

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

export const _groqRefresh = async (career, checked) => {
	console.log(csvExtract());
	return groq.chat.completions.create({
		//
		// Required parameters
		response_format: {
			type: 'json_object'
		},
		//
		messages: [
			// Set an optional system message. This sets the behavior of the
			// assistant and can be used to provide specific instructions for
			// how it should behave throughout the conversation.
			{
				role: 'system',
				content:
					'You are a model designed to tell the user the future steps they should take in order to be more successful in their chosen career path. You will split up your advice into three categories: short term (1 - 2 years), mid term (3 - 5 years(, long term (5+ years). They will provide the career they want, and previous pieces of advice they have completed.\nRespond in the form of a json file with three separate arrays, one for each category of advice. The arrays keys should be: shortTerm, midTerm, and longTerm.\nDo not include any information regarding the prompt, only the steps the user should take. Do not use any other keys in the json file then the ones provided. They arrays must only consist of string. Do not under any circumstances return arrays of anything other than strings. Each array should have at least four to five items.'
			},
			// Set a user message for the assistant to respond to.
			{
				role: 'user',
				content: career + ', completed: ' + checked
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
		max_tokens: tokenCount,

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

export const actions = {
	submitPrompt: async ({ request }) => {
		const data = await request.formData();
		const file = data.get('file');
		const promptInput = data.get('promptInput');
		const checked = data.get('checked');

		console.log(data);
		console.log(file);

		let response;

		let attempts = 10;
		while (attempts > 0) {
			try {
				response = await _groqCall(promptInput, checked);
				if (response.choices[0].message) break;
				attempts--;
			} catch (error) {
				console.log('groq excepted');
				attempts--;
			}
		}

		let message = response.choices[0].message.content;

		let jsonResponse = JSON.parse(message);

		//console.log(jsonResponse);

		return { success: true, groq: jsonResponse };
	},
	regenerateList: async ({ request }) => {
		const data = await request.formData();
		const checklist = data.get('checklist');
		const initialPrompt = data.get('initialPrompt');
		console.log(data);

		let response;

		let attempts = 5;
		while (attempts > 0) {
			try {
				response = await _groqRefresh(initialPrompt, checklist);
				console.log(response);
				break;
			} catch (error) {
				console.log('groq exception, trying again');
				attempts--;
			}
		}

		let message = response.choices[0].message.content;

		let jsonResponse = JSON.parse(message);

		console.log(jsonResponse);

		return { success: true, groq: jsonResponse };
	}
};
