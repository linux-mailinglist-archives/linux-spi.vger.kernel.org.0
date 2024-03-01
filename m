Return-Path: <linux-spi+bounces-1606-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA5786EA47
	for <lists+linux-spi@lfdr.de>; Fri,  1 Mar 2024 21:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D411C22249
	for <lists+linux-spi@lfdr.de>; Fri,  1 Mar 2024 20:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00103D0C5;
	Fri,  1 Mar 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i6GOcPL8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE063C680
	for <linux-spi@vger.kernel.org>; Fri,  1 Mar 2024 20:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324753; cv=none; b=RyZMzTY1MMJZJpugZhlti1hdh1s0uKEiIUes2fVESaTpufAii+U5ldxPSsBBafBYwyzFre3Tq8qBdAD0sBvK5IWlWS8bwgcu02AN+H5ex2uPQj5fkXt9FoYJvkTsSW+3p6IZPjkiS3IIWNF3WhAUidKaivai9kS1tShxa+xYz+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324753; c=relaxed/simple;
	bh=r0GlreGLsYtbA/Nea/FJMUIpPOXUZxD98Y/U+q/kZ/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8DE90rJw6J4LJsXx+0vvScxRYcC8Sf9Qoxzoj+zWiIFvbxjdXRLPPKlwOL0j19go7EUDCNpgBluk6g3xD4lpxUvd0fci+fgRBTo+9MrubAvHsetEmRoOxOdpb7Umv8cwc1IjpGY01dXYRKqZstUr24Tmh3tSM8+JVXHm1+vdsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=i6GOcPL8; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e45ef83c54so1660741a34.2
        for <linux-spi@vger.kernel.org>; Fri, 01 Mar 2024 12:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709324751; x=1709929551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4uxZbt0qin0Wn8Pr+rE6EDCFD41pXx3sQye6WwUWzw=;
        b=i6GOcPL8AT1LAVXkhE7YUVgaLtFy2ynvq0/1YkUBJArcYTcaZkv6pMXSXoHiagensk
         G7h0+i4TW0z6uNSqwrp4tX9krzlD9+3ppTYXmQR/1JpwqCD12PfGhwNaUdutGJN4pgzl
         oHC062+S1jK8DA2IZkB7H4dyLthluYAr/0PeoJAXJ2Be+HfbQ8DIw75OiqUsjPSp/g3x
         VerqdUwMuORqDfOwFkzqDZEcb475OVihaVC7rlNkaewqViRLEhR7z4CnljE4t7A+FEsJ
         wx4grYg7cNZwWKhhdjmcf0pNG5MiMWDuw88f5zbt1wMcDGtzxxAsByD8KEXwuX60Edmq
         z21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709324751; x=1709929551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4uxZbt0qin0Wn8Pr+rE6EDCFD41pXx3sQye6WwUWzw=;
        b=vvlonH8hG/M2SwHkym1tVQXmTLARU1R9W9aLcjYgbqMerPi6mROR/FnWBVNhAE0vyB
         jNEyr+zNCvofpz/qY++1sxook7aEdjP3xoCcDd+RZIUHH5gNYBPgsOuiTasrzTvGUpu0
         vbPJJTd12LtQCRsl2vTJc55l2rlY6vPitrNXC8CgGVSwMGwyWD+s6hbEeP9y5Ht7dzzw
         a1L/cDSW5arRUIAG1TJI1zpF1fFxG6oPiWMNdGkqj9w2OyMaXbwnSPWHrXDfFGy/yfz5
         4DDgSaXXYs2qHqKKTAgMvgl1Ruae+pKgi9bRiuz3sB7n+QmRUl4j5ezZ+vRNyXmHHEkE
         MrPw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Z6si9Sz5Ws3gwhiF95ojrg9LTyGEi2jJVBPdLLLYuGcjf1lZY4/31R9btqClAaGv1c/UuFOR4IDGoGc+Wl4h0ugqAC7KXq7S
X-Gm-Message-State: AOJu0YyFP8jcdmrEKWjrWCGOmRqsl13YG5n5PiVklVO0+1L0KecnImeP
	VWaBJoAKVpMUU/aKQ8w2dmyvoWXHPZq8IerhpkP9Emlt+6qxr7GFuUJ33SBerwk=
X-Google-Smtp-Source: AGHT+IGOIf9N2e0j0sOh4gWwieqF/orAK7lWNJdnsL4VsiGKxZBiUNq+AipTLP8PSCm9ay/w98JPVg==
X-Received: by 2002:a9d:6215:0:b0:6e2:baa2:42c8 with SMTP id g21-20020a9d6215000000b006e2baa242c8mr2925611otj.28.1709324751180;
        Fri, 01 Mar 2024 12:25:51 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e454aa54d1sm806213otq.56.2024.03.01.12.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:25:50 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/3] spi: axi-spi-engine: use struct_size() macro
Date: Fri,  1 Mar 2024 14:25:20 -0600
Message-ID: <20240301-mainline-axi-spi-engine-small-cleanups-v1-3-241dfd2a79f7@baylibre.com>
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

This makes use of the struct_size() macro to calculate the size of the
struct axi_spi_engine when allocating it.

Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index e801eed820df..9646764b0042 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
@@ -501,15 +502,13 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 static int spi_engine_optimize_message(struct spi_message *msg)
 {
 	struct spi_engine_program p_dry, *p;
-	size_t size;
 
 	spi_engine_precompile_message(msg);
 
 	p_dry.length = 0;
 	spi_engine_compile_message(msg, true, &p_dry);
 
-	size = sizeof(*p->instructions) * (p_dry.length + 1);
-	p = kzalloc(sizeof(*p) + size, GFP_KERNEL);
+	p = kzalloc(struct_size(p, instructions, p_dry.length + 1), GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 

-- 
2.43.2


