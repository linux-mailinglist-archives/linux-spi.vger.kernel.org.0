Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D753A434DA7
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 16:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhJTOam (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 10:30:42 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:54183 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhJTOaj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Oct 2021 10:30:39 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D738720005;
        Wed, 20 Oct 2021 14:28:22 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 09/18] dt-bindings: spi: mxic: Document the nand-ecc-engine property
Date:   Wed, 20 Oct 2021 16:28:00 +0200
Message-Id: <20211020142809.349347-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211020142809.349347-1-miquel.raynal@bootlin.com>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This SPI controller supports interacting with an external ECC
engine. The nand-ecc-engine property already exist in the NAND world but
also applies to SPI controller nodes which have external correction
capabilities like Macronix's.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml b/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
index 4036c14fc533..01618a77627d 100644
--- a/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
@@ -43,6 +43,12 @@ properties:
   "#size-cells":
     const: 0
 
+  nand-ecc-engine:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+    description: NAND ECC engine used by the SPI controller in order to perform
+      on-the-fly correction when using a SPI-NAND memory.
+
 required:
   - compatible
   - reg
-- 
2.27.0

