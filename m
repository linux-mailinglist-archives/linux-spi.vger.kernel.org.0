Return-Path: <linux-spi+bounces-1604-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9A386EA42
	for <lists+linux-spi@lfdr.de>; Fri,  1 Mar 2024 21:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307841C24681
	for <lists+linux-spi@lfdr.de>; Fri,  1 Mar 2024 20:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418043C6A4;
	Fri,  1 Mar 2024 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z6OsBG1m"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483DB3C46E
	for <linux-spi@vger.kernel.org>; Fri,  1 Mar 2024 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324752; cv=none; b=HBFVOXlEI+ttZrzixfp2DVPz7Esla/XUlmvT05fUKaFDpAx8WV2U6d8voo9kyTJcT5QyhD2QC4qvLYFcdqIeB6CLHEJAHu/Dh7a77yxCzznxpemaOTTOPkv7S9zKbLWrfqRsMu8uJmyhTMmdQGEPiYMVsaY+g7VB6k1+uJzOWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324752; c=relaxed/simple;
	bh=L65CnAU/1fE0bnLVD5fRYtl5Qy3ANgyj2SBr40g08Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vo4Whh3eE0Lc61PjU0RxXeph8hjy+x3a8mnPke2qWw4LUMpaofaK3Zhk9uQZReP0XK5teukL1CSBgXk+1E1oGt+tFJyoMXunuGrgeG/d0DS/O4o7iW2qllu0NbImZRTmbKnWujvc+fnSWDrETS0OtUDjhGpBjMu1/NI9/tq5iQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z6OsBG1m; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e4a0e80d14so1811904a34.1
        for <linux-spi@vger.kernel.org>; Fri, 01 Mar 2024 12:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709324749; x=1709929549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBwXoLLpgFu/uPd0sIAAdZiRIZ76bkWotyt1DwrJTTw=;
        b=z6OsBG1mrZqnrXQzZAeduezjnPYdpu15CaGBiB80XXok1/1KH6Nz/svv+uIPIlaeth
         buelwAp4PezVGoGqjO6yL0oe8DK/XmqFwegc4nr3vHJfXOMjvHO9qTiqAu8ccQqB3BP2
         xAkkJEfkBW7oDVU/RPH7tpxsViwNTGXAjbdqBuq0fiCBrsJTWidVF5W66xYpCrzH1exT
         ixzlZlRU6L64vME84PabmI6UhMe9vMDjaSF7iKCSnau+ARFrgP7J81e0sXeH+6NmOc60
         O9VCE97jVk1c3Y5x93y3VVdAGBQhGF89j+OpLXuYIh5u09ebxTY4yaVvN8rcAWs8xpx2
         NOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709324749; x=1709929549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBwXoLLpgFu/uPd0sIAAdZiRIZ76bkWotyt1DwrJTTw=;
        b=sO1qxkQZObCtE1F8oCPrp6HyyXWtbw7W7rX5GjGVBED7xRFmILP1OtKM1HVa45Um9z
         rMziIqNKC2vVtSv+W0hRRPDMw4NCm07tjeLEqU4WprWAyMRNRW/VFAz3PwuIONfxNHcM
         C4dYgc8ixE2InH+lBTjZJ5Zbh7N2Bd4fyK6zyexrQZNKw/2vfl7eMQjRSWvqRYRici4S
         lW7CyshSwvni32DQ/PqZ+QekWVBDZpxBaH/OVS5tC25te9BeAsyE6S+aU1aa8J8Xmb2C
         x3wi3vRLWCtZ+eclvDOEEz+LL08MMc+0W8MKiXZTKG9ZBJ1UywNeCnGDz23ryQwVNLPa
         awYw==
X-Forwarded-Encrypted: i=1; AJvYcCUgTnABewKEOZTeFluocuSU00tLtkI/3dMYc0QeUzJkp6X46ayVNacePYBU9XKMa2CPNig0o9ASfI/NLMMw0U3oGZ/KavzPqAft
X-Gm-Message-State: AOJu0YwTxGCAuOSsTaDYLBqh4tGxskUcGx8b1YdJ81V3bhtPYvFEgxez
	iY8YP0IdN8WvdvOxTmbcWjU09fTDIH7RlkxB1hj1XTVHnFR+cGzMyfm0NrZ+1Ns=
X-Google-Smtp-Source: AGHT+IG5IbGrsAHE8Wg0KPwmjwaAmSOb/2Wv78w/MbWbIsnKE0+zK3NiyMKM1IdCCXnj/pV22ljpxg==
X-Received: by 2002:a9d:7e8d:0:b0:6e0:b4ac:8cdd with SMTP id m13-20020a9d7e8d000000b006e0b4ac8cddmr2949588otp.18.1709324749500;
        Fri, 01 Mar 2024 12:25:49 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e454aa54d1sm806213otq.56.2024.03.01.12.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:25:49 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] spi: axi-spi-engine: remove p from struct spi_engine_message_state
Date: Fri,  1 Mar 2024 14:25:18 -0600
Message-ID: <20240301-mainline-axi-spi-engine-small-cleanups-v1-1-241dfd2a79f7@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
References: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The program pointer p in struct spi_engine_message_state in the AXI SPI
Engine controller driver was assigned but never read so it can be
removed.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 6177c1a8d56e..d89f75170c9e 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -82,8 +82,6 @@ struct spi_engine_program {
  * struct spi_engine_message_state - SPI engine per-message state
  */
 struct spi_engine_message_state {
-	/** @p: Instructions for executing this message. */
-	struct spi_engine_program *p;
 	/** @cmd_length: Number of elements in cmd_buf array. */
 	unsigned cmd_length;
 	/** @cmd_buf: Array of commands not yet written to CMD FIFO. */
@@ -543,7 +541,6 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 
 	/* reinitialize message state for this transfer */
 	memset(st, 0, sizeof(*st));
-	st->p = p;
 	st->cmd_buf = p->instructions;
 	st->cmd_length = p->length;
 	msg->state = st;

-- 
2.43.2


