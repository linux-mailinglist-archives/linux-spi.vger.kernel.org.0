Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4803BE4FA
	for <lists+linux-spi@lfdr.de>; Wed,  7 Jul 2021 11:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhGGJEt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Jul 2021 05:04:49 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:49244 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhGGJEt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Jul 2021 05:04:49 -0400
Received: from localhost (unknown [192.168.167.172])
        by lucky1.263xmail.com (Postfix) with ESMTP id D4CD9CE15B;
        Wed,  7 Jul 2021 17:02:06 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31480T139654576531200S1625648523311486_;
        Wed, 07 Jul 2021 17:02:06 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <0db54b15c2befd4efd78e6b278b90bfd>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: linux-spi@vger.kernel.org
X-RCPT-COUNT: 20
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     linux-spi@vger.kernel.org
Cc:     jon.lin@rock-chips.com, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, macroalpha82@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v11 06/10] clk: rockchip: Add support for hclk_sfc on rk3036
Date:   Wed,  7 Jul 2021 17:01:54 +0800
Message-Id: <20210707090158.711-2-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707090158.711-1-jon.lin@rock-chips.com>
References: <20210707090027.32608-1-jon.lin@rock-chips.com>
 <20210707090158.711-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for the bus clock for the serial flash controller on the
rk3036. Taken from the Rockchip BSP kernel but not tested on real
hardware (as I lack a 3036 based SoC to test).

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---

Changes in v11: None
Changes in v10: None
Changes in v9:
- Separate FDT binding docs and includes from rk3036 sfc_hclk patch

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 drivers/clk/rockchip/clk-rk3036.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 1986856d94b2..828af715d92e 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -404,7 +404,7 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 	GATE(HCLK_OTG0, "hclk_otg0", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 13, GFLAGS),
 	GATE(HCLK_OTG1, "hclk_otg1", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(7), 3, GFLAGS),
 	GATE(HCLK_I2S, "hclk_i2s", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
-	GATE(0, "hclk_sfc", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 14, GFLAGS),
+	GATE(HCLK_SFC, "hclk_sfc", "hclk_peri", 0, RK2928_CLKGATE_CON(3), 14, GFLAGS),
 	GATE(HCLK_MAC, "hclk_mac", "hclk_peri", 0, RK2928_CLKGATE_CON(3), 5, GFLAGS),
 
 	/* pclk_peri gates */
-- 
2.17.1



