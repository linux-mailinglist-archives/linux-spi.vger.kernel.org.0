Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFDABC634
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2019 13:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504597AbfIXLGH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Sep 2019 07:06:07 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:41327 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438614AbfIXLGF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Sep 2019 07:06:05 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46cyzb4d3Mz1rfM8;
        Tue, 24 Sep 2019 13:06:03 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46cyzb4FWcz1qqkG;
        Tue, 24 Sep 2019 13:06:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id mHzmAoV-eGzN; Tue, 24 Sep 2019 13:06:02 +0200 (CEST)
X-Auth-Info: D8eW+ivcXXiwUT+UPKNeTEAMLUuwXA7932l9M2UwFfw=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 24 Sep 2019 13:06:02 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 1/2] spi: Add call to spi_slave_abort() function when spidev driver is released
Date:   Tue, 24 Sep 2019 13:05:46 +0200
Message-Id: <20190924110547.14770-2-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190924110547.14770-1-lukma@denx.de>
References: <20190924110547.14770-1-lukma@denx.de>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This change is necessary for spidev devices (e.g. /dev/spidev3.0) working
in the slave mode (like NXP's dspi driver for Vybrid SoC).

When SPI HW works in this mode - the master is responsible for providing
CS and CLK signals. However, when some fault happens - like for example
distortion on SPI lines - the SPI Linux driver needs a chance to recover
from this abnormal situation and prepare itself for next (correct)
transmission.

This change doesn't pose any threat on drivers working in master mode as
spi_slave_abort() function checks if SPI slave mode is supported.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 255786f2e844..fe9ea7e55e5b 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -627,6 +627,7 @@ static int spidev_release(struct inode *inode, struct file *filp)
 		if (dofree)
 			kfree(spidev);
 	}
+	spi_slave_abort(spidev->spi);
 	mutex_unlock(&device_list_lock);
 
 	return 0;
-- 
2.20.1

