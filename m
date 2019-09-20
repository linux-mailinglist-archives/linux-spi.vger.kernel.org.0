Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5CAB8ECB
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2019 13:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438155AbfITLJq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Sep 2019 07:09:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43740 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438154AbfITLJp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Sep 2019 07:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7hI+o+psndomB3D9UFiMpJ0vG6hUICZeMtbHv4aGnFM=; b=QjwpV5xqBv3i
        AiENJx7jAxaoq64XWnIS8Crc3lqcWpOcO1GebVWnT921L8jlaCL9cXXct1N3vuMFzu3dLh+B8LRnU
        Uy+KaKy8BAPj69WYVHDqzsgxZjq+MoghCQLZcaBIdadyaFp19MyCEZ38Jw3UyrdiWOM49pa6NTyKf
        9oXUM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iBGnE-0001ck-JL; Fri, 20 Sep 2019 11:09:40 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 22EDD274293C; Fri, 20 Sep 2019 12:09:40 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Julien Su <juliensu@mxic.com.tw>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Applied "spi: mxic: Fix DMAS_CTRL register layout" to the spi tree
In-Reply-To: <20190919202504.9619-4-miquel.raynal@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190920110940.22EDD274293C@ypsilon.sirena.org.uk>
Date:   Fri, 20 Sep 2019 12:09:40 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: mxic: Fix DMAS_CTRL register layout

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

From 6fe7ab3837bdbc4830addac9898a5e4bc0783dcc Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 19 Sep 2019 22:25:04 +0200
Subject: [PATCH] spi: mxic: Fix DMAS_CTRL register layout

Fix the current layout which only matches early non-public revisions
of the IP. Since its official distribution, two bytes of the SPI
controller DMAS_CTRL register have been inverted.

Suggested-by: Mason Yang <masonccyang@mxic.com.tw>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20190919202504.9619-4-miquel.raynal@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mxic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index b641954fdc4b..a736fdf47119 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -145,8 +145,8 @@
 #define LWR_SUSP_CTRL_EN	BIT(31)
 
 #define DMAS_CTRL		0x9c
-#define DMAS_CTRL_DIR_READ	BIT(31)
-#define DMAS_CTRL_EN		BIT(30)
+#define DMAS_CTRL_EN		BIT(31)
+#define DMAS_CTRL_DIR_READ	BIT(30)
 
 #define DATA_STROB		0xa0
 #define DATA_STROB_EDO_EN	BIT(2)
-- 
2.20.1

