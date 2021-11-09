Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191A144B2A7
	for <lists+linux-spi@lfdr.de>; Tue,  9 Nov 2021 19:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242338AbhKISWg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Nov 2021 13:22:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45356 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242321AbhKISWb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Nov 2021 13:22:31 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1A9IJStP123394;
        Tue, 9 Nov 2021 12:19:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1636481968;
        bh=bNgxSpWcyBtnq7XC0L3A6Ob6weYYVTcirUbh0b7kL2s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=aXRzuFpPka5DkvMwFrWfN2lhqsuPCucq9O5cNfbfOL4/vGV3GUZNehy8mafVz8IkM
         AVJ3ltpRUtweFMUimcQjnMo3ViWp1VEaSqxTrHQ1MdOjjEQmzhVckIAzBGRum+uqun
         chUKHzlp1LhKI5GKWNrDx+wj7PUouPSYW7WNDziA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1A9IJSr5103683
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Nov 2021 12:19:28 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 9
 Nov 2021 12:19:28 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 9 Nov 2021 12:19:28 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1A9IJC54017044;
        Tue, 9 Nov 2021 12:19:25 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Mark Brown <broonie@kernel.org>,
        Nishanth Menon <nm@ti.com>, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v3 3/3] dt-bindings: mtd: spi-nor: Add a reference to spi-peripheral-props.yaml
Date:   Tue, 9 Nov 2021 23:49:11 +0530
Message-ID: <20211109181911.2251-4-p.yadav@ti.com>
X-Mailer: git-send-email 2.33.1.835.ge9e5ba39a7
In-Reply-To: <20211109181911.2251-1-p.yadav@ti.com>
References: <20211109181911.2251-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi-peripheral-props.yaml schema contains peripheral-specific
properties for SPI controllers that should be present in the peripheral
node. Add a reference to that so its constraints are followed.

additionalProperties: false cannot be used since it marks the controller
properties as unknown. Use unevaluatedProperties: false instead. This
has the side effect of allowing extra properties that are not specified
in the schema. The alternative is to list all the controller properties
in this schema but that would mean every peripheral binding would have
to repeat the same set of properties for each controller.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

---

Changes in v3:
- s/slave/peripheral/g

 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index ed590d7c6e37..39421f7233e4 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: "mtd.yaml#"
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
@@ -88,7 +89,7 @@ patternProperties:
   "^otp(-[0-9]+)?$":
     type: object
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.33.1.835.ge9e5ba39a7

