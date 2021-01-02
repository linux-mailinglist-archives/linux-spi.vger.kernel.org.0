Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2AD2E862F
	for <lists+linux-spi@lfdr.de>; Sat,  2 Jan 2021 04:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbhABDFN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 22:05:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:35271 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbhABDFN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 1 Jan 2021 22:05:13 -0500
IronPort-SDR: vVERRXup/ZnysZn4LstdiLINtKbAr4/jn/Hnt6S8QUC/tJdVjBIqjKu+K713o1bpHaXhGPInGR
 5q63ahJLhcbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9851"; a="173297445"
X-IronPort-AV: E=Sophos;i="5.78,468,1599548400"; 
   d="scan'208";a="173297445"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2021 19:04:32 -0800
IronPort-SDR: VGzmKTwRMOJvIvSjAiyTHEPh+kBB0ZmvyEyO2MUStDs0VzkdkpK+OYxui9GmHdIa/inYzXXslf
 Yr2GbaJPSVMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,468,1599548400"; 
   d="scan'208";a="349083059"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jan 2021 19:04:30 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] spi: fix the divide by 0 error when calculating xfer waiting time
Date:   Sat,  2 Jan 2021 10:59:46 +0800
Message-Id: <1609556386-19422-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The xfer waiting time is the result of xfer->len / xfer->speed_hz. This
patch makes the assumption of 1khz xfer speed if the xfer->speed_hz is
not assigned and stays 0. This avoids the divide by 0 issue and ensures
a reasonable tolerant waiting time.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
v2: use the normal conditional statement instead of the ternery operator
    change the default xfer speed from 1khz to 100khz
---
 drivers/spi/spi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 51d7c00..aacae88 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1108,6 +1108,7 @@ static int spi_transfer_wait(struct spi_controller *ctlr,
 {
 	struct spi_statistics *statm = &ctlr->statistics;
 	struct spi_statistics *stats = &msg->spi->statistics;
+	u32 speed_hz = xfer->speed_hz;
 	unsigned long long ms;
 
 	if (spi_controller_is_slave(ctlr)) {
@@ -1116,8 +1117,11 @@ static int spi_transfer_wait(struct spi_controller *ctlr,
 			return -EINTR;
 		}
 	} else {
+		if (!speed_hz)
+			speed_hz = 100000;
+
 		ms = 8LL * 1000LL * xfer->len;
-		do_div(ms, xfer->speed_hz);
+		do_div(ms, speed_hz);
 		ms += ms + 200; /* some tolerance */
 
 		if (ms > UINT_MAX)
-- 
2.7.4

