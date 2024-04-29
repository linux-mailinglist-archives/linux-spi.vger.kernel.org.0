Return-Path: <linux-spi+bounces-2587-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B55288B569B
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 13:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522D01F23864
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 11:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BDC4F1E0;
	Mon, 29 Apr 2024 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VSWpY1uW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131AA481A8
	for <linux-spi@vger.kernel.org>; Mon, 29 Apr 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390137; cv=none; b=fHs5ZskRavs12j5M00Sadc9DgPKoR34aAFy7DY/HZhgC7WMJg4XcziWEo5RrCjWXVHLW0XORXoRwLAhoeQVhdd+VW5nTqH7iCtlAs0GfsthCuXsSLyt/QvgDW/AzNtdfWuMoarvAlSy250l1JBcJWw9OfzWM1s3R4Uk//URQr9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390137; c=relaxed/simple;
	bh=6lX6Ow8+WDkXB8QGR8oS5cwaB8Odx+W5VMP6TmmTnWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTlZvT2/gvvvW1Cw1MwR/SgyjP8Ss9S0ZYz3OC+rwn7vaNIXTCeJepPGaaJeQt5eNOOQxRgchtC9SvBYOxBzR7phcjR0nD5TuSxsAbBVYS1t/PuJxmDaR048rOCsaI36s4HVafpjd6IlRkExawGrdJjLZ3hJ6GbtD9KqrPUq3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VSWpY1uW; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=yUtX8ec+dY41NIYbceVd82J6yRSNmS1VfJIrMLj50Sk=; b=VSWpY1
	uW5yn24Q352EjNSnroFqqmtWFagaHZseeL4FE7mlmLJWqgarDimkWGdi/DG+41sD
	f67zb7fQm5FjRa2FAMVDC9859kiLObZ/F+F1a7BHiwbxs3KGSGRBlwjCzKP7DuBv
	OEPNe8YsRMV6l4pvCz4jZ1nvqifCNT1yScaGEtFsuaUm78WtlD3QcBGj5UAFtSAt
	8RAKCy84gwtGEshdMwfIRSqNSF+3yIRcMRjt568enM8plDTpwvjzt4oiy7G9c+LI
	DtAlM1ymqlqz6iULtiTL7LP3jaFCirqdYlEwP40KH9iSjvNCmUvwhNvILItGBzMC
	fNRIkAPBMEn2QjQw==
Received: (qmail 2279629 invoked from network); 29 Apr 2024 13:28:48 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:28:48 +0200
X-UD-Smtp-Session: l3s3148p1@IK2VjjoXK1dtKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] spi: pic32-sqi: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon, 29 Apr 2024 13:28:37 +0200
Message-ID: <20240429112843.67628-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
References: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/spi/spi-pic32-sqi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 3f1e5b27776b..0031063a7e25 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -344,7 +344,7 @@ static int pic32_sqi_one_message(struct spi_controller *host,
 	struct spi_transfer *xfer;
 	struct pic32_sqi *sqi;
 	int ret = 0, mode;
-	unsigned long timeout;
+	unsigned long time_left;
 	u32 val;
 
 	sqi = spi_controller_get_devdata(host);
@@ -410,8 +410,8 @@ static int pic32_sqi_one_message(struct spi_controller *host,
 	writel(val, sqi->regs + PESQI_BD_CTRL_REG);
 
 	/* wait for xfer completion */
-	timeout = wait_for_completion_timeout(&sqi->xfer_done, 5 * HZ);
-	if (timeout == 0) {
+	time_left = wait_for_completion_timeout(&sqi->xfer_done, 5 * HZ);
+	if (time_left == 0) {
 		dev_err(&sqi->host->dev, "wait timedout/interrupted\n");
 		ret = -ETIMEDOUT;
 		msg->status = ret;
-- 
2.43.0


