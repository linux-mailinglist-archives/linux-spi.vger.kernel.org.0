Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E702BF2EF5
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2019 14:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388966AbfKGNNu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Nov 2019 08:13:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39532 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfKGNNt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Nov 2019 08:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=WOmUZ1RYVjZFQHJZFGdZnIC3fpebuUYqvoeEbLXTn+Y=; b=lXZ5OiVGTfbS
        ZivDSSIVQrHmenj9/YfGHVi9li7zosETEuemOS75d5g38zHWrSTu7/KcxC4GthelV01ZY6Q0X8Tk4
        b4hOg6VXj6n33UqE4MkYyNmO2muWu9BjBt5odI9zgcNmtnhrJhsTZ5aTMxEFcOZ2ZuoOSy7J+MNvT
        ivQYs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iShbZ-0004Nm-I5; Thu, 07 Nov 2019 13:13:41 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0A18327431AF; Thu,  7 Nov 2019 13:13:39 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     bcm-kernel-feedback-list@broadcom.com, broonie@kernel.org,
        kdasu.kdev@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-mem: fallback to using transfers when CS gpios are used" to the spi tree
In-Reply-To: <20191107044235.4864-3-chris.packham@alliedtelesis.co.nz>
X-Patchwork-Hint: ignore
Message-Id: <20191107131340.0A18327431AF@ypsilon.sirena.org.uk>
Date:   Thu,  7 Nov 2019 13:13:39 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-mem: fallback to using transfers when CS gpios are used

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

From 05766050d5bd9af24dcaec6b29255a6f2b324543 Mon Sep 17 00:00:00 2001
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Thu, 7 Nov 2019 17:42:35 +1300
Subject: [PATCH] spi: spi-mem: fallback to using transfers when CS gpios are
 used

Devices with chip selects driven via GPIO are not compatible with the
spi-mem operations. Fallback to using standard spi transfers when the
device is connected with a gpio CS.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Link: https://lore.kernel.org/r/20191107044235.4864-3-chris.packham@alliedtelesis.co.nz
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 9f0fa9f3116d..e5a46f0eb93b 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -286,7 +286,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (!spi_mem_internal_supports_op(mem, op))
 		return -ENOTSUPP;
 
-	if (ctlr->mem_ops) {
+	if (ctlr->mem_ops && !mem->spi->cs_gpiod) {
 		ret = spi_mem_access_start(mem);
 		if (ret)
 			return ret;
-- 
2.20.1

