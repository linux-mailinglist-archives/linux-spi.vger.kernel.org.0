Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23345784F42
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 05:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjHWDdi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 23:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjHWDdi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 23:33:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C5BE4A
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 20:33:35 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RVsGD1j7qz1L9FV;
        Wed, 23 Aug 2023 11:32:04 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 11:33:33 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 11:33:32 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 01/21] spi: lm70llp: switch to use modern name
Date:   Wed, 23 Aug 2023 11:29:43 +0800
Message-ID: <20230823033003.3407403-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823033003.3407403-1-yangyingliang@huawei.com>
References: <20230823033003.3407403-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-lm70llp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index ead0507c63be..e6a65b5c8c31 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -24,7 +24,7 @@
  * the SPI/Microwire bus interface. This driver specifically supports an
  * NS LM70 LLP Evaluation Board, interfacing to a PC using its parallel
  * port to bitbang an SPI-parport bridge.  Accordingly, this is an SPI
- * master controller driver.  The hwmon/lm70 driver is a "SPI protocol
+ * host controller driver.  The hwmon/lm70 driver is a "SPI protocol
  * driver", layered on top of this one and usable without the lm70llp.
  *
  * Datasheet and Schematic:
@@ -189,7 +189,7 @@ static void spi_lm70llp_attach(struct parport *p)
 {
 	struct pardevice	*pd;
 	struct spi_lm70llp	*pp;
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	int			status;
 	struct pardev_cb	lm70llp_cb;
 
@@ -202,17 +202,17 @@ static void spi_lm70llp_attach(struct parport *p)
 	 * the lm70 driver could verify it, reading the manf ID.
 	 */
 
-	master = spi_alloc_master(p->physport->dev, sizeof(*pp));
-	if (!master) {
+	host = spi_alloc_host(p->physport->dev, sizeof(*pp));
+	if (!host) {
 		status = -ENOMEM;
 		goto out_fail;
 	}
-	pp = spi_master_get_devdata(master);
+	pp = spi_controller_get_devdata(host);
 
 	/*
 	 * SPI and bitbang hookup.
 	 */
-	pp->bitbang.master = master;
+	pp->bitbang.master = host;
 	pp->bitbang.chipselect = lm70_chipselect;
 	pp->bitbang.txrx_word[SPI_MODE_0] = lm70_txrx;
 	pp->bitbang.flags = SPI_3WIRE;
@@ -228,7 +228,7 @@ static void spi_lm70llp_attach(struct parport *p)
 
 	if (!pd) {
 		status = -ENOMEM;
-		goto out_free_master;
+		goto out_free_host;
 	}
 	pp->pd = pd;
 
@@ -287,8 +287,8 @@ static void spi_lm70llp_attach(struct parport *p)
 	parport_release(pp->pd);
 out_parport_unreg:
 	parport_unregister_device(pd);
-out_free_master:
-	spi_master_put(master);
+out_free_host:
+	spi_controller_put(host);
 out_fail:
 	pr_info("spi_lm70llp probe fail, status %d\n", status);
 }
@@ -309,7 +309,7 @@ static void spi_lm70llp_detach(struct parport *p)
 	parport_release(pp->pd);
 	parport_unregister_device(pp->pd);
 
-	spi_master_put(pp->bitbang.master);
+	spi_controller_put(pp->bitbang.master);
 
 	lm70llp = NULL;
 }
-- 
2.25.1

