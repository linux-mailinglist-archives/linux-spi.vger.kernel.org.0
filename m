Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBF92D4808
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 18:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgLIRgk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 12:36:40 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:45155 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732068AbgLIRgk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 12:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1607535400; x=1639071400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UEPzXZfvg0KRtVh8AOZLVzo/9yBPGv4fZLRNHDWR5Og=;
  b=x/6wkeQfvv3bBB0Kkk0Sj4HKjV2WxVMw/nuGkcHVMhJ/c9oCWbsF1ZNM
   /YtvpGE2SRMAzOB+31AyVcC6rpJppRt5jeapHvrnk+hy8Q4DV/WE30C43
   C9VgqqdKLIKUxbO+Pm+szZ2RyYEdTIM5IJ/73KBcpSwDgfSWNL88gQI2s
   BhHzwqeXoFf4eYiM72jgI1ca9d0BfXUNKsewKj2AuEuPM4MK+p4MhVzLk
   IOP8kb2imU5IzISTSb+/I6BmzVlwk1kxeB8/T74lVY8T0E3VoWbeUjLvq
   4Q4EDhz1Z/XNTiwsu8z20FFgWYtVylfNr0KHwj5RoF3bQMcnNnXb5XTXZ
   A==;
IronPort-SDR: pQYxnXH4juROvY7XLaPE9BX5iAY0Ym5tvs3eKVmdB4a3qBJ8ocuPfntfthYUW88SHHqFmSkjjx
 jtEhVpTka65La4+q0Sp1DZbLSGfTB+suN0TIS8d5RA5HvN+KunuM2EyYf/0co9CUe1X5yu8Bow
 nj8CiUA8fGx0NBLZEuwYM+jJ5lZMtbzneeRh8tvVISyRLOXIxU3Md0P4cifX2lt2vqZl/nFJ5A
 9Oaw3U08Rtzs2cGDWOxF5ifyKlJTgoA6osc/PdmmsoqG07vZRFATAgdS8ROqeGzsRTV6TG/QxN
 sgs=
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="36817605"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Dec 2020 10:35:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Dec 2020 10:35:19 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 9 Dec 2020 10:35:17 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] spi: Limit the spi device max speed to controller's max speed
Date:   Wed, 9 Dec 2020 19:35:14 +0200
Message-ID: <20201209173514.93328-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Make sure the max_speed_hz of spi_device does not override
the max_speed_hz of controller.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cd3c395b4e90..51d7c004fbab 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3378,7 +3378,8 @@ int spi_setup(struct spi_device *spi)
 	if (status)
 		return status;
 
-	if (!spi->max_speed_hz)
+	if (!spi->max_speed_hz ||
+	    spi->max_speed_hz > spi->controller->max_speed_hz)
 		spi->max_speed_hz = spi->controller->max_speed_hz;
 
 	mutex_lock(&spi->controller->io_mutex);
-- 
2.25.1

