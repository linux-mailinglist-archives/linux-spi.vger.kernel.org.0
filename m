Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0083C6DE1
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 11:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbhGMJ5L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 05:57:11 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:35958 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbhGMJ5H (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 05:57:07 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 06134D5BD9;
        Tue, 13 Jul 2021 17:54:09 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P30158T139873832912640S1626170037329023_;
        Tue, 13 Jul 2021 17:53:59 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f4edf0553fb64da733e924475bc5017d>
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
Subject: [PATCH v12 10/10] arm64: dts: rockchip: Enable SFC for Odroid Go Advance
Date:   Tue, 13 Jul 2021 17:53:55 +0800
Message-Id: <20210713095355.3249-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210713094718.1709-1-jon.lin@rock-chips.com>
References: <20210713094718.1709-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

This enables the Rockchip Serial Flash Controller for the Odroid Go
Advance. Note that while the attached SPI NOR flash and the controller
both support quad read mode, only 2 of the required 4 pins are present.
The rx bus width is set to 2 for this reason, and tx bus width is set
to 1 for compatibility reasons.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v12: None
Changes in v11:
- The tx is set to 1 for Odroid Go Advance device

Changes in v10: None
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
index 49c97f76df77..4410a6ef5ada 100644
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
+		spi-tx-bus-width = <1>;
+	};
+};
+
 &tsadc {
 	status = "okay";
 };
-- 
2.17.1



