Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1846931D
	for <lists+linux-spi@lfdr.de>; Mon,  6 Dec 2021 10:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241696AbhLFKC7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Dec 2021 05:02:59 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:35143 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241693AbhLFKC7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Dec 2021 05:02:59 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E99E0240004;
        Mon,  6 Dec 2021 09:59:28 +0000 (UTC)
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
Subject: [PATCH v3 3/3] spi: dt-bindings: Add an example with two stacked flashes
Date:   Mon,  6 Dec 2021 10:59:21 +0100
Message-Id: <20211206095921.33302-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211206095921.33302-1-miquel.raynal@bootlin.com>
References: <20211206095921.33302-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Provide an example of how to describe two flashes in eg. stacked mode.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 36b72518f565..35743448fdd2 100644
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
+          stacked-memories;
+        };
     };
-- 
2.27.0

