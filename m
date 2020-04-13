Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7819E1A6BD9
	for <lists+linux-spi@lfdr.de>; Mon, 13 Apr 2020 20:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbgDMSEK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Apr 2020 14:04:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:36248 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387498AbgDMSEK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 13 Apr 2020 14:04:10 -0400
IronPort-SDR: /y2/nylhDOalCW6vBt3GAzGUqfb33BR82WSju+1TuTE258xe9Fj48RAoEkWIUmv7eoZgwCbqSy
 ETqrwav6Alxg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 11:04:10 -0700
IronPort-SDR: ucv/MYAdB+CWEmmu2y0YPFAKL20fu6zR4sHWSfHB1KcI1PcwgfLa2V6XmBVhqCs/yD4jg6V2/8
 DNUYc3AnGNRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="399685751"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2020 11:04:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 94E29DE; Mon, 13 Apr 2020 21:04:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] spi: Respect DataBitLength field of SpiSerialBusV2() ACPI resource
Date:   Mon, 13 Apr 2020 21:04:06 +0300
Message-Id: <20200413180406.1826-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

By unknown reason the commit 64bee4d28c9e
  ("spi / ACPI: add ACPI enumeration support")
missed the DataBitLength property to encounter when parse SPI slave
device data from ACPI.

Fill the gap here.

Fixes: 64bee4d28c9e ("spi / ACPI: add ACPI enumeration support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c92c89467e7e..e0e27fe06878 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2111,6 +2111,7 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 			}
 
 			lookup->max_speed_hz = sb->connection_speed;
+			lookup->bits_per_word = sb->data_bit_length;
 
 			if (sb->clock_phase == ACPI_SPI_SECOND_PHASE)
 				lookup->mode |= SPI_CPHA;
-- 
2.25.1

