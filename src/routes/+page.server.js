export const actions = {
    submitPrompt: async ({request}) => {
        const data = await request.formData();
        const promptInput = data.get('promptInput');
        const checked = data.get('checked');

        console.log(promptInput);
        console.log(checked);
    }
}