Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73032413AAB
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 21:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhIUTYJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Sep 2021 15:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229915AbhIUTYJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Sep 2021 15:24:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59CF560F4C;
        Tue, 21 Sep 2021 19:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632252160;
        bh=k2BOiXUcyi4f5zH7w1DVfqqJ3fX5DMrj6qVL21Cxa2w=;
        h=From:To:Cc:Subject:Date:From;
        b=L9jquIG7jvdoQzjxQT3P7DSZByWBK21UW2jCUlBk7lc7q2S30JWFxUBOHMrCzX3V5
         EcD+GL2u9yPnFayH9kunvNOtGFnntLVojMHCdESgWtQWtx9++1p3orP1Xa5Wqwyx61
         5EUwFWRwGeY2vnCg1aCt+pzpz78DnYr5W62TsQkJjUUGRqyJ9iT0lLbO7LGV6P5ioS
         BUSsAnpakMDrXLMzaq5pX7IaodaSNVgIMUyeE3oQFwLJ4nf5Q/19NVsn1Iji+JvOOa
         wr8XZuKx246QiYCVMMoM0GHKQpU6JdRNZtDH5jJYMIJMCId/CSBMcX6CvENQ4UCmik
         +MWNVIpG9vKkA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: Check we have a spi_device_id for each DT compatible
Date:   Tue, 21 Sep 2021 20:21:49 +0100
Message-Id: <20210921192149.50740-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2761; h=from:subject; bh=k2BOiXUcyi4f5zH7w1DVfqqJ3fX5DMrj6qVL21Cxa2w=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhSjCjkYxKoeEPRgn4D6V0M59l/4qysuidp0cIn/mv ny8JCf6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUowowAKCRAk1otyXVSH0CsLB/ 96EDkHOgH+C4pOt0vc67xO9rXcOZi37mdDSaO/qUWIjkNOFjmyRUz/rojBEQxmKOvMsPzmcBOLdPYG qS/lw9ifnIkOVY/LyoRDp1nGwIJWPKbXPid8hltYZCAvZGOpD/D+0ZWyRt8XQXDfLs6dugQsWXAweR 5t1gXjFdyKkHuKdEmUn1xRyrK4dQutzngOvESfh9hYLffh3fMlLMjFmoHv5/5KZtpuTsR4CX6TEuUA 3FF4taJ6S6nE2TWRpejm6DRRcfRR9nFcsl9yQBALTEBKZ6jJEyP9Ss56EkZA3CY1oA5PArbdfCkX5V EA9wcHvpdXLZKlTAVikmm1wHPF7+m0
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently for SPI devices we use the spi_device_id for module autoloading
even on systems using device tree, meaning that listing a compatible string
in the of_match_table isn't enough to have the module for a SPI driver
autoloaded.

We attempted to fix this by generating OF based modaliases for devices
instantiated from DT in 3ce6c9e2617e ("spi: add of_device_uevent_modalias
support") but this meant we no longer reported spi_device_id based aliases
which broke drivers such as spi-nor which don't list all the compatible
strings they support directly for DT, and in at least that case it's not
super practical to do so given the very large number of compatibles
needed, much larger than the number spi_device_ids due to vendor strings.
As a result fell back to using spi_device_id based modalises.

Try to close the gap by printing a warning when a SPI driver has a DT
compatible that won't be matched as a SPI device ID with the goal of having
drivers provide both. Given fallback compatibles this check is going to be
excessive but it should be robust which is probably more important here.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 57e2499ec1ed..2c7f420b9f73 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -459,6 +459,47 @@ int __spi_register_driver(struct module *owner, struct spi_driver *sdrv)
 {
 	sdrv->driver.owner = owner;
 	sdrv->driver.bus = &spi_bus_type;
+
+	/*
+	 * For Really Good Reasons we use spi: modaliases not of:
+	 * modaliases for DT so module autoloading won't work if we
+	 * don't have a spi_device_id as well as a compatible string.
+	 */
+	if (sdrv->driver.of_match_table) {
+		const struct of_device_id *of_id;
+
+		for (of_id = sdrv->driver.of_match_table; of_id->compatible[0];
+		     of_id++) {
+			const char *of_name;
+
+			/* Strip off any vendor prefix */
+			of_name = strnchr(of_id->compatible,
+					  sizeof(of_id->compatible), ',');
+			if (of_name)
+				of_name++;
+			else
+				of_name = of_id->compatible;
+
+			if (sdrv->id_table) {
+				const struct spi_device_id *spi_id;
+
+				for (spi_id = sdrv->id_table; spi_id->name[0];
+				     spi_id++)
+					if (strcmp(spi_id->name, of_name) == 0)
+						break;
+
+				if (spi_id->name[0])
+					continue;
+			} else {
+				if (strcmp(sdrv->driver.name, of_name) == 0)
+					continue;
+			}
+
+			pr_warn("SPI driver %s has no spi_device_id for %s\n",
+				sdrv->driver.name, of_id->compatible);
+		}
+	}
+
 	return driver_register(&sdrv->driver);
 }
 EXPORT_SYMBOL_GPL(__spi_register_driver);
-- 
2.20.1

