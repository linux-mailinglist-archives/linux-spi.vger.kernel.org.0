Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A937A2648E4
	for <lists+linux-spi@lfdr.de>; Thu, 10 Sep 2020 17:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbgIJPgu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Sep 2020 11:36:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36916 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731340AbgIJPgW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Sep 2020 11:36:22 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kGO7O-0005oO-PE; Thu, 10 Sep 2020 15:04:10 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andy Gross <agross@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: qup: remove redundant assignment to variable ret
Date:   Thu, 10 Sep 2020 16:04:10 +0100
Message-Id: <20200910150410.750959-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is
never read and it is being updated later with a new value. The
initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-qup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index a364b99497e2..8dcb2e70735c 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -848,7 +848,7 @@ static int spi_qup_transfer_one(struct spi_master *master,
 {
 	struct spi_qup *controller = spi_master_get_devdata(master);
 	unsigned long timeout, flags;
-	int ret = -EIO;
+	int ret;
 
 	ret = spi_qup_io_prep(spi, xfer);
 	if (ret)
-- 
2.27.0

