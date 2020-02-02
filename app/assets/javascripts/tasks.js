$(function(){

  //トークンの取得 
  let csrfToken = function (){
    let metaDiscre = document.head.children;
    let metaLength = metaDiscre.length;
    let csrf_token = "";
    for(let i = 0;i < metaLength;i++){
      let proper = metaDiscre[i].getAttribute('name');
      if(proper === 'csrf-token'){
        csrf_token = metaDiscre[i].content;
      }
    };
    return csrf_token;
  }; 

  //親要素の削除
  function removePrentElement(element) {
    //親要素の削除
    $(element)
      .parent()
      .remove();
  }
  
  let group_id = function(elemnt) {
    return elemnt.attr('data-group-id');
  }
  let user_id = function(elemnt) {
    return elemnt.attr('data-user-id');
  }

  // // ajaxでdoneの場合の共通終了処理。
  // let resetmessageform = function (input, insertHTML, resetarea) {
  //   //メッセージが入ったHTMLに入れ物ごと追加して、一番下にスクロールする。
  //   $(input).append(insertHTML).animate({scrollTop: $(input)[0].scrollHeight});
  //   // メッセージテキスト、画像テキストの内容をクリアする。
  //   $(resetarea)[0].reset();
  // };

  // ajaxで無効化されたsendボタンを有効化する。
  let sendButtonActivate = function (button) {
    $(button).removeAttr('disabled');
  };

  // // 投稿メッセージhtml
  // let bodyHTML = function(message) {
  //   let html = `<p class="message__lower-info__text">${message.body}</p>`
  //   return html;
  // };

  // // 画像ファイルhtml
  // let imageHTML = function(message) {
  //   let html = `<img src="${message.image}" class="lower-message__image" alt="${message.imagename}">`
  //   return html;
  // };

  // // Message親要素
  // let parentMessageHTML = function(buildhtml) {
  //   let html = `<div class="message">${buildhtml}</div>`
  //   return html;
  // };

  // // Message子要素
  // let childMessageHTML = function(buildhtml, message) {
  //   //data-idが反映されるようにしている
  //   let html = `<div class="message" data-message-id=${message.id}>${buildhtml}</div>`
  //   return html;
  // };

  const task_form = $('#task_form');

  // タスク新規登録フォーム
  let resetnewform = function (url) {
    let cftkn  =  csrfToken();
    let deletebtn = $('#submit-btn__delete');
    console.log(url);
    console.log(cftkn);
    console.log(hdn);
    //formを新規登録用に配置する。
    task_form.attr({id: "new_task", action: url, method: "POST"});
    //formを新規登録用に配置する。
    removePrentElement(deletebtn);
  };

  let resetupdateform = function(url) {
    '<input name="_method" type="hidden" value="PATCH">'
  };

  // フォームにタスク削除ボタンを追加する
  let appendDeletebtn = function(url) {
  let html = `<a rel='nofollow' data-method='delete' href='${url}'>` +
                `<div class='submit-btn__delete'>Delete</div>` +
              `</a>`
    task_form.append(html);
  };

  //ユーザーリストの追加用HTMLの生成
  function newformHTML(element, url) {
    let html = `<div class='chat-group-user clearfix'>
                  <p class='chat-group-user__name'>${user_name}</p>
                  <div class='user-search-add chat-group-user__btn chat-group-user__btn--add' data-user-id='${user_id}' data-user-name='${user_name}'>追加</div>
                </div>`
    task_form.append(html);
  }

  // // 投稿メッセージのhtmlを生成する
  // let buildHTML = function(message) {
  //   // upper-infoの生成
  //   let upperhtml = `<div class="message__upper-info">`
  //                 + ` <p class="message__upper-info__talker">${message.user_name}</p>`
  //                 + ` <p class="message__upper-info__date">${message.created_at}</p>`
  //                 + `</div>`

  //   // lower-infoの生成
  //   let lowerhtml = ''
  //   if (message.body && message.image) {
  //     //メッセージと画像が両方あるhtml
  //     lowerhtml = bodyHTML(message) + imageHTML(message);
  //   } else if (message.body) {
  //     //メッセージのみのhtml
  //     lowerhtml = bodyHTML(message);
  //   } else if (message.image) {
  //     //画像のみのhtml
  //     lowerhtml = imageHTML(message);
  //   };
  //   lowerhtml = mainMassageHTML(lowerhtml);

  //   // メッセージ子要素htmlの生成
  //   let childhtml = childMessageHTML(upperhtml + lowerhtml, message);
  //   // メッセージ親要素htmlの生成
  //   let html = parentMessageHTML(childhtml);
  //   return html;
  // };
  $('#add_task').on('click', function() {
    let url = `/groups/${group_id($(this))}/tasks`
    //タスク登録フォームに切り替え
    resetnewform(url);
  });

  $('#new_task').on('submit', function(e){
    console.log('new_task');
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action');
    $.ajax({
      url: url,       //同期通信でいう『パス』
      type: 'POST',   //同期通信でいう『HTTPメソッド』
      data: formData, //取得したFormData  
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(task){
      // 通信成功時の処理
      // 投稿されたメッセージをjsonからhtmlに生成する。
      // let html = buildHTML(message);
      // // 生成したhtmlをmessages要素の最後に追加して、一番下にスクロールする。
      // // メッセージテキスト、画像テキストの内容をクリアする。
      // resetmessageform('.messages', html, '#new_message');
    })
    .fail(function () {
      // 通信失敗時の処理
      alert('ファイルの取得に失敗しました。');
    })
    .always(function () {
      // submitボタンを有効化する。
      sendButtonActivate('.submit-btn');
    });
  })
  // トークンの取得
  csrfToken();
});

