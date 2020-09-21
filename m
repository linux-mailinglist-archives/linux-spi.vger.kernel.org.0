Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03982724BD
	for <lists+linux-spi@lfdr.de>; Mon, 21 Sep 2020 15:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgIUNKz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Sep 2020 09:10:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13808 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbgIUNKx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:53 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EAFC137D5C4A578F6FB8;
        Mon, 21 Sep 2020 21:10:51 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:10:42 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     <openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] spi: npcm-fiu: simplify the return expression of npcm_fiu_probe()
Date:   Mon, 21 Sep 2020 21:11:06 +0800
Message-ID: <20200921131106.93228-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/spi/spi-npcm-fiu.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 9468e71f0..341f7cffe 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -677,7 +677,6 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 	struct npcm_fiu_spi *fiu;
 	void __iomem *regbase;
 	struct resource *res;
-	int ret;
 	int id;
 
 	ctrl = spi_alloc_master(dev, sizeof(*fiu));
@@ -736,11 +735,7 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 	ctrl->num_chipselect = fiu->info->max_cs;
 	ctrl->dev.of_node = dev->of_node;
 
-	ret = devm_spi_register_master(dev, ctrl);
-	if (ret)
-		return ret;
-
-	return 0;
+	return devm_spi_register_master(dev, ctrl);
 }
 
 static int npcm_fiu_remove(struct platform_device *pdev)
-- 
2.23.0

