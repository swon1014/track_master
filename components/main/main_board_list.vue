<template>
<div class="col-lg-6" style="margin-top:20px">
	<div class="card shadow">
				<router-link :to="'/board_main/' + board_idx + '/1'" class="btn btn-primary" style="padding:50px; font-size:5rem;">{{server_data.board_info_name}}</router-link>
	</div>
</div>
</template>
<style>
	#board_list > tbody > tr {
		cursor: pointer;
	}
</style>
<script>
	module.exports = {
		data : function(){
			return {
				temp_list : [1, 2, 3, 4, 5],
				server_data : {}
			}
		},
		props : ['board_idx'],
		methods : {
			go_board_read : function(content_idx){
				this.$router.push('/board_read/' + this.board_idx + '/1/' + content_idx)		
			}
		},
		created () {
			var params = new URLSearchParams()
			params.append('board_idx', this.board_idx)
			
			axios.post('server/board/get_top5_list.jsp', params).then((response) => {
				this.server_data = response.data
			})
		}
	}
</script>







