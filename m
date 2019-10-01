Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B9CC2FA4
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 11:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfJAJHO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 05:07:14 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:60603 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbfJAJHO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 05:07:14 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46jD1D0RNWz1rgDj;
        Tue,  1 Oct 2019 11:07:12 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46jD1C664xz1qqkb;
        Tue,  1 Oct 2019 11:07:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 0VAN4JYGdG0K; Tue,  1 Oct 2019 11:07:10 +0200 (CEST)
X-Auth-Info: F+LKSSdXzI2pXTv5WUICbbnV81SyqaH7V/PX0VhRB3Q=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  1 Oct 2019 11:07:10 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-spi@vger.kernel.org, krzk@kernel.org,
        linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>,
        kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] spi: Avoid calling spi_slave_abort() with kfreed spidev
Date:   Tue,  1 Oct 2019 11:06:57 +0200
Message-Id: <20191001090657.25721-1-lukma@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Call spi_slave_abort() only when the spidev->spi is !NULL and the
structure hasn't already been kfreed.

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
This fix applies on:
repo: https://kernel.googlesource.com/pub/scm/linux/kernel/git/broonie/spi.git
branch: for-5.4
SHA1: 6b04e47b73f2a0d2c330cecca99f8e2cb8f85b34
---
 drivers/spi/spidev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 3ea9d8a3e6e8..2c6d4dbeebac 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -600,15 +600,16 @@ static int spidev_open(struct inode *inode, struct file *filp)
 static int spidev_release(struct inode *inode, struct file *filp)
 {
 	struct spidev_data	*spidev;
+	int dofree;
 
 	mutex_lock(&device_list_lock);
 	spidev = filp->private_data;
 	filp->private_data = NULL;
+	dofree = 0;
 
 	/* last close? */
 	spidev->users--;
 	if (!spidev->users) {
-		int		dofree;
 
 		kfree(spidev->tx_buffer);
 		spidev->tx_buffer = NULL;
@@ -628,7 +629,8 @@ static int spidev_release(struct inode *inode, struct file *filp)
 			kfree(spidev);
 	}
 #ifdef CONFIG_SPI_SLAVE
-	spi_slave_abort(spidev->spi);
+	if (!dofree)
+		spi_slave_abort(spidev->spi);
 #endif
 	mutex_unlock(&device_list_lock);
 
-- 
2.20.1

