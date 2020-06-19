Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138A12007DB
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 13:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgFSLcM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 07:32:12 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:58691 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731756AbgFSLbt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Jun 2020 07:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592566308; x=1624102308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p+8RoWLbgzQ96coLA+SJ/+5qhlXapbbgZpZg9wtUuf4=;
  b=mPvSu8OVn478ibndydbJZtrUMrup77in0GRY4W9TLLnIz1juZJGRewDU
   h0NB1idHg/ttZ17n2L/UF1hJJ7vflTXCJ97BtGhfpNerjYeEiFqs/OqGt
   4M/MkfJl+oofiGqUGoZiKtJ+6oTWX+y1ql/9XwVuygnkGOea3+lk3bpRL
   +ajDSLzqGC7m3HnHaG1JSXijA30uUqd6B2/DnYAs5V56SpcxctU+erSg4
   nZ8xekQXEUnFdlQYMjGQpE0Xjv7unbXqJyDjtoHyBVIBudQvtc4fK7hwe
   gYEvlrCVlQOA8t2y3lnDQEK+fRkt7wq/C3JjUPZcBGmbYNut78Y4wV+MM
   Q==;
IronPort-SDR: 7kjYpE4qCwU7hpIjsZCmnRIAd63u0JaCTHfE16IVpCjaQ2e6/R8xLUWIuAK4TWhSkZMVlPBqUx
 k/J21FbffWBfXn9Lyq+n+lrdD+MFdotgtghkdXt9jJE1iJEKpVa7Y1Xo/WVcLR/nEhtDcadQ6A
 64zHnZLFZQPRgDD4ukTi/TJTK0TYQqGVUdaHWFruG7I+rPWADwZjcQuAam79wLfsQTlqIaLcs9
 SN6CxnQ50EAExGTADKCK9Fy/8NUWjQgrkjKOaPwa7Mx1UvYxSVnfvaURqLEe9r5oh0AQP4kG/Q
 fWU=
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="84298554"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jun 2020 04:31:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 04:31:45 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 19 Jun 2020 04:31:35 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v2 5/6] arm64: dts: sparx5: Add spi-nor support
Date:   Fri, 19 Jun 2020 13:31:20 +0200
Message-ID: <20200619113121.9984-6-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619113121.9984-1-lars.povlsen@microchip.com>
References: <20200619113121.9984-1-lars.povlsen@microchip.com>
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

