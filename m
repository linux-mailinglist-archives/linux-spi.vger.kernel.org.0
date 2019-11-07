Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72E6F2EF7
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2019 14:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfKGNNx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Nov 2019 08:13:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39562 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388667AbfKGNNu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Nov 2019 08:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=DPvCSuAIpiPZSSt8bYUETNuluzO4Cudzsbas3/mrVGU=; b=W9sQB6ljMWbD
        RBNyKVugnHwAbz9beSB9aqUkTMtoamhf4Ktc3k+WH1guCLtexOOowGIx5bQ/6+LfEMMxK8cD8HCEv
        PB616R294RZcUqOIoqAtccjI5eGW6oPzEeTGwJiuea0x/DT1qEB0iNI77uI3X+BSdMptGH6xdJG4F
        AOvjU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iShbY-0004Nj-OJ; Thu, 07 Nov 2019 13:13:40 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3F28427431C3; Thu,  7 Nov 2019 13:13:40 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     bcm-kernel-feedback-list@broadcom.com, broonie@kernel.org,
        kdasu.kdev@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm-qspi: Convert to use CS GPIO descriptors" to the spi tree
In-Reply-To: <20191107044235.4864-2-chris.packham@alliedtelesis.co.nz>
X-Patchwork-Hint: ignore
Message-Id: <20191107131340.3F28427431C3@ypsilon.sirena.org.uk>
Date:   Thu,  7 Nov 2019 13:13:40 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: bcm-qspi: Convert to use CS GPIO descriptors

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

From 27fb2313f28d8c82adace68bf49f12fe810ba58c Mon Sep 17 00:00:00 2001
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Thu, 7 Nov 2019 17:42:34 +1300
Subject: [PATCH] spi: bcm-qspi: Convert to use CS GPIO descriptors

Set use_gpio_descriptors to true and avoid asserting the native chip
select if the spi core has done it for us.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Link: https://lore.kernel.org/r/20191107044235.4864-2-chris.packham@alliedtelesis.co.nz
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm-qspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 7a3531856491..85bad70f59e3 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -803,7 +803,8 @@ static int bcm_qspi_bspi_exec_mem_op(struct spi_device *spi,
 			return -EIO;
 
 	from = op->addr.val;
-	bcm_qspi_chip_select(qspi, spi->chip_select);
+	if (!spi->cs_gpiod)
+		bcm_qspi_chip_select(qspi, spi->chip_select);
 	bcm_qspi_write(qspi, MSPI, MSPI_WRITE_LOCK, 0);
 
 	/*
@@ -882,7 +883,8 @@ static int bcm_qspi_transfer_one(struct spi_master *master,
 	int slots;
 	unsigned long timeo = msecs_to_jiffies(100);
 
-	bcm_qspi_chip_select(qspi, spi->chip_select);
+	if (!spi->cs_gpiod)
+		bcm_qspi_chip_select(qspi, spi->chip_select);
 	qspi->trans_pos.trans = trans;
 	qspi->trans_pos.byte = 0;
 
@@ -1234,6 +1236,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	master->cleanup = bcm_qspi_cleanup;
 	master->dev.of_node = dev->of_node;
 	master->num_chipselect = NUM_CHIPSELECT;
+	master->use_gpio_descriptors = true;
 
 	qspi->big_endian = of_device_is_big_endian(dev->of_node);
 
-- 
2.20.1

