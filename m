Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FC06655DE
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jan 2023 09:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjAKIUL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Jan 2023 03:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjAKIUH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Jan 2023 03:20:07 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DA42DC1
        for <linux-spi@vger.kernel.org>; Wed, 11 Jan 2023 00:20:02 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:d992:2e67:38c1:3ab7])
        by michel.telenet-ops.be with bizsmtp
        id 7LKz2900422nSWd06LKzJW; Wed, 11 Jan 2023 09:19:59 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pFWKz-001YR3-2k;
        Wed, 11 Jan 2023 09:19:59 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pFWL0-003Bk8-S1;
        Wed, 11 Jan 2023 09:19:58 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Vincent Tremblay <vincent@vtremblay.dev>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: trivial-devices: Remove trailing whitespace
Date:   Wed, 11 Jan 2023 09:19:53 +0100
Message-Id: <7c1b2700f3727e94600f5f7e10beef16f8dc64ed.1673425053.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Remove trailing whitespace that hurts my eyes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
FWIW
Fixes: f7879d677e76d0c4 ("dt-bindings: trivial-devices: Add silabs,si3210")

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 7da40dadfe2eb4b1..b13f280f36fab608 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -325,7 +325,7 @@ properties:
           - sgx,vz89x
             # Silicon Labs EM3581 Zigbee SoC with SPI interface
           - silabs,em3581
-            # Silicon Labs SI3210 Programmable CMOS SLIC/CODEC with SPI interface 
+            # Silicon Labs SI3210 Programmable CMOS SLIC/CODEC with SPI interface
           - silabs,si3210
             # Relative Humidity and Temperature Sensors
           - silabs,si7020
-- 
2.34.1

