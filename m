Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0410B1F607B
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 05:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgFKD3J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jun 2020 23:29:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:28223 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgFKD3E (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Jun 2020 23:29:04 -0400
IronPort-SDR: YnwFT1iA3ngIbWc6JFb4W9VigW4nAe7tLDp5+WNJMACdbP2KaKBn2rJKariPa111LY4lUXku0i
 zJZBSYDWIfzg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 20:29:04 -0700
IronPort-SDR: h1niU8QmEMd2zNEPiPRGjDTJDW2dW9a0DUUyv9dKAlS1dYXB6vGrR0+8aVWwIztcosQK6UfdeT
 tpNK8J4aJFXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; 
   d="scan'208";a="260587397"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jun 2020 20:29:02 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com
Subject: [PATCH 5/6] spi: altera: move driver name string to header file
Date:   Thu, 11 Jun 2020 11:25:10 +0800
Message-Id: <1591845911-10197-6-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
References: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This allows other driver to reuse the name string for spi-altera
platform device creation.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/spi/spi-altera.c   | 6 ++----
 include/linux/spi/altera.h | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index 8d47c57..2c12c7a 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -19,8 +19,6 @@
 #include <linux/io.h>
 #include <linux/of.h>
 
-#define DRV_NAME "spi_altera"
-
 #define ALTERA_SPI_RXDATA	0
 #define ALTERA_SPI_TXDATA	4
 #define ALTERA_SPI_STATUS	8
@@ -338,7 +336,7 @@ MODULE_DEVICE_TABLE(of, altera_spi_match);
 static struct platform_driver altera_spi_driver = {
 	.probe = altera_spi_probe,
 	.driver = {
-		.name = DRV_NAME,
+		.name = ALTERA_SPI_DRV_NAME,
 		.pm = NULL,
 		.of_match_table = of_match_ptr(altera_spi_match),
 	},
@@ -348,4 +346,4 @@ module_platform_driver(altera_spi_driver);
 MODULE_DESCRIPTION("Altera SPI driver");
 MODULE_AUTHOR("Thomas Chou <thomas@wytron.com.tw>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_ALIAS("platform:" ALTERA_SPI_DRV_NAME);
diff --git a/include/linux/spi/altera.h b/include/linux/spi/altera.h
index 164ab7b..6539371 100644
--- a/include/linux/spi/altera.h
+++ b/include/linux/spi/altera.h
@@ -9,6 +9,8 @@
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 
+#define ALTERA_SPI_DRV_NAME	"spi-altera"
+
 /**
  * struct altera_spi_platform_data - Platform data of the Altera SPI driver
  * @mode_bits:		Mode bits of SPI master.
-- 
2.7.4

