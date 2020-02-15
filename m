Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6217B15FD3A
	for <lists+linux-spi@lfdr.de>; Sat, 15 Feb 2020 08:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgBOHAs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 15 Feb 2020 02:00:48 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44743 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgBOHAs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 15 Feb 2020 02:00:48 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so4644598plo.11;
        Fri, 14 Feb 2020 23:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XE5CJKc1a7rUfnazp7u4JItKmlkGauSYL++r+MJXVmk=;
        b=eME8l+Mz1VmjGK/Dqrt0VHQY0F5h1jH976J9MEfHNjh/ccDMhF5qTx4G9+X6pveDZj
         OrPRJOhFt2qU/q4ghkaoEpK5rKN4blEs8DHOam/D1s0IzmKeVGNmGjLVRAdM9bbEP731
         84PeYQlsjXqiCXpKUqS6haWVcVTi78oZ/2XKO7dnR1p93wWCGB4Hq2MJ2LfNX3cFjIyv
         Omp7coDij8BcqHXw5kbdlPtKXExub2YkDL9K1plTEI/6gM+TsRyHsHeMtVuCSCle/WdE
         G+JqkPvAIGkzD/zt5tW0qBx0Egvnkg6tIjnpxzCVwRzdi15EoEy+Ql3K/DFQISC3WS2+
         /E3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XE5CJKc1a7rUfnazp7u4JItKmlkGauSYL++r+MJXVmk=;
        b=KfSEjbH9rLtWulzF+Gkm5dW42vWqPQ/x+2C39AVNkThi4TzRinwtpLmcgzl3IZJmxZ
         QjJcYObJq/VuyStjCFdyB0HH6/YW78VA8RQkaZvbd7QUFZQtAg1FSBhbxiUHc/SpZyr8
         SooSIOyNXC7Hz+FPR9wLk0hHp2iJ8FuBM0VGEAeZ5O/I2QkEFVP4W8l7ApZOsyFxEUB2
         1UHZlOVGGveuJ2/T4EThmfVA206aLdtKNIO7snsQDmWWzj1LgcU4UgMJqZ9IcCttk++Q
         RTmc445QYbtS7K103mG8A/KnUtgis6ADJuR9/wIepZA2O/ZB5RwQOKEczWuXpqXkbjEB
         wOWQ==
X-Gm-Message-State: APjAAAX1sIRuNSzyyyA4ewajqfuz+Bv0BWCqH6r1k7WLAuG+RTuvp6Xs
        RxnbZKlzgU7ol9STawgDe14=
X-Google-Smtp-Source: APXvYqyXRMtaMTp5YdXfgVA8qeIZoLUUB+MIfZxktdbjVBwb3h8kbRh7Ndkxqtzl8O5vUZ5Kjp91jQ==
X-Received: by 2002:a17:902:d684:: with SMTP id v4mr7221978ply.14.1581750047679;
        Fri, 14 Feb 2020 23:00:47 -0800 (PST)
Received: from localhost.localdomain ([240e:379:95a:e780::fa3])
        by smtp.gmail.com with ESMTPSA id c15sm8918140pfo.137.2020.02.14.23.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 23:00:47 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 2/2] dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor
Date:   Sat, 15 Feb 2020 14:58:26 +0800
Message-Id: <20200215065826.739102-3-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200215065826.739102-1-gch981213@gmail.com>
References: <20200215065826.739102-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi-mtk-nor is a driver to replace mtk-quadspi and they have almost
the same device-tree bindings. Reuse this binding documentation and
convert it for new driver:

1. "Mediatek SoCs" -> "Mediatek ARM SoCs" because MTK MIPS SoCs
   use different controllers.
2. document "interrupts" as a required property because it's
   available on all SoCs with this controller and new driver takes
   advantages of it. It's implemented as optional only to maintain
   backward compatibility.
3. replace binding example with a mt7629 one because this is the
   only one I know the interrupt assignment.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 .../mtk-quadspi.txt => spi/spi-mtk-nor.txt}   | 34 ++++++++-----------
 1 file changed, 15 insertions(+), 19 deletions(-)
 rename Documentation/devicetree/bindings/{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt} (62%)

diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
similarity index 62%
rename from Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
rename to Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
index a12e3b5c495d..829da480b9a9 100644
--- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
@@ -1,4 +1,4 @@
-* Serial NOR flash controller for MediaTek SoCs
+* SPI NOR flash controller for MediaTek ARM SoCs
 
 Required properties:
 - compatible: 	  For mt8173, compatible should be "mediatek,mt8173-nor",
@@ -13,6 +13,7 @@ Required properties:
 		  "mediatek,mt7629-nor", "mediatek,mt8173-nor"
 		  "mediatek,mt8173-nor"
 - reg: 		  physical base address and length of the controller's register
+- interrupts:	  Interrupt number used by the controller.
 - clocks: 	  the phandle of the clocks needed by the nor controller
 - clock-names: 	  the names of the clocks
 		  the clocks should be named "spi" and "sf". "spi" is used for spi bus,
@@ -22,29 +23,24 @@ Required properties:
 - #address-cells: should be <1>
 - #size-cells:	  should be <0>
 
-The SPI flash must be a child of the nor_flash node and must have a
-compatible property. Also see jedec,spi-nor.txt.
-
-Required properties:
-- compatible:	  May include a device-specific string consisting of the manufacturer
-		  and name of the chip. Must also include "jedec,spi-nor" for any
-		  SPI NOR flash that can be identified by the JEDEC READ ID opcode (0x9F).
-- reg :		  Chip-Select number
+There should be only one spi slave device following generic spi bindings.
+It's not recommended to use this controller for devices other than SPI NOR
+flash due to limited transfer capability of this controller.
 
 Example:
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/mt7629-clk.h>
 
-nor_flash: spi@1100d000 {
-	compatible = "mediatek,mt8173-nor";
-	reg = <0 0x1100d000 0 0xe0>;
-	clocks = <&pericfg CLK_PERI_SPI>,
-		 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
+spi_nor: spi@11014000 {
+	compatible = "mediatek,mt7629-nor",
+		     "mediatek,mt8173-nor";
+	reg = <0x11014000 0xe0>;
+	interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
+	clocks = <&pericfg CLK_PERI_FLASH_PD>,
+		 <&topckgen CLK_TOP_FLASH_SEL>;
 	clock-names = "spi", "sf";
 	#address-cells = <1>;
 	#size-cells = <0>;
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-	};
 };
 
-- 
2.24.1

