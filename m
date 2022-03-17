Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60E94DCB40
	for <lists+linux-spi@lfdr.de>; Thu, 17 Mar 2022 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbiCQQZu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Mar 2022 12:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbiCQQZt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Mar 2022 12:25:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DCF4D370B;
        Thu, 17 Mar 2022 09:24:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 149C01684;
        Thu, 17 Mar 2022 09:24:30 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.196.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D97E3F7B4;
        Thu, 17 Mar 2022 09:24:28 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        George Hilliard <thirtythreeforty@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Subject: [PATCH v2 12/12] ARM: dts: suniv: licheepi-nano: add SPI flash
Date:   Thu, 17 Mar 2022 16:23:49 +0000
Message-Id: <20220317162349.739636-13-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317162349.739636-1-andre.przywara@arm.com>
References: <20220317162349.739636-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Most LicheePi Nano boards come with soldered SPI flash, so enable SPI0
in the .dts and describe the flash chip. There is evidence of different
flash chips used, also of boards with no flash chip soldered, but the
Winbond 16MiB model is the most common, so use that for the compatible
string.  The actual flash chip model will be auto-detected at runtime
anyway.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
index 8fa79a1d1d2d..04e59b8381cb 100644
--- a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
+++ b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
@@ -13,6 +13,7 @@ / {
 	aliases {
 		mmc0 = &mmc0;
 		serial0 = &uart0;
+		spi0 = &spi0;
 	};
 
 	chosen {
@@ -35,6 +36,20 @@ &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 };
 
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pc_pins>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q128", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pe_pins>;
-- 
2.25.1

