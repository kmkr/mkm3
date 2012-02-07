class mkm.helpers.TextileHelper
  settings:
    nameSpace:           "textile"
    previewParserPath:   "~/preview"
    onShiftEnter:
      keepDefault: false
      replaceWith: '\n\n'
    markupSet: [
        {name:'Heading 1', key:'1', openWith:'h1(!(([![Class]!]))!). ', placeHolder:'Insert heading...' }
        {name:'Heading 2', key:'2', openWith:'h2(!(([![Class]!]))!). ', placeHolder:'Insert heading...' }
        {name:'Heading 3', key:'3', openWith:'h3(!(([![Class]!]))!). ', placeHolder:'Insert heading...' }
        {name:'Heading 4', key:'4', openWith:'h4(!(([![Class]!]))!). ', placeHolder:'Insert heading...' }
        {name:'Heading 5', key:'5', openWith:'h5(!(([![Class]!]))!). ', placeHolder:'Insert heading...' }
        {name:'Heading 6', key:'6', openWith:'h6(!(([![Class]!]))!). ', placeHolder:'Insert heading...' }
        {name:'Paragraph', key:'P', openWith:'p(!(([![Class]!]))!). '}
        {separator:'---------------' }
        {name:'Bold', key:'B', closeWith:'*', openWith:'*'}
        {name:'Italic', key:'I', closeWith:'_', openWith:'_'}
        {name:'Strike through', key:'S', closeWith:'-', openWith:'-'}
        {separator:'---------------' }
        {name:'Bulleted list', openWith:'(!(* |!|*)!)'}
        {name:'Numeric list', openWith:'(!(# |!|#)!)'}
        {separator:'---------------' }
        {name:'Image', replaceWith:'![![Source:!:http://]!]([![Alternate text]!])!'}
        {name:'Link', openWith:'"', closeWith:'([![Title]!])":[![Link:!:http://]!]', placeHolder:'Link text here ...' }
        {separator:'---------------' }
        {name:'Quote', openWith:'bq(!(([![Class]!]))!). '}
        {name:'Code', openWith:'@', closeWith:'@'}
        {separator:'---------------' }
        {name:'Preview', call:'preview', className:'preview'}
    ]

