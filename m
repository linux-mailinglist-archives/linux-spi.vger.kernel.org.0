Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48ACE476FE6
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 12:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhLPLRN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 06:17:13 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52541 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhLPLRJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 06:17:09 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 305C3E000D;
        Thu, 16 Dec 2021 11:17:06 +0000 (UTC)
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
Subject: [PATCH v6 06/28] dt-bindings: vendor-prefixes: Clarify Macronix prefix
Date:   Thu, 16 Dec 2021 12:16:32 +0100
Message-Id: <20211216111654.238086-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211216111654.238086-1-miquel.raynal@bootlin.com>
References: <20211216111654.238086-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When looking at compatible prefixes, Macronix is sometimes referred as
"mxicy":
- mxicy,mx25r1635f
- mxicy,mx25u6435f
- mxicy,mx25v8035f
- mxicy,mx25f0a-spi
and sometimes as "mxic":
- mxic,multi-itfc-v009-nand-controller
- mxic,enable-randomizer-otp

The oldest prefix that is also the one preferred by Macronix engineers
is "mxicy", so document the other one and mark it deprecated.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a867f7102c35..93d65dc3746c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -774,6 +774,9 @@ patternProperties:
     description: Mundo Reader S.L.
   "^murata,.*":
     description: Murata Manufacturing Co., Ltd.
+  "^mxic,.*":
+    description: Macronix International Co., Ltd.
+    deprecated: true
   "^mxicy,.*":
     description: Macronix International Co., Ltd.
   "^myir,.*":
-- 
2.27.0

