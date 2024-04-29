Return-Path: <linux-spi+bounces-2584-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7C78B5695
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 13:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4AC1C230C2
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 11:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8EE47A64;
	Mon, 29 Apr 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="QiqdOS15"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B158341206
	for <linux-spi@vger.kernel.org>; Mon, 29 Apr 2024 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390135; cv=none; b=Kol6G2cFtaj64aA41eoU9x77jGzK9PlwVfK5sFu4OYw3DNbI5E5tMFwZbBHXCrDL3ROEw/BurVtDZLQteJBt8pRFe/WVwAjBP+0UPKuBsFp33vSevcrVEJcrd/+ZGwClXxbcIOMHz3wtasUOPo2oH4Ki6qvbz5Q5IvbevbiZvQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390135; c=relaxed/simple;
	bh=/+yQD/1xxpt49MoQExQ1xzYhBFcnigvlM4u45hspn/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzQy8PXL8NCLt8NHPatFR2CxJCBBSKmWd10SgI3rRxf1N1wP7CYEmZHUZQcrF7e4EYB41Y+BxF504K+OTVRySZuZKWNBJqHlDJdGbj5RMwy5aSAO0H17rcpDPAG0u03c5RD1bcRzrxZsgE7Zdo1+iM+VzTyC5IFI8GIgpzej7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=QiqdOS15; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=Tc5X/Zoe6TzZ7ehoGlEwf656j+yN61PTSQN5v3elxi4=; b=QiqdOS
	15/fKw2XKRiniG5gIdbcmDHbOpdjQWh7I8lyPv+YW4noWzynWoqS4K0+k/V7+Hbu
	xneolw1qFeu5yCzEFflcNHqp64h32A+twQhMzlEBDpmq8P/oO7XLq0H9ZYy124at
	iVCwNzV6cMjwXyUVLSINLpx6ay/79ouKo56lbcS4eB8DPEgIqX2EaQ+0rHdhhum1
	2/NMEhn/exNkM7LTfAEI8Cx+fIwNLZ9YKLBlPOq64Wte+1DrSTeAcy4UQ9yHr7M0
	uXiuT0dcPknJZxj0spnOiQyKs2LNOV+snuhUpEn/99ZthP+/K8OXxfsRSnaHLYe5
	ylbECwhGfAQoa4nw==
Received: (qmail 2279524 invoked from network); 29 Apr 2024 13:28:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:28:45 +0200
X-UD-Smtp-Session: l3s3148p1@3bxgjjoXflVtKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] spi: armada-3700: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon, 29 Apr 2024 13:28:34 +0200
Message-ID: <20240429112843.67628-2-wsa+renesas@sang-engineering.com>
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

Fix to the proper variable type 'unsigned long' while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/spi/spi-armada-3700.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 3c9ed412932f..02c1e625742d 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -339,7 +339,7 @@ static irqreturn_t a3700_spi_interrupt(int irq, void *dev_id)
 static bool a3700_spi_wait_completion(struct spi_device *spi)
 {
 	struct a3700_spi *a3700_spi;
-	unsigned int timeout;
+	unsigned long time_left;
 	unsigned int ctrl_reg;
 	unsigned long timeout_jiffies;
 
@@ -361,12 +361,12 @@ static bool a3700_spi_wait_completion(struct spi_device *spi)
 		     a3700_spi->wait_mask);
 
 	timeout_jiffies = msecs_to_jiffies(A3700_SPI_TIMEOUT);
-	timeout = wait_for_completion_timeout(&a3700_spi->done,
-					      timeout_jiffies);
+	time_left = wait_for_completion_timeout(&a3700_spi->done,
+						timeout_jiffies);
 
 	a3700_spi->wait_mask = 0;
 
-	if (timeout)
+	if (time_left)
 		return true;
 
 	/* there might be the case that right after we checked the
-- 
2.43.0


