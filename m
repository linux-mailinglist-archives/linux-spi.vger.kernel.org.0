Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEDF44B0E6
	for <lists+linux-spi@lfdr.de>; Tue,  9 Nov 2021 17:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbhKIQQN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Nov 2021 11:16:13 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:46678 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhKIQQN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Nov 2021 11:16:13 -0500
Received: by mail-ot1-f41.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so20839020otk.13;
        Tue, 09 Nov 2021 08:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YgF8jamzpaIqMaFLxvpOOV3SnWcjJD7TEwGpydEes34=;
        b=GYqnqAYzZpJcVcYiClS2sGkfVTdkOdFnv8gKdxStXbaylmWtB5gLAP/M3ekX08Nizk
         mMxE4eQKPdzUVDy/ZYXu7GCDmYcpI/qN2uD0Ww0/h7QpNLrsjMT7tj1CX35aNXSaWMsL
         IY6a8vrGcxIZok6SbPXo355VZohacViVnAeh0AKj1a/uV42LzuMtF4PfHU7usCv0dRGX
         drCckWBphKUlM7g12a9VWrxynJ+AnXX+mIfF1ewVTYIxxLNH/mt9UyPEs6YkW+g+6aKZ
         PxiSwXycIeoZPp52R0G2qBgjF+HOP6xZKI+piLIsrvZuEiavi0IutbgCxUYJKfDh7ufz
         yKAQ==
X-Gm-Message-State: AOAM530FdPTpHh1cOm/6EKFfWi5pdb9U62KA8w5Hv8GNnRtVEmwaV54e
        1YATMKr9cyJxaumiE9IhMA==
X-Google-Smtp-Source: ABdhPJw/yWunLCyUQLHrVmXuyciqvxSoPlfSe6RdxkCF+MQQamQlv3jX7e/z8xk3JRyyTluAFicEEg==
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr6722755oti.269.1636474406773;
        Tue, 09 Nov 2021 08:13:26 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id bf17sm3833953oib.27.2021.11.09.08.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 08:13:26 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH] spi: xlp: Remove Netlogic XLP variants
Date:   Tue,  9 Nov 2021 10:13:25 -0600
Message-Id: <20211109161325.2203564-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Netlogic XLP was removed in commit 95b8a5e0111a ("MIPS: Remove NETLOGIC
support"). With those gone, the single platform left to support is
Cavium ThunderX2. Remove the Netlogic variant and DT support.

For simplicity, the existing kconfig name is retained.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/spi/Kconfig   | 11 +++++------
 drivers/spi/spi-xlp.c |  8 --------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 596705d24400..b2a8821971e1 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -974,14 +974,13 @@ config SPI_XILINX
 	  Or for the DS570, see "XPS Serial Peripheral Interface (SPI) (v2.00b)"
 
 config SPI_XLP
-	tristate "Netlogic XLP SPI controller driver"
-	depends on CPU_XLP || ARCH_THUNDER2 || COMPILE_TEST
+	tristate "Cavium ThunderX2 SPI controller driver"
+	depends on ARCH_THUNDER2 || COMPILE_TEST
 	help
-	  Enable support for the SPI controller on the Netlogic XLP SoCs.
-	  Currently supported XLP variants are XLP8XX, XLP3XX, XLP2XX, XLP9XX
-	  and XLP5XX.
+	  Enable support for the SPI controller on the Cavium ThunderX2.
+	  (Originally on Netlogic XLP SoCs.)
 
-	  If you have a Netlogic XLP platform say Y here.
+	  If you have a Cavium ThunderX2 platform say Y here.
 	  If unsure, say N.
 
 config SPI_XTENSA_XTFPGA
diff --git a/drivers/spi/spi-xlp.c b/drivers/spi/spi-xlp.c
index 797ac0ea8fa3..e5707fe5c8f1 100644
--- a/drivers/spi/spi-xlp.c
+++ b/drivers/spi/spi-xlp.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
-#include <linux/of.h>
 #include <linux/interrupt.h>
 
 /* SPI Configuration Register */
@@ -436,17 +435,10 @@ static const struct acpi_device_id xlp_spi_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, xlp_spi_acpi_match);
 #endif
 
-static const struct of_device_id xlp_spi_dt_id[] = {
-	{ .compatible = "netlogic,xlp832-spi" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, xlp_spi_dt_id);
-
 static struct platform_driver xlp_spi_driver = {
 	.probe	= xlp_spi_probe,
 	.driver = {
 		.name	= "xlp-spi",
-		.of_match_table = xlp_spi_dt_id,
 		.acpi_match_table = ACPI_PTR(xlp_spi_acpi_match),
 	},
 };
-- 
2.32.0

