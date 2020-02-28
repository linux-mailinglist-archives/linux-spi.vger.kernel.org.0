Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA40017419A
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 22:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgB1VqS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Feb 2020 16:46:18 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:44499 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB1VqS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Feb 2020 16:46:18 -0500
Received: from localhost.localdomain ([92.140.213.100])
        by mwinf5d18 with ME
        id 8Mee220022AY1JL03MefEb; Fri, 28 Feb 2020 22:38:44 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Feb 2020 22:38:44 +0100
X-ME-IP: 92.140.213.100
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, jonas.gorski@gmail.com
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] spi: bcm63xx-hsspi: Really keep pll clk enabled
Date:   Fri, 28 Feb 2020 22:38:38 +0100
Message-Id: <20200228213838.7124-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The purpose of commit 0fd85869c2a9 ("spi/bcm63xx-hsspi: keep pll clk enabled")
was to keep the pll clk enabled through the lifetime of the device.

In order to do that, some 'clk_prepare_enable()'/'clk_disable_unprepare()'
calls have been added in the error handling path of the probe function, in
the remove function and in the suspend and resume functions.

However, a 'clk_disable_unprepare()' call has been unfortunately left in
the probe function. So the commit seems to be more or less a no-op.

Axe it now, so that the pll clk is left enabled through the lifetime of
the device, as described in the commit.

Fixes: 0fd85869c2a9 ("spi/bcm63xx-hsspi: keep pll clk enabled")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
To be honest, I don't see why we need to keep pll clk, or hsspi clk
enabled during the lifetime of the driver. My understanding of the code is
that it is only used to get the 'speed_hz' value in the probe function.
This value is never refreshed afterwards.
I don't see the point in enabling/disabling the clks. I think that they
both could be disabled in the probe function, without the need to keep
track in the bcm63xx_hsspi structure, neither during pm cycles or the
remove fucntion.

However, my knowledge on drivers is limited and I may be completly wrong :)
---
 drivers/spi/spi-bcm63xx-hsspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 7327309ea3d5..6c235306c0e4 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -366,7 +366,6 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 			goto out_disable_clk;
 
 		rate = clk_get_rate(pll_clk);
-		clk_disable_unprepare(pll_clk);
 		if (!rate) {
 			ret = -EINVAL;
 			goto out_disable_pll_clk;
-- 
2.20.1

