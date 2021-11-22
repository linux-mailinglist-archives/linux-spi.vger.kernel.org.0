Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75557459455
	for <lists+linux-spi@lfdr.de>; Mon, 22 Nov 2021 18:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhKVRz7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Nov 2021 12:55:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:30137 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236161AbhKVRzx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Nov 2021 12:55:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="321066670"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="321066670"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 09:52:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="570409072"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 22 Nov 2021 09:52:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1BBD6B8; Mon, 22 Nov 2021 19:52:48 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: spidev: Use SPI_MODE_USER_MASK instead of casting
Date:   Mon, 22 Nov 2021 19:52:45 +0200
Message-Id: <20211122175245.84691-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently the 16-bit mode is what being used in user space.
However assuming that is not fully correct. Instead we should
use the respective mask, i.e. SPI_MODE_USER_MASK, which
precisely defines what bits are available for user space apps.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spidev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 1bd73e322b7b..968dab2f5e3d 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -415,7 +415,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 				tmp |= SPI_CS_HIGH;
 
 			tmp |= spi->mode & ~SPI_MODE_MASK;
-			spi->mode = (u16)tmp;
+			spi->mode = tmp & SPI_MODE_USER_MASK;
 			retval = spi_setup(spi);
 			if (retval < 0)
 				spi->mode = save;
-- 
2.33.0

