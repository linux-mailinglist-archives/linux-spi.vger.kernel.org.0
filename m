Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6684B2E6E51
	for <lists+linux-spi@lfdr.de>; Tue, 29 Dec 2020 06:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgL2Fdb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Dec 2020 00:33:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:18331 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgL2Fdb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Dec 2020 00:33:31 -0500
IronPort-SDR: oRLJPfIJ8/WsvWFwIZUXDsrl6yoJYNT5BD6XD5dw3t8ImI66h/UgJyUGhO2ERfYmDUIetAw2nr
 6W/LAJJFNPrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="164170718"
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="164170718"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 21:32:27 -0800
IronPort-SDR: iesoPh/mEKFUaWWkzylIfyuTdq9A4nJSill3xnIDXp11QJGX7/G3TIOKnZTyEiRkLL5IF+i46C
 Gumt8+NXfLUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="395307714"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga002.fm.intel.com with ESMTP; 28 Dec 2020 21:32:25 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] spi: fix the divide by 0 error when calculating xfer waiting time
Date:   Tue, 29 Dec 2020 13:27:42 +0800
Message-Id: <1609219662-27057-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609219662-27057-1-git-send-email-yilun.xu@intel.com>
References: <1609219662-27057-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The xfer waiting time is the result of xfer->len / xfer->speed_hz, but
when the following patch is merged,

commit 9326e4f1e5dd ("spi: Limit the spi device max speed to controller's max speed")

the xfer->speed_hz may always be clamped to 0 if the controller doesn't
provide its max_speed_hz. There may be no hardware indication of the
max_speed_hz so the controller driver leaves it, but exception happens
when it tries to do irq mode transfer.

This patch makes the assumption of 1khz xfer speed if the xfer->speed_hz
is not assigned. This avoids the divide by 0 issue and ensures a
reasonable tolerant waiting time.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/spi/spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 51d7c00..2f3c2c9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1109,6 +1109,7 @@ static int spi_transfer_wait(struct spi_controller *ctlr,
 	struct spi_statistics *statm = &ctlr->statistics;
 	struct spi_statistics *stats = &msg->spi->statistics;
 	unsigned long long ms;
+	u32 speed_hz;
 
 	if (spi_controller_is_slave(ctlr)) {
 		if (wait_for_completion_interruptible(&ctlr->xfer_completion)) {
@@ -1116,8 +1117,9 @@ static int spi_transfer_wait(struct spi_controller *ctlr,
 			return -EINTR;
 		}
 	} else {
+		speed_hz = xfer->speed_hz ? : 1000;
 		ms = 8LL * 1000LL * xfer->len;
-		do_div(ms, xfer->speed_hz);
+		do_div(ms, speed_hz);
 		ms += ms + 200; /* some tolerance */
 
 		if (ms > UINT_MAX)
-- 
2.7.4

