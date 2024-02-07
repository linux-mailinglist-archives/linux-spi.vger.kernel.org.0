Return-Path: <linux-spi+bounces-1175-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA8B84D16D
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 19:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE8B0B216F2
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 18:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C34383CD7;
	Wed,  7 Feb 2024 18:43:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC8183CCB
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331397; cv=none; b=p6cHiHOOuk+qXG1B7WDGdheSrdJUKMB+597cQtSl1NM1yQgKnx9CibykCHHaBwx+CvizI+Jea6WubI30p5gmTkRseFnIIEUbA+4Iqd5LD578rk3G/3QmT+hLE2jiIE+pjqAo82MNijcfykKP190dRh73zpiYyMUsX4WZv25losc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331397; c=relaxed/simple;
	bh=JgBVUlN1d7qYFnm0ZKVPd582aguOzqNX2Ijr5H69uZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJXhsqScOjNoWtGDQv17AItPVUcltY08pKNw4SQU85wolRJgWS+HtbNJ9q6jmR+rlbyAbHSpJq1VQ8p58Vc8uhyvv8lg5vWyQXeGoOcfTDhu7v1G6J+3MXTYWyftMZS9Yg55TWhlKoqs4hYwjUjV1USu4MSHOp6aQ9GkfJP04/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt7-0007iL-Hm; Wed, 07 Feb 2024 19:43:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt7-0054Xq-1P; Wed, 07 Feb 2024 19:43:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt6-00HRss-36;
	Wed, 07 Feb 2024 19:43:12 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 17/32] spi: cadence-quadspi: Don't emit error message on allocation error
Date: Wed,  7 Feb 2024 19:40:31 +0100
Message-ID:  <8da90785395664bf17d16428f46e84b95ef5cc3b.1707324794.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=977; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=JgBVUlN1d7qYFnm0ZKVPd582aguOzqNX2Ijr5H69uZY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86pp9uzxmuDyQ0mFGdNd2DpAvbKt7gfjHNv9 bKDArohENOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOqQAKCRCPgPtYfRL+ TuIlB/9IqxAwKlOkz/l+TR7Hb1usnQ7iK++5ehWAYDu/QUDiAb0Yl6oDxx1gkrkZoMLbBbVL8ZZ HZ2aSBvGj/+pdWAEzqQiRLKWaOnlmljb9ZUigfxDM6ncvtG30HQ7kiQ1qizjLR+4diCVKZsR1Md fGAfxverac0tyFjzbeCouufNq/jVaDgEvLMpgp19kIz4IMGODU8wcTHr+/wWD9HbzZLeVo8LNYx EeQdKkrVAkOdnpay8fJ9nfaZAFUySgRpBRETYDKjauJ8Vtc7d0ifrcVHE2/auIeHfeC1kMcGFeX 5nJz+ea84Omsw9yoUs5bwsTeEzWUHJG0NLjokzF7tUN2MARp
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Drivers are not supposed to emit an error message when a memory
allocation fails, as the kernel is very loud in this case already
anyhow.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-cadence-quadspi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index f94e0d370d46..eb6cc861b00b 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1712,10 +1712,9 @@ static int cqspi_probe(struct platform_device *pdev)
 	int irq;
 
 	host = devm_spi_alloc_host(&pdev->dev, sizeof(*cqspi));
-	if (!host) {
-		dev_err(&pdev->dev, "devm_spi_alloc_host failed\n");
+	if (!host)
 		return -ENOMEM;
-	}
+
 	host->mode_bits = SPI_RX_QUAD | SPI_RX_DUAL;
 	host->mem_ops = &cqspi_mem_ops;
 	host->mem_caps = &cqspi_mem_caps;
-- 
2.43.0


