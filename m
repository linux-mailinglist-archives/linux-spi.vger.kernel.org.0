Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADB127ADCC
	for <lists+linux-spi@lfdr.de>; Mon, 28 Sep 2020 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgI1Mas (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Sep 2020 08:30:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53882 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgI1Mas (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Sep 2020 08:30:48 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kMsIk-000882-BW; Mon, 28 Sep 2020 12:30:42 +0000
From:   Colin King <colin.king@canonical.com>
To:     John Garry <john.garry@huawei.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] spi: hisi-sfc-v3xx: fix spelling mistake "occured" -> "occurred"
Date:   Mon, 28 Sep 2020 13:30:42 +0100
Message-Id: <20200928123042.125359-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 46454dc2d109..4650b483a33d 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -121,7 +121,7 @@ static int hisi_sfc_v3xx_handle_completion(struct hisi_sfc_v3xx_host *host)
 	 * happens, we regard it as an unsupported error here.
 	 */
 	if (!(reg & HISI_SFC_V3XX_INT_MASK_CPLT)) {
-		dev_err(host->dev, "unsupported error occured, status=0x%x\n", reg);
+		dev_err(host->dev, "unsupported error occurred, status=0x%x\n", reg);
 		return -EIO;
 	}
 
-- 
2.27.0

