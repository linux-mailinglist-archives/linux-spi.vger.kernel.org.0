Return-Path: <linux-spi+bounces-2782-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCAF8BF9E4
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 11:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB41C287F76
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85B87E11E;
	Wed,  8 May 2024 09:56:28 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD97E0F2
	for <linux-spi@vger.kernel.org>; Wed,  8 May 2024 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162188; cv=none; b=CKo16c8WnN1hMYp1PJ/TzcJfYKQZiU++Ug1/8Nn3xSw7Vu9dfY2LEa9eFsQ0xmaHdT39MZyo2QCDxMWA+KGuGz/kIReq+lmEuRF1MGJ2cXzAIJduX121M8rjHTUQI0sFyDTBmrqC0nt2Tb7hsb0DbGhf8BUeO8jZMgWwxo2A8is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162188; c=relaxed/simple;
	bh=4POJOZrPUHJ4nLXafYkKHc0N6Q4o99ssDV15veYIDv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m+I1FziuEWhmLcAafMAtAhWZV/4dFF/JFGiyDAs2nl206UgyyYGwFiGwrtERKWnA+CyVDO9yt5VfhyL3RB0k697dHoXAOOuS5Yq6IZpu+yUIY/JN4haX7whZ9p4j3qK8i1HM/aCVSDAIhZvDMpd4nvNR2ExH+WvIdEifUCp1pRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4e26-0003tz-2c; Wed, 08 May 2024 11:56:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4e22-000FZO-TL; Wed, 08 May 2024 11:56:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4e22-000P2m-2c;
	Wed, 08 May 2024 11:56:14 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Martin Kaiser <martin@kaiser.cx>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices
Date: Wed,  8 May 2024 11:56:10 +0200
Message-ID: <20240508095610.2146640-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=4POJOZrPUHJ4nLXafYkKHc0N6Q4o99ssDV15veYIDv4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmO0w7jfwBMKYN5LrwTb8WMy4uLu8hgzfnw4SlG sO0fmfSZeGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZjtMOwAKCRCPgPtYfRL+ TvqyB/oDstQEmdCXLVt/2A8ZzX9lJ4egjjfpipCboZqbVLrRSWx4y+ScewExE4oLHfYFbt8eMlG 828IAsPzjeM34V+YeBnNLAPMWR9DK/6/hj929Nqv6wMxp9TMarj8eqSzkAtwRAv9wa7cyA3JLIH FlLW1Swe0Zk5wda+KtsZQOhokZZHMbNbPWkhnueTbMaAyDiyTbyhcYKl+f2pV0DAYGrSjhmne1Q 9eB5AbSJ7jmeQycnEDewkJE+nKaRLJa09tX+SRFYlUUUOGk9kxsQmsVmA7BqV1Z83J0/XGJLahG CmDGwfaGnrxafovALzJezUnG7tdPQrVlOWLcsvG7TM7PAw8W
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

While in commit 2dd33f9cec90 ("spi: imx: support DMA for imx35") it was
claimed that DMA works on i.MX25, i.MX31 and i.MX35 the respective
device trees don't add DMA channels. The Reference manuals of i.MX31 and
i.MX25 also don't mention the CSPI core being DMA capable. (I didn't
check the others.)

Since commit e267a5b3ec59 ("spi: spi-imx: Use dev_err_probe for failed
DMA channel requests") this results in an error message

	spi_imx 43fa4000.spi: error -ENODEV: can't get the TX DMA channel!

during boot. However that isn't fatal and the driver gets loaded just
fine, just without using DMA.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index f4006c82f867..4de5476f79b8 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1060,7 +1060,7 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 	.rx_available = mx31_rx_available,
 	.reset = mx31_reset,
 	.fifo_size = 8,
-	.has_dmamode = true,
+	.has_dmamode = false,
 	.dynamic_burst = false,
 	.has_targetmode = false,
 	.devtype = IMX35_CSPI,

base-commit: e7b4ef8fffaca247809337bb78daceb406659f2d
-- 
2.43.0


