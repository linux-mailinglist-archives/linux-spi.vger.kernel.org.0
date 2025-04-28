Return-Path: <linux-spi+bounces-7791-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCA7A9FB87
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 23:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED5017783F
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 21:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99892213E97;
	Mon, 28 Apr 2025 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VZp/b/zH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AA820DD7E
	for <linux-spi@vger.kernel.org>; Mon, 28 Apr 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873989; cv=none; b=DZRuzJCOD3qM+VvcUc44cGzYqh4KhcBccpUYjN14T0UMiCBD2u7qctAf5Y1v+S7zIIHM0naXo0ER9//SD7HN3ZKU6ltKSpPhONbNCtnw99jBORz4B6z+PJZrOaKhJgFRKFMCGwwetqfhcQDzUi/k0SPU8fTk3NE7g5AfiRMz+Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873989; c=relaxed/simple;
	bh=ARaJN/laTWSSwP+pW1ygay2pt+8PIw/fbx6nDgGq5XQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mUGEaG3Gsuh7IxE7Pnqz6PGDdvLymZlI6pVPv5yFec1QIEQNFrX6aqtmbzj8elET0FVPsxE3/oEb7QaXxxYaw28qwGoeR87W3NHUd9e79trhE2H8MLHJ4hob9l/X/fpVez55YbcBMUW3daMbl47ypW8rAsjJmtDIjBf42Gt37ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VZp/b/zH; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7301c227512so3155913a34.2
        for <linux-spi@vger.kernel.org>; Mon, 28 Apr 2025 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745873985; x=1746478785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPm/vbZvGk/XMsHbJko6sUgnPY0qOBeRTAo3Ld3TAjY=;
        b=VZp/b/zHE/IG86D6caMqm5lx+/raSCj2sXRTtWuG7wtXVOtAbawsEa0KRHazppsNhM
         +f9TQOfWO8bGZob2RkYETSgjXpe+C3p6cmIqvwMIfgtzKdJN3g7wbDeALKulw/viu9aY
         X/JUM1N74bUlskgSD7cno/siCWXbI5Fc6X33TmKUbZ88oGZb7brvzkbKP4U9ids1m3TA
         TzqvSAKf94y6qqm2s9atxoB1dm167YNkQwT/TZbdeh3OfLMppZr8QqY0ebNMKbX8yIzR
         inmU1btuJ5Xk7Nd/bh7f1OL3eARG/dlaIFZ9fOi6JUxPq3yl0JYBZogX9cOSZRX3/91r
         p2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745873985; x=1746478785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPm/vbZvGk/XMsHbJko6sUgnPY0qOBeRTAo3Ld3TAjY=;
        b=h4ZfC3Yo30uKMT3Pzd9lDF/UyW4wRdxoz6N31nig5CA3DtRbAPpeKBgTGeyEL3F9c5
         N8108Y8X0DAf0fmRP0PK8rjTm0C61UsFzFQ1AoCRhUOPGDOWidJmZJj46TggF+v5aXp2
         BLC8RwgVCbka9g+ZoNLAmeB7UY18c0GqVn82r7hcgR9F7enGbJuncFn8PlPY0kRYO7o0
         qgTxOawp9il/PDAGymiLuQnebbQSBgesFwe3MxuABWeSbgkJmURiEs6Yncr2Xu7X/nDI
         Flc9hvpGA71pxQb66w2MbXUvFcejFzDCryp4W2M2kErJqwoOAJJY7ky67Tb0Yy/ba7u8
         V9UA==
X-Gm-Message-State: AOJu0YzZDK8pmNGZxwT7EbrCpY6zLbNNvQRJjFald/jJhlCkW1A1z1u0
	6VXfFbUhEw87m+h30NZABLLT8NpO6rGT5rb95eyKMF5x9gmNeC90WhT0VpwRekE=
X-Gm-Gg: ASbGncvr2mFA5FARCbKTDMkr5T5Rrf8+L8lxSOI19QRdX/ZC5e2+uR1n/NVcsmpAUFj
	dxfmtZs5Q52QZpEdiYauvFl5ey6YU1SfO9qHlJOVpR0vEvaHn024s1E/lEVVhz9h+tIbgca3Sbn
	+MO0io1BxZMjTc9RXCF6V15x9wuGaKO83xuk5kvPUCoS6LHaSLUakKiVZyUQObVBy8oiPPfinG1
	IHdkFH9Z92EK2m0Nlxxr8t/+uqgRGd9dCBiHHcHiudi2vxy7NeKYMmOjxjtWWszZvH+agH+0EsS
	7XOZgvrp3FeQIP2QLXmxzJTENtIo0oCeERDLHSxkCWBQPsE=
X-Google-Smtp-Source: AGHT+IGtUrL0vdxDI0xO+GerII96y3Pa4pSQsQzyvLDIuSbvj5q60OHBh+zIXpgdsShHxvLkTCZG4A==
X-Received: by 2002:a05:6830:6014:b0:72b:a9f0:55 with SMTP id 46e09a7af769-7308a4f12f8mr150300a34.6.1745873985641;
        Mon, 28 Apr 2025 13:59:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f056ed8sm1907614a34.0.2025.04.28.13.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:59:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 28 Apr 2025 15:58:58 -0500
Subject: [PATCH 3/4] spi: axi-spi-engine: optimize bits_per_word for
 offload
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-adi-main-v1-3-4b8a1b88a212@baylibre.com>
References: <20250428-adi-main-v1-0-4b8a1b88a212@baylibre.com>
In-Reply-To: <20250428-adi-main-v1-0-4b8a1b88a212@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3108; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ARaJN/laTWSSwP+pW1ygay2pt+8PIw/fbx6nDgGq5XQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoD+wtKbrM87Br0iUTrX8PmS0qoypqR5/xwfFbx
 5+1urDsIZ+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaA/sLQAKCRDCzCAB/wGP
 wGOQB/4lpOzs4u45Rj068DI3+3h1J80plwy9Pty6NFrRY9Tw+fylYlbbZcG11h3z4W0ivm+bt9U
 x7tzdi4H1R9LVPUoKkHEvKTPcQopzKNVPbdJNFJJG9+X80j9p08y4hplGSG/xTnKrOdS++xBaED
 KoSd4sjkHF10JeIpSjwmSiu5eACx1tVzYeVvM++RzPAPe5epKUVh3u1jCX240afaIaW2SKSamaF
 3YGTeZFT+gufYSO7CQ9jI56iAKKmtw5Yu4GCmfzbpytdEaoTWAgfOhT4THS07n56yee8uqZOg7f
 mZsMRlY8B2orYX9vUvAzxAiF+IIpcZOUXdcEnAdYrRwYaYN9
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add an optimization to avoid repeating bits_per_word instructions in
each message when using SPI offload. This only applies when all data
xfers in a message have the same bits_per_word. In this case, we can
execute the instruction that sets bits_per_word when the offload trigger
is enabled. This is useful e.g. for obtaining higher sample rates on
ADCs since each message takes less time to execute.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 05ef2589f8dc0bdaa1b3bb3a459670d174f821a2..b54d2e1437c9993d251aa2842d9040ec0949a78d 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -142,6 +142,7 @@ struct spi_engine_offload {
 	unsigned long flags;
 	unsigned int offload_num;
 	unsigned int spi_mode_config;
+	u8 bits_per_word;
 };
 
 struct spi_engine {
@@ -267,6 +268,8 @@ static int spi_engine_precompile_message(struct spi_message *msg)
 {
 	unsigned int clk_div, max_hz = msg->spi->controller->max_speed_hz;
 	struct spi_transfer *xfer;
+	u8 min_bits_per_word = U8_MAX;
+	u8 max_bits_per_word = 0;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		/* If we have an offload transfer, we can't rx to buffer */
@@ -275,6 +278,24 @@ static int spi_engine_precompile_message(struct spi_message *msg)
 
 		clk_div = DIV_ROUND_UP(max_hz, xfer->speed_hz);
 		xfer->effective_speed_hz = max_hz / min(clk_div, 256U);
+
+		if (xfer->len) {
+			min_bits_per_word = min(min_bits_per_word, xfer->bits_per_word);
+			max_bits_per_word = max(max_bits_per_word, xfer->bits_per_word);
+		}
+	}
+
+	/*
+	 * If all xfers in the message use the same bits_per_word, we can
+	 * provide some optimization when using SPI offload.
+	 */
+	if (msg->offload) {
+		struct spi_engine_offload *priv = msg->offload->priv;
+
+		if (min_bits_per_word == max_bits_per_word)
+			priv->bits_per_word = min_bits_per_word;
+		else
+			priv->bits_per_word = 0;
 	}
 
 	return 0;
@@ -306,6 +327,12 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	if (msg->offload) {
 		priv = msg->offload->priv;
 		priv->spi_mode_config = spi_engine_get_config(spi);
+
+		/*
+		 * If all xfers use the same bits_per_word, it can be optimized
+		 * in the same way.
+		 */
+		bits_per_word = priv->bits_per_word;
 	} else {
 		spi_engine_program_add_cmd(p, dry,
 			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
@@ -862,6 +889,11 @@ static int spi_engine_trigger_enable(struct spi_offload *offload)
 					    priv->spi_mode_config),
 		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
+	if (priv->bits_per_word)
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_XFER_BITS,
+						    priv->bits_per_word),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+
 	writel_relaxed(SPI_ENGINE_CMD_SYNC(1),
 		spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 

-- 
2.43.0


