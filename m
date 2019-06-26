Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765D1567A2
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jun 2019 13:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfFZLdH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Jun 2019 07:33:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53590 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfFZLdG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Jun 2019 07:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=kXrqPsqlfq/GQQd949LGt1UJI7yWwccTvb5Mmx6tCNs=; b=qLJtWDcBxbXT
        RuHEd+jFf1QRWbDnAcPmOrP38dbQnxM2e94Ewk1KRbpkMg6jiRYklCt0rd7KlT4m7QAxM8H5sOcZd
        3OHfxRXa3u9mqWRjrFIPO7LH1ZPDIS9sX+Rzbicg3Jwv6lr8C0Sd80EDtpkwGks7veGjN7S6q+925
        OCsUE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hg6Ad-0007oc-8b; Wed, 26 Jun 2019 11:32:59 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id BD290440046; Wed, 26 Jun 2019 12:32:58 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     broonie@kernel.org, hayashibara.keiji@socionext.com,
        jaswinder.singh@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, masami.hiramatsu@linaro.org,
        yamada.masahiro@socionext.com
Subject: Applied "spi: uniphier: fix zero-length transfer" to the spi tree
In-Reply-To: <1561509708-4175-3-git-send-email-hayashibara.keiji@socionext.com>
X-Patchwork-Hint: ignore
Message-Id: <20190626113258.BD290440046@finisterre.sirena.org.uk>
Date:   Wed, 26 Jun 2019 12:32:58 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: uniphier: fix zero-length transfer

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

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

From 2b947137f2b8f77474dfe77d68c52778bf6ae453 Mon Sep 17 00:00:00 2001
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Date: Wed, 26 Jun 2019 09:41:48 +0900
Subject: [PATCH] spi: uniphier: fix zero-length transfer

The zero-length transfer results in timeout error because
the transfer doesn't start.
This commit modified to return success in this case.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-uniphier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index c3c35c041ef1..b32c77df5d49 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -331,6 +331,10 @@ static int uniphier_spi_transfer_one(struct spi_master *master,
 	struct device *dev = master->dev.parent;
 	unsigned long time_left;
 
+	/* Terminate and return success for 0 byte length transfer */
+	if (!t->len)
+		return 0;
+
 	uniphier_spi_setup_transfer(spi, t);
 
 	reinit_completion(&priv->xfer_done);
-- 
2.20.1

