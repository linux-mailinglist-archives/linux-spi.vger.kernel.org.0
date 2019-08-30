Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1E9A35ED
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2019 13:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfH3Lpf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Aug 2019 07:45:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42726 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfH3Lpe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Aug 2019 07:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=iHEaQREeCsrnNxG2lXosrPwKiXi4CVnAiAtQwzI/tcE=; b=ESKEtOEp+oUi
        R0coxKnXRUy9/RX4jnZ1miE/qeaYQdxhREemvlpE6Ula0pxc4BUb9cC2VszDdasLniw1iS+KWJ3NU
        ducJ0YZYAvdfglRHFomiw3wjXeXmfRTyfhByDarJqOUPGH1ZR163nkqMO09cCsILELOwJDlIm2s6c
        A9XG0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i3fLQ-0006KM-Ah; Fri, 30 Aug 2019 11:45:32 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D3C672742B61; Fri, 30 Aug 2019 12:45:31 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm-qspi: Make BSPI default mode" to the spi tree
In-Reply-To: <1567139325-7912-1-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Patchwork-Hint: ignore
Message-Id: <20190830114531.D3C672742B61@ypsilon.sirena.org.uk>
Date:   Fri, 30 Aug 2019 12:45:31 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: bcm-qspi: Make BSPI default mode

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

From ca105398430de8c11e5e56a7bbfb00746ac5a268 Mon Sep 17 00:00:00 2001
From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date: Fri, 30 Aug 2019 09:58:45 +0530
Subject: [PATCH] spi: bcm-qspi: Make BSPI default mode

The spi-nor controller defaults to BSPI mode, hence switch back
to its default mode after MSPI operations (write or erase)
are completed.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>
Link: https://lore.kernel.org/r/1567139325-7912-1-git-send-email-rayagonda.kokatanur@broadcom.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 0dbfd2496ab8..7a3531856491 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -897,6 +897,7 @@ static int bcm_qspi_transfer_one(struct spi_master *master,
 
 		read_from_hw(qspi, slots);
 	}
+	bcm_qspi_enable_bspi(qspi);
 
 	return 0;
 }
-- 
2.20.1

