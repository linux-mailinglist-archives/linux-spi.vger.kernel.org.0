Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EBE4163C7
	for <lists+linux-spi@lfdr.de>; Thu, 23 Sep 2021 19:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhIWRCm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Sep 2021 13:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238281AbhIWRCl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 23 Sep 2021 13:02:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9242961090;
        Thu, 23 Sep 2021 17:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632416470;
        bh=Gz2IEtNQRa4ifNPpLyMX2FJc7Zul20qJymz0QcFJg58=;
        h=From:To:Cc:Subject:Date:From;
        b=R10LQqEaLZaSLuC53lQWi4MVjwjqOaPZupWT83krKvHTTtujQd8lpTlKQ7EFtQ2eO
         o6KTGmzvKShAPo62b0t7wylFFXyGKlRf+yNTHrpfW4WLd9Zsdm/JCg2AtwP0nzo7Bd
         7iD/OS7iGLYXB2Q3Kpvrfclbin44SJYm7RLya7ddmbTEilj8QTBzKNKij9sp2RxQaE
         NguFteyqbCbp5Mg/P42Dw1Bd4enlwOaQ0Ll6gtOgtsqI2x/sGlsN0QYuZURC+mEgUc
         /gSoMDEgze3XD59Gl9xPkXggahfv6819sx7sT88Bt3zj5Yq4Im1RdZ1CzXpt3+CKzP
         iREAD0K0IZ5tA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
Subject: [PATCH] spi: spidev: Add SPI ID table
Date:   Thu, 23 Sep 2021 18:00:23 +0100
Message-Id: <20210923170023.1683-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; h=from:subject; bh=Gz2IEtNQRa4ifNPpLyMX2FJc7Zul20qJymz0QcFJg58=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhTLKYNCCkgntivleIv3cugP/IW3J6YiRsKyB+wm6W 0OR9vfiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUyymAAKCRAk1otyXVSH0ELRB/ oDYYYguXJ0W+7BbGGL3SI1i7K57mbDV1I2LXxBsN5I5yGgI1+TlQpOqyyKNCIKr8ZSFH8G7aAFJ5Lu 5eQLUnYHuxG7S4LyxAmOp1MdG8TTQhPMAi4VyzE4SCZ2Ef02Z101c8O/dXlIrVK9x2k0gYKpIWBk8w 2s6Ky25WiTQY/6p+TcVDKno/XQZ221m/2oGWRg09wl9Qa0QHwsUJKMrEDG1BgEsCBB11Vk6DNGy3Fa 1d+487iZ/9WbMY/9W/nVuWpXU8J/Ln9+kxPH2Va9N/Qh7EVqA8/HtmRMImmUqi10RFPkA5mJvdKFNB YgzgoYMwqqSLr9Adk53RzXtsp9120P
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently autoloading for SPI devices does not use the DT ID table, it uses
SPI modalises. Supporting OF modalises is going to be difficult if not
impractical, an attempt was made but has been reverted, so ensure that
module autoloading works for this driver by adding an id_table listing the
SPI IDs for everything.

Fixes: 96c8395e2166 ("spi: Revert modalias changes")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: patches@opensource.cirrus.com
---
 drivers/spi/spidev.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 6dc29ce3b4bf..79c22fc8b0a4 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -673,6 +673,19 @@ static const struct file_operations spidev_fops = {
 
 static struct class *spidev_class;
 
+static const struct spi_device_id spidev_spi_ids[] = {
+	{ .name = "dh2228fv" },
+	{ .name = "ltc2488" },
+	{ .name = "sx1301" },
+	{ .name = "bk4" },
+	{ .name = "dhcom-board" },
+	{ .name = "m53cpld" },
+	{ .name = "spi-petra" },
+	{ .name = "spi-authenta" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, spidev_dt_ids);
+
 #ifdef CONFIG_OF
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "rohm,dh2228fv" },
@@ -818,6 +831,7 @@ static struct spi_driver spidev_spi_driver = {
 	},
 	.probe =	spidev_probe,
 	.remove =	spidev_remove,
+	.id_table =	spidev_spi_ids,
 
 	/* NOTE:  suspend/resume methods are not necessary here.
 	 * We don't do anything except pass the requests to/from
-- 
2.20.1

