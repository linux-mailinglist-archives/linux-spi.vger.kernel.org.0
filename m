Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BDF3A28FF
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jun 2021 12:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFJKIb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Jun 2021 06:08:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41594 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhFJKIa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Jun 2021 06:08:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15AA6SiT109779;
        Thu, 10 Jun 2021 10:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=he5sUlsgcL67RQiw/vAJSwJ3WuJOhKch0yOfO5TTFX4=;
 b=xvDkS68zB5VG9wmZ+5HvFRSihYNt+9w9TD+nCIpbEvnY7Nd+P/WvLsEI9vpmTw9+VEvr
 xnIIeezYh///3bBgtWh7AVVRwGvQrBHbFnGC4reh6YpgvVWtTXD7lumIhNd/7oxTicYj
 Bq6zEXwMT1LzF1+QdRcVV4825JNgwyACkh35qCSE8hQrvkILfTHY8rNAHzxS62rIgTNU
 TjIfjjYsSe9eqsRrVLVQD692Q0onlx8F/B9yWosgk9cBLrcH7Q6UX3gwSkwLvbkD6+s1
 eTquo98XyRsjt1eWZUsEQGB/5uuFZx+1A5iFv4CYFp9UveSI/keLKMLkdFipmAx3yT8/ uA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3900psbkag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 10:06:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15AA5AGf011139;
        Thu, 10 Jun 2021 10:06:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 390k1su91v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 10:06:27 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15AA6Rrk013068;
        Thu, 10 Jun 2021 10:06:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 390k1su91h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 10:06:27 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15AA6P3j018803;
        Thu, 10 Jun 2021 10:06:25 GMT
Received: from mwanda (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jun 2021 03:06:25 -0700
Date:   Thu, 10 Jun 2021 13:06:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: hisi-kunpeng: Delete some dead code
Message-ID: <YMHkGcroJwaBd1av@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: RbEYhwkmzzGu1kDrtuhqomo8PuRCZUKh
X-Proofpoint-ORIG-GUID: RbEYhwkmzzGu1kDrtuhqomo8PuRCZUKh
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10010 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1011
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100066
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The debugfs_create_dir() function returns error pointers, it doesn't
return NULL.  But debugfs functions aren't supposed to be checked in
normal circumstancers where the driver doesn't dereference the pointer
itself.

Fixes: 2b2142f247eb ("spi: hisi-kunpeng: Add debugfs support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/spi/spi-hisi-kunpeng.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 58b823a16fc4..875f337a7836 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -167,8 +167,6 @@ static int hisi_spi_debugfs_init(struct hisi_spi *hs)
 
 	snprintf(name, 32, "hisi_spi%d", hs->bus_num);
 	hs->debugfs = debugfs_create_dir(name, NULL);
-	if (!hs->debugfs)
-		return -ENOMEM;
 
 	hs->regset.regs = hisi_spi_regs;
 	hs->regset.nregs = ARRAY_SIZE(hisi_spi_regs);
-- 
2.30.2

