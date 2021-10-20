Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B84434DA3
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 16:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhJTOaj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 10:30:39 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:56825 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhJTOae (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Oct 2021 10:30:34 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E5BCB20016;
        Wed, 20 Oct 2021 14:28:17 +0000 (UTC)
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
Subject: [PATCH 05/18] dt-bindings: vendor-prefixes: Clarify Macronix prefix
Date:   Wed, 20 Oct 2021 16:27:56 +0200
Message-Id: <20211020142809.349347-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211020142809.349347-1-miquel.raynal@bootlin.com>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
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

