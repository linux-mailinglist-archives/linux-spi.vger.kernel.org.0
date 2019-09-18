Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0839AB5E8D
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2019 10:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfIRIFS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Sep 2019 04:05:18 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:27074 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729339AbfIRIFR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Sep 2019 04:05:17 -0400
X-IronPort-AV: E=Sophos;i="5.64,519,1559487600"; 
   d="scan'208";a="26658131"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 18 Sep 2019 17:05:16 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2322141CA6B6;
        Wed, 18 Sep 2019 17:05:13 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: snps,dw-apb-ssi: Add optional clock domain information
Date:   Wed, 18 Sep 2019 09:04:34 +0100
Message-Id: <1568793876-9009-3-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Note in the bindings documentation that pclk should be renamed if a clock
domain is used to enable the optional bus clock.

Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
v2: Introduced this patch.
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index f54c8c3..3ed08ee 100644
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
2.7.4

