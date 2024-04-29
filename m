Return-Path: <linux-spi+bounces-2585-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1738B5697
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 13:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948E01F23684
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 11:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D074AEE4;
	Mon, 29 Apr 2024 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Cm8xoqhr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15E44C87
	for <linux-spi@vger.kernel.org>; Mon, 29 Apr 2024 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390136; cv=none; b=OA+3o3yq+HYQx+HI/L9ZgMEBnk6Fzr4P3tWtEOjl9qmDArAkWQhAo48BRow+P9y2vlh4EDv/xFXyoH8p6VlsbL3hg+TCPRdwB3xfXbqOzSPGpoSZpdIpxqS0NjQEocsFCJU2+5AAO776U7DqPWPrH/BlnUvxD1zBbd/9zFfXPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390136; c=relaxed/simple;
	bh=ZZCt1Knc3LTkd7ud87jJX+jMQvb71Ot0fnQdxWqqxKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjqBXycN3EPUFQEA5ioMhjbfwxnBuGfk7cdorzHEL6TnEY6pwLY9yQDHOR0xwVN+GST7YuIawe3QTaqOgZLEoOkVtNy+/q9SojwKrDqpmqQCLMRy7syqFKdSGsgE8Tcf7vEKrJfPmRZEveXolpuXZsMvknrfeZvsYxVnzCRYG40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Cm8xoqhr; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=wiD2un7//igTyi+4riuvfy4dW9R7R9MwCjnV7qyUbeI=; b=Cm8xoq
	hriBqVte2y8G0rg6Ug/N85sy0zOjE4Pb94WiwqEMXBNXLY/QtC8ZBzikKXpsoguB
	ods8iB4Jh6r9tVbUj5YvjX8JMM0N67DeSsCEehhY4B1MxBGIyCboae8nTg2hF+Qi
	pMHp2ckB+R3ojPnLsRq9ZlgeG5GVqYWw1KMGBKV+4i1iob1sPvKGX59JCOUzJvG2
	xJ/stN+qddmEn7uNVWSV8L7qd7Rvxso22iPMJHit69WC05A79L8GfXKRdBgb7T6E
	YFXFZqUfeVDqtl4HADwv/gl4UitT5BpdwuUdTUczqjGok/pKKxQzBNzVd97Ulj5U
	s6ejYtEXGAQX88yw==
Received: (qmail 2279659 invoked from network); 29 Apr 2024 13:28:49 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:28:49 +0200
X-UD-Smtp-Session: l3s3148p1@pOukjjoXlx9tKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] spi: pic32: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon, 29 Apr 2024 13:28:38 +0200
Message-ID: <20240429112843.67628-6-wsa+renesas@sang-engineering.com>
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
 drivers/spi/spi-pic32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 709edb70ad7d..b8bcc220e96d 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -498,7 +498,7 @@ static int pic32_spi_one_transfer(struct spi_controller *host,
 {
 	struct pic32_spi *pic32s;
 	bool dma_issued = false;
-	unsigned long timeout;
+	unsigned long time_left;
 	int ret;
 
 	pic32s = spi_controller_get_devdata(host);
@@ -545,8 +545,8 @@ static int pic32_spi_one_transfer(struct spi_controller *host,
 	}
 
 	/* wait for completion */
-	timeout = wait_for_completion_timeout(&pic32s->xfer_done, 2 * HZ);
-	if (timeout == 0) {
+	time_left = wait_for_completion_timeout(&pic32s->xfer_done, 2 * HZ);
+	if (time_left == 0) {
 		dev_err(&spi->dev, "wait error/timedout\n");
 		if (dma_issued) {
 			dmaengine_terminate_all(host->dma_rx);
-- 
2.43.0


