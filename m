Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBCBE16FAEE
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2020 10:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgBZJhh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Feb 2020 04:37:37 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40602 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgBZJhh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Feb 2020 04:37:37 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01Q9bDZo019716;
        Wed, 26 Feb 2020 03:37:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582709833;
        bh=3zg6IMnhpry1kMZ9ELvtMgi825rhOhQg+hNu5ti2jCo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fxvgziQt5AQ+OrlY8ksVSMEIK6zpwuObRmhSuXV28jm7l7covCAlhgFasHjcxm9Ls
         1TtY91/TGYojl0dYZ3RmHX/zjE7FD0q2A02HSbmpP24FskJV1HdsN1hR9yx11mZNue
         LR6CSg0lSb9YsOeEAtRnhA8nIZCNMxaSW89WF1UU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01Q9bDoE118597
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Feb 2020 03:37:13 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 03:37:13 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 03:37:13 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01Q9b4A6110613;
        Wed, 26 Feb 2020 03:37:09 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR capability
Date:   Wed, 26 Feb 2020 15:06:53 +0530
Message-ID: <20200226093703.19765-2-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226093703.19765-1-p.yadav@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Allow spi devices to express DTR receive and transmit capabilities via
the properties "spi-rx-dtr" and "spi-tx-dtr".

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 .../devicetree/bindings/spi/spi-controller.yaml        | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 1e0ca6ccf64b..7a84debed213 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -120,6 +120,11 @@ patternProperties:
         description:
           Delay, in microseconds, after a read transfer.
 
+      spi-rx-dtr:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Device supports receiving in DTR mode.
+
       spi-tx-bus-width:
         allOf:
           - $ref: /schemas/types.yaml#/definitions/uint32
@@ -132,6 +137,11 @@ patternProperties:
         description:
           Delay, in microseconds, after a write transfer.
 
+      spi-tx-dtr:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Device supports transmitting in DTR mode.
+
     required:
       - compatible
       - reg
-- 
2.25.0

