Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3941F76EB1F
	for <lists+linux-spi@lfdr.de>; Thu,  3 Aug 2023 15:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjHCNtV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Aug 2023 09:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbjHCNtC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Aug 2023 09:49:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE3F10D
        for <linux-spi@vger.kernel.org>; Thu,  3 Aug 2023 06:48:37 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RGqpr4PKkzNmY8;
        Thu,  3 Aug 2023 21:45:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 21:48:34 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>
CC:     <lizetao1@huawei.com>, <linux-spi@vger.kernel.org>
Subject: [PATCH -next] spi: mpc5xxx-psc: Fix unsigned expression compared with zero
Date:   Thu, 3 Aug 2023 21:48:05 +0800
Message-ID: <20230803134805.1037251-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is two warnings reported by coccinelle:

./drivers/spi/spi-mpc512x-psc.c:493:5-13: WARNING:
	Unsigned expression compared with zero: mps -> irq     <     0
./drivers/spi/spi-mpc52xx-psc.c:332:5-13: WARNING:
	Unsigned expression compared with zero: mps -> irq     <     0

The commit "208ee586f862"
("spi: mpc5xxx-psc: Return immediately if IRQ resource is unavailable")
was to check whether the IRQ resource is unavailable. When the IRQ
resource is unavailable, an error code is returned, however, the type
of "mps->irq" is "unsigned int", causing the error code to flip. Modify
the type of "mps->irq" to solve this problem.

Fixes: 208ee586f862 ("spi: mpc5xxx-psc: Return immediately if IRQ resource is unavailable")
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/spi/spi-mpc512x-psc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 99aeef28a477..5cecca1bef02 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -53,7 +53,7 @@ struct mpc512x_psc_spi {
 	int type;
 	void __iomem *psc;
 	struct mpc512x_psc_fifo __iomem *fifo;
-	unsigned int irq;
+	int irq;
 	u8 bits_per_word;
 	u32 mclk_rate;
 
-- 
2.34.1

