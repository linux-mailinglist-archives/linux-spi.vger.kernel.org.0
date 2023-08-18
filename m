Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6F77808A4
	for <lists+linux-spi@lfdr.de>; Fri, 18 Aug 2023 11:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359255AbjHRJgA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Aug 2023 05:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359291AbjHRJf1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Aug 2023 05:35:27 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF4830E6
        for <linux-spi@vger.kernel.org>; Fri, 18 Aug 2023 02:35:25 -0700 (PDT)
Received: from dggpemm100014.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RRxX869szz1GFB2;
        Fri, 18 Aug 2023 17:34:00 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100014.china.huawei.com (7.185.36.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 17:35:23 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 17:35:23 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH -next v3 18/23] spi: sh-hspi: switch to use modern name
Date:   Fri, 18 Aug 2023 17:31:49 +0800
Message-ID: <20230818093154.1183529-19-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818093154.1183529-1-yangyingliang@huawei.com>
References: <20230818093154.1183529-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-hspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index d6ffeae66ed3..5d63aa1d28e2 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -82,7 +82,7 @@ static int hspi_status_check_timeout(struct hspi_priv *hspi, u32 mask, u32 val)
 }
 
 /*
- *		spi master function
+ *		spi host function
  */
 
 #define hspi_hw_cs_enable(hspi)		hspi_hw_cs_ctrl(hspi, 0)
@@ -224,7 +224,7 @@ static int hspi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(*hspi));
+	ctlr = spi_alloc_host(&pdev->dev, sizeof(*hspi));
 	if (!ctlr)
 		return -ENOMEM;
 
-- 
2.25.1

