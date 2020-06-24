Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07820206991
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jun 2020 03:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388458AbgFXBfh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Jun 2020 21:35:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:13602 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388448AbgFXBfg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Jun 2020 21:35:36 -0400
IronPort-SDR: 7mj+gMmOjKxmuH1/E5DPvIwYpfPrLj4H6yW1Y3Ay0vlHaodb18ukhlB9P4MwJJyR7ZFao3LfPX
 ZOOtCV8nnrQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="141785220"
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; 
   d="scan'208";a="141785220"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 18:35:35 -0700
IronPort-SDR: DcsF7zW1/WORb+WpgGTinT6fmS4ArXsY/BAVfiio1IYE+yOc7xg6Tujhf3XBIEegOFxR8xN4m6
 b80IUK5lgTLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; 
   d="scan'208";a="452459716"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 18:35:33 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, yilun.xu@intel.com
Subject: [PATCH 1/2] spi: altera: fix driver matching failure of the device ID "spi_altera"
Date:   Wed, 24 Jun 2020 09:31:25 +0800
Message-Id: <1592962286-25752-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592962286-25752-1-git-send-email-yilun.xu@intel.com>
References: <1592962286-25752-1-git-send-email-yilun.xu@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver is expected to support device ID "spi_altera" for MMIO accessed
devices, device ID "subdev_spi_altera" for indirect accessed devices. But
the platform bus will not try driver name match anymore if the platform
driver has an id_table. So the "spi_altera" should also be added to
id_table.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/spi/spi-altera.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index d91c093..e272a04 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -352,7 +352,8 @@ MODULE_DEVICE_TABLE(of, altera_spi_match);
 #endif /* CONFIG_OF */
 
 static const struct platform_device_id altera_spi_ids[] = {
-	{ "subdev_spi_altera", ALTERA_SPI_TYPE_SUBDEV },
+	{ DRV_NAME,		ALTERA_SPI_TYPE_UNKNOWN },
+	{ "subdev_spi_altera",	ALTERA_SPI_TYPE_SUBDEV },
 	{ }
 };
 
-- 
2.7.4

