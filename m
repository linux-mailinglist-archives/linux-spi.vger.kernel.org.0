Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26BD1140E26
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2020 16:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgAQPop (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jan 2020 10:44:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54166 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbgAQPof (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jan 2020 10:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tpRGY8braYYC4cmZ93sqnuMCgeJCOpcfO6gdfCvcFYM=; b=fUYGrIoZcm0K
        t0P/zIJTf8R6u7jLBtsfTN0v1HAe/tUiF2D1zwN0BCN6vInZ/sSyhlsbrckahYJr1qySIgTnpY1OA
        AYmg4fdcHuc+9cQKQBVhIXPHIn6dBRIPwDdTRsU7z+5zV+IZKxboCMfROovwy0xHqELP2n1Dja7fo
        /W/H8=;
Received: from fw-tnat-cam4.arm.com ([217.140.106.52] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1isTnM-0006uX-Dt; Fri, 17 Jan 2020 15:44:24 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 278C1D02C26; Fri, 17 Jan 2020 15:44:24 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Jean Pihet <jean.pihet@newoldbits.com>
Cc:     Arnout Vandecappelle <arnout.vandecappelle@essensium.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Applied "spi: spi-ti-qspi: fix warning" to the spi tree
In-Reply-To: <20200115100700.3357-1-jean.pihet@newoldbits.com>
Message-Id: <applied-20200115100700.3357-1-jean.pihet@newoldbits.com>
X-Patchwork-Hint: ignore
Date:   Fri, 17 Jan 2020 15:44:24 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-ti-qspi: fix warning

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

From 6925212f328bf2abde0c8f0d037fddd36751d489 Mon Sep 17 00:00:00 2001
From: Jean Pihet <jean.pihet@newoldbits.com>
Date: Wed, 15 Jan 2020 11:07:00 +0100
Subject: [PATCH] spi: spi-ti-qspi: fix warning
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

drivers/spi/spi-ti-qspi.c: In function ‘ti_qspi_start_transfer_one’:
drivers/spi/spi-ti-qspi.c:392:8: warning: ‘rx_wlen’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  392 |     if (rx_wlen >= 32)
      |        ^
drivers/spi/spi-ti-qspi.c:318:12: note: ‘rx_wlen’ was declared here
  318 |  u8 rxlen, rx_wlen;
      |            ^~~~~~~

The warning is a false positive; it is not thrown by all compiler versions, e.g.
Red Hat Cross 9.2.1-1 but not Linaro GCC 7.5-2019.12.

Signed-off-by: Jean Pihet <jean.pihet@newoldbits.com>
Link: https://lore.kernel.org/r/20200115100700.3357-1-jean.pihet@newoldbits.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ti-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 858fda8ac73e..366a3e5cca6b 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -332,6 +332,7 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
 		break;
 	}
 	wlen = t->bits_per_word >> 3;	/* in bytes */
+	rx_wlen = wlen;
 
 	while (count) {
 		dev_dbg(qspi->dev, "rx cmd %08x dc %08x\n", cmd, qspi->dc);
-- 
2.20.1

