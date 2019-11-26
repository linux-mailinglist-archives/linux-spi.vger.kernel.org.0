Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3869109DDC
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2019 13:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfKZMXl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Nov 2019 07:23:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34148 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbfKZMXk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Nov 2019 07:23:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQCMweY128458;
        Tue, 26 Nov 2019 12:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=AY5t6mCKu0v/D1wAnR9xbZnkTSmQoPfBlK1bQ69QfSM=;
 b=Rm0V0onp8IAlh4jFSXmMKT5Y7BPKP7atI6gKxIUGiwItdmi5ta5QYg4Nj+cFtCnySLG2
 cFar3XVP5dg/uKCe0fhKfcQko2Qe5UR7V+iCdQYNf4iewx0U3/GEuwhn/YgXtd9maeGq
 yJ/vTD3ZlCfb9FV9N0/EjARlkTk32t+LRl4nrCNav4V7eOQsonV/ZjnzO9yvQsDmCJm3
 rdtCtfX1RjG4EsUjcqk3SHUMg+eWh3Fgq2sas/DHBpufsdO7t8JKzEe1yQYwaBxneCJk
 3XXY3ugVg+INuTHtLuyNSpxI4mUGmpXiNZbL5uIuU9fo3rLQnink6plrymZjCdNWmoue Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wev6u6f2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 12:23:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQC8iSV033337;
        Tue, 26 Nov 2019 12:23:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wgvh9wnrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 12:23:32 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAQCNVHW002325;
        Tue, 26 Nov 2019 12:23:31 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Nov 2019 04:23:31 -0800
Date:   Tue, 26 Nov 2019 15:23:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: pic32: Fix an error code in pic32_spi_dma_prep()
Message-ID: <20191126122324.v3rj7oscvjobhjxo@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911260110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911260110
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We accidentally return success on this error path.

Fixes: eb7e6dc6d9ff ("spi: pic32: Retire dma_request_slave_channel_compat()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/spi/spi-pic32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 156961b4ca86..93fb95073522 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -633,7 +633,8 @@ static int pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
 		goto out_err;
 	}
 
-	if (pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE))
+	ret = pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE);
+	if (ret)
 		goto out_err;
 
 	/* DMA chnls allocated and prepared */
-- 
2.11.0

