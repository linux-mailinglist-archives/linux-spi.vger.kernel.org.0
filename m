Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41734FA1BF
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2019 03:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbfKMB7F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Nov 2019 20:59:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730137AbfKMB7E (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 12 Nov 2019 20:59:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7F24222CF;
        Wed, 13 Nov 2019 01:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610344;
        bh=FxbYPhvLR8fg0DHgSH8WQhAhiiLiSwo6/aH4Zs4YwwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+N7D3sDnRSAINv449sHBNV37jhdOJQPBQqKGcJm7s/qWscEQY+n8b4Bmt8FOIRbF
         TKD1KZLCQImD4lQivTD/fJmmAPJ7obBtEXwj1FxPBXAJQHgUCkfvjl6u5uuY7s5yDl
         Acd9gH3dJuSVIp8T+nb6qLEimwmK5UvhpBea0G7E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hieu Tran Dang <dangtranhieu2012@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 097/115] spi: fsl-lpspi: Prevent FIFO under/overrun by default
Date:   Tue, 12 Nov 2019 20:56:04 -0500
Message-Id: <20191113015622.11592-97-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Hieu Tran Dang <dangtranhieu2012@gmail.com>

[ Upstream commit de8978c388c66b8fca192213ec9f0727e964c652 ]

Certain devices don't work well when a transmit FIFO underrun or
receive FIFO overrun occurs. Example is the SAF400x radio chip when
running at high speed which leads to garbage being sent to/received from
the chip. In which case, it should stall waiting for further data to be
available before proceeding. This patch unset the NOSTALL bit in CFGR1
by default to prevent this issue.

Signed-off-by: Hieu Tran Dang <dangtranhieu2012@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index cb3c73007ca15..8fe51f7541bb3 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -287,7 +287,7 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 
 	fsl_lpspi_set_watermark(fsl_lpspi);
 
-	temp = CFGR1_PCSCFG | CFGR1_MASTER | CFGR1_NOSTALL;
+	temp = CFGR1_PCSCFG | CFGR1_MASTER;
 	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
 		temp |= CFGR1_PCSPOL;
 	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
-- 
2.20.1

