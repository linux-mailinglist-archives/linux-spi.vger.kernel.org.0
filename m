Return-Path: <linux-spi+bounces-1176-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9A384D16F
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 19:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF507B22184
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 18:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E1485278;
	Wed,  7 Feb 2024 18:43:18 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B0683CCB
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331398; cv=none; b=lnIG38XlBpxfvxaH1i9T7QC0wKxgS8DXEobMj80p1RCGZC39KGu1dnuNagPeecG0u3AdHTTOihESAUEgXk1UmVqWKY97OlSlOGnp7dbNa8bjVci2RvCdRLL4NuX+xfXjWrwlCTzfcCCAC0PyAYEHiIs69G/muIv/R3TSD+hgoyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331398; c=relaxed/simple;
	bh=RbOvDVmurbfANfv8VPt3j5rWCMBhT6rMxR0v2GBXhN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A81GPnNqWHJ+B/Wj63FtM/CzqMDOFTFKfsyIsuokbzspmWxMYS7SeTSqRH4KodNPHduAqxhOlzuMPRuL/sJ2KqO2Q8Zg85bP4xKYfBhxv7AN9FjKCj2+1zaEyQ0MW09AebMAwvb+744djhG1vhjC6fJpp2yxOtOZtoFoDYJC03w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt9-0007mI-Eo; Wed, 07 Feb 2024 19:43:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt9-0054Xx-2G; Wed, 07 Feb 2024 19:43:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt8-00HRsw-3B;
	Wed, 07 Feb 2024 19:43:14 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 18/32] spi: cadence-quadspi: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:32 +0100
Message-ID:  <d741960846b7f4896eeff91a4c8c7dfa8a6f8b7b.1707324794.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=RbOvDVmurbfANfv8VPt3j5rWCMBhT6rMxR0v2GBXhN4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86qP+LJktb5dkl7rbmpmK/xxovvRS6CdS4pc qKGLZfaToCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOqgAKCRCPgPtYfRL+ TgPICACEOB9h8aDM2Y6v2EVwZJouk5eaWTzwY3r62EzHehblZh3eWE8hbMVE4ggfzLMWsCh8nZ4 hwrXvjFYzSrS9knpA0IlE5CjRWPIpggKClkKWH69BllfWdHFRsRKDQ80Ng4IFpsos4ye19+/49T wplWugZUQYfyiJdoOtiMMJZqTN2gURsUli8soUDoIZWpd536oujqrhOgtFISveiWNBXmohzD9qO 71OInPWc7QkUWGXT5d16jndIpWhVJA9WarVwNnj2bpOq2jhVZdMPLly3VIKRMmMOPqS1romHIFC E5+IWGxVDmaV6MPQ7jQn2fQ/QW81p2X0F61RL9rLCGRa1uyN
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

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index eb6cc861b00b..a5e2f7786b76 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1410,7 +1410,7 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	int ret;
-	struct cqspi_st *cqspi = spi_master_get_devdata(mem->spi->master);
+	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct device *dev = &cqspi->pdev->dev;
 
 	ret = pm_runtime_resume_and_get(dev);
-- 
2.43.0


