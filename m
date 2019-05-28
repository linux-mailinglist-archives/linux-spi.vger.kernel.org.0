Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 772C52C32B
	for <lists+linux-spi@lfdr.de>; Tue, 28 May 2019 11:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfE1J1f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 May 2019 05:27:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41138 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfE1J1f (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 May 2019 05:27:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3so6009044pgp.8
        for <linux-spi@vger.kernel.org>; Tue, 28 May 2019 02:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8He96LBvzgwWKZ93ZshlZgpeoHlqzqGddbd8HI8Wh0=;
        b=AW7cWllHjdolFWgu+JShM/ogqPLt4UX8wQQSC5On5EgrskUTXTvrBKh/OWEFWeOY8N
         kcJd2/sHIwwnxyL1WBjpndrHJ4BMy+iol9cJAVYSuUzB/yFXVMXLhshrfmXlPehcegr/
         hoUtqI6nwLLfV436Z8WNmx06UahIiUKotjDOLDiLLYZ5zc4QXgBEFKLbtdQJdALaY+qq
         5xyUtQa75GWgohsowyx0OIv/tr3KNHApl7/2EuxTaB+Y9AytF5U2MryGSvU4M3MSVCKe
         IhDue6Uu0vCalmLJMNgKfO1+oe+I/TbsMAJjV60fAUwJYYt0jkQj/OImISIc88dvtN/U
         9wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J8He96LBvzgwWKZ93ZshlZgpeoHlqzqGddbd8HI8Wh0=;
        b=dBeTDtGyx5/REss7WNX8ibWTR9mk02F9RimvGvRsogWRprcGHfff/0PRQTxO5OZN8F
         oaOLaU8Dt9/RaMKg+Edshb4UTfBOObHOsHNps8k6CmNf7f7eUgz31D1xJD8E6FbRyTWu
         fZtpHA+wZ7AFbcQGXvDfQeIUhzdv889FosHH5IfvhfaKTwWAWMhQx23nK6sXZkeUCIFh
         wFZ8Z6tAvVq/fmWDLzEG68Y6F8MIbpDwO0AowWodoxBbheant68yYH+ClhRuZQph6qLx
         mwkUcf+Ud8fLy4hC+xnYxq7REMyq5unl2+Uht8KFZNpnFci/shAe/UqlvmmBITfb7aG4
         lYxg==
X-Gm-Message-State: APjAAAWgtfRgB3vAed9+S1F1irFeutCp2ViVSbinWd+D9hDyAvOPnEvN
        cqpcUyW473rcLrKSYUfQwEqoycDTF+AlPQ==
X-Google-Smtp-Source: APXvYqxcoBrV2AjSUXxQ8I9pqDxssScuvyPZeUYj1KGf/CEiOJ6HRw+ztIbWWvXXLPFvf4N07pu44Q==
X-Received: by 2002:a63:1622:: with SMTP id w34mr29122881pgl.45.1559035653789;
        Tue, 28 May 2019 02:27:33 -0700 (PDT)
Received: from localhost ([121.95.100.191])
        by smtp.gmail.com with ESMTPSA id j72sm2118569pje.12.2019.05.28.02.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 02:27:33 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     broonie@kernel.org, geert@linux-m68k.org, tpiepho@impinj.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        jaswinder.singh@linaro.org, masami.hiramatsu@linaro.org,
        okamoto.satoru@socionext.com, osaki.yoshitoyo@socionext.com,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v6 2/3] dt-bindings: spi: Add DT bindings for Synquacer
Date:   Tue, 28 May 2019 18:27:12 +0900
Message-Id: <20190528092713.10516-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190528092713.10516-1-masahisa.kojima@linaro.org>
References: <20190528092713.10516-1-masahisa.kojima@linaro.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds documentation for Device-Tree bindings for the
Socionext Synquacer spi driver.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spi/spi-synquacer.txt      | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-synquacer.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-synquacer.txt b/Documentation/devicetree/bindings/spi/spi-synquacer.txt
new file mode 100644
index 000000000000..291dfa692d0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-synquacer.txt
@@ -0,0 +1,27 @@
+* Socionext Synquacer HS-SPI bindings
+
+Required Properties:
+- compatible: should be "socionext,synquacer-spi"
+- reg: physical base address of the controller and length of memory mapped
+       region.
+- interrupts: should contain the "spi_rx", "spi_tx" and "spi_fault" interrupts.
+- clocks: core clock iHCLK. Optional rate clock iPCLK (default is iHCLK)
+- clock-names: Shall be "iHCLK" and "iPCLK" respectively
+
+Optional Properties:
+- socionext,use-rtm: boolean, if required to use "retimed clock" for RX
+- socionext,set-aces: boolean, if same active clock edges field to be set.
+
+Example:
+
+	spi0: spi@ff110000 {
+		compatible = "socionext,synquacer-spi";
+		reg = <0xff110000 0x1000>;
+		interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk_hsspi>;
+		clock-names = "iHCLK";
+		socionext,use-rtm;
+		socionext,set-aces;
+	};
-- 
2.14.2

