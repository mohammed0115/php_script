#!/usr/bin/env php
<?php

# Fill our vars and run on cli
# $ php -f db-connect-test.php

$dbname = 'script';
$dbuser = 'snso';
$dbpass = 'snso';
$dbhost = '192.168.1.39';
$baseUrl ='https://a2zpins.com/api/v1.0/';
function DoRequest($url,$param,$method)
{
   echo "url ==>".$url."\n";
    $curl = curl_init();

    curl_setopt_array($curl, array(
      CURLOPT_URL => $url,
      CURLOPT_RETURNTRANSFER => true,
      CURLOPT_ENCODING => '',
      CURLOPT_MAXREDIRS => 10,
      CURLOPT_TIMEOUT => 0,
      CURLOPT_FOLLOWLOCATION => true,
      CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
      CURLOPT_CUSTOMREQUEST => $method,
      CURLOPT_POSTFIELDS => $param,
      CURLOPT_HTTPHEADER => array(
        'Authorization: Basic YWxpa2hhbGlkQHN1bWVyLmNhc2g6YzZhNWZjZWUxYjU3ODFlYzhmNTk4YjFhNmU5MDFmZDI2MTdjOTU5Yg=='
      ),
    ));

  $response = curl_exec($curl);
  curl_close($curl);
  return $response;

}
function CreateProductOrder($conn,$url,$subcategory,$product_sku,$product_qty)
{
  $response = DoRequest($url.'order/',array('product_sku' => $product_sku,'product_qty' => $product_qty),'POST');
  $response = json_decode($response, true);
  if($response['code']==200)
  {
      if ( ((int)$response['data']['order_status'])==1)
      {
        foreach($response['data']['cards'] as $res)
        {
          InsertOrdered($conn,$res['giftcard_code'],$subcategory,$res['giftcard_serial']);
        }
        echo $subcategory." order is completed  \n";

      }
      else
      {  
        #  echo $SubCategory." is ".(($response['data']['order_status'])==0?"new order":($response['data']['order_status'])==2?"Order inProccessing":"Order Rejected")."  \n";
         if(((int)$response['data']['order_status']) == 2)
           {  
              echo $subcategory." is Order inProccessing\n";
              InsertOrder($conn,$res['order_reference'],$product_sku,$product_qty,0);
           }
           else if(((int)$response['data']['order_status']) == 0)
           {
             echo $subcategory." is new order\n";

           }
           else
           {
             echo $subcategory." is Order Rejected\n";

           }


      }
  }
  return $response;
}
function InsertOrder($conn,$reference,$product_sku,$order_qty,$status)
{
  $d = new DateTime('now');
  $d->setTimezone(new DateTimeZone('UTC'));
  $sql = "INSERT INTO `check_order` (`id`, `reference`, `product_sku`, `order_qty`, `status`, `order_date`)
  VALUES (NULL, '".$reference."', '".$product_sku."','".$order_qty."', '".$status."', '".$d->format('Y-m-d H:i:s')."')";

    if ($conn->query($sql) === true) {
      echo "New record created successfully for subcategory = ".$product_sku ."\n";
    } else {
      echo "Error: " . $sql . "<br>" . $conn->error."\n";
    }

}
function UpdateOrder($conn,$id)
{
  $query ="UPDATE `check_order` SET `status`=1 WHERE `id` =".$id;
  if ($conn->query($query) === true) {
      echo "updated successfully for pending create order \n";
    } else {
      echo "Error: " . $query . "<br>" . $conn->error."\n";
    }
}
function InsertOrdered($conn,$key,$subcategory,$serial)
{
  $d = new DateTime('now');
  $d->setTimezone(new DateTimeZone('UTC'));
  $myserial=$serial==false?'NULL':'".$serial."';
  $sql = "INSERT INTO `Card` (`id`, `key`, `state`, `createdAt`, `subcategory`, `serial`) 

  VALUES (NULL, '".$key."', 'Available', '".$d->format('Y-m-d H:i:s')."', $subcategory, '".$myserial."')";

    if (($result = $conn->query($sql)) !== FALSE) {
      echo "New record created successfully for subcategory = ".$subcategory."\n";
    } else {
      echo "Error: " . $sql . "<br>" . $conn->error;
    }

    
}
function GetProductAvailable($url,$product_sku,$product_qty)
{
  $response = DoRequest($url.'availability/',array('product_sku' => $product_sku,'product_qty' => $product_qty),'POST');
  $response = json_decode($response, true);
  return ($response['code'] == 200);
}
function GetProductDetails($url,$reference)
{
  $response = DoRequest($url.'order/details/'.$reference,array(),'GET');
  $response = json_decode($response, true);
  return $response;
}
function GetProductList($url)
{
    $response = DoRequest($url.'catalogs/',array(),'GET');
    return $response;
}
function Connect($dbhost, $dbuser, $dbpass)
{
  $link = mysqli_connect($dbhost, $dbuser, $dbpass) or die("Unable to Connect to '$dbhost'");
  return $link;
}
function useDB($link, $dbname)
{
  mysqli_select_db($link, $dbname) or die("Could not open the db '$dbname'");
  return true;
}
function getVailableCard($link, $query)
{
  $result = $link->query($query);
  return $result;
}
function getQty($link, $query)
{
  $result = $link->query("SELECT * FROM `quantity_need` ORDER BY `id` DESC");
  $tbl = $result->fetch_assoc();
  return $tbl['qty'];
}
function CheckProduct_sku($baseUrl,$sku)
{
  echo "search sku =".$sku."\n";
  $exists = false;
  $data= json_decode(GetProductList($baseUrl), true);
  foreach($data['data'] as $list)
  {
      # echo $list['catalog_id']."\n";
    if(array_key_exists('product_list', $list)) 
      {
        foreach($list['product_list'] as $product)
        {
        
          echo "sku =".$product['product_sku']."\n";;
          if(((int)$product['product_sku']) == $sku)
            {
              
              $exists =true;
              break;
             
            }

        }
        if ($exists)
           break;

      }
      
    }
    return $exists;

}
function updateCurrentList($link,$baseUrl)
{
      /**
        البحث في قاعدة البيانات كل المنتجات التي هي حالتها 
        -available-
          ولها 
          sku 
          عرض الكميه المتاحه 
          عرض الطلبيات
          عرض product_sku

      */
      $query="SELECT count(*) as available,`Category`.`order`, `Category`.`sku`,`SubCategory`.`id` FROM `Card` INNER JOIN `SubCategory` INNER JOIN `Category` ON `Card`.`subcategory` =`SubCategory`.`id` and `SubCategory`.`category`=`Category`.`id` and `Card`.`state`='Available' and `Category`.`sku`<> 0;";
      $availability = getVailableCard($link, $query);

      $qty =(int)getQty($link, $query);

      if ($availability->num_rows > 0) {

      while($row = $availability->fetch_assoc()) {
        /**
            هنا يتأكد المنتجات كميتها المتحاه اكثر من 5
            اذا اقل من خمسه نسدعي 
            API GetProductList
            بال product_sku
          المحدد
          اذا كان موجود في API
          نسدعي 
          API GetProductAvailable
          لتأكد ان الكميه متاحه اذا كانت  موجود
          نسدعي API
          CreateProductOrder
          لطلب المنتج المتاحه

          اذا عملية الطلبه ناجحه
          نضيف 

          giftcard_code من API 
          الي key في قاعدة البيانات
          وكذلك في api اسمها giftcard_serial
      في قاعدة البيانات اسمها serial

      اذا كان serial false ستضيف فقط key
        */
        $available =$row["available"];
        $order = $row["order"];
        $sku = $row["sku"];
        $subcategory = $row["id"];
        echo "qty=".$qty."\n";
        if ($available > $qty )
        {
          echo "is more than ".$qty."\n";
          continue;
        }
        else
        {
            echo "is less than ".$qty."\n";
            if( CheckProduct_sku($baseUrl,$sku))
            {
                  echo "sku is founded  \n";
                
                if(GetProductAvailable($baseUrl,$sku,$order))
                {
                  echo "is available on API  \n";
                  echo "select subcategory ".$subcategory."\n";
                  CreateProductOrder($link,$baseUrl,$subcategory,$sku,$order);
                  
                }
                else
                {
                    echo "is not available on API  \n";
                  continue;
                }

              
            }
            else
            {
                echo "sku is not  founded  \n";
              continue;
            }
        }
        

      }
      }
      else
      {
      echo "0 results empty tables";
      }
}
function CheckPending($link,$baseUrl)
{
    $query ="SELECT `check_order`.`id` as ref,`SubCategory`.`id`,`Category`.`sku`, `check_order`.`reference`, `check_order`.`order_qty` , 
    `check_order`.`status`, `check_order`.`order_date` FROM `SubCategory`,`Category`, `check_order` WHERE `SubCategory`.`category`=`Category`.`id`
     and `Category`.`sku` = `check_order`.`product_sku` and `check_order`.`status`=0 ";
    $result = $link->query($query);
    while ($row = $result->fetch_assoc())
    {
      echo " list all pending request to check is completed or not \n";
      $ref = $row['ref'];
      $SubCategory = $row['id'];
      $sku = $row['ref'];
      $reference = $row['reference'];
      $qty = $row['order_qty'];
      $date = $row['order_date'];
      $response = GetProductDetails($baseUrl,trim($reference));
    
      if (((int)$response['data']['order_status']) == 1)
      {
          echo $SubCategory." is completed  \n";
          foreach($response['data']['cards'] as $res)
          {
            InsertOrdered($link,$res['giftcard_code'],$SubCategory,$res['giftcard_serial']);
          }
          UpdateOrder($link,$ref);

      }
      else
      {
           if(((int)$response['data']['order_status']) == 2)
           {  

              echo $SubCategory." is Order inProccessing\n";
             
           }
           else if(((int)$response['data']['order_status']) == 0)
           {
             echo $SubCategory." is new order\n";

           }
           else
           {
             echo $SubCategory." is Order Rejected\n";

           }
          continue;
      }

    }
    

    
}
$link = Connect($dbhost, $dbuser, $dbpass);
useDB($link, $dbname);
CheckPending($link,$baseUrl);
updateCurrentList($link,$baseUrl);
$link->close();





?>
