Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 660001593EA
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2020 16:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbgBKPvy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Feb 2020 10:51:54 -0500
Received: from foss.arm.com ([217.140.110.172]:48962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730657AbgBKPvx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 Feb 2020 10:51:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D1EA31B;
        Tue, 11 Feb 2020 07:51:53 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A73DF3F68E;
        Tue, 11 Feb 2020 07:51:52 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:51:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Etienne Carriere <etienne.carriere@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        christophe.kerello@st.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        patrice.chotard@st.com
Subject: Applied "spi: stm32-qspi: defer probe for reset controller" to the spi tree
In-Reply-To: <20200203135048.1299-2-patrice.chotard@st.com>
Message-Id: <applied-20200203135048.1299-2-patrice.chotard@st.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: stm32-qspi: defer probe for reset controller

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 8196f7bcc2adf21f83d82691d537fcef7abaa1c7 Mon Sep 17 00:00:00 2001
From: Etienne Carriere <etienne.carriere@st.com>
Date: Mon, 3 Feb 2020 14:50:47 +0100
Subject: [PATCH] spi: stm32-qspi: defer probe for reset controller

Changes stm32 QSPI driver to defer its probe operation when a reset
controller device have not yet probed but is registered in the
system.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Link: https://lore.kernel.org/r/20200203135048.1299-2-patrice.chotard@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32-qspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 4ef569b47aa6..13bb64bf4c8f 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -615,7 +615,11 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	}
 
 	rstc = devm_reset_control_get_exclusive(dev, NULL);
-	if (!IS_ERR(rstc)) {
+	if (IS_ERR(rstc)) {
+		ret = PTR_ERR(rstc);
+		if (ret == -EPROBE_DEFER)
+			goto err;
+	} else {
 		reset_control_assert(rstc);
 		udelay(2);
 		reset_control_deassert(rstc);
-- 
2.20.1

