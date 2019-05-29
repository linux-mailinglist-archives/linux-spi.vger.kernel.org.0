Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC72DA71
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2019 12:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfE2KZY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 May 2019 06:25:24 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:36988 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfE2KZY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 May 2019 06:25:24 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45DRg60sk5z1rcqw;
        Wed, 29 May 2019 12:25:22 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45DRg60f83z1qqkr;
        Wed, 29 May 2019 12:25:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id p_CpuK81GGex; Wed, 29 May 2019 12:25:20 +0200 (CEST)
X-Auth-Info: 5blf25sXoWv84nvQ+vatnazYN3XG2LO6mrRP+8/gStc=
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz [86.49.110.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 29 May 2019 12:25:20 +0200 (CEST)
From:   Marek Vasut <marex@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Mark Brown <broonie@kernel.org>
Subject: [PATCH] spidev: Add M53Menlo CPLD compatible
Date:   Wed, 29 May 2019 12:24:51 +0200
Message-Id: <20190529102451.4548-1-marex@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add compatible string for Menlosystems CPLD present on the M53Menlo
board. This CPLD is used to communicate with various custom sensors.

Signed-off-by: Marek Vasut <marex@denx.de>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index df4c0a9b34dd..30498cf25f3b 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -673,6 +673,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "semtech,sx1301" },
 	{ .compatible = "lwn,bk4" },
 	{ .compatible = "dh,dhcom-board" },
+	{ .compatible = "menlo,m53cpld" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.20.1

