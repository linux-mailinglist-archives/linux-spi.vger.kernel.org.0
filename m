Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E60ECA67E5
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2019 13:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbfICL54 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Sep 2019 07:57:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53126 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbfICL54 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Sep 2019 07:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cgxtaWs//pWcWZQdK/XoplWjvgqpaZGkl5enIyRVTjU=; b=B3tLuBNEB1du
        xHMinHE6b1SDBxOOXLbRMKvex5t9HBuTBpeXaU2gvU/W/0UPZOCtL7m41UYCxMURP3mP1EL3KtQBc
        xdi0KEVOdwHWHQfTFHe4lYSwqgd7eNToJdLZkFSfSwGcwE5i/QBMQIrij3jijFIcBF48p3SK9nXte
        edmqk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i57RV-0008M4-Qw; Tue, 03 Sep 2019 11:57:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 44CAB2742D32; Tue,  3 Sep 2019 12:57:49 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     broonie@kernel.org, hayashibara.keiji@socionext.com,
        jaswinder.singh@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, masami.hiramatsu@linaro.org,
        yamada.masahiro@socionext.com
Subject: Applied "spi: uniphier: fix wrong register overwrite" to the spi tree
In-Reply-To: <1567488661-11428-2-git-send-email-hayashibara.keiji@socionext.com>
X-Patchwork-Hint: ignore
Message-Id: <20190903115749.44CAB2742D32@ypsilon.sirena.org.uk>
Date:   Tue,  3 Sep 2019 12:57:49 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: uniphier: fix wrong register overwrite

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

From 3c633f9dbd824b2f8e5e1a3c1fd533c1b2801be5 Mon Sep 17 00:00:00 2001
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Date: Tue, 3 Sep 2019 14:30:59 +0900
Subject: [PATCH] spi: uniphier: fix wrong register overwrite

When it changes the spi mode, the register is overwritten incorrectly.
This commit fixes this register overwrite.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Link: https://lore.kernel.org/r/1567488661-11428-2-git-send-email-hayashibara.keiji@socionext.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-uniphier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 5a6137fe172d..50f12fb20403 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -214,6 +214,7 @@ static void uniphier_spi_setup_transfer(struct spi_device *spi,
 	if (!priv->is_save_param || priv->mode != spi->mode) {
 		uniphier_spi_set_mode(spi);
 		priv->mode = spi->mode;
+		priv->is_save_param = false;
 	}
 
 	if (!priv->is_save_param || priv->bits_per_word != t->bits_per_word) {
-- 
2.20.1

