Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24EEC4A9E7
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 20:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfFRSde (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 14:33:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47800 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730073AbfFRSdd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 14:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GLJH+OGHleg2bIG7WWdkgF3y9D8/8Ek9al/7WKjjj6Q=; b=l+ntme/Dp5bz
        AsZasZE3/FdOPmSsctnNykUk1eRWxdRg/SzUk2XgZU02KMc2TOPuiR5Ep4LPnBP1cZwhfOtpTRAfw
        3x0Y2ccOESyVr8h0lLu/66nMoWtjHKRXsLj37X6q7VQ5ygPa+bFKyqX9IOINU6UQrRYmDoHsuYI/G
        N65TE=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdIvC-0005LY-T1; Tue, 18 Jun 2019 18:33:30 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 5A58E440046; Tue, 18 Jun 2019 19:33:30 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: don't open code list_for_each_entry_safe_reverse()" to the spi tree
In-Reply-To: <20190618162818.24415-1-vz@mleia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190618183330.5A58E440046@finisterre.sirena.org.uk>
Date:   Tue, 18 Jun 2019 19:33:30 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: don't open code list_for_each_entry_safe_reverse()

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

From f56943699463478617b235930252261d5277bd46 Mon Sep 17 00:00:00 2001
From: Vladimir Zapolskiy <vz@mleia.com>
Date: Tue, 18 Jun 2019 19:28:18 +0300
Subject: [PATCH] spi: don't open code list_for_each_entry_safe_reverse()

The loop declaration in function spi_res_release() can be simplified
by reusing the common list_for_each_entry_safe_reverse() helper
macro.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e71881afe475..01a40bcfc352 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2721,12 +2721,9 @@ EXPORT_SYMBOL_GPL(spi_res_add);
  */
 void spi_res_release(struct spi_controller *ctlr, struct spi_message *message)
 {
-	struct spi_res *res;
-
-	while (!list_empty(&message->resources)) {
-		res = list_last_entry(&message->resources,
-				      struct spi_res, entry);
+	struct spi_res *res, *tmp;
 
+	list_for_each_entry_safe_reverse(res, tmp, &message->resources, entry) {
 		if (res->release)
 			res->release(ctlr, message, res->data);
 
-- 
2.20.1

