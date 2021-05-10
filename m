Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524E5378F1F
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 15:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbhEJNdo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 09:33:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:33803 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352056AbhEJNNy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 09:13:54 -0400
IronPort-SDR: rlniRiIoyfB4uaifsHZFo0vM/58h3+8f3PowU0MYlks/rVjcf+YFFpX5JQtt0cilC7LzVC6r9T
 Q4wJONLNs5hA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="263122578"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="263122578"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 06:11:14 -0700
IronPort-SDR: TYUGSpAYirdA6DAbx+o4/wISui+roA3VIJWoWqK6Jenkjck9dXiyzNFFHIbWVyH54q/qKaDfis
 XQl5dObFAJFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="468122274"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 10 May 2021 06:11:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7FA86D7; Mon, 10 May 2021 16:11:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Convert to use predefined time multipliers
Date:   Mon, 10 May 2021 16:11:20 +0300
Message-Id: <20210510131120.49253-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We have a lot of hard coded values in nanoseconds or other units.
Use predefined constants to make it more clear.

While at it, add or amend comments in the corresponding functions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f9885c096563..407420977a73 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1118,10 +1118,20 @@ static int spi_transfer_wait(struct spi_controller *ctlr,
 		if (!speed_hz)
 			speed_hz = 100000;
 
-		ms = 8LL * 1000LL * xfer->len;
+		/*
+		 * For each byte we wait for 8 cycles of the SPI clock.
+		 * Since speed is defined in Hz and we want milliseconds,
+		 * use respective multiplier, but before the division,
+		 * otherwise we may get 0 for short transfers.
+		 */
+		ms = 8LL * MSEC_PER_SEC * xfer->len;
 		do_div(ms, speed_hz);
-		ms += ms + 200; /* some tolerance */
 
+		/*
+		 * Increase it twice and add 200 ms tolerance, use
+		 * predefined maximum in case of overflow.
+		 */
+		ms += ms + 200;
 		if (ms > UINT_MAX)
 			ms = UINT_MAX;
 
@@ -1144,10 +1154,10 @@ static void _spi_transfer_delay_ns(u32 ns)
 {
 	if (!ns)
 		return;
-	if (ns <= 1000) {
+	if (ns <= NSEC_PER_USEC) {
 		ndelay(ns);
 	} else {
-		u32 us = DIV_ROUND_UP(ns, 1000);
+		u32 us = DIV_ROUND_UP(ns, NSEC_PER_USEC);
 
 		if (us <= 10)
 			udelay(us);
@@ -1167,21 +1177,25 @@ int spi_delay_to_ns(struct spi_delay *_delay, struct spi_transfer *xfer)
 
 	switch (unit) {
 	case SPI_DELAY_UNIT_USECS:
-		delay *= 1000;
+		delay *= NSEC_PER_USEC;
 		break;
-	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
+	case SPI_DELAY_UNIT_NSECS:
+		/* Nothing to do here */
 		break;
 	case SPI_DELAY_UNIT_SCK:
 		/* clock cycles need to be obtained from spi_transfer */
 		if (!xfer)
 			return -EINVAL;
-		/* if there is no effective speed know, then approximate
-		 * by underestimating with half the requested hz
+		/*
+		 * If there is unknown effective speed, approximate it
+		 * by underestimating with half of the requested hz.
 		 */
 		hz = xfer->effective_speed_hz ?: xfer->speed_hz / 2;
 		if (!hz)
 			return -EINVAL;
-		delay *= DIV_ROUND_UP(1000000000, hz);
+
+		/* Convert delay to nanoseconds */
+		delay *= DIV_ROUND_UP(NSEC_PER_SEC, hz);
 		break;
 	default:
 		return -EINVAL;
@@ -1213,6 +1227,7 @@ EXPORT_SYMBOL_GPL(spi_delay_exec);
 static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 					  struct spi_transfer *xfer)
 {
+	u32 default_delay_ns = 10 * NSEC_PER_USEC;
 	u32 delay = xfer->cs_change_delay.value;
 	u32 unit = xfer->cs_change_delay.unit;
 	int ret;
@@ -1220,16 +1235,16 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 	/* return early on "fast" mode - for everything but USECS */
 	if (!delay) {
 		if (unit == SPI_DELAY_UNIT_USECS)
-			_spi_transfer_delay_ns(10000);
+			_spi_transfer_delay_ns(default_delay_ns);
 		return;
 	}
 
 	ret = spi_delay_exec(&xfer->cs_change_delay, xfer);
 	if (ret) {
 		dev_err_once(&msg->spi->dev,
-			     "Use of unsupported delay unit %i, using default of 10us\n",
-			     unit);
-		_spi_transfer_delay_ns(10000);
+			     "Use of unsupported delay unit %i, using default of %luus\n",
+			     unit, default_delay_ns / NSEC_PER_USEC);
+		_spi_transfer_delay_ns(default_delay_ns);
 	}
 }
 
-- 
2.30.2

