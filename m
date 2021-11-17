Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B7F45473D
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 14:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhKQNeW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 08:34:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237579AbhKQNeW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 17 Nov 2021 08:34:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B2A961B1E;
        Wed, 17 Nov 2021 13:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637155883;
        bh=bIfKk8x8FPQrwjQCXe/QcQKHD2wOs1Tj104cFQl0pWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UyjuDYaOnMfauFh2YcgOU77XuQCHWb78IjoGf220omneriTg5QVkCs1hyE1E1qLfQ
         m4exTtCy1lmOJRFZyXeDWRszvBld3Gn6JCY+BToT5TrH7NMHtbcPo5WkMHPjC4mj9D
         yOpZVh/p60o3LgkTfvKRQltYkvCmwx55umJIrEthnxfjkevp4ZHFohxVBWgyj1cjo9
         rJ3ZQJE6iwi7FK7dsIn4hKqq/MNz3IVOPO5ELb07/vdbKAk0JWxA5bUYKTqn6lJ3BJ
         ny2NSBq/+MGi9F9YyjCliZX/IIpKg24DswvKuUVG1NI8rmq/CSoQBGiC9IV+T5uQLx
         bhg0jE9Mpqxxg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] spi: qcom: geni: set the error code for gpi transfer
Date:   Wed, 17 Nov 2021 19:01:09 +0530
Message-Id: <20211117133110.2682631-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211117133110.2682631-1-vkoul@kernel.org>
References: <20211117133110.2682631-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Before we invoke spi_finalize_current_transfer() in
spi_gsi_callback_result() we should set the spi->cur_msg->status as
appropriate (0 for success, error otherwise).

The helps to return error on transfer and not wait till it timesout on
error

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 413fa1a7a936..b9769de1f5f0 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -346,17 +346,20 @@ spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
 {
 	struct spi_master *spi = cb;
 
+	spi->cur_msg->status = -EIO;
 	if (result->result != DMA_TRANS_NOERROR) {
 		dev_err(&spi->dev, "DMA txn failed: %d\n", result->result);
 		return;
 	}
 
 	if (!result->residue) {
+		spi->cur_msg->status = 0;
 		dev_dbg(&spi->dev, "DMA txn completed\n");
-		spi_finalize_current_transfer(spi);
 	} else {
 		dev_err(&spi->dev, "DMA xfer has pending: %d\n", result->residue);
 	}
+
+	spi_finalize_current_transfer(spi);
 }
 
 static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas,
-- 
2.31.1

