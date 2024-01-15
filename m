Return-Path: <linux-spi+bounces-464-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F200B82E19A
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7A32839A2
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB2519BCF;
	Mon, 15 Jan 2024 20:21:20 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBE419BB2
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSG-0004n3-Bv; Mon, 15 Jan 2024 21:21:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSF-0005go-Ry; Mon, 15 Jan 2024 21:21:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSF-000N81-2W;
	Mon, 15 Jan 2024 21:21:07 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH 15/33] net: vertexcom: mse102x: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:13:01 +0100
Message-ID:  <a7ca57cfa5b63e5c70824c24fb1bca1eba8cb087.1705348269.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=7C4zRbcOYQG4tJidTuFGLzIixkZC7rGzdeDNsmoDdKo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHR5w9UJMSGBhYFbfYejDSf18bb33uHXlgIB LC/Z6ua2HeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWR0QAKCRCPgPtYfRL+ TvWHB/9Lp5YsOXqNM7soeRudWBaNe+fVSAFSPxGs3A9faGAc3x4eepf5idQlgT/ac7fVsPk/UU1 ws355JuTiwxO0WbVM+AxsNei8WNvDfY4GwKEyj5Wq+IusEbEk1B6IIxjrES9k6Aguj2sbvgSpRS HLFWrI3GEEnlv3wt4E4wlKBYyMGIN48iPZLdFcdDLppObkboe/oVnFsLPHcFJw78E8EuxjFQHGp VrUiDRCWw/mLdvVCLdiXj7PqvtlYBwENh1Iwx1Wp5hxqw/F0I0QQhbzG2NtK++67KrNe+qHz2xf xeiuI2wVSA5rAnGS6zp66ntdkOeBifTB8vgarCJlWGDglzwY
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


