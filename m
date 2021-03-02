Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A632A5E0
	for <lists+linux-spi@lfdr.de>; Tue,  2 Mar 2021 17:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446181AbhCBN1h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Mar 2021 08:27:37 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:19692 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376334AbhCBHRG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Mar 2021 02:17:06 -0500
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 01 Mar 2021 23:10:36 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 01 Mar 2021 23:10:34 -0800
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 Mar 2021 12:40:15 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 55B2320EB6; Tue,  2 Mar 2021 12:40:15 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Md Sadre Alam <mdalam@codeaurora.org>
Subject: [PATCH] spi: qup: Change usleep_range to udelay
Date:   Tue,  2 Mar 2021 12:40:13 +0530
Message-Id: <1614669013-1755-1-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change usleep_range() to udelay(). Since delay request
for 1 to 2 usec so we have to use udelay() instead of
usleep_range() as per kernel documentation.

Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
---
 drivers/spi/spi-qup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 8dcb2e7..37b013f 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -189,7 +189,7 @@ static int spi_qup_set_state(struct spi_qup *controller, u32 state)
 	loop = 0;
 	while (!spi_qup_is_valid_state(controller)) {
 
-		usleep_range(SPI_DELAY_THRESHOLD, SPI_DELAY_THRESHOLD * 2);
+		udelay(SPI_DELAY_THRESHOLD);
 
 		if (++loop > SPI_DELAY_RETRY)
 			return -EIO;
@@ -217,7 +217,7 @@ static int spi_qup_set_state(struct spi_qup *controller, u32 state)
 	loop = 0;
 	while (!spi_qup_is_valid_state(controller)) {
 
-		usleep_range(SPI_DELAY_THRESHOLD, SPI_DELAY_THRESHOLD * 2);
+		udelay(SPI_DELAY_THRESHOLD);
 
 		if (++loop > SPI_DELAY_RETRY)
 			return -EIO;
-- 
2.7.4

