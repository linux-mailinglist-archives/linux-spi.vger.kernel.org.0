Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25C1417A8C
	for <lists+linux-spi@lfdr.de>; Fri, 24 Sep 2021 20:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347930AbhIXSJC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Sep 2021 14:09:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48834 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347867AbhIXSJB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Sep 2021 14:09:01 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18OI7A5G012410;
        Fri, 24 Sep 2021 13:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632506830;
        bh=XCO0SGn6EFVz7qEBim1aa+y//pbJCMPKkkRQzolDxdc=;
        h=From:To:CC:Subject:Date;
        b=onhGpHZ5ODS7GJmAHmhlTXDB54XTIyW4ZsSB8Y1uxpdqTM9v0FdrmkLt6+nrWp8nF
         yLLRwsssUTfrIuZFDz6g0utsQMIy54WJFZdho6uRXBQ2tr8zuENhdvHS/4Fw2HmcIv
         1ALLar00KI7Ky8VJFIk/aH7mg7edm7KGYUBVNOf8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18OI7Avr046883
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Sep 2021 13:07:10 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 24
 Sep 2021 13:07:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 24 Sep 2021 13:07:10 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18OI76Ei009629;
        Fri, 24 Sep 2021 13:07:07 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     Michael Walle <michael@walle.cc>, Apurva Nandan <a-nandan@ti.com>,
        Nishanth Menon <nm@ti.com>, <linux-spi@vger.kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: [PATCH v1] dt-bindings: mtd: spi-nor: use unevaluatedProperties: false
Date:   Fri, 24 Sep 2021 23:37:05 +0530
Message-ID: <20210924180705.14021-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Many SPI controllers need to add properties to slave devices. This could
be the delay in clock or data lines, etc. These properties are
controller specific but need to be defined in the slave node because
they are per-slave and there can be multiple slaves attached to a
controller.

If these properties are not added to the slave binding, then the dtbs
check emits a warning. But these properties do not make much sense in
the slave binding because they are controller-specific and they will
just pollute every slave binding.

One option is to add a separate schema that collects all such properties
from all such controllers. Slave bindings can simply refer to this
binding and they should be rid of the warnings.

There are some limitations with this approach:

1. There is no way to specify required properties. The schema would
contain properties for all controllers and there would be no way to know
which controller is being used.

2. There would be no way to restrict additional properties. Since this
schema will be used with an allOf operator, additionalProperties would
need to be true. In addition, the slave schema will have to set
unevaluatedProperties: false.

A much simpler option would be to make controller schemas specify those
properties in patternProperties and set unevaluatedProperties to false
on slave schemas, which is done in the previous approach anyway. This
approach would have the same limitations as the 2nd limitation in the
previous approach. But it does not have the 1st limitation since the
properties of all controllers are not collected in a single schema, but
instead reside in the same schema as the controller. It also has the
added benefit of being much simpler.

The SPI NOR binding is taken as the first one to follow this. Other
bindings like SPI NAND can follow in later patches.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

---
I sent the first approach mentioned in the commit message some time ago
[0]. When re-rolling this series I realized that if we are going to use
unevaluatedProperties: false, then it would be much simpler to just keep
everything else as-is. This has clear positives with no negatives
relative to [0], as explained in the commit message.

[0] https://lore.kernel.org/all/20210609111707.9555-1-p.yadav@ti.com/T/#u

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
2.33.0

