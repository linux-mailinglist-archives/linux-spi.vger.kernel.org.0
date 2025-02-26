Return-Path: <linux-spi+bounces-6947-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F64A46270
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 15:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CB83B39B4
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519CB225765;
	Wed, 26 Feb 2025 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV+P/RRp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239A224B1C;
	Wed, 26 Feb 2025 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579560; cv=none; b=Vbn8dUdoFyJifS78MsB76zldhKQn4TutcFCzHFaraKtAdr3Rt/k80G3o0Rij8+zdpAx+1Uh+e41OP93Wbve1b04wLasHddrX1aj0dqHipuWTCTVPPXdm/1DKo+rid6W6laBbp3Et5YF16vQDW5t0pMUduDLClCejGH8NuQaX/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579560; c=relaxed/simple;
	bh=DZAIwy474BxHnWdTlinCOI4ZDC7nNWcwJwZumH78k00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W1ez+QGhUmFl1PerfBN+KcENmRNpMEtK4N0vwg4lddjwYr1t4p24vgILgDY060HEU84m2Wr1saShP03gH1IBmpaRdNz8nFmjKOowA0g/j8atGnGPVThLr6NW9mec4OkMp7j/nYbPwqXMcL5x0YV1pHOo2fhZadoNCOipKpT6v8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV+P/RRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 985C0C4CEEE;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579559;
	bh=DZAIwy474BxHnWdTlinCOI4ZDC7nNWcwJwZumH78k00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cV+P/RRp2xszlVr9z1Vh0ArX36PmCwNCY1byzVrJRksOTBkxsf2BI8J0AXmW8fSTt
	 65uFKdaL2LrtnAXSKQPPeAYs5xrpwZ80fDPSO92cjHVNXFSgiWUmBtbTzSEUn252fZ
	 7pvZaKzXZvbzC+p3eXFRsQj92SIuTynhQLz6HZvCPoQfrSUw/2rXHbGlDulys40Ssz
	 sG/lcEag+uXZfBTkrN1QieJAER/LXlyWmGG1ectMy1qW7vtVGAyIG0LYHsmFmcHgzO
	 ijlJ4jC0p29+9NPGJMbkH/HrN0oQVpaNH4xNYPgrw4VjouvZnZNfR0Mvqa4xVZCl+q
	 pe8/jOzE24mdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8281EC18E7C;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Wed, 26 Feb 2025 15:19:21 +0100
Subject: [PATCH v2 10/12] arm64: dts: freescale: Add the BOE av101hdt-a10
 variant of the Moduline Display
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-initial_display-v2-10-23fafa130817@gocontroll.com>
References: <20250226-initial_display-v2-0-23fafa130817@gocontroll.com>
In-Reply-To: <20250226-initial_display-v2-0-23fafa130817@gocontroll.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579556; l=3190;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=jB1HgPWOK0qbF1v4On/PUYtz6lbKCTwFh2VYt8OMzz4=;
 b=Y/ty2Qd/tgxvUGQu2YuP6KaAr2NTRWw5TQb+z6gOG+HGlQgkhlH1vOYzKDtBwgGFnNu7lI14J
 MzuYpucjN3RDDD0Gzh7KlUMmsMcV8mpSfRvzSdqFwoCM7DC2cr6Ks1B
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Add the BOE av101hdt-a10 variant of the Moduline Display, this variant
comes with a 10.1 1280x720 display with a touchscreen (not working in
mainline).

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>

---
Currently the backlight driver is not available, this will be upstreamed
in a future patch series. It is a Maxim max25014atg.

The touchscreen has a Cypress CYAT81658-64AS48 controller which as far as
I know is not supported upstream, the driver we currently use for this is
a mess and I doubt we will be able to get it in an upstreamable state.
---
 ...tx8p-ml81-moduline-display-106-av101hdt-a10.dts | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av101hdt-a10.dts b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av101hdt-a10.dts
new file mode 100644
index 0000000000000000000000000000000000000000..1917e22001a1815a6540f00cf039ff352801cda8
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av101hdt-a10.dts
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2025 GOcontroll B.V.
+ * Author: Maud Spierings <maudspierings@gocontroll.com>
+ */
+
+/dts-v1/;
+
+#include "imx8mp-tx8p-ml81-moduline-display-106.dtsi"
+
+/ {
+	model = "GOcontroll Moduline Display with BOE av101hdt-a10 display";
+
+	panel {
+		compatible = "boe,av101hdt-a10";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_panel>;
+		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+		power-supply = <&reg_3v3_per>;
+
+		port {
+			panel_lvds_in: endpoint {
+				remote-endpoint = <&ldb_lvds_ch0>;
+			};
+		};
+	};
+
+	reg_vbus: regulator-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb-c-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		power-supply = <&reg_6v4>;
+		regulator-always-on;
+	};
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
+
+&usb3_phy1 {
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+
+	port {
+		usb1_hs_ep: endpoint {
+			remote-endpoint = <&high_speed_ep>;
+		};
+	};
+
+	connector {
+		compatible = "usb-c-connector";
+		pd-disable;
+		data-role = "host";
+		vbus-supply = <&reg_vbus>;
+
+		port {
+			high_speed_ep: endpoint {
+				remote-endpoint = <&usb1_hs_ep>;
+			};
+		};
+	};
+};
+
+&lvds_bridge {
+	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>,
+	<&clk IMX8MP_VIDEO_PLL1>;
+	assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;
+	/* IMX8MP_VIDEO_PLL1 = IMX8MP_CLK_MEDIA_DISP2_PIX * 2 * 7 */
+	assigned-clock-rates = <0>, <1054620000>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			ldb_lvds_ch0: endpoint {
+				remote-endpoint = <&panel_lvds_in>;
+			};
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_panel: panelgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07 /* COM pin 157 */
+			MX8MP_DSE_X1
+			MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09 /* COM pin 159 */
+			MX8MP_DSE_X1
+		>;
+	};
+};

-- 
2.48.1



