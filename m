Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8CE1BD2B8
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 04:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgD2C6w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Apr 2020 22:58:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3377 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726507AbgD2C6v (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 Apr 2020 22:58:51 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C58BFA6554E70D350698;
        Wed, 29 Apr 2020 10:53:18 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 29 Apr 2020 10:53:12 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-spi@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] spi: spi-amd: Fix a NULL vs IS_ERR() check in amd_spi_probe()
Date:   Wed, 29 Apr 2020 02:54:26 +0000
Message-ID: <20200429025426.167664-1-weiyongjun1@huawei.com>
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

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: bbb336f39efc ("spi: spi-amd: Add AMD SPI controller driver support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/spi/spi-amd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 0d9debe1386e..d8e66689d132 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -266,10 +266,9 @@ static int amd_spi_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	amd_spi->io_remap_addr = devm_ioremap_resource(&pdev->dev, res);
-
-	if (!amd_spi->io_remap_addr) {
+	if (IS_ERR(amd_spi->io_remap_addr)) {
+		err = PTR_ERR(amd_spi->io_remap_addr);
 		dev_err(dev, "error %d ioremap of SPI registers failed\n", err);
-		err = -ENOMEM;
 		goto err_free_master;
 	}
 	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);



