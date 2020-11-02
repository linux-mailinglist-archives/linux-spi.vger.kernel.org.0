Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6B32A259F
	for <lists+linux-spi@lfdr.de>; Mon,  2 Nov 2020 08:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgKBHxC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Nov 2020 02:53:02 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:18018 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgKBHxC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Nov 2020 02:53:02 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 0A27mtgo046598;
        Mon, 2 Nov 2020 15:48:55 +0800 (GMT-8)
        (envelope-from chin-ting_kuo@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 2 Nov
 2020 15:52:23 +0800
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <clg@kaod.org>, <bbrezillon@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-spi@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH 3/4] ARM: dts: aspeed: ast2600-evb: Adjust SPI flash configuration
Date:   Mon, 2 Nov 2020 15:52:12 +0800
Message-ID: <20201102075213.32404-4-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102075213.32404-1-chin-ting_kuo@aspeedtech.com>
References: <20201102075213.32404-1-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 0A27mtgo046598
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

- Enable FMC CS1 and SPI2 CS0 SPI NOR flashes since both of
  these two flashes are mounted on AST2600 EVB by default.
- Remove spi-max-frequency setting: 50MHz is usual SPI bus
  frequency adopted on AST2600 EVB which has already been
  configured in aspeed-g6.dtsi.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 26 ++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 8d0f4656aa05..5a2e4612d155 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -96,12 +96,11 @@
 
 &fmc {
 	status = "okay";
+
 	flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-max-frequency = <50000000>;
-
 		partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
@@ -133,18 +132,37 @@
 			};
 		};
 	};
+
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "fmc0:1";
+	};
 };
 
 &spi1 {
 	status = "okay";
+
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_spi1_default>;
 
 	flash@0 {
 		status = "okay";
 		m25p,fast-read;
-		label = "pnor";
-		spi-max-frequency = <100000000>;
+		label = "spi1:0";
+	};
+};
+
+&spi2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2_default>;
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "spi2:0";
 	};
 };
 
-- 
2.17.1

