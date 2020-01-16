Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2FC13F094
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2020 19:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404046AbgAPR12 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jan 2020 12:27:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404036AbgAPR10 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jan 2020 12:27:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15BF0246D3;
        Thu, 16 Jan 2020 17:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195645;
        bh=CkuyHy+LTnuMc8iztfegljcTXrOlV57qafrOQbbVHqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+1wdNZBOSu2WiRKtaeospNgcm9KEh7+HpMzO/4idp9OYDJVTAu7LQ9jI+AQ/AIHu
         PXLfBHDboLS4FlX1T1LHj2yvwx+287vulXZ2IkSDXwL+VKtR3taTNy/IFXfNMYIMWc
         rodFJVvfIR3JHSo3+i9VWLG0PfNf/dv/PQt9td4Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 209/371] spi: spi-fsl-spi: call spi_finalize_current_message() at the end
Date:   Thu, 16 Jan 2020 12:21:21 -0500
Message-Id: <20200116172403.18149-152-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 44a042182cb1e9f7916e015c836967bf638b33c4 ]

spi_finalize_current_message() shall be called once all
actions are finished, otherwise the last actions might
step over a newly started transfer.

Fixes: c592becbe704 ("spi: fsl-(e)spi: migrate to generic master queueing")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 8b79e36fab21..cd784552de7f 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -407,7 +407,6 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	}
 
 	m->status = status;
-	spi_finalize_current_message(master);
 
 	if (status || !cs_change) {
 		ndelay(nsecs);
@@ -415,6 +414,7 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	}
 
 	fsl_spi_setup_transfer(spi, NULL);
+	spi_finalize_current_message(master);
 	return 0;
 }
 
-- 
2.20.1

