Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A710D476FED
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 12:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhLPLRP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 06:17:15 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44195 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbhLPLRP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 06:17:15 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C7A5EE0014;
        Thu, 16 Dec 2021 11:17:11 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 09/28] dt-bindings: spi: mxic: Document the nand-ecc-engine property
Date:   Thu, 16 Dec 2021 12:16:35 +0100
Message-Id: <20211216111654.238086-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211216111654.238086-1-miquel.raynal@bootlin.com>
References: <20211216111654.238086-1-miquel.raynal@bootlin.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml b/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
index f20d100b4a68..9202c44b4478 100644
--- a/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
@@ -38,6 +38,11 @@ properties:
       - const: send_dly_clk
       - const: ps_clk
 
+  nand-ecc-engine:
+    description: NAND ECC engine used by the SPI controller in order to perform
+      on-the-fly correction when using a SPI-NAND memory.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
 required:
   - compatible
   - reg
-- 
2.27.0

