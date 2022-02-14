Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80AD4B449C
	for <lists+linux-spi@lfdr.de>; Mon, 14 Feb 2022 09:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242245AbiBNIoO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Feb 2022 03:44:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbiBNIoM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Feb 2022 03:44:12 -0500
Received: from mail-m17664.qiye.163.com (mail-m17664.qiye.163.com [59.111.176.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FA55F8F3;
        Mon, 14 Feb 2022 00:44:04 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m17664.qiye.163.com (Hmail) with ESMTPA id 3DB14140362;
        Mon, 14 Feb 2022 16:44:02 +0800 (CST)
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shengfei Xu <xsf@rock-chips.com>,
        Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH v2 5/6] spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM ops
Date:   Mon, 14 Feb 2022 16:43:38 +0800
Message-Id: <20220214084339.18996-6-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214084339.18996-1-jon.lin@rock-chips.com>
References: <20220214084339.18996-1-jon.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRlNGklWHUlNGBhNTB0dSE
        wdVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MCI6PTo5Ej5DLBEhTj4PGRkz
        TRgaFB5VSlVKTU9PQ0lDSU9JTEhDVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
        QVlOQ1VJSVVMVUpKT1lXWQgBWUFISUpINwY+
X-HM-Tid: 0a7ef7673204da2fkuws3db14140362
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: shengfei Xu <xsf@rock-chips.com>

the wakeup interrupt handler which is guaranteed not to run while
@resume noirq() is being executed. the patch can help to avoid the
wakeup source try to access spi when the spi is in suspend mode.

Signed-off-by: shengfei Xu <xsf@rock-chips.com>
Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v2: None
Changes in v1: None

 drivers/spi/spi-rockchip.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 2628cf4e6f3d..fd6a1f9de119 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -961,14 +961,14 @@ static int rockchip_spi_suspend(struct device *dev)
 {
 	int ret;
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
 	ret = spi_controller_suspend(ctlr);
 	if (ret < 0)
 		return ret;
 
-	ret = pm_runtime_force_suspend(dev);
-	if (ret < 0)
-		return ret;
+	clk_disable_unprepare(rs->spiclk);
+	clk_disable_unprepare(rs->apb_pclk);
 
 	pinctrl_pm_select_sleep_state(dev);
 
@@ -983,10 +983,14 @@ static int rockchip_spi_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	ret = pm_runtime_force_resume(dev);
+	ret = clk_prepare_enable(rs->apb_pclk);
 	if (ret < 0)
 		return ret;
 
+	ret = clk_prepare_enable(rs->spiclk);
+	if (ret < 0)
+		clk_disable_unprepare(rs->apb_pclk);
+
 	ret = spi_controller_resume(ctlr);
 	if (ret < 0) {
 		clk_disable_unprepare(rs->spiclk);
@@ -1028,7 +1032,7 @@ static int rockchip_spi_runtime_resume(struct device *dev)
 #endif /* CONFIG_PM */
 
 static const struct dev_pm_ops rockchip_spi_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(rockchip_spi_suspend, rockchip_spi_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_spi_suspend, rockchip_spi_resume)
 	SET_RUNTIME_PM_OPS(rockchip_spi_runtime_suspend,
 			   rockchip_spi_runtime_resume, NULL)
 };
-- 
2.17.1

