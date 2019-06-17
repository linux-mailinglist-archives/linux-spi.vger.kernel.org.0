Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1BB148708
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2019 17:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfFQPY6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jun 2019 11:24:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52330 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbfFQPY5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jun 2019 11:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cISVkSd0Idc+ftOHCHbQfbJgXUZkYpNnMD4BSGTdwoc=; b=xmBu++zTE5Id
        cC/ResLzUiD5vRiChQW6Ou6msOC+u+lA5V+oC5FqZHbIen2ZkmMvg43iJsAF3Ic9SBC90WGmb8j1V
        bSJJyDQkMz5xJZRDvO4IuXHGp7FS6e9MhOyCTSeUnhpjc4MEMmNOlsMojvZbOs+/fOPJtiyvo5EUk
        KXXtc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hctV8-000206-BR; Mon, 17 Jun 2019 15:24:54 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id D6DA0440046; Mon, 17 Jun 2019 16:24:53 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Add a prototype for exported spi_set_cs_timing()" to the spi tree
In-Reply-To: <20190615174737.4868-1-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190617152453.D6DA0440046@finisterre.sirena.org.uk>
Date:   Mon, 17 Jun 2019 16:24:53 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Add a prototype for exported spi_set_cs_timing()

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

From 36f34737ff48f66c8a19b8788311e4b40d4adf80 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Sat, 15 Jun 2019 20:47:37 +0300
Subject: [PATCH] spi: Add a prototype for exported spi_set_cs_timing()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Compiler is not happy about spi_set_cs_timing() prototype.

drivers/spi/spi.c:3016:6: warning: no previous prototype for ‘spi_set_cs_timing’ [-Wmissing-prototypes]
 void spi_set_cs_timing(struct spi_device *spi, u8 setup, u8 hold,
      ^~~~~~~~~~~~~~~~~

Let's add it to the header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index d0c5ba746e01..0ec11f2911af 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -980,6 +980,8 @@ static inline void spi_message_free(struct spi_message *m)
 	kfree(m);
 }
 
+extern void spi_set_cs_timing(struct spi_device *spi, u8 setup, u8 hold, u8 inactive_dly);
+
 extern int spi_setup(struct spi_device *spi);
 extern int spi_async(struct spi_device *spi, struct spi_message *message);
 extern int spi_async_locked(struct spi_device *spi,
-- 
2.20.1

