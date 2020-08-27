Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA77254CD8
	for <lists+linux-spi@lfdr.de>; Thu, 27 Aug 2020 20:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgH0SSx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Aug 2020 14:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgH0SSu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Aug 2020 14:18:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A08C061264;
        Thu, 27 Aug 2020 11:18:49 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q1so3022420pjd.1;
        Thu, 27 Aug 2020 11:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hl7owRtuqO+nbDg2yFqvJPtQa89IxgWCrgChGWtbZ1Y=;
        b=QYFhPpXpmkURLzOHv/XGe3n4fce+F4gPVd0lKUzVF/sFfUvXvkC2GVs3hvCGEzjERM
         NXlDBrDgcQHT29SFhbuMBDEQOrms09o6fS6LxFBOLRmGrgEivzJZK0oriyuvZc9gRsZJ
         Qe2ok826vhcTxtlsysOhzNFugExWsW8aXvokCCnY5mujHBMz4LWQ0SBMLS4eEuWin0Dq
         VLeyF9jvu58VS5Rid0lRA8Jm+RcX9AOiSvVmSXxKVDyocAIXMnqztFSXUGgDmCAtcgIz
         SqnD6Hq4Oum/Qre7hivqqUToZl+164kepInbLtp/Jek8lqrObnORT2k5nmwS+BYe7K3U
         prHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hl7owRtuqO+nbDg2yFqvJPtQa89IxgWCrgChGWtbZ1Y=;
        b=Ks1NTwcisCX/HEUguCw31BAaPzHFLY7Ym/m72nXGNI3oX+YH+I8NeikntjJjZkeYnh
         sbNI9zssh9amsih2F+ZJlD17wtd42yKelY8BJIOtO0kCb5lrQf+In1yR48r9D3Ahop8A
         WYOlJngXlPCMWbtCvsEaJebNS/5rYk4/e8iKsE6c+L5ksn+bu8zj8OwRA3VIUAdCHi8v
         1ZlEKzd8nWFfdA0aYBHmv65RZxB03lr459ScS5jK7Rky5FKy+DI37ZXx6+T6PA00SlwL
         FGA9OQfQjNJv/VpdKrs9//cOkXkwlDnWtW/rXIEQW19kmBPggCVpUyWvDBcQOQf4i7qc
         Hd3w==
X-Gm-Message-State: AOAM532b5Y7Sos9rL1iFuyj468wM44L6JQGm0ySVOHfXcXzgRLVgs3Fp
        Sobo5GBgBu0SI+zPEXD2U0w=
X-Google-Smtp-Source: ABdhPJy4UTBLzEa4OVCZG17ii+J8Oh/hKLLcdPurxKIvFSuAzbMyFjBh95lsmtcm8BnLsPSrzXRdVA==
X-Received: by 2002:a17:90b:696:: with SMTP id m22mr116217pjz.158.1598552328571;
        Thu, 27 Aug 2020 11:18:48 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q18sm3580179pfn.106.2020.08.27.11.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 11:18:47 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM SPI DRIVER),
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>,
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] dt-bindings: spi: Fix spi-bcm-qspi compatible ordering
Date:   Thu, 27 Aug 2020 11:18:38 -0700
Message-Id: <20200827181842.1000451-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200827181842.1000451-1-f.fainelli@gmail.com>
References: <20200827181842.1000451-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The binding is currently incorrectly defining the compatible strings
from least specific to most specific instead of the converse. Re-order
them from most specific (left) to least specific (right) and fix the
examples as well.

Fixes: 5fc78f4c842a ("spi: Broadcom BRCMSTB, NSP, NS2 SoC bindings")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/spi/brcm,spi-bcm-qspi.txt           | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
index f5e518d099f2..62d4ed2d7fd7 100644
--- a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
@@ -23,8 +23,8 @@ Required properties:
 
 - compatible:
     Must be one of :
-    "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-qspi" : MSPI+BSPI on BRCMSTB SoCs
-    "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
+    "brcm,spi-brcmstb-qspi", "brcm,spi-bcm-qspi" : MSPI+BSPI on BRCMSTB SoCs
+    "brcm,spi-brcmstb-mspi", "brcm,spi-bcm-qspi" : Second Instance of MSPI
 						   BRCMSTB  SoCs
     "brcm,spi-bcm7425-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
     			     			  			    BRCMSTB  SoCs
@@ -36,8 +36,8 @@ Required properties:
     			     			  			    BRCMSTB  SoCs
     "brcm,spi-bcm7278-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
     			     			  			    BRCMSTB  SoCs
-    "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi"     : MSPI+BSPI on Cygnus, NSP
-    "brcm,spi-bcm-qspi", "brcm,spi-ns2-qspi"     : NS2 SoCs
+    "brcm,spi-nsp-qspi", "brcm,spi-bcm-qspi"     : MSPI+BSPI on Cygnus, NSP
+    "brcm,spi-ns2-qspi", "brcm,spi-bcm-qspi"     : NS2 SoCs
 
 - reg:
     Define the bases and ranges of the associated I/O address spaces.
@@ -86,7 +86,7 @@ BRCMSTB SoC Example:
     spi@f03e3400 {
 		#address-cells = <0x1>;
 		#size-cells = <0x0>;
-		compatible = "brcm,spi-brcmstb-qspi", "brcm,spi-brcmstb-qspi";
+		compatible = "brcm,spi-brcmstb-qspi", "brcm,spi-bcm-qspi";
 		reg = <0xf03e0920 0x4 0xf03e3400 0x188 0xf03e3200 0x50>;
 		reg-names = "cs_reg", "mspi", "bspi";
 		interrupts = <0x6 0x5 0x4 0x3 0x2 0x1 0x0>;
@@ -149,7 +149,7 @@ BRCMSTB SoC Example:
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&upg_fixed>;
-		compatible = "brcm,spi-brcmstb-qspi", "brcm,spi-brcmstb-mspi";
+		compatible = "brcm,spi-brcmstb-mspi", "brcm,spi-bcm-qspi";
 		reg = <0xf0416000 0x180>;
 		reg-names = "mspi";
 		interrupts = <0x14>;
@@ -160,7 +160,7 @@ BRCMSTB SoC Example:
 iProc SoC Example:
 
     qspi: spi@18027200 {
-	compatible = "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi";
+	compatible = "brcm,spi-nsp-qspi", "brcm,spi-bcm-qspi";
 	reg = <0x18027200 0x184>,
 	      <0x18027000 0x124>,
 	      <0x1811c408 0x004>,
@@ -191,7 +191,7 @@ iProc SoC Example:
  NS2 SoC Example:
 
 	       qspi: spi@66470200 {
-		       compatible = "brcm,spi-bcm-qspi", "brcm,spi-ns2-qspi";
+		       compatible = "brcm,spi-ns2-qspi", "brcm,spi-bcm-qspi";
 		       reg = <0x66470200 0x184>,
 			     <0x66470000 0x124>,
 			     <0x67017408 0x004>,
-- 
2.25.1

