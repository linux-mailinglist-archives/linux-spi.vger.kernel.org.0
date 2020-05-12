Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B7B1CFFC9
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 22:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbgELUpz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 16:45:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46372 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731230AbgELUpy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 16:45:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id z25so11643985otq.13;
        Tue, 12 May 2020 13:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5EWPkkP6N2ZUkvWsPqjNMm42jFiR+PsyeCzyPsXfEfE=;
        b=Q4rsH8tVOAv/DptsgDmCVKmuVVCnerkCJhImyi75FUTJsdeK/BaBOOwuMqpT8UnzSj
         k+oja0diFrIfwyzdk6prExPcvco132y/QM2uWY0IOI4TtMiBDLH0QDbltvfskcuZGrgv
         +YH/u0cSmTwrsw9Dd3wahPX9CUA7hj8BeKPdr7pFOEWO3OqqROvXwPmwbTD26kFMIpIg
         rFx06VcvqTdjL67SpNMIQk6Cifb0LkJ29jA1211gt7CJjf7f7/v5rsktUqlC7yFBK26G
         I1felu+G2DPpWLg7oXjuWxpbxa+8CNZePzJICrz1SMq/fZc3LORL6B/p1go0dnLG7REB
         XEiA==
X-Gm-Message-State: AGi0PuaHBlAD9fDWMfR+2p4UNteF2BcjPCCnDK4Qmw75Hl04rbSxr9WT
        Bv7Gle+Rpr3/qlCmb1AY300uJr4=
X-Google-Smtp-Source: APiQypIVg8NKBuftBdufqod90vPf7/pfXTIFl/IuNO85tZQfoNa5GtAiWTsa9VmXsnEq0cOrs4LTyA==
X-Received: by 2002:a9d:69c9:: with SMTP id v9mr18809926oto.267.1589316350270;
        Tue, 12 May 2020 13:45:50 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k8sm3943792ood.24.2020.05.12.13.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 13:45:49 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5/5] dt-bindings: Fix incorrect 'reg' property sizes
Date:   Tue, 12 May 2020 15:45:43 -0500
Message-Id: <20200512204543.22090-5-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512204543.22090-1-robh@kernel.org>
References: <20200512204543.22090-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The examples template is a 'simple-bus' with a size of 1 cell for
#address-cells and #size-cells. The schema was only checking the entries
had between 2 and 4 cells which really only errors on I2C or SPI type
devices with a single cell.

The easiest fix in most cases is to change the 'reg' property to for 1 cell
address and size. In some cases with child devices having 2 cells, that
doesn't make sense so a bus node is needed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/coresight-cti.yaml           |  2 +-
 .../devicetree/bindings/arm/renesas,prr.yaml  |  2 +-
 .../arm/tegra/nvidia,tegra20-pmc.yaml         |  2 +-
 .../bindings/clock/bitmain,bm1880-clk.yaml    |  2 +-
 .../devicetree/bindings/clock/fsl,plldig.yaml |  2 +-
 .../bindings/clock/qcom,gcc-sc7180.yaml       |  2 +-
 .../bindings/clock/qcom,gcc-sm8150.yaml       |  2 +-
 .../bindings/clock/qcom,gcc-sm8250.yaml       |  2 +-
 .../bindings/clock/qcom,sc7180-dispcc.yaml    |  2 +-
 .../bindings/clock/qcom,sc7180-gpucc.yaml     |  2 +-
 .../bindings/clock/qcom,sc7180-mss.yaml       |  2 +-
 .../bindings/clock/qcom,sc7180-videocc.yaml   |  2 +-
 .../bindings/clock/qcom,sdm845-dispcc.yaml    |  2 +-
 .../bindings/clock/qcom,sdm845-gpucc.yaml     |  2 +-
 .../bindings/clock/qcom,sdm845-videocc.yaml   |  2 +-
 .../bindings/clock/sprd,sc9863a-clk.yaml      | 29 +++---
 .../bindings/crypto/amlogic,gxl-crypto.yaml   |  2 +-
 .../bindings/display/renesas,cmm.yaml         |  2 +-
 .../bindings/display/ti/ti,am65x-dss.yaml     | 14 +--
 .../bindings/display/ti/ti,j721e-dss.yaml     | 34 +++----
 .../bindings/dma/sifive,fu540-c000-pdma.yaml  |  2 +-
 .../devicetree/bindings/gpio/sifive,gpio.yaml |  2 +-
 .../bindings/interconnect/qcom,sc7180.yaml    |  6 +-
 .../bindings/interconnect/qcom,sdm845.yaml    |  4 +-
 .../interrupt-controller/renesas,irqc.yaml    |  2 +-
 .../media/amlogic,meson-gx-ao-cec.yaml        |  2 +-
 .../bindings/media/qcom,sc7180-venus.yaml     |  2 +-
 .../bindings/media/qcom,sdm845-venus-v2.yaml  |  2 +-
 .../bindings/media/qcom,sdm845-venus.yaml     |  2 +-
 .../bindings/media/renesas,csi2.yaml          |  2 +-
 .../bindings/media/renesas,vin.yaml           |  6 +-
 .../nvidia,tegra124-emc.yaml                  |  4 +-
 .../nvidia,tegra124-mc.yaml                   |  2 +-
 .../devicetree/bindings/mmc/owl-mmc.yaml      |  2 +-
 .../bindings/mmc/rockchip-dw-mshc.yaml        |  2 +-
 .../devicetree/bindings/net/qcom,ipa.yaml     |  6 +-
 .../bindings/net/renesas,ether.yaml           |  2 +-
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml   | 91 ++++++++++---------
 .../amlogic,meson-axg-mipi-pcie-analog.yaml   |  2 +-
 .../bindings/phy/amlogic,meson-axg-pcie.yaml  |  2 +-
 .../bindings/phy/phy-cadence-torrent.yaml     | 44 +++++----
 .../bindings/phy/rockchip,px30-dsi-dphy.yaml  |  2 +-
 .../pinctrl/aspeed,ast2500-pinctrl.yaml       |  2 +-
 .../bindings/pwm/renesas,pwm-rcar.yaml        |  2 +-
 .../bindings/serial/sifive-serial.yaml        |  2 +-
 .../bindings/sound/amlogic,aiu.yaml           |  3 +-
 .../bindings/sound/amlogic,g12a-toacodec.yaml |  2 +-
 .../bindings/sound/amlogic,t9015.yaml         |  3 +-
 .../bindings/spi/renesas,sh-msiof.yaml        |  2 +-
 .../devicetree/bindings/spi/spi-sifive.yaml   |  2 +-
 .../bindings/thermal/rcar-thermal.yaml        |  6 +-
 .../bindings/thermal/sprd-thermal.yaml        |  2 +-
 .../usb/amlogic,meson-g12a-usb-ctrl.yaml      |  3 +-
 .../devicetree/bindings/usb/generic-ehci.yaml |  2 +-
 .../bindings/usb/nvidia,tegra-xudc.yaml       |  6 +-
 .../bindings/usb/renesas,usb3-peri.yaml       |  2 +-
 .../bindings/usb/renesas,usbhs.yaml           |  2 +-
 .../devicetree/bindings/usb/ti,j721e-usb.yaml | 54 ++++++-----
 .../bindings/watchdog/ti,rti-wdt.yaml         |  2 +-
 59 files changed, 204 insertions(+), 195 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight-cti.yaml b/Documentation/devicetree/bindings/arm/coresight-cti.yaml
index 6b31008d67b5..17df5cd12d8d 100644
--- a/Documentation/devicetree/bindings/arm/coresight-cti.yaml
+++ b/Documentation/devicetree/bindings/arm/coresight-cti.yaml
@@ -295,7 +295,7 @@ examples:
   - |
     cti@20110000 {
       compatible = "arm,coresight-cti", "arm,primecell";
-      reg = <0 0x20110000 0 0x1000>;
+      reg = <0x20110000 0x1000>;
 
       clocks = <&soc_smc50mhz>;
       clock-names = "apb_pclk";
diff --git a/Documentation/devicetree/bindings/arm/renesas,prr.yaml b/Documentation/devicetree/bindings/arm/renesas,prr.yaml
index dd087643a9f8..1f80767da38b 100644
--- a/Documentation/devicetree/bindings/arm/renesas,prr.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas,prr.yaml
@@ -33,5 +33,5 @@ examples:
   - |
     prr: chipid@ff000044 {
         compatible = "renesas,prr";
-        reg = <0 0xff000044 0 4>;
+        reg = <0xff000044 4>;
     };
diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
index f17bb353f65e..81534d04094b 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
@@ -323,7 +323,7 @@ examples:
 
     tegra_pmc: pmc@7000e400 {
               compatible = "nvidia,tegra210-pmc";
-              reg = <0x0 0x7000e400 0x0 0x400>;
+              reg = <0x7000e400 0x400>;
               clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
               clock-names = "pclk", "clk32k_in";
               #clock-cells = <1>;
diff --git a/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
index 8559fe8f7efd..228c9313df53 100644
--- a/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
@@ -65,7 +65,7 @@ examples:
   - |
     uart0: serial@58018000 {
          compatible = "snps,dw-apb-uart";
-         reg = <0x0 0x58018000 0x0 0x2000>;
+         reg = <0x58018000 0x2000>;
          clocks = <&clk 45>, <&clk 46>;
          clock-names = "baudclk", "apb_pclk";
          interrupts = <0 9 4>;
diff --git a/Documentation/devicetree/bindings/clock/fsl,plldig.yaml b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
index 8141f22410dd..9ac716dfa602 100644
--- a/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
+++ b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
@@ -50,7 +50,7 @@ examples:
   - |
     dpclk: clock-display@f1f0000 {
         compatible = "fsl,ls1028a-plldig";
-        reg = <0x0 0xf1f0000 0x0 0xffff>;
+        reg = <0xf1f0000 0xffff>;
         #clock-cells = <0>;
         clocks = <&osc_27m>;
     };
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
index a345320e0e49..a404c8fbee67 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
@@ -65,7 +65,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmh.h>
     clock-controller@100000 {
       compatible = "qcom,gcc-sc7180";
-      reg = <0 0x00100000 0 0x1f0000>;
+      reg = <0x00100000 0x1f0000>;
       clocks = <&rpmhcc RPMH_CXO_CLK>,
                <&rpmhcc RPMH_CXO_CLK_A>,
                <&sleep_clk>;
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml
index 36f3b3668ced..12766a866625 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml
@@ -63,7 +63,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmh.h>
     clock-controller@100000 {
       compatible = "qcom,gcc-sm8150";
-      reg = <0 0x00100000 0 0x1f0000>;
+      reg = <0x00100000 0x1f0000>;
       clocks = <&rpmhcc RPMH_CXO_CLK>,
                <&sleep_clk>;
       clock-names = "bi_tcxo", "sleep_clk";
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
index 2c40a8aa9815..a5766ff89082 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
@@ -61,7 +61,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmh.h>
     clock-controller@100000 {
       compatible = "qcom,gcc-sm8250";
-      reg = <0 0x00100000 0 0x1f0000>;
+      reg = <0x00100000 0x1f0000>;
       clocks = <&rpmhcc RPMH_CXO_CLK>,
                <&sleep_clk>;
       clock-names = "bi_tcxo", "sleep_clk";
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
index 58cdfd5924d3..e94847f92770 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
@@ -66,7 +66,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmh.h>
     clock-controller@af00000 {
       compatible = "qcom,sc7180-dispcc";
-      reg = <0 0x0af00000 0 0x200000>;
+      reg = <0x0af00000 0x200000>;
       clocks = <&rpmhcc RPMH_CXO_CLK>,
                <&gcc GCC_DISP_GPLL0_CLK_SRC>,
                <&dsi_phy 0>,
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-gpucc.yaml
index 8635e35fd3f0..fe08461fce05 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7180-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7180-gpucc.yaml
@@ -60,7 +60,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmh.h>
     clock-controller@5090000 {
       compatible = "qcom,sc7180-gpucc";
-      reg = <0 0x05090000 0 0x9000>;
+      reg = <0x05090000 0x9000>;
       clocks = <&rpmhcc RPMH_CXO_CLK>,
                <&gcc GCC_GPU_GPLL0_CLK_SRC>,
                <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml
index 0dd5d25ae7d7..970030986a86 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml
@@ -50,7 +50,7 @@ examples:
     #include <dt-bindings/clock/qcom,gcc-sc7180.h>
     clock-controller@41a8000 {
       compatible = "qcom,sc7180-mss";
-      reg = <0 0x041a8000 0 0x8000>;
+      reg = <0x041a8000 0x8000>;
       clocks = <&gcc GCC_MSS_MFAB_AXIS_CLK>,
                <&gcc GCC_MSS_NAV_AXI_CLK>,
                <&gcc GCC_MSS_CFG_AHB_CLK>;
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-videocc.yaml
index 0071b9701960..2feea2b91aa9 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7180-videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7180-videocc.yaml
@@ -55,7 +55,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmh.h>
     clock-controller@ab00000 {
       compatible = "qcom,sc7180-videocc";
-      reg = <0 0x0ab00000 0 0x10000>;
+      reg = <0x0ab00000 0x10000>;
       clocks = <&rpmhcc RPMH_CXO_CLK>;
       clock-names = "bi_tcxo";
       #clock-cells = <1>;
diff --git a/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
index ad47d747a3e4..4a3be733d042 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
@@ -75,7 +75,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmh.h>
     clock-controller@af00000 {
       compatible = "qcom,sdm845-dispcc";
-      reg = <0 0x0af00000 0 0x10000>;
+      reg = <0x0af00000 0x10000>;
       clocks = <&rpmhcc RPMH_CXO_CLK>,
                <&gcc GCC_DISP_GPLL0_CLK_SRC>,
                <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>,
diff --git a/Documentation/devicetree/bindings/clock/qcom,sdm845-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sdm845-gpucc.yaml
index 7a052ac5dc00..8a0c576ba8b3 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sdm845-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sdm845-gpucc.yaml
@@ -60,7 +60,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmh.h>
     clock-controller@5090000 {
       compatible = "qcom,sdm845-gpucc";
-      reg = <0 0x05090000 0 0x9000>;
+      reg = <0x05090000 0x9000>;
       clocks = <&rpmhcc RPMH_CXO_CLK>,
                <&gcc GCC_GPU_GPLL0_CLK_SRC>,
                <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
diff --git a/Documentation/devicetree/bindings/clock/qcom,sdm845-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sdm845-videocc.yaml
index 2a6a81ab0318..f7a0cf53d5f0 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sdm845-videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sdm845-videocc.yaml
@@ -55,7 +55,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmh.h>
     clock-controller@ab00000 {
       compatible = "qcom,sdm845-videocc";
-      reg = <0 0x0ab00000 0 0x10000>;
+      reg = <0x0ab00000 0x10000>;
       clocks = <&rpmhcc RPMH_CXO_CLK>;
       clock-names = "bi_tcxo";
       #clock-cells = <1>;
diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
index bb3a78d8105e..14ae4ea3bc20 100644
--- a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
@@ -76,29 +76,24 @@ examples:
   - |
     ap_clk: clock-controller@21500000 {
       compatible = "sprd,sc9863a-ap-clk";
-      reg = <0 0x21500000 0 0x1000>;
+      reg = <0x21500000 0x1000>;
       clocks = <&ext_26m>, <&ext_32k>;
       clock-names = "ext-26m", "ext-32k";
       #clock-cells = <1>;
     };
 
   - |
-    soc {
-      #address-cells = <2>;
-      #size-cells = <2>;
-
-      ap_ahb_regs: syscon@20e00000 {
-        compatible = "sprd,sc9863a-glbregs", "syscon", "simple-mfd";
-        reg = <0 0x20e00000 0 0x4000>;
-        #address-cells = <1>;
-        #size-cells = <1>;
-        ranges = <0 0 0x20e00000 0x4000>;
-
-        apahb_gate: apahb-gate@0 {
-          compatible = "sprd,sc9863a-apahb-gate";
-          reg = <0x0 0x1020>;
-          #clock-cells = <1>;
-        };
+    syscon@20e00000 {
+      compatible = "sprd,sc9863a-glbregs", "syscon", "simple-mfd";
+      reg = <0x20e00000 0x4000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges = <0 0x20e00000 0x4000>;
+
+      apahb_gate: apahb-gate@0 {
+        compatible = "sprd,sc9863a-apahb-gate";
+        reg = <0x0 0x1020>;
+        #clock-cells = <1>;
       };
     };
 
diff --git a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
index 385b23d255c3..ecf98a9e72b2 100644
--- a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
+++ b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
@@ -45,7 +45,7 @@ examples:
 
     crypto: crypto-engine@c883e000 {
         compatible = "amlogic,gxl-crypto";
-        reg = <0x0 0xc883e000 0x0 0x36>;
+        reg = <0xc883e000 0x36>;
         interrupts = <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>, <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
         clocks = <&clkc CLKID_BLKMV>;
         clock-names = "blkmv";
diff --git a/Documentation/devicetree/bindings/display/renesas,cmm.yaml b/Documentation/devicetree/bindings/display/renesas,cmm.yaml
index 005406c89507..561efaaa5a91 100644
--- a/Documentation/devicetree/bindings/display/renesas,cmm.yaml
+++ b/Documentation/devicetree/bindings/display/renesas,cmm.yaml
@@ -60,7 +60,7 @@ examples:
     cmm0: cmm@fea40000 {
          compatible = "renesas,r8a7796-cmm",
                       "renesas,rcar-gen3-cmm";
-         reg = <0 0xfea40000 0 0x1000>;
+         reg = <0xfea40000 0x1000>;
          power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
          clocks = <&cpg CPG_MOD 711>;
          resets = <&cpg 711>;
diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index 7af21bde32e4..4f9185462ed3 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -122,13 +122,13 @@ examples:
 
     dss: dss@4a00000 {
             compatible = "ti,am65x-dss";
-            reg =   <0x0 0x04a00000 0x0 0x1000>, /* common */
-                    <0x0 0x04a02000 0x0 0x1000>, /* vidl1 */
-                    <0x0 0x04a06000 0x0 0x1000>, /* vid */
-                    <0x0 0x04a07000 0x0 0x1000>, /* ovr1 */
-                    <0x0 0x04a08000 0x0 0x1000>, /* ovr2 */
-                    <0x0 0x04a0a000 0x0 0x1000>, /* vp1 */
-                    <0x0 0x04a0b000 0x0 0x1000>; /* vp2 */
+            reg =   <0x04a00000 0x1000>, /* common */
+                    <0x04a02000 0x1000>, /* vidl1 */
+                    <0x04a06000 0x1000>, /* vid */
+                    <0x04a07000 0x1000>, /* ovr1 */
+                    <0x04a08000 0x1000>, /* ovr2 */
+                    <0x04a0a000 0x1000>, /* vp1 */
+                    <0x04a0b000 0x1000>; /* vp2 */
             reg-names = "common", "vidl1", "vid",
                     "ovr1", "ovr2", "vp1", "vp2";
             ti,am65x-oldi-io-ctrl = <&dss_oldi_io_ctrl>;
diff --git a/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
index eb4b1a266210..bbd76591c180 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
@@ -156,23 +156,23 @@ examples:
 
     dss: dss@4a00000 {
             compatible = "ti,j721e-dss";
-            reg =   <0x00 0x04a00000 0x00 0x10000>, /* common_m */
-                    <0x00 0x04a10000 0x00 0x10000>, /* common_s0*/
-                    <0x00 0x04b00000 0x00 0x10000>, /* common_s1*/
-                    <0x00 0x04b10000 0x00 0x10000>, /* common_s2*/
-                    <0x00 0x04a20000 0x00 0x10000>, /* vidl1 */
-                    <0x00 0x04a30000 0x00 0x10000>, /* vidl2 */
-                    <0x00 0x04a50000 0x00 0x10000>, /* vid1 */
-                    <0x00 0x04a60000 0x00 0x10000>, /* vid2 */
-                    <0x00 0x04a70000 0x00 0x10000>, /* ovr1 */
-                    <0x00 0x04a90000 0x00 0x10000>, /* ovr2 */
-                    <0x00 0x04ab0000 0x00 0x10000>, /* ovr3 */
-                    <0x00 0x04ad0000 0x00 0x10000>, /* ovr4 */
-                    <0x00 0x04a80000 0x00 0x10000>, /* vp1 */
-                    <0x00 0x04aa0000 0x00 0x10000>, /* vp2 */
-                    <0x00 0x04ac0000 0x00 0x10000>, /* vp3 */
-                    <0x00 0x04ae0000 0x00 0x10000>, /* vp4 */
-                    <0x00 0x04af0000 0x00 0x10000>; /* wb */
+            reg =   <0x04a00000 0x10000>, /* common_m */
+                    <0x04a10000 0x10000>, /* common_s0*/
+                    <0x04b00000 0x10000>, /* common_s1*/
+                    <0x04b10000 0x10000>, /* common_s2*/
+                    <0x04a20000 0x10000>, /* vidl1 */
+                    <0x04a30000 0x10000>, /* vidl2 */
+                    <0x04a50000 0x10000>, /* vid1 */
+                    <0x04a60000 0x10000>, /* vid2 */
+                    <0x04a70000 0x10000>, /* ovr1 */
+                    <0x04a90000 0x10000>, /* ovr2 */
+                    <0x04ab0000 0x10000>, /* ovr3 */
+                    <0x04ad0000 0x10000>, /* ovr4 */
+                    <0x04a80000 0x10000>, /* vp1 */
+                    <0x04aa0000 0x10000>, /* vp2 */
+                    <0x04ac0000 0x10000>, /* vp3 */
+                    <0x04ae0000 0x10000>, /* vp4 */
+                    <0x04af0000 0x10000>; /* wb */
             reg-names = "common_m", "common_s0",
                     "common_s1", "common_s2",
                     "vidl1", "vidl2","vid1","vid2",
diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
index e7f2ad7dab5e..d32a71b975fe 100644
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -49,7 +49,7 @@ examples:
   - |
     dma@3000000 {
       compatible = "sifive,fu540-c000-pdma";
-      reg = <0x0 0x3000000 0x0 0x8000>;
+      reg = <0x3000000 0x8000>;
       interrupts = <23 24 25 26 27 28 29 30>;
       #dma-cells = <1>;
     };
diff --git a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
index 418e8381e07c..a0efd8dc2538 100644
--- a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
@@ -57,7 +57,7 @@ examples:
         compatible = "sifive,fu540-c000-gpio", "sifive,gpio0";
         interrupt-parent = <&plic>;
         interrupts = <7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22>;
-        reg = <0x0 0x10060000 0x0 0x1000>;
+        reg = <0x10060000 0x1000>;
         clocks = <&tlclk PRCI_CLK_TLCLK>;
         gpio-controller;
         #gpio-cells = <2>;
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
index 50f78f87f3fb..d01bac80d416 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
@@ -65,21 +65,21 @@ examples:
 
       config_noc: interconnect@1500000 {
             compatible = "qcom,sc7180-config-noc";
-            reg = <0 0x01500000 0 0x28000>;
+            reg = <0x01500000 0x28000>;
             #interconnect-cells = <1>;
             qcom,bcm-voters = <&apps_bcm_voter>;
       };
 
       system_noc: interconnect@1620000 {
             compatible = "qcom,sc7180-system-noc";
-            reg = <0 0x01620000 0 0x17080>;
+            reg = <0x01620000 0x17080>;
             #interconnect-cells = <1>;
             qcom,bcm-voters = <&apps_bcm_voter>;
       };
 
       mmss_noc: interconnect@1740000 {
             compatible = "qcom,sc7180-mmss-noc";
-            reg = <0 0x01740000 0 0x1c100>;
+            reg = <0x01740000 0x1c100>;
             #interconnect-cells = <1>;
             qcom,bcm-voters = <&apps_bcm_voter>;
       };
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
index 8b087e0b0b81..74536747b51d 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
@@ -60,14 +60,14 @@ examples:
 
       mem_noc: interconnect@1380000 {
              compatible = "qcom,sdm845-mem-noc";
-             reg = <0 0x01380000 0 0x27200>;
+             reg = <0x01380000 0x27200>;
              #interconnect-cells = <1>;
              qcom,bcm-voters = <&apps_bcm_voter>;
       };
 
       mmss_noc: interconnect@1740000 {
              compatible = "qcom,sdm845-mmss-noc";
-             reg = <0 0x01740000 0 0x1c1000>;
+             reg = <0x01740000 0x1c1000>;
              #interconnect-cells = <1>;
              qcom,bcm-voter-names = "apps", "disp";
              qcom,bcm-voters = <&apps_bcm_voter>, <&disp_bcm_voter>;
diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
index ee5273b6c5a3..1eead27f0b55 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
@@ -78,7 +78,7 @@ examples:
         compatible = "renesas,irqc-r8a7790", "renesas,irqc";
         #interrupt-cells = <2>;
         interrupt-controller;
-        reg = <0 0xe61c0000 0 0x200>;
+        reg = <0xe61c0000 0x200>;
         interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/Documentation/devicetree/bindings/media/amlogic,meson-gx-ao-cec.yaml b/Documentation/devicetree/bindings/media/amlogic,meson-gx-ao-cec.yaml
index c08e2ddf292a..d93aea6a0258 100644
--- a/Documentation/devicetree/bindings/media/amlogic,meson-gx-ao-cec.yaml
+++ b/Documentation/devicetree/bindings/media/amlogic,meson-gx-ao-cec.yaml
@@ -87,7 +87,7 @@ examples:
   - |
     cec_AO: cec@100 {
         compatible = "amlogic,meson-gx-ao-cec";
-        reg = <0x0 0x00100 0x0 0x14>;
+        reg = <0x00100 0x14>;
         interrupts = <199>;
         clocks = <&clkc_cec>;
         clock-names = "core";
diff --git a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
index 764affa4877e..55f2d67ae34e 100644
--- a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
@@ -115,7 +115,7 @@ examples:
 
         venus: video-codec@aa00000 {
                 compatible = "qcom,sc7180-venus";
-                reg = <0 0x0aa00000 0 0xff000>;
+                reg = <0x0aa00000 0xff000>;
                 interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
                 power-domains = <&videocc VENUS_GDSC>,
                                 <&videocc VCODEC0_GDSC>;
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
index 8552f4ab907e..157dff8057e9 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
@@ -110,7 +110,7 @@ examples:
 
         video-codec@aa00000 {
                 compatible = "qcom,sdm845-venus-v2";
-                reg = <0 0x0aa00000 0 0xff000>;
+                reg = <0x0aa00000 0xff000>;
                 interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
                 clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
                          <&videocc VIDEO_CC_VENUS_AHB_CLK>,
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
index 05cabe4e893a..084e45e2df62 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
@@ -127,7 +127,7 @@ examples:
 
         video-codec@aa00000 {
                 compatible = "qcom,sdm845-venus";
-                reg = <0 0x0aa00000 0 0xff000>;
+                reg = <0x0aa00000 0xff000>;
                 interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
                 clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
                          <&videocc VIDEO_CC_VENUS_AHB_CLK>,
diff --git a/Documentation/devicetree/bindings/media/renesas,csi2.yaml b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
index 408442a0c389..c9e068231d4b 100644
--- a/Documentation/devicetree/bindings/media/renesas,csi2.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
@@ -135,7 +135,7 @@ examples:
 
     csi20: csi2@fea80000 {
             compatible = "renesas,r8a7796-csi2";
-            reg = <0 0xfea80000 0 0x10000>;
+            reg = <0xfea80000 0x10000>;
             interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
             clocks = <&cpg CPG_MOD 714>;
             power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
diff --git a/Documentation/devicetree/bindings/media/renesas,vin.yaml b/Documentation/devicetree/bindings/media/renesas,vin.yaml
index 6d473cdcb16a..53c0a7238bac 100644
--- a/Documentation/devicetree/bindings/media/renesas,vin.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,vin.yaml
@@ -306,7 +306,7 @@ examples:
     vin1: vin@e6ef1000 {
             compatible = "renesas,vin-r8a7790",
                          "renesas,rcar-gen2-vin";
-            reg = <0 0xe6ef1000 0 0x1000>;
+            reg = <0xe6ef1000 0x1000>;
             interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
             clocks = <&cpg CPG_MOD 810>;
             power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
@@ -328,7 +328,7 @@ examples:
 
     vin0: video@e6ef0000 {
             compatible = "renesas,vin-r8a7795";
-            reg = <0 0xe6ef0000 0 0x1000>;
+            reg = <0xe6ef0000 0x1000>;
             interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
             clocks = <&cpg CPG_MOD 811>;
             power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
@@ -365,7 +365,7 @@ examples:
 
     vin2: video@e6ef2000 {
             compatible = "renesas,vin-r8a77970";
-            reg = <0 0xe6ef2000 0 0x1000>;
+            reg = <0xe6ef2000 0x1000>;
             interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
             clocks = <&cpg CPG_MOD 809>;
             power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
index a3b36dea88b6..278549f9e051 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
@@ -337,7 +337,7 @@ examples:
 
     mc: memory-controller@70019000 {
         compatible = "nvidia,tegra124-mc";
-        reg = <0x0 0x70019000 0x0 0x1000>;
+        reg = <0x70019000 0x1000>;
         clocks = <&tegra_car TEGRA124_CLK_MC>;
         clock-names = "mc";
 
@@ -349,7 +349,7 @@ examples:
 
     external-memory-controller@7001b000 {
         compatible = "nvidia,tegra124-emc";
-        reg = <0x0 0x7001b000 0x0 0x1000>;
+        reg = <0x7001b000 0x1000>;
         clocks = <&car TEGRA124_CLK_EMC>;
         clock-names = "emc";
 
diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
index 30d9fb193d7f..84d0339505b1 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
@@ -111,7 +111,7 @@ examples:
   - |
     memory-controller@70019000 {
         compatible = "nvidia,tegra124-mc";
-        reg = <0x0 0x70019000 0x0 0x1000>;
+        reg = <0x70019000 0x1000>;
         clocks = <&tegra_car 32>;
         clock-names = "mc";
 
diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
index 12b40213426d..1380501fb8f0 100644
--- a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
@@ -47,7 +47,7 @@ examples:
   - |
     mmc0: mmc@e0330000 {
         compatible = "actions,owl-mmc";
-        reg = <0x0 0xe0330000 0x0 0x4000>;
+        reg = <0xe0330000 0x4000>;
         interrupts = <0 42 4>;
         clocks = <&cmu 56>;
         resets = <&cmu 23>;
diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index 42d44cbf962f..01316185e771 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -109,7 +109,7 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
     sdmmc: mmc@ff0c0000 {
       compatible = "rockchip,rk3288-dw-mshc";
-      reg = <0x0 0xff0c0000 0x0 0x4000>;
+      reg = <0xff0c0000 0x4000>;
       interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
       clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
                <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index 1ef3087eb7b2..b2ac7606095b 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -162,9 +162,9 @@ examples:
                 modem-init;
                 modem-remoteproc = <&mss_pil>;
 
-                reg = <0 0x1e40000 0 0x7000>,
-                        <0 0x1e47000 0 0x2000>,
-                        <0 0x1e04000 0 0x2c000>;
+                reg = <0x1e40000 0x7000>,
+                        <0x1e47000 0x2000>,
+                        <0x1e04000 0x2c000>;
                 reg-names = "ipa-reg",
                             "ipa-shared",
                             "gsi";
diff --git a/Documentation/devicetree/bindings/net/renesas,ether.yaml b/Documentation/devicetree/bindings/net/renesas,ether.yaml
index 005a3aeaf181..909f4b245c84 100644
--- a/Documentation/devicetree/bindings/net/renesas,ether.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,ether.yaml
@@ -92,7 +92,7 @@ examples:
 
     ethernet@ee700000 {
         compatible = "renesas,ether-r8a7790", "renesas,rcar-gen2-ether";
-        reg = <0 0xee700000 0 0x400>;
+        reg = <0xee700000 0x400>;
         interrupt-parent = <&gic>;
         interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&mstp8_clks R8A7790_CLK_ETHER>;
diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
index e3e9393c91b7..7f2cd163a0e2 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
@@ -164,37 +164,41 @@ examples:
     #include <dt-bindings/soc/ti,sci_pm_domain.h>
     #include <dt-bindings/net/ti-dp83867.h>
 
-    mcu_cpsw: ethernet@46000000 {
-        compatible = "ti,am654-cpsw-nuss";
+    bus {
         #address-cells = <2>;
         #size-cells = <2>;
-        reg = <0x0 0x46000000 0x0 0x200000>;
-        reg-names = "cpsw_nuss";
-        ranges = <0x0 0x0 0x46000000 0x0 0x200000>;
-        dma-coherent;
-        clocks = <&k3_clks 5 10>;
-        clock-names = "fck";
-        power-domains = <&k3_pds 5 TI_SCI_PD_EXCLUSIVE>;
-        pinctrl-names = "default";
-        pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
-
-        dmas = <&mcu_udmap 0xf000>,
-               <&mcu_udmap 0xf001>,
-               <&mcu_udmap 0xf002>,
-               <&mcu_udmap 0xf003>,
-               <&mcu_udmap 0xf004>,
-               <&mcu_udmap 0xf005>,
-               <&mcu_udmap 0xf006>,
-               <&mcu_udmap 0xf007>,
-               <&mcu_udmap 0x7000>;
-        dma-names = "tx0", "tx1", "tx2", "tx3", "tx4", "tx5", "tx6", "tx7",
-                    "rx";
-
-        ethernet-ports {
-              #address-cells = <1>;
-              #size-cells = <0>;
-
-              cpsw_port1: port@1 {
+
+        mcu_cpsw: ethernet@46000000 {
+            compatible = "ti,am654-cpsw-nuss";
+            #address-cells = <2>;
+            #size-cells = <2>;
+            reg = <0x0 0x46000000 0x0 0x200000>;
+            reg-names = "cpsw_nuss";
+            ranges = <0x0 0x0 0x0 0x46000000 0x0 0x200000>;
+            dma-coherent;
+            clocks = <&k3_clks 5 10>;
+            clock-names = "fck";
+            power-domains = <&k3_pds 5 TI_SCI_PD_EXCLUSIVE>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
+
+            dmas = <&mcu_udmap 0xf000>,
+                   <&mcu_udmap 0xf001>,
+                   <&mcu_udmap 0xf002>,
+                   <&mcu_udmap 0xf003>,
+                   <&mcu_udmap 0xf004>,
+                   <&mcu_udmap 0xf005>,
+                   <&mcu_udmap 0xf006>,
+                   <&mcu_udmap 0xf007>,
+                   <&mcu_udmap 0x7000>;
+            dma-names = "tx0", "tx1", "tx2", "tx3", "tx4", "tx5", "tx6", "tx7",
+                        "rx";
+
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                cpsw_port1: port@1 {
                     reg = <1>;
                     ti,mac-only;
                     label = "port1";
@@ -203,22 +207,23 @@ examples:
 
                     phy-mode = "rgmii-rxid";
                     phy-handle = <&phy0>;
-              };
-        };
-
-        davinci_mdio: mdio@f00 {
-              compatible = "ti,cpsw-mdio","ti,davinci_mdio";
-              reg = <0x0 0xf00 0x0 0x100>;
-              #address-cells = <1>;
-              #size-cells = <0>;
-              clocks = <&k3_clks 5 10>;
-              clock-names = "fck";
-              bus_freq = <1000000>;
-
-              phy0: ethernet-phy@0 {
+                };
+            };
+
+            davinci_mdio: mdio@f00 {
+                compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+                reg = <0x0 0xf00 0x0 0x100>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                clocks = <&k3_clks 5 10>;
+                clock-names = "fck";
+                bus_freq = <1000000>;
+
+                phy0: ethernet-phy@0 {
                     reg = <0>;
                     ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
                     ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-              };
+                };
+            };
         };
     };
diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
index 88683db6cf81..18c1ec5e19ad 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
@@ -30,6 +30,6 @@ examples:
   - |
     mpphy: phy@0 {
           compatible = "amlogic,axg-mipi-pcie-analog-phy";
-          reg = <0x0 0x0 0x0 0xc>;
+          reg = <0x0 0xc>;
           #phy-cells = <1>;
     };
diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
index 086478aec946..45f3d72b1cca 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
@@ -44,7 +44,7 @@ examples:
     #include <dt-bindings/phy/phy.h>
     pcie_phy: pcie-phy@ff644000 {
           compatible = "amlogic,axg-pcie-phy";
-          reg = <0x0 0xff644000 0x0 0x1c>;
+          reg = <0xff644000 0x1c>;
           resets = <&reset RESET_PCIE_PHY>;
           phys = <&mipi_analog_phy PHY_TYPE_PCIE>;
           phy-names = "analog";
diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 256dd149698b..4071438be2ba 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -117,24 +117,30 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/phy/phy.h>
-    torrent_phy: torrent-phy@f0fb500000 {
-          compatible = "cdns,torrent-phy";
-          reg = <0xf0 0xfb500000 0x0 0x00100000>,
-                <0xf0 0xfb030a00 0x0 0x00000040>;
-          reg-names = "torrent_phy", "dptx_phy";
-          resets = <&phyrst 0>;
-          clocks = <&ref_clk>;
-          clock-names = "refclk";
-          #address-cells = <1>;
-          #size-cells = <0>;
-          torrent_phy_dp: phy@0 {
-                    reg = <0>;
-                    resets = <&phyrst 1>, <&phyrst 2>,
-                             <&phyrst 3>, <&phyrst 4>;
-                    #phy-cells = <0>;
-                    cdns,phy-type = <PHY_TYPE_DP>;
-                    cdns,num-lanes = <4>;
-                    cdns,max-bit-rate = <8100>;
-          };
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        torrent-phy@f0fb500000 {
+            compatible = "cdns,torrent-phy";
+            reg = <0xf0 0xfb500000 0x0 0x00100000>,
+                  <0xf0 0xfb030a00 0x0 0x00000040>;
+            reg-names = "torrent_phy", "dptx_phy";
+            resets = <&phyrst 0>;
+            clocks = <&ref_clk>;
+            clock-names = "refclk";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            phy@0 {
+                      reg = <0>;
+                      resets = <&phyrst 1>, <&phyrst 2>,
+                               <&phyrst 3>, <&phyrst 4>;
+                      #phy-cells = <0>;
+                      cdns,phy-type = <PHY_TYPE_DP>;
+                      cdns,num-lanes = <4>;
+                      cdns,max-bit-rate = <8100>;
+            };
+        };
     };
 ...
diff --git a/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
index 72aca81e8959..8a3032a3bd73 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
@@ -59,7 +59,7 @@ examples:
   - |
     dsi_dphy: phy@ff2e0000 {
         compatible = "rockchip,px30-dsi-dphy";
-        reg = <0x0 0xff2e0000 0x0 0x10000>;
+        reg = <0xff2e0000 0x10000>;
         clocks = <&pmucru 13>, <&cru 12>;
         clock-names = "ref", "pclk";
         resets = <&cru 12>;
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
index 7fd73d6e3803..c643d6d44415 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
@@ -121,7 +121,7 @@ examples:
 
             lhc: lhc@20 {
                    compatible = "aspeed,ast2500-lhc";
-                   reg = <0x20 0x24 0x48 0x8>;
+                   reg = <0x20 0x24>, <0x48 0x8>;
             };
         };
     };
diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
index 945c14e1be35..461afb4c1f5d 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
@@ -68,7 +68,7 @@ examples:
 
     pwm0: pwm@e6e30000 {
         compatible = "renesas,pwm-r8a7743", "renesas,pwm-rcar";
-        reg = <0 0xe6e30000 0 0x8>;
+        reg = <0xe6e30000 0x8>;
         clocks = <&cpg CPG_MOD 523>;
         power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
         resets = <&cpg 523>;
diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.yaml b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
index e8d3aeda1202..92283f693de0 100644
--- a/Documentation/devicetree/bindings/serial/sifive-serial.yaml
+++ b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
@@ -55,7 +55,7 @@ examples:
         compatible = "sifive,fu540-c000-uart", "sifive,uart0";
         interrupt-parent = <&plic0>;
         interrupts = <80>;
-        reg = <0x0 0x10010000 0x0 0x1000>;
+        reg = <0x10010000 0x1000>;
         clocks = <&prci PRCI_CLK_TLCLK>;
       };
 
diff --git a/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml b/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
index a61bccf915d8..f9344adaf6c2 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
@@ -86,7 +86,7 @@ examples:
     aiu: audio-controller@5400 {
         compatible = "amlogic,aiu-gxl", "amlogic,aiu";
         #sound-dai-cells = <2>;
-        reg = <0x0 0x5400 0x0 0x2ac>;
+        reg = <0x5400 0x2ac>;
         interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>,
                      <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
         interrupt-names = "i2s", "spdif";
@@ -110,4 +110,3 @@ examples:
                       "spdif_mclk_sel";
         resets = <&reset RESET_AIU>;
     };
-
diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
index f778d3371fde..51a0c30e10f9 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
@@ -45,7 +45,7 @@ examples:
 
     toacodec: audio-controller@740 {
         compatible = "amlogic,g12a-toacodec";
-        reg = <0x0 0x740 0x0 0x4>;
+        reg = <0x740 0x4>;
         #sound-dai-cells = <1>;
         resets = <&clkc_audio AUD_RESET_TOACODEC>;
     };
diff --git a/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml b/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
index b7c38c2b5b54..04014e658c90 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
@@ -49,10 +49,9 @@ examples:
 
     acodec: audio-controller@32000 {
         compatible = "amlogic,t9015";
-        reg = <0x0 0x32000 0x0 0x14>;
+        reg = <0x32000 0x14>;
         #sound-dai-cells = <0>;
         clocks = <&clkc CLKID_AUDIO_CODEC>;
         clock-names = "pclk";
         resets = <&reset RESET_AUDIO_CODEC>;
     };
-
diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
index c8f0985a8738..e84edcf8b332 100644
--- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
@@ -145,7 +145,7 @@ examples:
 
     msiof0: spi@e6e20000 {
         compatible = "renesas,msiof-r8a7791", "renesas,rcar-gen2-msiof";
-        reg = <0 0xe6e20000 0 0x0064>;
+        reg = <0xe6e20000 0x0064>;
         interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
         dmas = <&dmac0 0x51>, <&dmac0 0x52>;
diff --git a/Documentation/devicetree/bindings/spi/spi-sifive.yaml b/Documentation/devicetree/bindings/spi/spi-sifive.yaml
index fb583e57c1f2..4932205d1cba 100644
--- a/Documentation/devicetree/bindings/spi/spi-sifive.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-sifive.yaml
@@ -70,7 +70,7 @@ examples:
   - |
     spi: spi@10040000 {
       compatible = "sifive,fu540-c000-spi", "sifive,spi0";
-      reg = <0x0 0x10040000 0x0 0x1000 0x0 0x20000000 0x0 0x10000000>;
+      reg = <0x10040000 0x1000>, <0x20000000 0x10000000>;
       interrupt-parent = <&plic>;
       interrupts = <51>;
       clocks = <&tlclk>;
diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
index d2f4f1b063ac..bebd930daa8a 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
@@ -94,8 +94,8 @@ examples:
 
     thermal@e61f0000 {
             compatible = "renesas,thermal-r8a73a4", "renesas,rcar-thermal";
-            reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>,
-                  <0 0xe61f0200 0 0x38>, <0 0xe61f0300 0 0x38>;
+            reg = <0xe61f0000 0x14>, <0xe61f0100 0x38>,
+                  <0xe61f0200 0x38>, <0xe61f0300 0x38>;
             interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
             clocks = <&mstp5_clks R8A73A4_CLK_THERMAL>;
             power-domains = <&pd_c5>;
@@ -111,7 +111,7 @@ examples:
       compatible = "renesas,thermal-r8a7790",
                    "renesas,rcar-gen2-thermal",
                    "renesas,rcar-thermal";
-            reg = <0 0xe61f0000 0 0x10>, <0 0xe61f0100 0 0x38>;
+            reg = <0xe61f0000 0x10>, <0xe61f0100 0x38>;
             interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
             clocks = <&cpg CPG_MOD 522>;
             power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
index 058c4cc06ba6..af2ff930646a 100644
--- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
@@ -83,7 +83,7 @@ examples:
   - |
         ap_thm0: thermal@32200000 {
                 compatible = "sprd,ums512-thermal";
-                reg = <0 0x32200000 0 0x10000>;
+                reg = <0x32200000 0x10000>;
                 clock-names = "enable";
                 clocks = <&aonapb_gate 32>;
                 #thermal-sensor-cells = <1>;
diff --git a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
index b0e5e0fe9386..f6d48f4a0116 100644
--- a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
+++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
@@ -111,7 +111,7 @@ examples:
   - |
     usb: usb@ffe09000 {
           compatible = "amlogic,meson-g12a-usb-ctrl";
-          reg = <0x0 0xffe09000 0x0 0xa0>;
+          reg = <0xffe09000 0xa0>;
           interrupts = <16>;
           #address-cells = <1>;
           #size-cells = <1>;
@@ -147,4 +147,3 @@ examples:
               snps,quirk-frame-length-adjustment;
           };
     };
-
diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 37a818d72a74..fde980b9d73e 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -101,7 +101,7 @@ examples:
         compatible = "ibm,usb-ehci-440epx", "generic-ehci";
         interrupt-parent = <&UIC0>;
         interrupts = <0x1a 4>;
-        reg = <0 0xe0000300 90 0 0xe0000390 70>;
+        reg = <0xe0000300 90>, <0xe0000390 70>;
         big-endian;
     };
 
diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
index b84ed8ee8cfc..d814d2db19ee 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
@@ -163,9 +163,9 @@ examples:
 
     usb@700d0000 {
         compatible = "nvidia,tegra210-xudc";
-        reg = <0x0 0x700d0000 0x0 0x8000>,
-              <0x0 0x700d8000 0x0 0x1000>,
-              <0x0 0x700d9000 0x0 0x1000>;
+        reg = <0x700d0000 0x8000>,
+              <0x700d8000 0x1000>,
+              <0x700d9000 0x1000>;
         reg-names = "base", "fpci", "ipfs";
 
         interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml b/Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml
index 92d8631b9aa6..2e2f71a8d714 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml
@@ -72,7 +72,7 @@ examples:
 
     usb3_peri0: usb@ee020000 {
         compatible = "renesas,r8a774c0-usb3-peri", "renesas,rcar-gen3-usb3-peri";
-        reg = <0 0xee020000 0 0x400>;
+        reg = <0xee020000 0x400>;
         interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&cpg CPG_MOD 328>;
         companion = <&xhci0>;
diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
index 469affa872d3..992f43f6f7de 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
@@ -120,7 +120,7 @@ examples:
 
     usbhs: usb@e6590000 {
         compatible = "renesas,usbhs-r8a7790", "renesas,rcar-gen2-usbhs";
-        reg = <0 0xe6590000 0 0x100>;
+        reg = <0xe6590000 0x100>;
         interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&cpg CPG_MOD 704>;
     };
diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
index 5f5264b2e9ad..90750255792f 100644
--- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -57,30 +57,36 @@ examples:
   - |
     #include <dt-bindings/soc/ti,sci_pm_domain.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    cdns_usb@4104000 {
-          compatible = "ti,j721e-usb";
-          reg = <0x00 0x4104000 0x00 0x100>;
-          power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
-          clocks = <&k3_clks 288 15>, <&k3_clks 288 3>;
-          clock-names = "ref", "lpm";
-          assigned-clocks = <&k3_clks 288 15>;	/* USB2_REFCLK */
-          assigned-clock-parents = <&k3_clks 288 16>; /* HFOSC0 */
-          #address-cells = <2>;
-          #size-cells = <2>;
 
-          usb@6000000 {
-                compatible = "cdns,usb3";
-                reg = <0x00 0x6000000 0x00 0x10000>,
-                      <0x00 0x6010000 0x00 0x10000>,
-                      <0x00 0x6020000 0x00 0x10000>;
-                reg-names = "otg", "xhci", "dev";
-                interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,	/* irq.0 */
-                             <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,	/* irq.6 */
-                             <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;	/* otgirq.0 */
-                interrupt-names = "host",
-                                  "peripheral",
-                                  "otg";
-                maximum-speed = "super-speed";
-                dr_mode = "otg";
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        cdns_usb@4104000 {
+            compatible = "ti,j721e-usb";
+            reg = <0x00 0x4104000 0x00 0x100>;
+            power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
+            clocks = <&k3_clks 288 15>, <&k3_clks 288 3>;
+            clock-names = "ref", "lpm";
+            assigned-clocks = <&k3_clks 288 15>;	/* USB2_REFCLK */
+            assigned-clock-parents = <&k3_clks 288 16>; /* HFOSC0 */
+            #address-cells = <2>;
+            #size-cells = <2>;
+
+            usb@6000000 {
+                  compatible = "cdns,usb3";
+                  reg = <0x00 0x6000000 0x00 0x10000>,
+                        <0x00 0x6010000 0x00 0x10000>,
+                        <0x00 0x6020000 0x00 0x10000>;
+                  reg-names = "otg", "xhci", "dev";
+                  interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,	/* irq.0 */
+                               <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,	/* irq.6 */
+                               <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;	/* otgirq.0 */
+                  interrupt-names = "host",
+                                    "peripheral",
+                                    "otg";
+                  maximum-speed = "super-speed";
+                  dr_mode = "otg";
+            };
         };
     };
diff --git a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
index e83026fef2e9..f0452791c598 100644
--- a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
@@ -57,7 +57,7 @@ examples:
 
     watchdog0: rti@2200000 {
         compatible = "ti,rti-wdt";
-        reg = <0x0 0x2200000 0x0 0x100>;
+        reg = <0x2200000 0x100>;
         clocks = <&k3_clks 252 1>;
         power-domains = <&k3_pds 252 TI_SCI_PD_EXCLUSIVE>;
         assigned-clocks = <&k3_clks 252 1>;
-- 
2.20.1

