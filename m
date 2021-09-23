Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7369416447
	for <lists+linux-spi@lfdr.de>; Thu, 23 Sep 2021 19:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242543AbhIWRXC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Sep 2021 13:23:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242519AbhIWRW7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 23 Sep 2021 13:22:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 933D1610A0;
        Thu, 23 Sep 2021 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632417688;
        bh=nq7Crn2q8GriwIpAVcn+glrwJBVc8i6itJL0kbM0uK0=;
        h=From:To:Cc:Subject:Date:From;
        b=Q1MPvBVc0CHiitvS/WM3foV2Sn+/SKgBLHCgRPqractKwVjCw0rlwv/zd1kjtyIY8
         1jzPtVd2ePctgOvLhCLa7fDnlV6Kv0/1AQUgx60cijmOvfJENQoTc2jgi1i0/iJ7Ki
         6r2WFjCLjgUSvmjcaLQVvdDauXWploVfQdZx9SCgvt6FKSgOC/GIroDkDBbsrSVKBi
         d1jIVrs1aLMlSZqOw8J0cjyTAjlka9rY600T6K2mKvUyGgpemKQtRrUtVqK5nk30Ma
         07uFJFthLQkuHSJi6SapzuUmEA/+2OSzG0dixzaGVjA1kZ1obBQ7jSLyGRLFDP8xmH
         zLSUulprorD5Q==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] spi: spidev: Add SPI ID table
Date:   Thu, 23 Sep 2021 18:20:41 +0100
Message-Id: <20210923172041.4773-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521; h=from:subject; bh=nq7Crn2q8GriwIpAVcn+glrwJBVc8i6itJL0kbM0uK0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhTLdDK5jtdtKutVf9FyRaG/Xja/339hhekFYBDItD /JQVjjKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUy3QwAKCRAk1otyXVSH0KLRB/ 9BtAg6P254zQiCj3T4Glq//8283rfu8T3aGM8/It6j7HtfGukZs4MwCxYmkKedGlCC2IwQEaK5IEUD lIuJNopfbLBxI89dMd8sFBuUZaB5pmvjR+OHGAJ+yVfuC8F+t9DUfvIm97+teHAKfjN68ARizgkWEm J0DVw/c5SELgOZccXkepEne9UYtPhhMmumNME0uIEW5Kwp30TWPOIrpK9dR9PM+qtpHDX/ETI6Efj4 EiuMCmkpQkvwKZ96QQYnzoatbTpjKEK2Y2HtAZl8TColU0QkRX72wzHFwLQR2g/V3C+dfuB0UbDsGE I0yED8eO0yM2eTkaIuBCwBAKipechO
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
---
 drivers/spi/spidev.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 6dc29ce3b4bf..1bd73e322b7b 100644
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
+MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
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

