Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3984182F46
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 12:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgCLLcJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 07:32:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47546 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLLcI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Mar 2020 07:32:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CBN1hc117160;
        Thu, 12 Mar 2020 11:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=TJzDJUWEmPBvm/C4lmLKTLoDU+nOfEOzfxoMUaGpdIs=;
 b=BX/6zlpHKN7/xCdywJXax3iTIQllXUevPrIc8fOuFZ/eex9JzgBP32sNI8WLaTNut8QV
 G8HMUm6FKX9ogHJV33uEwjCEJ6tjP1Y3gWEqE3RXkcuRQGBQDp56PS8zPZslxqXH+NYl
 WbatyAkI+mZEVtcPBMBhZZUc7LN0JBYdLPnsG0tMnuhiysgPHrquK+29OmSCh09NeY79
 0rgKw6mxMGl5VA3qQpuLhT8eFGIA7IqmymJ4iLupIKolr9yMjTX0GBRonufU1T9e+dQ3
 w1LDIyBF9fi4Hh0tjBZvPuYzdp/3ww18Kq1GhoMJ79NBPbVQUMky3Nr9ipf4i7pguAQc VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2yp9v6c4rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 11:32:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CBMIrq192999;
        Thu, 12 Mar 2020 11:32:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2yqkvmh4f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 11:32:01 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02CBW1bD002510;
        Thu, 12 Mar 2020 11:32:01 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 04:32:00 -0700
Date:   Thu, 12 Mar 2020 14:31:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yogesh Gaur <yogeshgaur.83@gmail.com>, Han Xu <han.xu@nxp.com>,
        Adam Ford <aford173@gmail.com>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: spi-nxp-fspi: Fix a NULL vs IS_ERR() check in probe
Message-ID: <20200312113154.GC20562@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120062
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The platform_get_resource_byname() function returns NULL on error, it
doesn't return error pointers.

Fixes: d166a73503ef ("spi: fspi: dynamically alloc AHB memory")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The commit message for commit d166a73503ef ("spi: fspi: dynamically
alloc AHB memory") is not very good.  Why is it necessary to allocate
the AHB memory dynamically instead of during probe?  Also I suspect that
Adam should have recieved authorship credit for that patch.

 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 019f40e2917c..1ccda82da206 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1019,8 +1019,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	/* find the resources - controller memory mapped space */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_mmap");
-	if (IS_ERR(res)) {
-		ret = PTR_ERR(res);
+	if (!res) {
+		ret = -ENODEV;
 		goto err_put_ctrl;
 	}
 
-- 
2.20.1

