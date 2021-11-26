Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690AC45F22B
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 17:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378480AbhKZQk0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 11:40:26 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57277 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378513AbhKZQiX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 11:38:23 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 17669E000E;
        Fri, 26 Nov 2021 16:35:09 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michal Simek <monstr@monstr.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 2/5] dt-bindings: mtd: spi-nor: Allow external properties
Date:   Fri, 26 Nov 2021 17:34:47 +0100
Message-Id: <20211126163450.394861-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211126163450.394861-1-miquel.raynal@bootlin.com>
References: <20211126163450.394861-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Setting "additionalProperties: false" will refuse any generic SPI
property while they should be of course authorized. In practice it looks
like many people used compatibles different than "jedec,spi-nor" in
order to workaround this limitation because otherwise no SPI property
could be used in the examples. Use "unevaluatedProperties: false"
instead to allow defined properties to be used. It is likely that at the
time of the conversion to yaml of the jedec file, the unevaluated
keyword was not yet introduced.

Fixes: 3ff9ee2a8890 ("dt-bindings: mtd: spi-nor: Convert to DT schema format")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index ed590d7c6e37..81be0620b264 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -88,7 +88,7 @@ patternProperties:
   "^otp(-[0-9]+)?$":
     type: object
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.27.0

