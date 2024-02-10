Return-Path: <linux-spi+bounces-1260-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862B8850555
	for <lists+linux-spi@lfdr.de>; Sat, 10 Feb 2024 17:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D1D1F25533
	for <lists+linux-spi@lfdr.de>; Sat, 10 Feb 2024 16:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BF15C8F2;
	Sat, 10 Feb 2024 16:40:50 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6A5C8ED
	for <linux-spi@vger.kernel.org>; Sat, 10 Feb 2024 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583249; cv=none; b=lbNc/iiejETCGg3lD4xUZuRx0FFms8eHpsqGXRcNqPinqSahXOXCJkoElCCCynyxPIt/ty5VPxw9u8TGdked5UNUFP6ixfkfZKD+bcLIk5melOB69MZ1z6Dyizz2JONmbrlGsw1iog/yoWSmHdFLAAqo9kQ/pA7/AORZpFzClos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583249; c=relaxed/simple;
	bh=10BznG4/Q7I4p/NCADVIk4BSO8uNoZg982rmmdanDP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZ4JNLjP8btigwj/JxIIeCzyH/sqCuSbYv7mxVAvU3ajYQd8xykWTV6ApgoDD6V78sKM+Whg6XdnTnnEm0Fr7SuvLg7fdnTYe2ey0a2v3wg9qYdYzGPZ1pE6jGllfzAvqTfJtc6VLXPpCu3LezTSkHBnfMVnEbdVOedtM2V/8P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYqOs-0001IB-Pk; Sat, 10 Feb 2024 17:40:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYqOr-005i4D-24; Sat, 10 Feb 2024 17:40:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYqOq-002ERK-39;
	Sat, 10 Feb 2024 17:40:20 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Rob Herring <robh@kernel.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] spi: ppc4xx: Drop write-only variable
Date: Sat, 10 Feb 2024 17:40:08 +0100
Message-ID: <20240210164006.208149-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210164006.208149-5-u.kleine-koenig@pengutronix.de>
References: <20240210164006.208149-5-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=10BznG4/Q7I4p/NCADVIk4BSO8uNoZg982rmmdanDP0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlx6bqu4OIok6KAOl5u5CmjU5gQ1LXdKCj/lzYj wmW21P1rXyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcem6gAKCRCPgPtYfRL+ TiX/B/0cEuFK96ul4c/xZ283WZaBg1+kQ8qA0NWUk4lAxw8d7kjNPCAPuFc2sjFLD9zCleMGM/n /hhyCohFXxk4PAXOjzGKr+6x1odZwO3MbpAOrbFeKgx8F/WrVqyYiNMOwvtSmdkpZm96prEfnKi fhymfBMG1uicbzKhb6HVDfopsENqmDPsyotwUZoAulJAc9KyrQUGL/eYyxzWymRSC+pqhnZvzU0 b1eP0z8Kj+yw6t2kY5Tp5HkNnN0iOpKD0Xf1usiJyWnzr6Qw0meRbf82NNoxrOXm7hc0aj9VGI6 qVJ72xnijJQTyl8c5n0MJcUDDla22i2eXV3LjVcdoQApBZ9L
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Since commit 24778be20f87 ("spi: convert drivers to use
bits_per_word_mask") the bits_per_word variable is only written to. The
check that was there before isn't needed any more as the spi core
ensures that only 8 bit transfers are used, so the variable can go away
together with all assignments to it.

Fixes: 24778be20f87 ("spi: convert drivers to use bits_per_word_mask")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-ppc4xx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 2d5536efa9f8..942c3117ab3a 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -168,10 +168,8 @@ static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	int scr;
 	u8 cdm = 0;
 	u32 speed;
-	u8 bits_per_word;
 
 	/* Start with the generic configuration for this device. */
-	bits_per_word = spi->bits_per_word;
 	speed = spi->max_speed_hz;
 
 	/*
@@ -179,9 +177,6 @@ static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	 * the transfer to overwrite the generic configuration with zeros.
 	 */
 	if (t) {
-		if (t->bits_per_word)
-			bits_per_word = t->bits_per_word;
-
 		if (t->speed_hz)
 			speed = min(t->speed_hz, spi->max_speed_hz);
 	}
-- 
2.43.0


