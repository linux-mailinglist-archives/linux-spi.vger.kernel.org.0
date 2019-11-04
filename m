Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D91EE540
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2019 17:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfKDQy4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Nov 2019 11:54:56 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727861AbfKDQy4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Nov 2019 11:54:56 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2F009202F7ED87065250;
        Tue,  5 Nov 2019 00:54:52 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 00:54:42 +0800
From:   John Garry <john.garry@huawei.com>
To:     <broonie@kernel.org>, <marek.vasut@gmail.com>,
        <tudor.ambarus@microchip.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <xuejiancheng@hisilicon.com>, <fengsheng5@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/3] HiSilicon v3xx SFC driver
Date:   Tue, 5 Nov 2019 00:51:34 +0800
Message-ID: <1572886297-45400-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patchset introduces support for the HiSilicon SFC V3XX driver.

Whilst the kernel tree already includes support for a "HiSilicon SFC
driver", that is for different HW. Indeed, as mentioned in patch #1, the
naming for that driver could be better, as it should support more memory
technologies than SPI NOR (as I have been told), and it is actually known
internally as FMC. As such, maybe "hisi-fmc" would have been better, but
we can't change that now.

I used V3XX in this driver name, as that is the unique versioning for
this HW.

As for the driver itself, it is quite simple. Only ACPI firmware is
supported, and we assume m25p80 compatible SPI NOR part will be used.

DMA is not supported, and we just use polling mode for operation
completion notification. The driver uses the SPI MEM OPs.

Tested against 5.4-rc4.

John Garry (3):
  mtd: spi-nor: hisi-sfc: Try to provide some clarity on which SFC we
    are
  spi: Add HiSilicon v3xx SPI NOR flash controller driver
  MAINTAINERS: Add a maintainer for the HiSilicon v3xx SFC driver

 MAINTAINERS                     |   6 +
 drivers/mtd/spi-nor/Kconfig     |   4 +-
 drivers/mtd/spi-nor/hisi-sfc.c  |   2 +-
 drivers/spi/Kconfig             |   9 +
 drivers/spi/Makefile            |   1 +
 drivers/spi/spi-hisi-sfc-v3xx.c | 287 ++++++++++++++++++++++++++++++++
 6 files changed, 306 insertions(+), 3 deletions(-)
 create mode 100644 drivers/spi/spi-hisi-sfc-v3xx.c

-- 
2.17.1

