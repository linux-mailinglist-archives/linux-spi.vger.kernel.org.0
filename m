Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586FC1F8E2E
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 08:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgFOGro (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 02:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbgFOGrP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:15 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E49B2067B;
        Mon, 15 Jun 2020 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203632;
        bh=fv0MzJ8bIKCwSrIThq9x0hNnlzQ27eGxPFmXO+dIS00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hzwv+xEXH5jb9Hia7ucOdQ5hRa/40+9UQBu1bs8agR2EBLgoAOHNadiHf4lOkLjOp
         bynK+1U49kBQ4et91TbnzHpT3uaeIx1IPJUurjfaKrwA6m/YlO3Dh6keJahgaZDEis
         US0EwvYWYmZ+1G89Kuiqo5T9Gb6tDcR3EuCHeJcs=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkith-009nmv-RU; Mon, 15 Jun 2020 08:47:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 14/29] dt: Fix broken references to renamed docs
Date:   Mon, 15 Jun 2020 08:46:53 +0200
Message-Id: <6866c0d6d10ce36bb151c2d3752a20eb5122c532.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some files got renamed. Those were all fixed automatically by

	./scripts/documentation-file-ref-check --fix

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt   | 2 +-
 Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt | 4 ++--
 Documentation/devicetree/bindings/display/imx/ldb.txt         | 4 ++--
 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt  | 2 +-
 MAINTAINERS                                                   | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 715047444391..10b8459e49f8 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -47,7 +47,7 @@ Required properties:
 			  &lsio_mu1 1 2
 			  &lsio_mu1 1 3
 			  &lsio_mu1 3 3>;
-		See Documentation/devicetree/bindings/mailbox/fsl,mu.txt
+		See Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
 		for detailed mailbox binding.
 
 Note: Each mu which supports general interrupt should have an alias correctly
diff --git a/Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt b/Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt
index 5bf77f6dd19d..5a99490c17b9 100644
--- a/Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt
+++ b/Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt
@@ -68,7 +68,7 @@ Required properties:
   datasheet
 - clocks : phandle to the PRE axi clock input, as described
   in Documentation/devicetree/bindings/clock/clock-bindings.txt and
-  Documentation/devicetree/bindings/clock/imx6q-clock.txt.
+  Documentation/devicetree/bindings/clock/imx6q-clock.yaml.
 - clock-names: should be "axi"
 - interrupts: should contain the PRE interrupt
 - fsl,iram: phandle pointing to the mmio-sram device node, that should be
@@ -94,7 +94,7 @@ Required properties:
   datasheet
 - clocks : phandles to the PRG ipg and axi clock inputs, as described
   in Documentation/devicetree/bindings/clock/clock-bindings.txt and
-  Documentation/devicetree/bindings/clock/imx6q-clock.txt.
+  Documentation/devicetree/bindings/clock/imx6q-clock.yaml.
 - clock-names: should be "ipg" and "axi"
 - fsl,pres: phandles to the PRE units attached to this PRG, with the fixed
   PRE as the first entry and the muxable PREs following.
diff --git a/Documentation/devicetree/bindings/display/imx/ldb.txt b/Documentation/devicetree/bindings/display/imx/ldb.txt
index 38c637fa39dd..8e6e7d797943 100644
--- a/Documentation/devicetree/bindings/display/imx/ldb.txt
+++ b/Documentation/devicetree/bindings/display/imx/ldb.txt
@@ -30,8 +30,8 @@ Required properties:
                 "di2_sel" - IPU2 DI0 mux
                 "di3_sel" - IPU2 DI1 mux
         The needed clock numbers for each are documented in
-        Documentation/devicetree/bindings/clock/imx5-clock.txt, and in
-        Documentation/devicetree/bindings/clock/imx6q-clock.txt.
+        Documentation/devicetree/bindings/clock/imx5-clock.yaml, and in
+        Documentation/devicetree/bindings/clock/imx6q-clock.yaml.
 
 Optional properties:
  - pinctrl-names : should be "default" on i.MX53, not used on i.MX6q
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
index 790311a42bf1..c8c1e913f4e7 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
@@ -19,7 +19,7 @@ Required properties:
 
 SPI Controller nodes must be child of GENI based Qualcomm Universal
 Peripharal. Please refer GENI based QUP wrapper controller node bindings
-described in Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt.
+described in Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml.
 
 SPI slave nodes must be children of the SPI master node and conform to SPI bus
 binding as described in Documentation/devicetree/bindings/spi/spi-bus.txt.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0617dd671c2d..452904d75228 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14561,8 +14561,8 @@ RENESAS R-CAR THERMAL DRIVERS
 M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
 L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
-F:	Documentation/devicetree/bindings/thermal/rcar-thermal.txt
+F:	Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
+F:	Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
 F:	drivers/thermal/rcar_gen3_thermal.c
 F:	drivers/thermal/rcar_thermal.c
 
-- 
2.26.2

