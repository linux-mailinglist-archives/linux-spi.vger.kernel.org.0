Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225793A1232
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 13:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238775AbhFILTa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 07:19:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44692 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbhFILT3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Jun 2021 07:19:29 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 159BHKOM070200;
        Wed, 9 Jun 2021 06:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623237440;
        bh=k+MYscYK157qqj9O9OVFOcOn5X9nPnm+nv8lFRPh3Fg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eiO3GUxBoaX4CZoZ8CSZP8nEJ2jbE8OZ1eM759a0fUqHRGwiuA/ZeSdvkuGvtT3pZ
         uKP+CBaQ+lTNVVAgh4hUqKMolYuyKuaNM2BtYU70Ef7jdpV5uK/Lo054u+8RO25oqk
         jopC6PKnT25tx3sMdhpfGPSZ+BWqQDZLLebtAQIU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 159BHKcj085970
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jun 2021 06:17:20 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 9 Jun
 2021 06:17:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 9 Jun 2021 06:17:19 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 159BH7uH073420;
        Wed, 9 Jun 2021 06:17:16 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 2/2] dt-bindings: mtd: spi-nor: Add a reference to spi-slave-props.yaml
Date:   Wed, 9 Jun 2021 16:47:07 +0530
Message-ID: <20210609111707.9555-3-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210609111707.9555-1-p.yadav@ti.com>
References: <20210609111707.9555-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi-slave-props.yaml schema contains slave-specific properties
for SPI controllers that should be present in the slave node. Add a
reference to that so its constraints are followed.

additionalProperties: false cannot be used since it marks the controller
properties as unknown. Use unevaluatedProperties: false instead. This
has the side effect of allowing extra properties that are not specified
in the schema. The alternative is to list all the controller properties
in this schema but that would mean every slave binding would have to
repeat the same set of properties for each controller.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

---

 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index ed590d7c6e37..e69a8fbb91f1 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: "mtd.yaml#"
+  - $ref: /schemas/spi/spi-slave-props.yaml#
 
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
2.30.0

