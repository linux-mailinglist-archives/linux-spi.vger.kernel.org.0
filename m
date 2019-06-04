Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED9634B48
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2019 17:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfFDO7T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jun 2019 10:59:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48996 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfFDO7Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jun 2019 10:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NgUgr2ndlv+NkDqtV9ENgHd/H11fu7d+IN1/kqdr8+g=; b=ag3ZQSxk0Wrt
        S5NE86YttXz7XswuPDesJVfKVBPCr+wSCT1yq7bbA/i31kQCQ+ZauRloAxI9RAWO1yGwCzAmA392o
        aiRz2lgLasnRCFsL6ghztMqUyxxr5NKnY4qdSLufbI7E5x6MtpiKypcbgKX5TwRMsVpTlCW0xpVBT
        GZrG0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYAu6-0006Fr-Jl; Tue, 04 Jun 2019 14:59:10 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 341D0440049; Tue,  4 Jun 2019 15:59:10 +0100 (BST)
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
Subject: Applied "spi: Add DT bindings for Synquacer" to the spi tree
In-Reply-To: <20190604051257.14264-3-masahisa.kojima@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190604145910.341D0440049@finisterre.sirena.org.uk>
Date:   Tue,  4 Jun 2019 15:59:10 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Add DT bindings for Synquacer

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

From 6d72a49ff3f6bb0932718c132b75351aedc9458e Mon Sep 17 00:00:00 2001
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Tue, 4 Jun 2019 14:12:56 +0900
Subject: [PATCH] spi: Add DT bindings for Synquacer

This patch adds documentation for Device-Tree bindings for the
Socionext Synquacer spi driver.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/spi-synquacer.txt | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-synquacer.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-synquacer.txt b/Documentation/devicetree/bindings/spi/spi-synquacer.txt
new file mode 100644
index 000000000000..291dfa692d0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-synquacer.txt
@@ -0,0 +1,27 @@
+* Socionext Synquacer HS-SPI bindings
+
+Required Properties:
+- compatible: should be "socionext,synquacer-spi"
+- reg: physical base address of the controller and length of memory mapped
+       region.
+- interrupts: should contain the "spi_rx", "spi_tx" and "spi_fault" interrupts.
+- clocks: core clock iHCLK. Optional rate clock iPCLK (default is iHCLK)
+- clock-names: Shall be "iHCLK" and "iPCLK" respectively
+
+Optional Properties:
+- socionext,use-rtm: boolean, if required to use "retimed clock" for RX
+- socionext,set-aces: boolean, if same active clock edges field to be set.
+
+Example:
+
+	spi0: spi@ff110000 {
+		compatible = "socionext,synquacer-spi";
+		reg = <0xff110000 0x1000>;
+		interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk_hsspi>;
+		clock-names = "iHCLK";
+		socionext,use-rtm;
+		socionext,set-aces;
+	};
-- 
2.20.1

