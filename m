Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754EA2DBD7A
	for <lists+linux-spi@lfdr.de>; Wed, 16 Dec 2020 10:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgLPJYm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Dec 2020 04:24:42 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16852 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgLPJYl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Dec 2020 04:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1608110681; x=1639646681;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LKlskkTEja+g/wyA5SZA9HKNe4uKtWhP0Z7NFbF434c=;
  b=syH/5SM95y59kr0RNV3t0cLZNxtdE+DNncu2Zole1GAHGTqrN/hA9sfa
   fUOC42jiX5axRvRc+F7Rp4Bc3LPlnEF977UFEyfBQB7w2BUGzlzkx5hDJ
   BP092CpRaO+5EsYEHbkGrbfkIvB6k/o2F6aFB5lrURjMJA091O1obqw7/
   QIuw8vpjQeyutgFaysw/yJBhQOlKNCvMkmGaWSevsQHi/RiuzU5I/e+ZM
   htrkcNR8GpmNjShFqNTJfQa9e1fTSj6wX1W32YerayyltDIYhAu0WCvu3
   bDWqcCh5+EXhNFFq6/kdSCjU2wvRpB8Y+ZEqGP9qHv1Wkkl6yeg/MDesK
   g==;
IronPort-SDR: RTdiEybJ8PsZpCX6QbDK/f8eQu6euVfJ6SUgCJe6Fd9xAvkL8/uyyXhxtZgR6ruZgohwGmRBgi
 8m5ljduBwIlM8FVBy+H7II2Bzv6zIT0svj+uVNV4Wgflq/SfguFz7BlABEnLsLtAS5KvltiS3M
 N7mIovY1U+j4qvGXbK3LUlpEFS5DBDBCLOj1BdhSZ/lXGCZZb0oNiMLchl+qAJdaCvI5hUdnSi
 lL0Y0iFuE4YB/iCtBd6VRZvclYtQPpSrnt4uvW/TgCqxsPwBYapHiTfOZgTIUkM6bNM3akBQRN
 Vhk=
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="37598480"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2020 02:23:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Dec 2020 02:23:25 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 16 Dec 2020 02:23:23 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <geert@linux-m68k.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] spi: Fix the clamping of spi->max_speed_hz
Date:   Wed, 16 Dec 2020 11:23:21 +0200
Message-ID: <20201216092321.413262-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If spi->controller->max_speed_hz is zero, a non-zero spi->max_speed_hz
will be overwritten by zero. Make sure spi->controller->max_speed_hz
is not zero when clamping spi->max_speed_hz.

Put the spi->controller->max_speed_hz non-zero check higher in the if,
so that we avoid a superfluous init to zero when both spi->max_speed_hz
and spi->controller->max_speed_hz are zero.

Fixes: 9326e4f1e5dd ("spi: Limit the spi device max speed to controller's max speed")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 51d7c004fbab..f59bf5094adb 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3378,8 +3378,9 @@ int spi_setup(struct spi_device *spi)
 	if (status)
 		return status;
 
-	if (!spi->max_speed_hz ||
-	    spi->max_speed_hz > spi->controller->max_speed_hz)
+	if (spi->controller->max_speed_hz &&
+	    (!spi->max_speed_hz ||
+	     spi->max_speed_hz > spi->controller->max_speed_hz))
 		spi->max_speed_hz = spi->controller->max_speed_hz;
 
 	mutex_lock(&spi->controller->io_mutex);
-- 
2.25.1

