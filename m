Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5829117B89F
	for <lists+linux-spi@lfdr.de>; Fri,  6 Mar 2020 09:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgCFIun (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Mar 2020 03:50:43 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:38840 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgCFIun (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Mar 2020 03:50:43 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id Awqg220075USYZQ01wqg0k; Fri, 06 Mar 2020 09:50:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jA8gq-0002XL-AJ; Fri, 06 Mar 2020 09:50:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jA8gq-00027e-6t; Fri, 06 Mar 2020 09:50:40 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 2/2] spi: dt-bindings: spi-controller: Fix spi-[rt]x-bus-width for slave mode
Date:   Fri,  6 Mar 2020 09:50:38 +0100
Message-Id: <20200306085038.8111-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200306085038.8111-1-geert+renesas@glider.be>
References: <20200306085038.8111-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The descriptions for the spi-rx-bus-width and spi-tx-bus-width
properties refer to "MISO" and "MOSI", which are not explained in the
document.  While these abbreviations are fairly common when talking
about SPI, and thus may not need an explanation, they are not entirely
correct in this context, as the SPI controller may be used in slave mode
instead of master mode.

Fix this by replacing them by "read transfers" resp. "write transfers",
like is done for the spi-rx-delay-us and spi-tx-delay-us properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - New.

This issue was present in the .txt version of the bindings, too, so
technically it needs
Fixes: a8830cb19cfea04e ("spi: Document DT bindings for SPI controllers in slave mode")
but of course it won't apply to that version.
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 0ebaf6677ac4f68d..d8e5509a70816df5 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -120,7 +120,7 @@ patternProperties:
           - enum: [ 1, 2, 4, 8 ]
           - default: 1
         description:
-          Bus width to the SPI bus used for MISO.
+          Bus width to the SPI bus used for read transfers.
 
       spi-rx-delay-us:
         description:
@@ -132,7 +132,7 @@ patternProperties:
           - enum: [ 1, 2, 4, 8 ]
           - default: 1
         description:
-          Bus width to the SPI bus used for MOSI.
+          Bus width to the SPI bus used for write transfers.
 
       spi-tx-delay-us:
         description:
-- 
2.17.1

