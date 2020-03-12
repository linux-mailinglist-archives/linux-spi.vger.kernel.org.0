Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 023041831E4
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 14:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgCLNpa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 09:45:30 -0400
Received: from sauhun.de ([88.99.104.3]:42506 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgCLNp3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Mar 2020 09:45:29 -0400
Received: from localhost (p54B331A0.dip0.t-ipconnect.de [84.179.49.160])
        by pokefinder.org (Postfix) with ESMTPSA id 8DF112C1ECC;
        Thu, 12 Mar 2020 14:45:22 +0100 (CET)
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-spi@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] spi: acpi: remove superfluous parameter check
Date:   Thu, 12 Mar 2020 14:45:07 +0100
Message-Id: <20200312134507.10000-1-wsa@the-dreams.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

to_spi_device() already checks 'dev'. No need to do it before calling
it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Found while fiddling with bus_find_device_by_acpi_dev() in the I2C
subsystem.

 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 755221bc3745..75978b6c5834 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4034,7 +4034,7 @@ static struct spi_device *acpi_spi_find_device_by_adev(struct acpi_device *adev)
 	struct device *dev;
 
 	dev = bus_find_device_by_acpi_dev(&spi_bus_type, adev);
-	return dev ? to_spi_device(dev) : NULL;
+	return to_spi_device(dev);
 }
 
 static int acpi_spi_notify(struct notifier_block *nb, unsigned long value,
-- 
2.20.1

