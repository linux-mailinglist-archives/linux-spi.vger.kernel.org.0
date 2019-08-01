Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8D77DA1D
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 13:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbfHALSY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 07:18:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50870 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730447AbfHALSX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Aug 2019 07:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ts7Wuhwdp6RUU0lWUdro44IST7FhRZuEKkrJRN/QhKM=; b=S2iVsB9TvL3c2A0C6BVu99iu8C
        M4CYn3OLGZe/Kq2Z3wvLAEiNZiQdCq25GSXPjnY3goThBuRPh/1OOeNWTWG/JbG2FUKzGV3A0su4U
        MraCsCcc+ZLreEhvH2+hg9GTVv1YN9BzFbP2RlYSM/LoMTmkhjMOUjErl7rPWyyF6aljEusK4HKZz
        A814rOmCbId28UB+7qzPIBg/EtNIpAYMe/iJ2bKu4WDNIF1pc4OEz5wwA2sgyPZak8KEoF55VxaVg
        kbINHdxSoCP9mXEns/GU9+dneG35Ys9fn+it/VTzNa1zGwH1aZBtx/vC47CMV5pUKogy104q4LPxt
        F2OqzPrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ht968-0005fe-Ie; Thu, 01 Aug 2019 11:18:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8E421202975E5; Thu,  1 Aug 2019 13:18:12 +0200 (CEST)
Message-Id: <20190801111541.917256884@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 01 Aug 2019 13:13:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH 5/5] spi: Reduce kthread priority
References: <20190801111348.530242235@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI thingies request FIFO-99 by default, reduce this to FIFO-50.

FIFO-99 is the very highest priority available to SCHED_FIFO and
it not a suitable default; it would indicate the SPI work is the
most important work on the machine.

Cc: Benson Leung <bleung@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/platform/chrome/cros_ec_spi.c |    2 +-
 drivers/spi/spi.c                     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -706,7 +706,7 @@ static int cros_ec_spi_devm_high_pri_all
 					   struct cros_ec_spi *ec_spi)
 {
 	struct sched_param sched_priority = {
-		.sched_priority = MAX_RT_PRIO - 1,
+		.sched_priority = MAX_RT_PRIO / 2,
 	};
 	int err;
 
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1434,7 +1434,7 @@ static void spi_pump_messages(struct kth
  */
 static void spi_set_thread_rt(struct spi_controller *ctlr)
 {
-	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
+	struct sched_param param = { .sched_priority = MAX_RT_PRIO / 2 };
 
 	dev_info(&ctlr->dev,
 		"will run message pump with realtime priority\n");


