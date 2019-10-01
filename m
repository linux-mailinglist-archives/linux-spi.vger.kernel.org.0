Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD69C3307
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 13:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbfJALlp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 07:41:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41312 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387651AbfJALlO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 07:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=JiGt1yEYk797Tl22LhrJU1LZAH62oQR2ZxhFZ2ZqV0E=; b=hY9FQG+jAY/Y
        ICgMK59EI959H2L3JegmSaTZIq+jueOkE/8wTjpywqp9DsF72hkrSn/eSIKP50ZwpfLJEGok0y6kA
        1erNSm+PjNRZOyLrj8JbI3xisVrGVf5e0Z/6FoZWSOc/0tBhi/5JY9Hzm1MBz83FCyXeCNAQiBAda
        kjLxI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWh-0004Yt-B1; Tue, 01 Oct 2019 11:41:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C716F27429C0; Tue,  1 Oct 2019 12:41:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Julien Su <juliensu@mxic.com.tw>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Applied "spi: mxic: Ensure width is respected in spi-mem operations" to the spi tree
In-Reply-To: <20190919202504.9619-2-miquel.raynal@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114106.C716F27429C0@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:41:06 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: mxic: Ensure width is respected in spi-mem operations

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

From 539ff2488af87f25f2c090fd74ced55bd966e5a9 Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 19 Sep 2019 22:25:02 +0200
Subject: [PATCH] spi: mxic: Ensure width is respected in spi-mem operations

Make use of a core helper to ensure the desired width is respected
when calling spi-mem operators.

Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20190919202504.9619-2-miquel.raynal@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mxic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index f48563c09b97..409bfa163647 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -346,7 +346,7 @@ static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
 	if (op->addr.nbytes > 7)
 		return false;
 
-	return true;
+	return spi_mem_default_supports_op(mem, op);
 }
 
 static int mxic_spi_mem_exec_op(struct spi_mem *mem,
-- 
2.20.1

