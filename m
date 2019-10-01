Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 706C7C32F5
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 13:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbfJALlN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 07:41:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41148 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387624AbfJALlL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 07:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=5RlbHh8rwxXyihgE5xepVD66/5wBHu9kLeWwEiDJYwA=; b=TE4JDBjoZYIa
        i1yrmXy+PE+RydKV9Cjbr5NqQ3br+oIJBCKAVZEUAyOjymDjDenvTFo0eDk46hUZA2JydH3G1rm60
        8C79ByBRec/qcxntnaXrSbnvbMu8m20PtV+1mz0nrWYSf2pP6QPdT5LmS/Ull3lW6mAFFIfB2Xr5W
        /3BgU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWh-0004Z6-PG; Tue, 01 Oct 2019 11:41:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 44C832742A30; Tue,  1 Oct 2019 12:41:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw: Add compatible string for Renesas RZ/N1 SPI Controller" to the spi tree
In-Reply-To: <1568793876-9009-5-git-send-email-gareth.williams.jx@renesas.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114107.44C832742A30@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:41:07 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dw: Add compatible string for Renesas RZ/N1 SPI Controller

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

From 3ade3a37bdd77319dd7865228402cf1669c9b678 Mon Sep 17 00:00:00 2001
From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 18 Sep 2019 09:04:36 +0100
Subject: [PATCH] spi: dw: Add compatible string for Renesas RZ/N1 SPI
 Controller

The Renesas RZ/N1 SPI Controller is based on the Synopsys DW SSI, but has
additional registers for software CS control and DMA. This patch does not
address the changes required for DMA support, it simply adds the compatible
string. The CS registers are not needed as Linux can use gpios for the CS
signals.

Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Link: https://lore.kernel.org/r/1568793876-9009-5-git-send-email-gareth.williams.jx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index bd46fca3f094..b5ce8bd58d9e 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -223,6 +223,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_ocelot_init},
 	{ .compatible = "mscc,jaguar2-spi", .data = dw_spi_mscc_jaguar2_init},
 	{ .compatible = "amazon,alpine-dw-apb-ssi", .data = dw_spi_alpine_init},
+	{ .compatible = "renesas,rzn1-spi", },
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.20.1

