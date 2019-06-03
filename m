Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 379243376B
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2019 20:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFCSCy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jun 2019 14:02:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56568 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFCSCy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jun 2019 14:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ma35thperYGWyb/nkjWyegfRbpj87ZHQlb98QF7Ppqg=; b=MacOEriOZ/v7
        nuQEgHWOdboZ17Tw2BaNzgeiQmEEvvL93bfSbzUj62TIG00QKGp8rcP1m4hyHfYhVRtSJje45fL9O
        zpVFui3og9JLXDxmFvYsW8vLkltfLZzo7tZgvrPzBXpiJ9gN9ubQTiFpmBoEinpaBKk7xUef9q0VX
        2xvAU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hXrIJ-0003ay-6h; Mon, 03 Jun 2019 18:02:51 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 9792D440046; Mon,  3 Jun 2019 19:02:50 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     agross@kernel.org, broonie@kernel.org, david.brown@linaro.org,
        jorge.ramirez-ortiz@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: remove unnecessary goto" to the spi tree
In-Reply-To: <20190531144636.27843-1-jorge.ramirez-ortiz@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190603180250.9792D440046@finisterre.sirena.org.uk>
Date:   Mon,  3 Jun 2019 19:02:50 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: qup: remove unnecessary goto

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 3594bfa265da38dcfbab2312ddaff39711b98857 Mon Sep 17 00:00:00 2001
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Date: Fri, 31 May 2019 16:46:36 +0200
Subject: [PATCH] spi: qup: remove unnecessary goto

Remove unnecessary condition check and associated goto.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 974a8ce58b68..314d91b95a16 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -842,10 +842,6 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	else
 		ret = spi_qup_do_pio(spi, xfer, timeout);
 
-	if (ret)
-		goto exit;
-
-exit:
 	spi_qup_set_state(controller, QUP_STATE_RESET);
 	spin_lock_irqsave(&controller->lock, flags);
 	if (!ret)
-- 
2.20.1

