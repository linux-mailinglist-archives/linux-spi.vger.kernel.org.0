Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51DC3B1F56
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jun 2021 19:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFWRZT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Jun 2021 13:25:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38189 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWRZT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Jun 2021 13:25:19 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lw6aa-0001GY-Dg; Wed, 23 Jun 2021 17:23:00 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] spi: Fix self assignment issue with ancillary->mode
Date:   Wed, 23 Jun 2021 18:23:00 +0100
Message-Id: <20210623172300.161484-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is an assignment of ancillary->mode to itself which looks
dubious since the proceeding comment states that the speed and
mode is taken over from the SPI main device, indicating that
ancillary->mode should assigned using the value spi->mode.
Fix this.

Addresses-Coverity: ("Self assignment")
Fixes: 0c79378c0199 ("spi: add ancillary device support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b1b6031961b7..3104055a54e2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2184,7 +2184,7 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 
 	/* Take over SPI mode/speed from SPI main device */
 	ancillary->max_speed_hz = spi->max_speed_hz;
-	ancillary->mode = ancillary->mode;
+	ancillary->mode = spi->mode;
 
 	/* Register the new device */
 	rc = spi_add_device_locked(ancillary);
-- 
2.31.1

