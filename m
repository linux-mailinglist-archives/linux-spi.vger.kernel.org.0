Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D05C4BF1D1
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2019 13:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfIZLhE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Sep 2019 07:37:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53943 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfIZLhD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Sep 2019 07:37:03 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iDS50-0005PK-2u; Thu, 26 Sep 2019 11:37:02 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: fsl-lpspi: clean up indentation issue
Date:   Thu, 26 Sep 2019 12:37:01 +0100
Message-Id: <20190926113701.26986-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The complete call is indented incorrectly, remove the extraneous tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index d08e9324140e..5efd73cd0ead 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -779,7 +779,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 
 	if (temp_SR & SR_FCF && (temp_IER & IER_FCIE)) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
-			complete(&fsl_lpspi->xfer_done);
+		complete(&fsl_lpspi->xfer_done);
 		return IRQ_HANDLED;
 	}
 
-- 
2.20.1

