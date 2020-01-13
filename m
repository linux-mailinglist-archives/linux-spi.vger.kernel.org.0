Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2B9C139482
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2020 16:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgAMPNe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 10:13:34 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36044 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbgAMPNd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jan 2020 10:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ppr818tdebi0ZdaBDntiSTiKbFXycDBN/XtB4wtugXc=; b=J+dA8yLoo1OR
        APdJcYcXtV+ZGhRWZaVqyfUnbCJ/4OBfmB/tpwbUV+m165Kjt5Wmi915Ns7a0HwGA0x2S5M/TD2Vi
        283NKv98K3nX2J26nrQva3lwaNCSh8pY4OcekFDrMBQx2R7FOTcoIzZEdDbMa/9WwPs2iJ0SpQIEe
        fWw84=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ir1PE-0003O7-75; Mon, 13 Jan 2020 15:13:28 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id E595DD01965; Mon, 13 Jan 2020 15:13:27 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Applied "spi: spi-qcom-qspi: Use device managed memory for clk_bulk_data" to the spi tree
In-Reply-To: <20200108133948.1.I35ceb4db3ad8cfab78f7cd51494aeff4891339f5@changeid>
Message-Id: <applied-20200108133948.1.I35ceb4db3ad8cfab78f7cd51494aeff4891339f5@changeid>
X-Patchwork-Hint: ignore
Date:   Mon, 13 Jan 2020 15:13:27 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-qcom-qspi: Use device managed memory for clk_bulk_data

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

From b8d40d7712f10475effc4552eda96b9d44822cfb Mon Sep 17 00:00:00 2001
From: Matthias Kaehlcke <mka@chromium.org>
Date: Wed, 8 Jan 2020 13:40:32 -0800
Subject: [PATCH] spi: spi-qcom-qspi: Use device managed memory for
 clk_bulk_data

Currrently the memory for the clk_bulk_data of the QSPI controller
is allocated with spi_alloc_master(). The bulk data pointer is passed
to devm_clk_bulk_get() which saves it in clk_bulk_devres->clks. When
the device is removed later devm_clk_bulk_release() is called and
uses the bulk data referenced by the pointer to release the clocks.
For this driver this results in accessing memory that has already
been freed, since the memory allocated with spi_alloc_master() is
released by spi_controller_release(), which is called before the
managed resources are released.

Use device managed memory for the clock bulk data to fix the issue
described above.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20200108133948.1.I35ceb4db3ad8cfab78f7cd51494aeff4891339f5@changeid
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qcom-qspi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 250fd60e1678..3c4f83bf7084 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -137,7 +137,7 @@ enum qspi_clocks {
 struct qcom_qspi {
 	void __iomem *base;
 	struct device *dev;
-	struct clk_bulk_data clks[QSPI_NUM_CLKS];
+	struct clk_bulk_data *clks;
 	struct qspi_xfer xfer;
 	/* Lock to protect xfer and IRQ accessed registers */
 	spinlock_t lock;
@@ -445,6 +445,13 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		goto exit_probe_master_put;
 	}
 
+	ctrl->clks = devm_kcalloc(dev, QSPI_NUM_CLKS,
+				  sizeof(*ctrl->clks), GFP_KERNEL);
+	if (!ctrl->clks) {
+		ret = -ENOMEM;
+		goto exit_probe_master_put;
+	}
+
 	ctrl->clks[QSPI_CLK_CORE].id = "core";
 	ctrl->clks[QSPI_CLK_IFACE].id = "iface";
 	ret = devm_clk_bulk_get(dev, QSPI_NUM_CLKS, ctrl->clks);
-- 
2.20.1

