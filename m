Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85DE2E8F39
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 02:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbhADBej (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 Jan 2021 20:34:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:15795 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbhADBej (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 3 Jan 2021 20:34:39 -0500
IronPort-SDR: 7kYrfV15KzKzFrSBmyf3lVkZaSPjbsl6aB3NiVKwlFhnyTeZBrqqxxawqccxPJasIg2wNE4NZn
 5XZMGqBUveuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="173390097"
X-IronPort-AV: E=Sophos;i="5.78,472,1599548400"; 
   d="scan'208";a="173390097"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2021 17:33:59 -0800
IronPort-SDR: RnqLSzBC5+25x1dJldGLD4SD3oyNLznPPmn52S36k/Ul2MolOR3tArhl4DGh7oPLRgE0iuBQac
 8G6RMT0bolOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,472,1599548400"; 
   d="scan'208";a="349708939"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jan 2021 17:33:57 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3] spi: fix the divide by 0 error when calculating xfer waiting time
Date:   Mon,  4 Jan 2021 09:29:09 +0800
Message-Id: <1609723749-3557-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The xfer waiting time is the result of xfer->len / xfer->speed_hz. This
patch makes the assumption of 100khz xfer speed if the xfer->speed_hz is
not assigned and stays 0. This avoids the divide by 0 issue and ensures
a reasonable tolerant waiting time.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
v2: use the normal conditional statement instead of the ternery operator
    change the default xfer speed from 1khz to 100khz
v3: fix the commit message
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

