Return-Path: <linux-spi+bounces-586-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295A4837074
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 19:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4FF288A01
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 18:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFFF633F1;
	Mon, 22 Jan 2024 18:08:37 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB09D629E4
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946917; cv=none; b=hAAmmJNZwgDP9MvreFsBhjBGYASAfLzrRNLJ7LxY1TzSzps+uBNWuS02r3JhYedI04IHmjg0Ae4os/nIEQUfzal+j/1I8H/AIQCFGJ6IUadDyhdUFVIWHX3YUr12xDZTDG2z+Eb4nEZD44wPRZVj/b2+fOwuCfhx5wXLP2OMDwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946917; c=relaxed/simple;
	bh=NBOC25sdOvGb/9mPNsZnEncAlQwVHEMnCLFxkavQ8DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdZ35U786u33RdOEwuIjMkr76KNROD2OfdD38TSJvBpYtMEzhmA/RT503oA1le4w2UE6B/5xBX/6Ll38gHY2qHqea7rydGL/SoQxXyCDt/YkHuA/rbhDG8KPW1iVRi7e+r1Wh9oe8C7kByK8lFLdwJvJHurFPPz1Rpc5WwkFiTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiW-0001qd-F5; Mon, 22 Jan 2024 19:08:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiV-001ePv-6S; Mon, 22 Jan 2024 19:08:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiV-005ZxV-0L;
	Mon, 22 Jan 2024 19:08:15 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Amit Kumar Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 12/33] mtd: dataflash: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:07 +0100
Message-ID:  <63d7d1f1e6fe564daf034c66eb3073aa265b7969.1705944943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=NBOC25sdOvGb/9mPNsZnEncAlQwVHEMnCLFxkavQ8DQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7QEfATD5xG2hpQG6DlgMRzWaTKGPWZHTQ2z pPbTlCX0dqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6u0AAKCRCPgPtYfRL+ TilmCACJ2388gx/UewF/Ask4RyYTH4immf27buUsBhyAWpQD91hjhGO1pzM01We+2TVb2u8Jy6A FoGHOBwlRZf2Tx2aB4t7W5q1xTEPbyWoQ9bnQwfwgfXolDRDIV5GwM3ZqCz+h+eimI5QSMe767M kdX2SuNYwXeUFWMjjRVDqQ0aoRmsC6SNFSH3uxOrbKpwEwyJcGPbF517SxNU0OkcCAbrX9fzofM HT+90MYf3Hl3BvpMsEbIEScn1PJyzXQuftXRqV2CNqd+LfG5G2bIR1ywtj+s85K3Ub620706Qm4 ApiO+eZUFjSc5n57Dns7TZNVuXXKmFjwxbfOI1fcTbszlBMJ
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
 drivers/mtd/devices/mtd_dataflash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 0c1b93303618..ec52277e3dd5 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -638,7 +638,7 @@ static int add_dataflash_otp(struct spi_device *spi, char *name, int nr_pages,
 
 	/* name must be usable with cmdlinepart */
 	sprintf(priv->name, "spi%d.%d-%s",
-			spi->master->bus_num, spi_get_chipselect(spi, 0),
+			spi->controller->bus_num, spi_get_chipselect(spi, 0),
 			name);
 
 	device = &priv->mtd;
-- 
2.43.0


