Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADC145F229
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 17:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378477AbhKZQkZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 11:40:25 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44261 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378498AbhKZQiW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 11:38:22 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id D5351E0017;
        Fri, 26 Nov 2021 16:34:58 +0000 (UTC)
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
Subject: [PATCH v2 1/5] spi: dt-bindings: Allow describing flashes with two CS
Date:   Fri, 26 Nov 2021 17:34:46 +0100
Message-Id: <20211126163450.394861-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211126163450.394861-1-miquel.raynal@bootlin.com>
References: <20211126163450.394861-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Xilinx QSPI controller has two advanced modes which allow the
controller to behave differently and consider two flashes as one single
storage.

One of these two modes is quite complex to support from a binding point
of view and is the dual parallel memories. In this mode, each byte of
data is stored in both devices: the even bits in one, the odd bits in
the other. The split is automatically handled by the QSPI controller and
is transparent for the user.

The other mode is simpler to support, it is called dual stacked
memories. The controller shares the same SPI bus but each of the devices
contain half of the data. Once in this mode, the controller does not
follow CS requests but instead internally wires the two CSlevels with
the value of the most significant address bit.

Supporting these two modes will involve core changes which include the
possibility of providing two CS for a single SPI device, and thus
changing the node name regular expression.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 8246891602e7..556c5ddc39d2 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -91,7 +91,7 @@ properties:
       - compatible
 
 patternProperties:
-  "^.*@[0-9a-f]+$":
+  "^.*@[0-9a-f]+,?[0-9a-f]*$":
     type: object
 
     properties:
-- 
2.27.0

