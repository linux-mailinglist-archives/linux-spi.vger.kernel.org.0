Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E45B5EAC48
	for <lists+linux-spi@lfdr.de>; Mon, 26 Sep 2022 18:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbiIZQRd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Sep 2022 12:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbiIZQQz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Sep 2022 12:16:55 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C9D95E48
        for <linux-spi@vger.kernel.org>; Mon, 26 Sep 2022 08:05:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:d95b:5c9b:4085:7c0d])
        by xavier.telenet-ops.be with bizsmtp
        id Qf5t2800g3Qogd101f5tGF; Mon, 26 Sep 2022 17:05:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ocpg9-006Je7-HP; Mon, 26 Sep 2022 17:05:53 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ocpg9-00DOBA-1a; Mon, 26 Sep 2022 17:05:53 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: renesas,sh-msiof: Add r8a779g0 support
Date:   Mon, 26 Sep 2022 17:05:42 +0200
Message-Id: <a840ca8487cfd612fae2b20c98e93ae7c7f50ef4.1664204638.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document support for the Clock-Synchronized Serial Interface with FIFO
(MSIOF) in the Renesas R-Car V4H (R8A779G0) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
index 33651f79a793711d..8ee97eb1cd7517d2 100644
--- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
@@ -53,6 +53,7 @@ properties:
           - enum:
               - renesas,msiof-r8a779a0      # R-Car V3U
               - renesas,msiof-r8a779f0      # R-Car S4-8
+              - renesas,msiof-r8a779g0      # R-Car V4H
           - const: renesas,rcar-gen4-msiof  # generic R-Car Gen4
                                             # compatible device
       - items:
-- 
2.25.1

