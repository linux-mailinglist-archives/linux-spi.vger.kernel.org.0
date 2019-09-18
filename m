Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF3BB5E89
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2019 10:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfIRIFF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Sep 2019 04:05:05 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:10399 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbfIRIFD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Sep 2019 04:05:03 -0400
X-IronPort-AV: E=Sophos;i="5.64,519,1559487600"; 
   d="scan'208";a="26658094"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 18 Sep 2019 17:05:01 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 05B2F41C9BD7;
        Wed, 18 Sep 2019 17:04:58 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH v2 1/4] dt: spi: Add Renesas RZ/N1 binding documentation
Date:   Wed, 18 Sep 2019 09:04:33 +0100
Message-Id: <1568793876-9009-2-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

The Renesas RZ/N1 SPI Controller is based on the Synopsys DW SSI, but has
additional registers for software CS control and DMA. This patch does not
address the changes required for DMA support, it simply adds the compatible
string. The CS functionality is not very useful and also not needed as
Linux can use gpios for the CS signals.

Add a compatible string to handle any unforeseen issues that may arise, and
pave the way for DMA support.

Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
Note: All the other manufacturers detail their compatible strings in
snps,dw-apb-ssi.txt. I think it makes sense for rzn1 to be in it's own file
due to the changes made to the peripheral for DMA support.

v2:
 - No changes.
---
 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt b/Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt
new file mode 100644
index 0000000..fb1a672
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
2.7.4

