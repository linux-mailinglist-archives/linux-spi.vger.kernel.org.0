Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C65E884D61
	for <lists+linux-spi@lfdr.de>; Wed,  7 Aug 2019 15:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbfHGNdd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Aug 2019 09:33:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35380 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388342AbfHGNa7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Aug 2019 09:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3mT0qX6BJMb19WlpAQonUb3hiJi+k8YBab91Hj0vvho=; b=LhjsSrdJD78p
        CED+ljKGscLImtPr8cvKltrohbkNClfrC0SEY+UP0JVdNvM/j5+rbHsbi4p9e+yiqcFhdzCm0jD5w
        OzSBPn91Kh/M8VhSVnSP0RsnF5xa8+QCJTZf33sJJOa5jiXmATUaZnac/OIMwhkyg+elvg970I2x1
        J2W/w=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvM1o-0007hL-Fe; Wed, 07 Aug 2019 13:30:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D6BF32742BE8; Wed,  7 Aug 2019 14:30:55 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm-qspi: Fix BSPI QUAD and DUAL mode support when using flex mode" to the spi tree
In-Reply-To: <1565086070-28451-1-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Patchwork-Hint: ignore
Message-Id: <20190807133055.D6BF32742BE8@ypsilon.sirena.org.uk>
Date:   Wed,  7 Aug 2019 14:30:55 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: bcm-qspi: Fix BSPI QUAD and DUAL mode support when using flex mode

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

From 79629d0f7ce5b38515c1716911a0181f01b91102 Mon Sep 17 00:00:00 2001
From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date: Tue, 6 Aug 2019 15:37:50 +0530
Subject: [PATCH] spi: bcm-qspi: Fix BSPI QUAD and DUAL mode support when using
 flex mode

Fix data transfer width settings based on DT field 'spi-rx-bus-width'
to configure BSPI in single, dual or quad mode by using data width
and not the command width.

Fixes: 5f195ee7d830c ("spi: bcm-qspi: Implement the spi_mem interface")

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Link: https://lore.kernel.org/r/1565086070-28451-1-git-send-email-rayagonda.kokatanur@broadcom.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 584bcb018a62..285a6f463013 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -354,7 +354,7 @@ static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi,
 {
 	int bpc = 0, bpp = 0;
 	u8 command = op->cmd.opcode;
-	int width  = op->cmd.buswidth ? op->cmd.buswidth : SPI_NBITS_SINGLE;
+	int width = op->data.buswidth ? op->data.buswidth : SPI_NBITS_SINGLE;
 	int addrlen = op->addr.nbytes;
 	int flex_mode = 1;
 
@@ -992,7 +992,7 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 	if (mspi_read)
 		return bcm_qspi_mspi_exec_mem_op(spi, op);
 
-	ret = bcm_qspi_bspi_set_mode(qspi, op, -1);
+	ret = bcm_qspi_bspi_set_mode(qspi, op, 0);
 
 	if (!ret)
 		ret = bcm_qspi_bspi_exec_mem_op(spi, op);
-- 
2.20.1

