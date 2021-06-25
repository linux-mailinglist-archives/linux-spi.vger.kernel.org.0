Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E32E3B3F4C
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jun 2021 10:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhFYIa5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Jun 2021 04:30:57 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:52318 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFYIat (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Jun 2021 04:30:49 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 04463D5AC0;
        Fri, 25 Jun 2021 16:28:28 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P5175T139828399277824S1624609700131161_;
        Fri, 25 Jun 2021 16:28:21 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <26a5f75aa850e77c02c8ca96857f5a94>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: linux-spi@vger.kernel.org
X-RCPT-COUNT: 20
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     linux-spi@vger.kernel.org
Cc:     jon.lin@rock-chips.com, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, macroalpha82@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC PATCH v9 10/10] arm64: dts: rockchip: Enable SFC for Odroid Go Advance
Date:   Fri, 25 Jun 2021 16:28:18 +0800
Message-Id: <20210625082818.884-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210625082735.562-1-jon.lin@rock-chips.com>
References: <20210625082735.562-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

This enables the Rockchip Serial Flash Controller for the Odroid Go
Advance. Note that while the attached SPI NOR flash and the controller
both support quad read mode, only 2 of the required 4 pins are present.
The rx and tx bus width is set to 2 for this reason.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 .../boot/dts/rockchip/rk3326-odroid-go2.dts      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index 49c97f76df77..f78e11dd8447 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -484,6 +484,22 @@
 	status = "okay";
 };
 
+&sfc {
+	pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus2>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <108000000>;
+		spi-rx-bus-width = <2>;
+		spi-tx-bus-width = <2>;
+	};
+};
+
 &tsadc {
 	status = "okay";
 };
-- 
2.17.1



