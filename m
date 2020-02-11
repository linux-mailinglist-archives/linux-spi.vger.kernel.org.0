Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8754A159D8B
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2020 00:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgBKXk1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Feb 2020 18:40:27 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54725 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgBKXiq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Feb 2020 18:38:46 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 836d623a7f020c50; Wed, 12 Feb 2020 00:38:44 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Han Xu <han.xu@nxp.com>, linux-spi@vger.kernel.org
Subject: [PATCH 21/28] drivers: spi: Call cpu_latency_qos_*() instead of pm_qos_*()
Date:   Wed, 12 Feb 2020 00:26:04 +0100
Message-ID: <3093071.fpHvlHfnRF@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Call cpu_latency_qos_add/remove_request() instead of
pm_qos_add/remove_request(), respectively, because the
latter are going to be dropped.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/spi/spi-fsl-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index e8a499cd1f13..02e5cba0a5bb 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -484,7 +484,7 @@ static int fsl_qspi_clk_prep_enable(struct fsl_qspi *q)
 	}
 
 	if (needs_wakeup_wait_mode(q))
-		pm_qos_add_request(&q->pm_qos_req, PM_QOS_CPU_DMA_LATENCY, 0);
+		cpu_latency_qos_add_request(&q->pm_qos_req, 0);
 
 	return 0;
 }
@@ -492,7 +492,7 @@ static int fsl_qspi_clk_prep_enable(struct fsl_qspi *q)
 static void fsl_qspi_clk_disable_unprep(struct fsl_qspi *q)
 {
 	if (needs_wakeup_wait_mode(q))
-		pm_qos_remove_request(&q->pm_qos_req);
+		cpu_latency_qos_remove_request(&q->pm_qos_req);
 
 	clk_disable_unprepare(q->clk);
 	clk_disable_unprepare(q->clk_en);
-- 
2.16.4





