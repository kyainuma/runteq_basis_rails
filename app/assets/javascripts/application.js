// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require_tree .

//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require jquery_ujs

// コメント編集エリア表示
// $(.js-edit-comment-button).on("click", function () {             // ① クリックイベント
$(function () {
  $(document).on("click", ".js-edit-comment-button", function () {  // ① クリックイベント
    const commentId = $(this).data('comment-id');                   // ② 一意のcomment.idを代入
    const commentLabelArea = $('#js-comment-label-' + commentId);   // ③ 一意のラベルを代入
    const commentTextArea = $('#js-textarea-comment-box-' + commentId); // ④ 一意のコメントエリアを代入
    //const commentButton = $('#js-comment-button-' + commentId);     // ⑤ 一意のボタンエリアを代入

    commentLabelArea.hide(); // ③ を非表示
    commentTextArea.show();  // ④ を表示
    //commentButton.show();    // ⑤ を表示
  });
});

// コメント編集エリア非表示
$(document).on("click", '.js-button-edit-comment-cancel', function() {
      const commentId = $(this).data("comment-id")
      const commentLabelArea = $("#js-comment-" + commentId)
      const commentTextArea = $("#js-textarea-comment-box-" + commentId)

      alert(commentTextArea.val())
      commentLabelArea.show()
      commentTextArea.hide()

});

// コメント更新ボタン
$(function () {
  $(document).on("click", ".js-button-comment-update", function () {
    const commentId = $(this).data('comment-id');
    const textField = $('#js-textarea-comment-' + commentId); // ①
    const body = textField.val();                             // ② textFieldの内容を取得
//const commentError = $('#js-comment-post-error-' + commentId);
  $.ajax({                         // ③ ajax関数
      url: '/comments/' + commentId, // ④ comments/updateアクションにリクエスト
      type: 'PATCH',                 // ⑤ HTTP通信の種類： updateアクションなので'PATCH'と記述
      data: {                        // ⑥ commentモデルのbodyカラムに変数bodyを格納
        comment: {
          body: body
        }
      }
    })
    .done(function (data) {        // ① ajax通信が成功した時の処理
      const commentLabelArea = $('#js-comment-label-' + commentId);
      const commentTextArea = $('#js-textarea-comment-box-' + commentId);
      //const commentButton = $('#js-comment-button-' + commentId);
      const commentError = $('#js-comment-post-error-' + commentId); // ②

      commentLabelArea.show();
      commentLabelArea.text(data.body);  // ③ データベースにupdateされたbodyのvalueが欲しい
      commentTextArea.hide();
      //commentButton.hide();
      commentError.hide();
    })
    .fail(function () {
      const commentError = $('#js-comment-post-error-' + commentId); //① コメントエラー用の空タグ
      commentError.text('コメントを入力してください');                       // ② 空タグにメッセージを書き換える
    })
  });
});

