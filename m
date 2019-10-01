Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92155C32F3
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 13:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbfJALlM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 07:41:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41188 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387631AbfJALlM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 07:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZTdDCrXMNUBiChoI6oHj9PmGOmxRxT7bGSqcEkIkOhg=; b=Desj934jLs9n
        b6NTwMYJL2lNLWqb72TTR6WgoNEXVEBMH9PhRxU9RhyTLyb1qz1Ns9tF9A3DTYGBrtymaSDq+pk8/
        Ul5TNRWCVLcy5cxum3JmNHPd69UxntLXfbKbzUcX0XQKTPjUZ4T5iRBsux+i57HG8hj3iqj6i3oB3
        cHDxc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWi-0004ZM-F9; Tue, 01 Oct 2019 11:41:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id EA2CF2742A30; Tue,  1 Oct 2019 12:41:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     devicetree@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "dt: spi: Add Renesas RZ/N1 binding documentation" to the spi tree
In-Reply-To: <1568793876-9009-2-git-send-email-gareth.williams.jx@renesas.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114107.EA2CF2742A30@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:41:07 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   dt: spi: Add Renesas RZ/N1 binding documentation

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

From da182a61fce01dbd7c4a78c68a34af110f00e36f Mon Sep 17 00:00:00 2001
From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 18 Sep 2019 09:04:33 +0100
Subject: [PATCH] dt: spi: Add Renesas RZ/N1 binding documentation

The Renesas RZ/N1 SPI Controller is based on the Synopsys DW SSI, but has
additional registers for software CS control and DMA. This patch does not
address the changes required for DMA support, it simply adds the compatible
string. The CS functionality is not very useful and also not needed as
Linux can use gpios for the CS signals.

Add a compatible string to handle any unforeseen issues that may arise, and
pave the way for DMA support.

Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Link: https://lore.kernel.org/r/1568793876-9009-2-git-send-email-gareth.williams.jx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/renesas,rzn1-spi.txt      | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt b/Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt
new file mode 100644
index 000000000000..fb1a6728638d
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt
@@ -0,0 +1,11 @@
+Renesas RZ/N1 SPI Controller
+
+This controller is based on the Synopsys DW Synchronous Serial Interface and
+inherits all properties defined in snps,dw-apb-ssi.txt except for the
+compatible property.
+
+Required properties:
+- compatible : The device specific string followed by the generic RZ/N1 string.
+   Therefore it must be one of:
+   "renesas,r9a06g032-spi", "renesas,rzn1-spi"
+   "renesas,r9a06g033-spi", "renesas,rzn1-spi"
-- 
2.20.1

