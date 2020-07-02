Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5E82120C6
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 12:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgGBKPY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 06:15:24 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:18767 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgGBKOu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jul 2020 06:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593684890; x=1625220890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p+8RoWLbgzQ96coLA+SJ/+5qhlXapbbgZpZg9wtUuf4=;
  b=GJj+1DOkln24GRlGFBpvMq1qpTMSFWmYDWibmiGBRDNXhb5Voc2UIRNL
   jDWPxtjsaJKKhLp/MC/FfWHwkwYnAgY3QVET88qhEjDEggXDY2DFROyzQ
   xMXss6HrZm+V5/i2wvECVwOT9eFACmC7wrPXSpywxaBK/oCytJYAeBLIe
   XAuh71VTLQzDPO4REY+RVnQWmkMPztIONjmzMOpy6YsIHanskbtugLFJ5
   SNpv9F1U+D6IWZHJBSdjvDLpUv6uu7FbDVED1cQrWySPcyD9pGr6O+6TJ
   +lBZu7LZX3yZqjtWqgHyosad/j5IkWUWIbmE24R0YD3YY/aQHMZmoDtZt
   Q==;
IronPort-SDR: YCec0Nw7lZbTX3YCKGVjHYdOZQZuUN/hEwuk5HMGqMUaU6VD2jqa3ZVJxho9kVdS24/2MCMqLu
 cb25i4weKmlzz+cKCBy8qZbKkVw/mz0uHEbyvl3K/CYb4bbHLHL+mCJ7WLeVm36dSpjZPTFtoH
 Spt5KIkYBrWIjmo7f7YqkxEHcZeoc9YDHaUi1enN/QZb015yJRxWcBuZNQGai78cHK9/ycbhCA
 uFRsXnwm4cYkXfFthnKlZs0CfADzb89w+Pz+b/uFcFLJhMQv1UhFEjjuylbnsL2gUNQ2g+3eHJ
 Xpg=
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="82369352"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 03:14:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 03:14:29 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 2 Jul 2020 03:14:27 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v3 7/8] arm64: dts: sparx5: Add spi-nor support
Date:   Thu, 2 Jul 2020 12:13:30 +0200
Message-ID: <20200702101331.26375-8-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702101331.26375-1-lars.povlsen@microchip.com>
References: <20200702101331.26375-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This add spi-nor device nodes to the Sparx5 reference boards.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5_pcb125.dts        | 9 +++++++++
 arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi | 9 +++++++++
 arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi | 9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts b/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
index 573309fe45823..d8b5d23abfab0 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
@@ -39,6 +39,15 @@ &sdhci0 {
 	microchip,clock-delay = <10>;
 };
 
+&spi0 {
+	status = "okay";
+	spi-flash@0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <8000000>; /* input clock */
+		reg = <0>; /* CS0 */
+	};
+};
+
 &i2c1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
index 18a535a043686..628a05d3f57ce 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
@@ -38,6 +38,15 @@ gpio-restart {
 	};
 };
 
+&spi0 {
+	status = "okay";
+	spi-flash@0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <8000000>;
+		reg = <0>;
+	};
+};
+
 &gpio {
 	i2cmux_pins_i: i2cmux-pins-i {
 	       pins = "GPIO_16", "GPIO_17", "GPIO_18", "GPIO_19",
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
index d71f11a10b3d2..fb0bc3b241204 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
@@ -51,6 +51,15 @@ i2cmux_s32: i2cmux-3 {
 	};
 };
 
+&spi0 {
+	status = "okay";
+	spi-flash@0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <8000000>;
+		reg = <0>;
+	};
+};
+
 &axi {
 	i2c0_imux: i2c0-imux@0 {
 		compatible = "i2c-mux-pinctrl";
-- 
2.27.0

