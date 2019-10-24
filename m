Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E98E319C
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2019 13:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409267AbfJXL6A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Oct 2019 07:58:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53696 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409254AbfJXL6A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Oct 2019 07:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=6Fr03L50fl93+YebJv4nFx8wK7Qt3CGRJxXT2ySx5HQ=; b=o6JnZZXUBbd3
        DRds99rxZRbA8n83RxzfBRO8gdYN9im5BAwAzpjgrvVOW0R8rt3TTmiJlR6nyYRXGFXtx/royWSG/
        rwYknVJg6c50APL1mHjCQct80ZHKzsSNHBv9mhWQjcNVHAO+xkzXbbHXDOOtV99vthJ747oSHSZmJ
        o0vCg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNbkc-0003Ri-5F; Thu, 24 Oct 2019 11:57:58 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8FD5D2743259; Thu, 24 Oct 2019 12:57:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
Subject: Applied "spi: xilinx: add description of new property xlnx,num-transfer-bits" to the spi tree
In-Reply-To: <20191024110757.25820-2-alvaro.gamez@hazent.com>
X-Patchwork-Hint: ignore
Message-Id: <20191024115757.8FD5D2743259@ypsilon.sirena.org.uk>
Date:   Thu, 24 Oct 2019 12:57:57 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: xilinx: add description of new property xlnx,num-transfer-bits

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

From e3354b17b4ac10ad2c23e244444ab38927a69ee9 Mon Sep 17 00:00:00 2001
From: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Date: Thu, 24 Oct 2019 13:07:55 +0200
Subject: [PATCH] spi: xilinx: add description of new property
 xlnx,num-transfer-bits

This property is used to set the number of bits per transfer (bits_per_word).

Xilinx' IP core allows either 8, 16 or 32, and is non changeable on runtime,
only when instantiating the core.

Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Link: https://lore.kernel.org/r/20191024110757.25820-2-alvaro.gamez@hazent.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-xilinx.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.txt b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
index dc924a5f71db..5f4ed3e5c994 100644
--- a/Documentation/devicetree/bindings/spi/spi-xilinx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
@@ -8,7 +8,8 @@ Required properties:
 			  number.
 
 Optional properties:
-- xlnx,num-ss-bits	: Number of chip selects used.
+- xlnx,num-ss-bits	 : Number of chip selects used.
+- xlnx,num-transfer-bits : Number of bits per transfer. This will be 8 if not specified
 
 Example:
 	axi_quad_spi@41e00000 {
@@ -17,5 +18,6 @@ Example:
 			interrupts = <0 31 1>;
 			reg = <0x41e00000 0x10000>;
 			xlnx,num-ss-bits = <0x1>;
+			xlnx,num-transfer-bits = <32>;
 	};
 
-- 
2.20.1

