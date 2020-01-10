Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAF6137798
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2020 21:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgAJUAA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jan 2020 15:00:00 -0500
Received: from foss.arm.com ([217.140.110.172]:50568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbgAJT7F (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 10 Jan 2020 14:59:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D051E328;
        Fri, 10 Jan 2020 11:59:04 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5615D3F534;
        Fri, 10 Jan 2020 11:59:04 -0800 (PST)
Date:   Fri, 10 Jan 2020 19:59:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     broonie@kernel.org, chenxiang66@hisilicon.com,
        fengsheng5@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        Mark Brown <broonie@kernel.org>, tudor.ambarus@microchip.com,
        xuejiancheng@hisilicon.com
Subject: Applied "MAINTAINERS: Add a maintainer for the HiSilicon v3xx SFC driver" to the spi tree
In-Reply-To: <1575900490-74467-4-git-send-email-john.garry@huawei.com>
Message-Id: <applied-1575900490-74467-4-git-send-email-john.garry@huawei.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   MAINTAINERS: Add a maintainer for the HiSilicon v3xx SFC driver

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 99eb0a1221ac1083b8c87932c438ef016abdaa05 Mon Sep 17 00:00:00 2001
From: John Garry <john.garry@huawei.com>
Date: Mon, 9 Dec 2019 22:08:10 +0800
Subject: [PATCH] MAINTAINERS: Add a maintainer for the HiSilicon v3xx SFC
 driver

Set John Garry @ Huawei as the maintainer.

Signed-off-by: John Garry <john.garry@huawei.com>
Link: https://lore.kernel.org/r/1575900490-74467-4-git-send-email-john.garry@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd5847e802de..8c119bd4f687 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7492,6 +7492,12 @@ S:	Supported
 F:	drivers/scsi/hisi_sas/
 F:	Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
 
+HISILICON V3XX SPI NOR FLASH Controller Driver
+M:	John Garry <john.garry@huawei.com>
+W:	http://www.hisilicon.com
+S:	Maintained
+F:	drivers/spi/spi-hisi-sfc-v3xx.c
+
 HISILICON QM AND ZIP Controller DRIVER
 M:	Zhou Wang <wangzhou1@hisilicon.com>
 L:	linux-crypto@vger.kernel.org
-- 
2.20.1

