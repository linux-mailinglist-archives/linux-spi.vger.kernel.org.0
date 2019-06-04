Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC5B34B41
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2019 16:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfFDO7S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jun 2019 10:59:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49000 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbfFDO7R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jun 2019 10:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Q7dszm4STF3lvuZE1ayXRVg4P2dVVssja00iqA94/bs=; b=rXIpDoiz5E2y
        YILiLcnsh4JD7uMaBsjcj1Dn9/wGB9SUwxeUkRpQt9Az66sTwxfHijy5Yml36yHDYlsq28/+4Nw6P
        lgeN9oXRZhMhxiavW89vFNh6QPW4AN/9KwbQhfPl5ylHjIkNxg3UQX2g/5rukVbniyGR0T0g30ejd
        DjSLk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYAu7-0006Fu-5L; Tue, 04 Jun 2019 14:59:11 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id B119D440046; Tue,  4 Jun 2019 15:59:10 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     andy.shevchenko@gmail.com, ard.biesheuvel@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        geert@linux-m68k.org, Jassi Brar <jaswinder.singh@linaro.org>,
        jaswinder.singh@linaro.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        masami.hiramatsu@linaro.org, okamoto.satoru@socionext.com,
        osaki.yoshitoyo@socionext.com, robh+dt@kernel.org,
        tpiepho@impinj.com
Subject: Applied "MAINTAINERS: Add entry for Synquacer SPI driver" to the spi tree
In-Reply-To: <20190604051257.14264-2-masahisa.kojima@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190604145910.B119D440046@finisterre.sirena.org.uk>
Date:   Tue,  4 Jun 2019 15:59:10 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   MAINTAINERS: Add entry for Synquacer SPI driver

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

From 6acf0ed57b8c30f57cba1e3d4fd56e37480affc3 Mon Sep 17 00:00:00 2001
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Tue, 4 Jun 2019 14:12:55 +0900
Subject: [PATCH] MAINTAINERS: Add entry for Synquacer SPI driver

Add entry for the Synquacer spi driver and DT bindings.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4ce575..66738ccc1257 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14599,6 +14599,14 @@ S:	Maintained
 F:	drivers/net/ethernet/socionext/netsec.c
 F:	Documentation/devicetree/bindings/net/socionext-netsec.txt
 
+SOCIONEXT (SNI) Synquacer SPI DRIVER
+M:	Masahisa Kojima <masahisa.kojima@linaro.org>
+M:	Jassi Brar <jaswinder.singh@linaro.org>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-synquacer.c
+F:	Documentation/devicetree/bindings/spi/spi-synquacer.txt
+
 SOLIDRUN CLEARFOG SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 S:	Maintained
-- 
2.20.1

