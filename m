Return-Path: <linux-spi+bounces-1624-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D73387068A
	for <lists+linux-spi@lfdr.de>; Mon,  4 Mar 2024 17:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6541C212F4
	for <lists+linux-spi@lfdr.de>; Mon,  4 Mar 2024 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3505F495E0;
	Mon,  4 Mar 2024 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ojILu51K"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3919E482ED
	for <linux-spi@vger.kernel.org>; Mon,  4 Mar 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568417; cv=none; b=AKNM7qS07Ec2e2iRUshBIT5pBkA6Kxqwe57GSNBE7PRls/c0epuw/oa3u73ErQaTbCiV9UPIgFgfbn2YLDZTt5yUuItIgaZTJIlD5b+liVKcawc2oAFLRaDn7iXojwVG+SdzXZZtW7D488fm4gtvEZvpvw/icFk7KXIqjFiOgJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568417; c=relaxed/simple;
	bh=5hT5wjsUvej4t0PzrwkFZZddS5utw/QYaLNNX9eOC0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bf+ral9f+oB8k2zrFQ2OV836gC/cp1wdrUVMhPgTwOY+cXW9F2OfBVx35EVK6fjblhqB/flx2kYE3xOA/Jdnf6tgatb9UpYC0v9s/+fJCfTA/spWaCqMVDGuNzODmHV05y9OG4+Xhd4r0iDv+6WnFcujmhCAWXb8aUvZTiHXv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ojILu51K; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-220ef791617so1114556fac.1
        for <linux-spi@vger.kernel.org>; Mon, 04 Mar 2024 08:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709568414; x=1710173214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47S4ZgnBYo9jKRg+1Qx0IpWuTU4W29awdHsHBhIR8G8=;
        b=ojILu51KDxcLa8wt1MuvwAZ2zY0s/ZInPDn+TrUK5FsoZzwbXRJdUlVEgu9z4czUXm
         /XNS6Eyqxw2xa11MkN2Fn8w1mJdPgPqTH2NWyrNGddt8UjFpB8si9zCM9xVY52D3VMYY
         rWTA7E5TXy89VWoBTs5KmQkkkkKwMZYYEmR2K37Xy4o/t7JEMtqCkqtCFahzYYfBnkQp
         3zK6rfVRLI0yzWsZ1KLlGTQ9F3RLoXYAdvQm/r/FEosbIFN4NUPfnzwsWjz4+7LGxYpM
         0s0DKqrfF21G1/xVQ89lbHPuIG9JqV7oUtTAorFMyEAF5LtEXzrnDqr62iT2RORfUlm+
         Hj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709568414; x=1710173214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47S4ZgnBYo9jKRg+1Qx0IpWuTU4W29awdHsHBhIR8G8=;
        b=kWGmFamqKQp5dgyCGdTppGVSMvqH2blU2vCKTcOPJb5CU5bbbrJDL19QILvTPmi2UZ
         XwPjPiDyDU9F7Cht68EHRnM0o9se0oYVlT3euxYn8YlylyMu364ubLFEBN/eubzL9IZX
         7VQiBriCLzXWAGWcHDGA24g2ASYoutRdUL5yQdZbvXA6vW6M38L6ropx/wb4DSyW23qI
         Yw89u1Rl8bs6HCzX5NdTIqGMFivWmK0gczvGIjXfHT00MrjZXMYr8qLZkKmIg1i2JGTI
         fXOyaRS7b5LfNZAsQw2S7MR551UOvLt+P1LXmHmOhZM2uDIxuhxY6pLdlZfRx5O3YFKP
         omLA==
X-Forwarded-Encrypted: i=1; AJvYcCWY9zzHVku5YJ4nvPwW2cm9C2IQ9OVIvzSo8mXQBFf0VKGXGyxsJtR5kIUy14j4kzI7gv0AtRnf6ab6fQE7vyovpYqAuupfZ5uW
X-Gm-Message-State: AOJu0YytL74TgSFvnsgvxc9q+9B72JrOgE7me22QDkG7h2oczZcJ0DzL
	jOfpQsM1h3WNbd/sybAB9PcJgyzzL0Zji/aHuf3HEXiKI1Mf0qkLe1eQGjqVbRE=
X-Google-Smtp-Source: AGHT+IHnUujhgYRoulUU9Ki4jG7rgvaQB6rYriALE46IC4meCxLSw11sUvrfGLvhQczpaNuwleJnxw==
X-Received: by 2002:a05:6870:37cd:b0:220:9862:a2dc with SMTP id p13-20020a05687037cd00b002209862a2dcmr10440444oai.57.1709568414246;
        Mon, 04 Mar 2024 08:06:54 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id lu6-20020a056871314600b00221287ebd03sm83392oac.4.2024.03.04.08.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:06:53 -0800 (PST)
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
Subject: [PATCH v2 1/3] spi: axi-spi-engine: remove p from struct spi_engine_message_state
Date: Mon,  4 Mar 2024 10:04:23 -0600
Message-ID: <20240304-mainline-axi-spi-engine-small-cleanups-v2-1-5b14ed729a31@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com>
References: <20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com>
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

Reviewed-by: Kees Cook <keescook@chromium.org>
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


