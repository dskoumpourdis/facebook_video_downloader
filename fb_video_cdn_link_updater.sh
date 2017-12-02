#!/usr/bin/php


<?php
define('FACEBOOK_SDK_V5_SRC_DIR', __DIR__ . '/home/dskoumpourdis/Desktop/Ptuxiaki/Facebook_scripts/Facebook');
require_once 'Facebook/autoload.php';

date_default_timezone_set("Europe/Athens");

$fb_page = file("facebook_pages.txt");
$fb_page = preg_replace("/[^a-zA-Z 0-9 \.]+/", "", $fb_page );

$page_number = count($fb_page,0);

$current_date = file_get_contents("current_date.txt", NULL, NULL, 0, 10);
echo "Today is " . $current_date . "\n";

$fb = new Facebook\Facebook([
  'app_id' => '1688509554780260',
  'app_secret' => '2f9e00a26feabfc00fe2569075393323',
  'default_access_token' => 'EAAXZCsMQ2aGQBALZBn0VTgUevZCBsiR8WGe3HMQHB4x7AsKMbgWVUFZBPAGC1mHKvSUgBYy7o6fMYy1bmFcBfSpPsTFyZAXGryvIWettcHNmMxMTU9pXJr0c9MN667ZCSZBDqr4ligXTxvtBnSsG3X3Ds1qPXvF6dl7UW6f2nppcGFf9UrdgZAg6DnlBxaQdZBNEtOuexGmUudgZDZD',
  'default_graph_version' => 'v2.8',
]);
# https://video.xx.fbcdn.net/v/t43.1792-2/18289097_1842262736099926_8647244011372806144_n.mp4?efg=eyJybHIiOjE2OTUsInJsYSI6MTQ1NiwidmVuY29kZV90YWciOiJzdmVfaGQifQ%3D%3D&rl=1695&vabr=1130&oh=f5b2af30dcedd43e401f38480d1042fc&oe=592FC364
# https://video.xx.fbcdn.net/v/t43.1792-2/18289097_1842262736099926_8647244011372806144_n.mp4?efg=eyJybHIiOjE2OTUsInJsYSI6MTQ1NiwidmVuY29kZV90YWciOiJzdmVfaGQifQ%3D%3D&rl=1695&vabr=1130&oh=5a844f91b273446371a446309209ad46&oe=59101F64
# $page_number-20
for($j=0; $j<$page_number; $j++){

    $fb_page_id = file("facebook_sampling/".$fb_page[$j]."/".$current_date."/fb_video_info/fb_video_ids.txt");
    $fb_page_id = preg_replace("/[^a-zA-Z 0-9 \.]+/", "", $fb_page_id );
    $page_number_id = count($fb_page_id,0);
    #$k=0;

    if(!file_exists('facebook_sampling/'.$fb_page[$j].'/'.$current_date.'/fb_video_info/fb_video_info.json'))
    {
        echo 'facebook_sampling/'.$fb_page[$j].'/'.$current_date.'/fb_video_info/fb_video_info.json does not exist. Exiting.'. "\n";
        exit;
    }

    if(file_exists('facebook_sampling/'.$fb_page[$j].'/'.$current_date.'/fb_video_info/fb_video_cdn_links.json')){
        echo "=====================" . "\n";
        echo "Removing old facebook_sampling/".$fb_page[$j].'/'.$current_date."/fb_video_info/fb_video_cdn_links.json" . "\n";
        echo "=====================" . "\n";
        echo "\n";
        unlink('facebook_sampling/'.$fb_page[$j].'/'.$current_date.'/fb_video_info/fb_video_cdn_links.json');
    }
	
	echo "Parsing page " . $fb_page[$j] . " " . $k++ . "\n";
	
    for($i=0; $i<$page_number_id; $i++){
        $request = $fb->request(
        'GET',
        '/'.$fb_page_id[$i],
        array(
            'fields' => 'created_time,length,permalink_url,source'
            )
        );

        try {
        $response = $fb->getClient()->sendRequest($request);
        }
            catch(Facebook\Exceptions\FacebookResponseException $e) {
            # When Graph returns an error
            echo 'Graph returned an error: ' . $e->getMessage() . "\n";
            # exit;
        } 
        catch(Facebook\Exceptions\FacebookSDKException $e)
        {
            # When validation fails or other local issues
            echo 'Facebook SDK returned an error: ' . $e->getMessage() . "\n";
            # exit;
        }        

        $graphEdge = $response->getGraphNode();
        # print_r($graphEdge);
        # echo $k++ . "\n";
        file_put_contents('facebook_sampling/'.$fb_page[$j].'/'.$current_date.'/fb_video_info/fb_video_cdn_links.json', $graphEdge->asJson(), FILE_APPEND);
    }
}
?>