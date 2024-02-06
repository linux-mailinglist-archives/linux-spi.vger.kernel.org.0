Return-Path: <linux-spi+bounces-1108-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D5884BE70
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 21:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1961C22A2E
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 20:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F714AA9;
	Tue,  6 Feb 2024 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ebFeEHn6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76CD17984
	for <linux-spi@vger.kernel.org>; Tue,  6 Feb 2024 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707250034; cv=none; b=Eee93ZWh9PMMgsogydIimOEar2XQappKxiuiKFW8eRLyv16deZXVeV7tm++sABRgDGxzuOsRtOxdg7ERobH37DVN1wSKiqY5wv2JUSxKIyV+CnavmF5H0LfMSNLQtguBhK6EfEmdZfE/XvAL45uAVT0YO/3c7vJEOeEtYNQN7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707250034; c=relaxed/simple;
	bh=jUJ5txeuTrJIO3eaW1kqxV28UKwZzqPZVONJzpB8gbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RGVIaxRVQpoCUGFd/k/VcsbvmxKytEj7yGS/t7m+0wi1dh/yIMhKXj8Dm5ZJs4+DF59ssUCvFUVsAV0UWJXEYgej6nzkIG78h19BP0V4u1TQcAWAPFXsi0S5XvpXV3Lm439kdg9Jk0T8sRSAmS9QXRmI4Ps4/XI3X6DoOt60Nq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ebFeEHn6; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bda4bd14e2so5254016b6e.2
        for <linux-spi@vger.kernel.org>; Tue, 06 Feb 2024 12:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707250031; x=1707854831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UeBXYxW5TvJCXcyEazsNfsDYcAc2yu/IZuUSf2VlU18=;
        b=ebFeEHn6KS9npxDv/6LNKnwYM+HgfmYMPVDK1eI3IPNBJcmtw1k2uqt+AeMikdL1MW
         bhL6yW7Lqxdvq1AZHq/8foRnCt/plVAkJQMpJH2k1lp9I2kf5BgCvTk2U1i+K72Fz3p3
         X5Xc14ZtsGLtUJEw/T3xi47ldVoYIGE2srj8DPy/QxTZ3ScHaf79jaAXhnXRQUbblnnx
         vmnJbyqHfXtqEgi7hV8Gq/ks/6UmOXReZbeN0+ZWPMpsDOgdLoX9Od7fWfl3fXzYSnbE
         OIHJeF3Bu8PJXqOj1c4ww9bh3tIpcH54UX3qqiTgQOli+IMCJyJ6O2n/lrJi6JMkSPXw
         yH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707250031; x=1707854831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeBXYxW5TvJCXcyEazsNfsDYcAc2yu/IZuUSf2VlU18=;
        b=mQrPR+HTjPdvW/6yCH75s+yz93gQa5ZWEYFgXJlH7CJnx8lrhcN9tN/Aprt8PIjQNL
         928icfCOD8B1DerU7JPrVCg91VTQBIhcpk2crz56vCU4cqM2OZQlZqIsFNBbiv3pFVbK
         8GW21kNoXYbGhIaLWw/HUlPKbmD7SOeKQje2FOYHeoSlW8QJ6Tg1M5wpfF2D/i1JFpS+
         VirCerFOoJIlE9NAjV2S5zY4qPgdkOuUB7XRW964T1hGjmT39sEZeH5TtOgvpp5C8HOm
         OMjYrgfbhrVnGuEdzp5wKQ8P4OXxsy7TL6GL1cltZYZhm9M8YFivv3Q0fC9DtchdUttD
         QPdA==
X-Gm-Message-State: AOJu0YzMk1P/lF+KnaVhxQohIdG4gghlNW7/5Vq0m2CI9WGTC+NZDiVT
	3aYVxg0HLna5rZ3wD0cSk9fZAMbXlq7oGjOjO0o9Z6qZHCNInZzmM4+/zv9/SEVNyXqxnFqYv+e
	m
X-Google-Smtp-Source: AGHT+IFuObE8RLCSG43YjDz974IG8KvcqthwJ6ZAtRS/7qVGeo9TWZtH9h3WHQTkX8/5LS2tCw/m3g==
X-Received: by 2002:a05:6808:120a:b0:3bf:d0ee:9873 with SMTP id a10-20020a056808120a00b003bfd0ee9873mr4046929oil.3.1707250030989;
        Tue, 06 Feb 2024 12:07:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUgm87u0rmtYgY+Ov2zo4VlVzmeu0wG5JizNIBPlgh5Bf7BAFdYDvI+RFde/tAq5xWofsF7uOew748xJKgCzQyl+bTcdTLnB7e0eAE6hYKfADHxi57ahCz9mwH/AA26br44wDxgQc5mi8xtPgrNBzf6kFbXrxD+YGw/KvreBaU+fMAeJ+6jpNTBY+Fem+CJiXj+LBqUxrfG6D7nLzodMiwLeaTGbf/i5DGTth1jDk+hpnrdNAShFleA7sf7dbxRq2O/Av1qxzrBPubouWZ9KLojd7++ld+j7gyBE6azUh1Ga7e+83X0TVb6TBBc5IAWmznP0br1WFGiNphDaX27chNx4FCo
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id cg6-20020a056808328600b003beb12430basm421579oib.26.2024.02.06.12.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 12:07:10 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-spi@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: drop gpf arg from __spi_split_transfer_maxsize()
Date: Tue,  6 Feb 2024 14:06:46 -0600
Message-ID: <20240206200648.1782234-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __spi_split_transfer_maxsize() function has a gpf argument to allow
callers to specify the type of memory allocation that needs to be used.
However, this function only allocates struct spi_transfer and is not
intended to be used from atomic contexts so this type should always be
GFP_KERNEL, so we can just drop the argument.

Some callers of these functions also passed GFP_DMA, but since only
struct spi_transfer is allocated and not any tx/rx buffers, this is
not actually necessary and is removed in this commit.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-stm32.c |  4 +---
 drivers/spi/spi.c       | 22 ++++++++--------------
 include/linux/spi/spi.h |  6 ++----
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index e61302ef3c21..c32e57bb38bd 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1170,9 +1170,7 @@ static int stm32_spi_prepare_msg(struct spi_controller *ctrl,
 	if (spi->cfg->set_number_of_data) {
 		int ret;
 
-		ret = spi_split_transfers_maxwords(ctrl, msg,
-						   spi->t_size_max,
-						   GFP_KERNEL | GFP_DMA);
+		ret = spi_split_transfers_maxwords(ctrl, msg, spi->t_size_max);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a8b8474abc74..99ffc179f77d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1756,7 +1756,7 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
 	 */
 	if ((msg->spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
 					       spi_is_csgpiod(msg->spi))) {
-		ret = spi_split_transfers_maxwords(ctlr, msg, 1, GFP_KERNEL);
+		ret = spi_split_transfers_maxwords(ctlr, msg, 1);
 		if (ret) {
 			msg->status = ret;
 			spi_finalize_current_message(ctlr);
@@ -1771,8 +1771,7 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
 		}
 	} else {
 		ret = spi_split_transfers_maxsize(ctlr, msg,
-						  spi_max_transfer_size(msg->spi),
-						  GFP_KERNEL | GFP_DMA);
+						  spi_max_transfer_size(msg->spi));
 		if (ret) {
 			msg->status = ret;
 			spi_finalize_current_message(ctlr);
@@ -3711,8 +3710,7 @@ static struct spi_replaced_transfers *spi_replace_transfers(
 static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 					struct spi_message *msg,
 					struct spi_transfer **xferp,
-					size_t maxsize,
-					gfp_t gfp)
+					size_t maxsize)
 {
 	struct spi_transfer *xfer = *xferp, *xfers;
 	struct spi_replaced_transfers *srt;
@@ -3723,7 +3721,7 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 	count = DIV_ROUND_UP(xfer->len, maxsize);
 
 	/* Create replacement */
-	srt = spi_replace_transfers(msg, xfer, 1, count, NULL, 0, gfp);
+	srt = spi_replace_transfers(msg, xfer, 1, count, NULL, 0, GFP_KERNEL);
 	if (IS_ERR(srt))
 		return PTR_ERR(srt);
 	xfers = srt->inserted_transfers;
@@ -3783,14 +3781,12 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
  * @ctlr:    the @spi_controller for this transfer
  * @msg:   the @spi_message to transform
  * @maxsize:  the maximum when to apply this
- * @gfp: GFP allocation flags
  *
  * Return: status of transformation
  */
 int spi_split_transfers_maxsize(struct spi_controller *ctlr,
 				struct spi_message *msg,
-				size_t maxsize,
-				gfp_t gfp)
+				size_t maxsize)
 {
 	struct spi_transfer *xfer;
 	int ret;
@@ -3805,7 +3801,7 @@ int spi_split_transfers_maxsize(struct spi_controller *ctlr,
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		if (xfer->len > maxsize) {
 			ret = __spi_split_transfer_maxsize(ctlr, msg, &xfer,
-							   maxsize, gfp);
+							   maxsize);
 			if (ret)
 				return ret;
 		}
@@ -3823,14 +3819,12 @@ EXPORT_SYMBOL_GPL(spi_split_transfers_maxsize);
  * @ctlr:     the @spi_controller for this transfer
  * @msg:      the @spi_message to transform
  * @maxwords: the number of words to limit each transfer to
- * @gfp:      GFP allocation flags
  *
  * Return: status of transformation
  */
 int spi_split_transfers_maxwords(struct spi_controller *ctlr,
 				 struct spi_message *msg,
-				 size_t maxwords,
-				 gfp_t gfp)
+				 size_t maxwords)
 {
 	struct spi_transfer *xfer;
 
@@ -3848,7 +3842,7 @@ int spi_split_transfers_maxwords(struct spi_controller *ctlr,
 		maxsize = maxwords * roundup_pow_of_two(BITS_TO_BYTES(xfer->bits_per_word));
 		if (xfer->len > maxsize) {
 			ret = __spi_split_transfer_maxsize(ctlr, msg, &xfer,
-							   maxsize, gfp);
+							   maxsize);
 			if (ret)
 				return ret;
 		}
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 9e3866809a0e..1ec2c07eb711 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1365,12 +1365,10 @@ struct spi_replaced_transfers {
 
 extern int spi_split_transfers_maxsize(struct spi_controller *ctlr,
 				       struct spi_message *msg,
-				       size_t maxsize,
-				       gfp_t gfp);
+				       size_t maxsize);
 extern int spi_split_transfers_maxwords(struct spi_controller *ctlr,
 					struct spi_message *msg,
-					size_t maxwords,
-					gfp_t gfp);
+					size_t maxwords);
 
 /*---------------------------------------------------------------------------*/
 
-- 
2.43.0


