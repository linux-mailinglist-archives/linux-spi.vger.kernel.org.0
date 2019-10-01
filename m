Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D221C330D
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 13:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732692AbfJALlv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 07:41:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41204 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387633AbfJALlN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 07:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=CX+gGn0ulj8a8xwxiDkqA33F/I+QW8zBsiOoBhNf9xY=; b=RuAYOK3rUhXn
        IzkI03E9zhw4HUdJ2iRpLTMz/cGsSgFpZPpp/4vSs0VpxgIGnyWxOQYCbA9qctKpj9MihunuLRcH4
        yfkarbQl0M6VTb864ffF6xv/sdPSpwjJ5ugpgVMYZ+KkJgbypu0hnHCEwWJxcXD42JLow2XanvIbG
        5uOUQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWi-0004ZF-8E; Tue, 01 Oct 2019 11:41:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id ACF3F2742A10; Tue,  1 Oct 2019 12:41:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "dt-bindings: snps,dw-apb-ssi: Add optional clock domain information" to the spi tree
In-Reply-To: <1568793876-9009-3-git-send-email-gareth.williams.jx@renesas.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114107.ACF3F2742A10@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:41:07 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   dt-bindings: snps,dw-apb-ssi: Add optional clock domain information

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

From 47cf13bc763c891c6192184c5e5aa8c1b331b2ff Mon Sep 17 00:00:00 2001
From: Gareth Williams <gareth.williams.jx@renesas.com>
Date: Wed, 18 Sep 2019 09:04:34 +0100
Subject: [PATCH] dt-bindings: snps,dw-apb-ssi: Add optional clock domain
 information

Note in the bindings documentation that pclk should be renamed if a clock
domain is used to enable the optional bus clock.

Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
Link: https://lore.kernel.org/r/1568793876-9009-3-git-send-email-gareth.williams.jx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index f54c8c36395e..3ed08ee9feba 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -16,7 +16,8 @@ Required properties:
 Optional properties:
 - clock-names : Contains the names of the clocks:
     "ssi_clk", for the core clock used to generate the external SPI clock.
-    "pclk", the interface clock, required for register access.
+    "pclk", the interface clock, required for register access. If a clock domain
+     used to enable this clock then it should be named "pclk_clkdomain".
 - cs-gpios : Specifies the gpio pins to be used for chipselects.
 - num-cs : The number of chipselects. If omitted, this will default to 4.
 - reg-io-width : The I/O register width (in bytes) implemented by this
-- 
2.20.1

