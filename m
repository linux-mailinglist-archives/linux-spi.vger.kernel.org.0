Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40B1470B91
	for <lists+linux-spi@lfdr.de>; Fri, 10 Dec 2021 21:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343620AbhLJUOX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Dec 2021 15:14:23 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:47995 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344096AbhLJUOW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Dec 2021 15:14:22 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D0A9424000C;
        Fri, 10 Dec 2021 20:10:44 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 3/3] spi: dt-bindings: Add an example with two stacked flashes
Date:   Fri, 10 Dec 2021 21:10:39 +0100
Message-Id: <20211210201039.729961-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210201039.729961-1-miquel.raynal@bootlin.com>
References: <20211210201039.729961-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Provide an example of how to describe two flashes in eg. stacked mode.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 36b72518f565..048d2bbc74a5 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -139,4 +139,11 @@ examples:
             spi-max-frequency = <100000>;
             reg = <1>;
         };
+
+        flash@2 {
+          compatible = "jedec,spi-nor";
+          spi-max-frequency = <50000000>;
+          reg = <2>, <3>;
+          stacked-memories = /bits/ 64 <0x10000000>, /bits/ 64 <0x10000000>;
+        };
     };
-- 
2.27.0

