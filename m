Return-Path: <linux-spi+bounces-564-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C85837020
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 19:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737091C292D4
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 18:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7505456756;
	Mon, 22 Jan 2024 18:08:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC155E5A
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946901; cv=none; b=r/06NMGucrmmEUW3xGDDMHUfozMYqFcVC/lI7GogFGaekmzCOXx6cwL+E1tF3875DMKI7t5ZF/SCMKG696wojaOLzmr27cvMvZLYP1zJjax9Hxp+rpvvnwLb1sB8CpkU2lawlHTrgW4XxTVgFw8eNjOykQEjZ8UE+J8ggCbOHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946901; c=relaxed/simple;
	bh=aQaJs5zOPqrNYXsF86uQSVSe/HBmYb++L9H1dH23v/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=El1kcKo/UbEnpEJziI+qrFCRmc1aUcUdfpHEp8xUJWjQoKW1BnATNxYQV1J7QICAe9iwgnsAUiJV5dSPUZr0w+OZvpzPJAYXFNJicuuVnAyI540yNIoyQHvwDtlrx4ycQmCZpB+jyn33Ad7kWSteVGDUe45E9DHEXkNjcxIAKZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiX-0001vA-Cm; Mon, 22 Jan 2024 19:08:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiW-001eQP-Kw; Mon, 22 Jan 2024 19:08:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiW-005Zy7-1r;
	Mon, 22 Jan 2024 19:08:16 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/33] spi: cadence-quadspi: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:14 +0100
Message-ID:  <25ed09fe942039ac3e00051c0576bfa7a588853c.1705944943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=aQaJs5zOPqrNYXsF86uQSVSe/HBmYb++L9H1dH23v/0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7ZdzpRpf6q8UTsNP3T0nfnHawuW0/OpFKXK QmRy5mu8EuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6u2QAKCRCPgPtYfRL+ TmC4B/9sM3Ya60LQkzAlTriXzYLOLMAXgr6PZCcnH3ze9dIP+WcCYjNubsH/Y8wPXICzIfFwSzI Nfchiymlu5dVpX2P7oEGh6WZRujWLpXfEWKt0/DiiuehEb90EkSBNrRZdz2h3l3mI3xXsoo4dqd 0V2T1uyRUYyY789ao1Z888UkZZFlXIFt1/YVnVX0IaiLW1yChw7SaCecKjp1OWlhfO0nY+kfxb6 9Y3Hav2YDuOk3azp13zEC8dfQnswyrm6rOC24etkRGeo8BHH+Wvk5D1XvpsIBmuXjBwLlOwr55l +ZtxRuRSOsiUT/OLreDKgeMm6iBmID5yHdV1X7qIFaHHz6Ly
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


