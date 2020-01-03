Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB7A12F28F
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jan 2020 02:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgACBF5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jan 2020 20:05:57 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51618 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgACBF4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jan 2020 20:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=g+wWEWkvQoOBjR0Vk+qKtSqMF6zrj4x2Z/l+Cp7rLrk=; b=gkz3Vsnvjmb4
        07YbcVXSq587LPHvfPabZsFchQF/+BWmFSW1JYHXpNAfLOY5E/3TULMJUWKhSQ/wYtLqJtzZIQ3Pq
        IYSP34ZlY9hZtHGPYft0kAT4klybAev7RHVFNvHAbn2i7WwAyy8zlzvrCRREpVGSxGsCPrgBnshml
        OJiTE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1inBPU-0003Na-G3; Fri, 03 Jan 2020 01:05:52 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 07C5FD057C6; Fri,  3 Jan 2020 01:05:52 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "spi: Document Octal mode as valid SPI bus width" to the spi tree
In-Reply-To: <20200102102118.23318-1-vigneshr@ti.com>
Message-Id: <applied-20200102102118.23318-1-vigneshr@ti.com>
X-Patchwork-Hint: ignore
Date:   Fri,  3 Jan 2020 01:05:52 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Document Octal mode as valid SPI bus width

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

From 09b6636cea4f8e419d7cca4155e8695e462535a6 Mon Sep 17 00:00:00 2001
From: Vignesh Raghavendra <vigneshr@ti.com>
Date: Thu, 2 Jan 2020 15:51:18 +0530
Subject: [PATCH] spi: Document Octal mode as valid SPI bus width

SPI core supports Octal SPI controllers which have 8 IO lines.
Therefore document 8 as a valid option for spi-tx{rx}-bus-width

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Link: https://lore.kernel.org/r/20200102102118.23318-1-vigneshr@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 732339275848..1e0ca6ccf64b 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -111,7 +111,7 @@ patternProperties:
       spi-rx-bus-width:
         allOf:
           - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [ 1, 2, 4 ]
+          - enum: [ 1, 2, 4, 8 ]
           - default: 1
         description:
           Bus width to the SPI bus used for MISO.
@@ -123,7 +123,7 @@ patternProperties:
       spi-tx-bus-width:
         allOf:
           - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [ 1, 2, 4 ]
+          - enum: [ 1, 2, 4, 8 ]
           - default: 1
         description:
           Bus width to the SPI bus used for MOSI.
-- 
2.20.1

