Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA22E12E4E8
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jan 2020 11:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgABKU7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jan 2020 05:20:59 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:32886 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgABKU7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jan 2020 05:20:59 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 002AKroY087456;
        Thu, 2 Jan 2020 04:20:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577960453;
        bh=NNAFSiZet0q9H7dCqZQEuNd5IpHuJ08LE1cBBRQAp+o=;
        h=From:To:CC:Subject:Date;
        b=MNW3kx/JpfFeSpgL1rOKLujMRiYt0xlIb130ejENEl6A0VdrCeP9bW34DOTnb/7hu
         c4yWXjjvgyyDtZXS+TcifqA3qEZ5J7psVkMNCRgZmOvcw1T6eTr9uDZny8w7fBx+bb
         iuGY/gat9g3fJeTIGwwHOA0b89brsNORTZClkslI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 002AKrqg084456;
        Thu, 2 Jan 2020 04:20:53 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 2 Jan
 2020 04:20:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 2 Jan 2020 04:20:53 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 002AKmJt026697;
        Thu, 2 Jan 2020 04:20:49 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] spi: Document Octal mode as valid SPI bus width
Date:   Thu, 2 Jan 2020 15:51:18 +0530
Message-ID: <20200102102118.23318-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI core supports Octal SPI controllers which have 8 IO lines.
Therefore document 8 as a valid option for spi-tx{rx}-bus-width

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 732339275848..1e0ca6ccf64b 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -111,7 +111,7 @@ patternProperties:
       spi-rx-bus-width:
         allOf:
           - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [ 1, 2, 4 ]
+          - enum: [ 1, 2, 4, 8 ]
           - default: 1
         description:
           Bus width to the SPI bus used for MISO.
@@ -123,7 +123,7 @@ patternProperties:
       spi-tx-bus-width:
         allOf:
           - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [ 1, 2, 4 ]
+          - enum: [ 1, 2, 4, 8 ]
           - default: 1
         description:
           Bus width to the SPI bus used for MOSI.
-- 
2.24.1

