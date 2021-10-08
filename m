Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B917B426E9D
	for <lists+linux-spi@lfdr.de>; Fri,  8 Oct 2021 18:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhJHQYh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Oct 2021 12:24:37 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:47675 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhJHQYf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Oct 2021 12:24:35 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 03E86240011;
        Fri,  8 Oct 2021 16:22:37 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaimeliao@mxic.com.tw,
        juliensu@mxic.com.tw,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [RFC PATCH 03/10] dt-bindings: vendor-prefixes: Update Macronix prefix
Date:   Fri,  8 Oct 2021 18:22:21 +0200
Message-Id: <20211008162228.1753083-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211008162228.1753083-1-miquel.raynal@bootlin.com>
References: <20211008162228.1753083-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When looking at compatible prefixes, Macronix is sometimes referred as
mxicy:
- mxicy,mx25r1635f
- mxicy,mx25u6435f
- mxicy,mx25v8035f
- mxicy,mx25f0a-spi
and sometimes as mxic:
- mxic,multi-itfc-v009-nand-controller
- mxic,enable-randomizer-otp

It looks like the more up-to-date way is mxic so declare this prefix and
mark the other one as deprecated.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b868cefc7c55..013a87850cd5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -758,8 +758,11 @@ patternProperties:
     description: Mundo Reader S.L.
   "^murata,.*":
     description: Murata Manufacturing Co., Ltd.
+  "^mxic,.*":
+    description: Macronix International Co., Ltd.
   "^mxicy,.*":
     description: Macronix International Co., Ltd.
+    deprecated: true
   "^myir,.*":
     description: MYIR Tech Limited
   "^national,.*":
-- 
2.27.0

