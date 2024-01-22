Return-Path: <linux-spi+bounces-583-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0728E83704B
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 19:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4BD1F2AAD3
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 18:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89B65676A;
	Mon, 22 Jan 2024 18:08:35 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3AE612CE
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946915; cv=none; b=gt2NcyDb/SWb227F4vnNLJYIWt8icawsumW5XHS/LjK2cyAqU7kgi9JoypiL7SWT439e5qRR0jxRDqaDxEWCMPWquEmevEfQU76lb7A/zOc6zQv6k01lpK/bFsl7+iBd1za8nfha96PpzdpmeHGKp6+6RRFzR7a9X99iNnjfVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946915; c=relaxed/simple;
	bh=iR4kxLxaE7Icwhg9XpP8gyJgiftiGtkYPg5z6rw0lWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGG0V5GQD6qfPp18taDJ/dQ9otO0bX4V23GKEVIV7niRJAG0DuveatjSjQiASlWEm/CSwXjD5mFfmpIghusnVLtya+A3q7K2s7jVtlF2h9dQXpXkb4F3acnpO7Y2W0pYLkxmjngflylwRQGpNSsCRbhz9uXfQUrMxrUo2ON6BVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiW-0001rw-8O; Mon, 22 Jan 2024 19:08:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiV-001eQ7-Rs; Mon, 22 Jan 2024 19:08:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiV-005Zxh-2U;
	Mon, 22 Jan 2024 19:08:15 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 15/33] net: vertexcom: mse102x: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:10 +0100
Message-ID:  <007fae0c67ce212a1d31082ad5762197c87bcd57.1705944943.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=iR4kxLxaE7Icwhg9XpP8gyJgiftiGtkYPg5z6rw0lWQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7UA6Lxfh6Mp7DFurx6GyME0hE2Jfo0sMA4A bE79fFN6giJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6u1AAKCRCPgPtYfRL+ Toj2CAC1hxmRZLmZ3JtzHqs9FTXz5bVe80g03g/ovNpfkfb8fWUlgGVKnD/CsjhCxmk+0x6P93R NoBZrY8tYpm30YBtTQlZd3KsuEl2Zh25mFZMBF+clxtH9XzQlxAGtBRzkM1tME1/olDYnibAiAW m4zBqQXqe8rBbzeMsEG02LKYCU1z5Zd7ycJd/5tGChyMkpD+H0SUpB0P+OnQXPATH+kO/+PSb5P OxFvUWgK2txCoZH2pxz2GdKTyTw6NIbwqF3vBNGPJiuK3iatRvJgKLO8s+EMLL/CZq1++cqWTnC cCdTIaJAKLsi7s+NKmdyoe+OcXtNiaxevHmveZclfKW4H3sU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. To not break all drivers
compatibility macros were provided.

To be able to remove these compatibility macros push the renaming into
this driver.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ethernet/vertexcom/mse102x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethernet/vertexcom/mse102x.c
index aeed2a093e34..edd8b59680e5 100644
--- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -664,7 +664,7 @@ static int mse102x_probe_spi(struct spi_device *spi)
 	spi->bits_per_word = 8;
 	spi->mode |= SPI_MODE_3;
 	/* enforce minimum speed to ensure device functionality */
-	spi->master->min_speed_hz = MIN_FREQ_HZ;
+	spi->controller->min_speed_hz = MIN_FREQ_HZ;
 
 	if (!spi->max_speed_hz)
 		spi->max_speed_hz = MAX_FREQ_HZ;
-- 
2.43.0


