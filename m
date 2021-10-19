Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF35432B2E
	for <lists+linux-spi@lfdr.de>; Tue, 19 Oct 2021 02:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhJSA0U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 Oct 2021 20:26:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:2609 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhJSA0U (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 Oct 2021 20:26:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="208497544"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="208497544"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 17:24:08 -0700
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="718061213"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.149.34])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 17:24:07 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH 1/1] spi: altera: Change to dynamic allocation of spi id
Date:   Mon, 18 Oct 2021 17:24:01 -0700
Message-Id: <20211019002401.24041-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi-altera driver has two flavors: platform and dfl. I'm seeing
a case where I have both device types in the same machine, and they
are conflicting on the SPI ID:

... kernel: couldn't get idr
... kernel: WARNING: CPU: 28 PID: 912 at drivers/spi/spi.c:2920 spi_register_controller.cold+0x84/0xc0a

Both the platform and dfl drivers use the parent's driver ID as the SPI
ID. In the error case, the parent devices are dfl_dev.4 and
subdev_spi_altera.4.auto. When the second spi-master is created, the
failure occurs because the SPI ID of 4 has already been allocated.

Change the ID allocation to dynamic (by initializing bus_num to -1) to
avoid duplicate SPI IDs.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/spi/spi-altera-dfl.c      | 2 +-
 drivers/spi/spi-altera-platform.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
index 44fc9ee13fc7..ca40923258af 100644
--- a/drivers/spi/spi-altera-dfl.c
+++ b/drivers/spi/spi-altera-dfl.c
@@ -134,7 +134,7 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 	if (!master)
 		return -ENOMEM;
 
-	master->bus_num = dfl_dev->id;
+	master->bus_num = -1;
 
 	hw = spi_master_get_devdata(master);
 
diff --git a/drivers/spi/spi-altera-platform.c b/drivers/spi/spi-altera-platform.c
index f7a7c14e3679..65147aae82a1 100644
--- a/drivers/spi/spi-altera-platform.c
+++ b/drivers/spi/spi-altera-platform.c
@@ -48,7 +48,7 @@ static int altera_spi_probe(struct platform_device *pdev)
 		return err;
 
 	/* setup the master state. */
-	master->bus_num = pdev->id;
+	master->bus_num = -1;
 
 	if (pdata) {
 		if (pdata->num_chipselect > ALTERA_SPI_MAX_CS) {
-- 
2.25.1

