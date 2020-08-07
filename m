Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988D623ED22
	for <lists+linux-spi@lfdr.de>; Fri,  7 Aug 2020 14:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgHGMLJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Aug 2020 08:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgHGMLH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Aug 2020 08:11:07 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E53C061756
        for <linux-spi@vger.kernel.org>; Fri,  7 Aug 2020 05:11:05 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id CcAz230074C55Sk01cAzZ2; Fri, 07 Aug 2020 14:11:02 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k41D9-0000Z2-93; Fri, 07 Aug 2020 14:10:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k41D9-0003hp-7L; Fri, 07 Aug 2020 14:10:59 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: lpspi: Add missing boolean type for fsl,spi-only-use-cs1-sel
Date:   Fri,  7 Aug 2020 14:10:57 +0200
Message-Id: <20200807121057.14204-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When running "make dt_binding_check" (even if restricted to an unrelated
binding document using DT_SCHEMA_FILES=...):

    Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml: ignoring, error in schema: properties: fsl,spi-only-use-cs1-sel
    warning: no schema found in file: Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml

Fix this by adding a proper type definition for the vendor-specific
fsl,spi-only-use-cs1-sel property.

Fixes: 7ac9bbf6ab3085c2 ("dt-bindings: lpspi: New property in document DT bindings for LPSPI")
Suggested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
index 22882e769e260f76..312d8fee9dbb8199 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -39,6 +39,7 @@ properties:
       spi common code does not support use of CS signals discontinuously.
       i.MX8DXL-EVK board only uses CS1 without using CS0. Therefore, add
       this property to re-config the chipselect value in the LPSPI driver.
+    type: boolean
 
 required:
   - compatible
-- 
2.17.1

