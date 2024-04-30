Return-Path: <linux-spi+bounces-2664-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FBA8B74B2
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 13:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4621F22353
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 11:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F0D142E63;
	Tue, 30 Apr 2024 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="agg2mMQU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA2D13F440
	for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477318; cv=none; b=o42QJ8b78Kqqyr3X2EBNRJdRp6BCeKmH0FRn2UHFXvZLwzQTjU5vEvNIkXtnyNXQYyQCtgmLrKHUUnuATB87d8g1h7GFHVPSCmmiqzWdBGbOC4Hac3MPX/QpMwz6qO2P98B+2MVIPddzjYPOWOmpldNrdAnvLTZ+at7uAM5Y8JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477318; c=relaxed/simple;
	bh=hcbx56Y5k3mfmOycKnABdCI4HKZUNrDJD2fERcGh1U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppIDtgoj+b7SjhJ69GjJ7JcyTHHNfttpnTVG935yCSXvQywlFxSdsJl6XlFNlq8R9bAMdeauTd6Qif+aIbQgkRWcFSDF0bbAMZZMkvrS7tn/z+OlzEL+d6Kur/OzkQHqvyYH96Fh82LP8qD1IYxFK2dnxeBlXUvwyg8gykB2BrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=agg2mMQU; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=LfhC74UTazCJF1AHQxec+FPBKj436LgBlykgn19Hkp8=; b=agg2mM
	QUq/qw/CPUMg3MUlGvabUhtC3Av3vJWr05yK4cm/qZbclwHuATMGEV444n04qDeM
	htXBcmEfA0ayOffXkVHPpBPKqP6O0aEL8e34tJ+EXgYgWmUbF7D0J+hpDA1FN5PW
	1XUO22VdoP7TI+cG/fJGnIV0WQz5McR7UCUL4BL+KebYBpmcfzcDqs+UW1FqbiNC
	Xocud5Lobpl4xnSyIHwgGqodQo5T4ctEUpIdFVC7RDF1/pxDO/Q+ZW22o2tX+981
	UURil3X0J5nEZRrmiLdBKEtjaSid9F6yh8EvVNU1GdUwUxhXnJBITijIKtG33Gt3
	opmfO5UsXuEV2nEg==
Received: (qmail 2617931 invoked from network); 30 Apr 2024 13:41:49 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Apr 2024 13:41:49 +0200
X-UD-Smtp-Session: l3s3148p1@WnT/2k4X4Ohehhrb
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] spi: sun6i: use 'time_left' variable with wait_for_completion_timeout()
Date: Tue, 30 Apr 2024 13:41:39 +0200
Message-ID: <20240430114142.28551-8-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430114142.28551-1-wsa+renesas@sang-engineering.com>
References: <20240430114142.28551-1-wsa+renesas@sang-engineering.com>
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
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/spi/spi-sun6i.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index cd018ea1abf1..5c26bf056293 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -277,7 +277,8 @@ static int sun6i_spi_transfer_one(struct spi_controller *host,
 				  struct spi_transfer *tfr)
 {
 	struct sun6i_spi *sspi = spi_controller_get_devdata(host);
-	unsigned int div, div_cdr1, div_cdr2, timeout;
+	unsigned int div, div_cdr1, div_cdr2;
+	unsigned long time_left;
 	unsigned int start, end, tx_time;
 	unsigned int trig_level;
 	unsigned int tx_len = 0, rx_len = 0, nbits = 0;
@@ -488,26 +489,26 @@ static int sun6i_spi_transfer_one(struct spi_controller *host,
 
 	tx_time = spi_controller_xfer_timeout(host, tfr);
 	start = jiffies;
-	timeout = wait_for_completion_timeout(&sspi->done,
-					      msecs_to_jiffies(tx_time));
+	time_left = wait_for_completion_timeout(&sspi->done,
+						msecs_to_jiffies(tx_time));
 
 	if (!use_dma) {
 		sun6i_spi_drain_fifo(sspi);
 	} else {
-		if (timeout && rx_len) {
+		if (time_left && rx_len) {
 			/*
 			 * Even though RX on the peripheral side has finished
 			 * RX DMA might still be in flight
 			 */
-			timeout = wait_for_completion_timeout(&sspi->dma_rx_done,
-							      timeout);
-			if (!timeout)
+			time_left = wait_for_completion_timeout(&sspi->dma_rx_done,
+								time_left);
+			if (!time_left)
 				dev_warn(&host->dev, "RX DMA timeout\n");
 		}
 	}
 
 	end = jiffies;
-	if (!timeout) {
+	if (!time_left) {
 		dev_warn(&host->dev,
 			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
 			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
-- 
2.43.0


