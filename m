Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0FA913CA63
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 18:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgAORHu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jan 2020 12:07:50 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:38833 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729010AbgAORHu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jan 2020 12:07:50 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 00FGN4nS021581;
        Wed, 15 Jan 2020 18:23:04 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 5AFCE60328; Wed, 15 Jan 2020 18:23:04 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 3/4] dt-binding: spi: add NPCM PSPI reset binding
Date:   Wed, 15 Jan 2020 18:23:00 +0200
Message-Id: <20200115162301.235926-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200115162301.235926-1-tmaimon77@gmail.com>
References: <20200115162301.235926-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add NPCM Peripheral SPI reset binding documentation,
Removing unnecessary aliases use.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../devicetree/bindings/spi/nuvoton,npcm-pspi.txt    | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
index 1fd9a4406a1d..b98203ca656d 100644
--- a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
@@ -12,6 +12,7 @@ Required properties:
  - clock-names: Should be "clk_apb5".
  - pinctrl-names : a pinctrl state named "default" must be defined.
  - pinctrl-0 : phandle referencing pin configuration of the device.
+ - resets : phandle to the reset control for this device.
  - cs-gpios: Specifies the gpio pins to be used for chipselects.
             See: Documentation/devicetree/bindings/spi/spi-bus.txt
 
@@ -19,16 +20,6 @@ Optional properties:
 - clock-frequency : Input clock frequency to the PSPI block in Hz.
 		    Default is 25000000 Hz.
 
-Aliases:
-- All the SPI controller nodes should be represented in the aliases node using
-  the following format 'spi{n}' withe the correct numbered in "aliases" node.
-
-Example:
-
-aliases {
-	spi0 = &spi0;
-};
-
 spi0: spi@f0200000 {
 	compatible = "nuvoton,npcm750-pspi";
 	reg = <0xf0200000 0x1000>;
@@ -39,5 +30,6 @@ spi0: spi@f0200000 {
 	interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 	clocks = <&clk NPCM7XX_CLK_APB5>;
 	clock-names = "clk_apb5";
+	resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_PSPI1>
 	cs-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
 };
-- 
2.22.0

