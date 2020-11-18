$(function() {

    $(document).on("click", '.js-edit-comment-button', function(e) {  // コメント編集ボタンクリック時のイベント、引数のfunction(e)？
        e.preventDefault(); // デフォルトの動作？を発生させない
        const commentId = $(this).data("comment-id")  // コメントIDを取得
        switchToEdit(commentId) // フォーム表示
    })

    $(document).on("click", '.js-button-edit-comment-cancel', function() {  // コメントキャンセルクリック時
        clearErrorMessages()  // エラーメッセージをクリア
        const commentId = $(this).data("comment-id")  // コメントIDを取得
        switchToLabel(commentId) // コメント表示
    })

    $(document).on("click", '.js-button-comment-update', function() { // コメント更新クリック時
        clearErrorMessages()  // エラーメッセージをクリア
        const commentId = $(this).data("comment-id")  // コメントIDを取得
        submitComment($("#js-textarea-comment-" + commentId).val(), commentId)  // フォームの送信　引数はURLの指定？
            .then(result => { // フォーム送信に成功した場合？
                $("#js-comment-" + result.comment.id).html(result.comment.body.replace(/\r?\n/g, '<br>')) // コメントを更新？
                switchToLabel(result.comment.id)  // コメント表示
            })
            .catch(result => {   // フォーム送信に失敗した場合？
                const commentId = result.responseJSON.comment.id  // コメントIDを取得
                const messages = result.responseJSON.errors.messages  // エラーメッセージを取得
                showErrorMessages(commentId, messages)  // エラーメッセージを表示
            })
    })

    function switchToLabel(commentId) { // コメント表示
        $("#js-textarea-comment-box-" + commentId).hide()
        $("#js-comment-" + commentId).show()
    }

    function switchToEdit(commentId) {  // フォーム表示
        $("#js-comment-" + commentId).hide()
        $("#js-textarea-comment-box-" + commentId).show()
    }

    function showErrorMessages(commentId, messages) { // エラーメッセージ表示
        $('<p class="error_messages text-danger">' + messages.join('<br>') + '</p>').insertBefore($("#js-textarea-comment-" + commentId))
    }

    function submitComment(body, commentId) { // コメント更新クリック時
        return new Promise(function(resolve, reject) {
debugger
            $.ajax({
                type: 'PATCH',
                url: '/comments/' + commentId,
                data: {
                    comment: {
                        body: body
                    }
                }
            }).done(function (result) {
                resolve(result)
            }).fail(function (result) {
                reject(result)
            });
        })
    }

    function clearErrorMessages() { // エラーメッセージクリア
        $("p.error_messages").remove()
    }
});

