Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463A61B22F7
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 11:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDUJhk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 05:37:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2854 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726628AbgDUJhk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Apr 2020 05:37:40 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F1BEA917131797E39F2B;
        Tue, 21 Apr 2020 17:37:36 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Apr 2020 17:37:29 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>,
        Ashish Kumar <Ashish.Kumar@nxp.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-spi@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] spi: spi-fsl-qspi: Fix return value check in fsl_qspi_probe()
Date:   Tue, 21 Apr 2020 09:39:08 +0000
Message-ID: <20200421093908.48213-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In case of error, the function devm_ioremap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: 858e26a515c2 ("spi: spi-fsl-qspi: Reduce devm_ioremap size to 4 times AHB buffer size")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/spi/spi-fsl-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 83eb8a484faf..6766262d7e75 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -880,8 +880,8 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	/* Since there are 4 cs, map size required is 4 times ahb_buf_size */
 	q->ahb_addr = devm_ioremap(dev, q->memmap_phy,
 				   (q->devtype_data->ahb_buf_size * 4));
-	if (IS_ERR(q->ahb_addr)) {
-		ret = PTR_ERR(q->ahb_addr);
+	if (!q->ahb_addr) {
+		ret = -ENOMEM;
 		goto err_put_ctrl;
 	}



