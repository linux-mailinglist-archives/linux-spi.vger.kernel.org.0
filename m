Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE022EF0BF
	for <lists+linux-spi@lfdr.de>; Fri,  8 Jan 2021 11:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbhAHKgI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Jan 2021 05:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbhAHKgI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Jan 2021 05:36:08 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76979C0612F8
        for <linux-spi@vger.kernel.org>; Fri,  8 Jan 2021 02:35:27 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id EAbR2400c4C55Sk06AbR1R; Fri, 08 Jan 2021 11:35:26 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kxp77-001zoy-FQ; Fri, 08 Jan 2021 11:35:25 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kxp77-008V2G-0f; Fri, 08 Jan 2021 11:35:25 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] spi: renesas,sh-msiof: Add r8a779a0 support
Date:   Fri,  8 Jan 2021 11:35:22 +0100
Message-Id: <20210108103522.2025880-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Document R-Car V3U (R8A779A0) SoC bindings.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Improve patch description.
---
 Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
index 44c7ddb4b1098e15..b104899205f6d2da 100644
--- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
@@ -47,6 +47,7 @@ properties:
               - renesas,msiof-r8a77980      # R-Car V3H
               - renesas,msiof-r8a77990      # R-Car E3
               - renesas,msiof-r8a77995      # R-Car D3
+              - renesas,msiof-r8a779a0      # R-Car V3U
           - const: renesas,rcar-gen3-msiof  # generic R-Car Gen3 and RZ/G2
                                             # compatible device
       - items:
-- 
2.25.1

