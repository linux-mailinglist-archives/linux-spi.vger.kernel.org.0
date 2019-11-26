Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C316109F8A
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2019 14:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfKZNus (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Nov 2019 08:50:48 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44636 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfKZNus (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Nov 2019 08:50:48 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQDiQ7C190618;
        Tue, 26 Nov 2019 13:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=waq964sTuStsGuSgtrYBJJhZiD4pBWm7PcUtgYb/5KU=;
 b=BG6dJa94zc03y9vnTdrxnT0XkIscZvVd7naORd2BlaRTDdyywlYZPBVkwCGHl7kj7tg1
 3d9UGDhqRq2dwRG1X3M9XTtKo49sASrXYV1l1j16aibdkI9EUdwQsf6Aq/NgyGbkxC0P
 uDhySI33guOJfQYTbeOw7t0FyJpHrdALcWJ25SRrS+D3lkhTFFc82IqchXiCjFPJRoG+
 MtRF73WBGkY22XVVKzk2nDxTfw+WwhgTlf0g0+NZa7TYilsD40mEnyxCFtQxxh3QaucO
 c1JNVjQ+ndftZajiM4kv5wq2LR4oFIJHZR0jcJrYvPodEjYE1oGAO6yLDALUxrBhtGLD BA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wevqq6w2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 13:50:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQDmGUI069902;
        Tue, 26 Nov 2019 13:50:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wgvha1jsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 13:50:37 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAQDoZKa006919;
        Tue, 26 Nov 2019 13:50:35 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Nov 2019 05:50:34 -0800
Date:   Tue, 26 Nov 2019 16:50:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>, kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: pic32: Add a comment in pic32_spi_dma_prep()
Message-ID: <20191126135025.mligekonmv2u6dcl@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a22ba950-f65b-b80e-948a-eddfa0a7d431@ti.com>
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911260124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911260124
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This code triggers a static checker warning about missed error codes.
It's slightly tricky that we fall back to PIO so let's silence the
checker and add a comment for anyone who is confused.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I won't feel offended at all if people don't think it's worth applying
this patch.

 drivers/spi/spi-pic32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 156961b4ca86..835380ab8bf2 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -633,8 +633,10 @@ static int pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
 		goto out_err;
 	}
 
-	if (pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE))
+	if (pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE)) {
+		ret = 0;  /* Fall back to PIO if DMA fails. */
 		goto out_err;
+	}
 
 	/* DMA chnls allocated and prepared */
 	set_bit(PIC32F_DMA_PREP, &pic32s->flags);
-- 
2.11.0

