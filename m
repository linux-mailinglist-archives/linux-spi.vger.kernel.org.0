Return-Path: <linux-spi+bounces-1626-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D275687068E
	for <lists+linux-spi@lfdr.de>; Mon,  4 Mar 2024 17:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107F71C20A6C
	for <lists+linux-spi@lfdr.de>; Mon,  4 Mar 2024 16:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1FD4D9F5;
	Mon,  4 Mar 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HIh9XJsY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E2A487B6
	for <linux-spi@vger.kernel.org>; Mon,  4 Mar 2024 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568419; cv=none; b=FCJdJU28iKEHhbHk4ufkjnZeqYAiRX3+97fsCf57YK9ZEIiTDUlk1czJWIDkzdymzqVkd3ZqBEcyGsyS0xGPrMBumg5Fwy2y0zyUMRrkEotpyM2ObNrJrPYaD++5nTQw88grZB3UTQs7BnaXtdR2uNQpJqjPqgzM/47jJvkx9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568419; c=relaxed/simple;
	bh=HDTEIEeTth+YlarlZwpbtqNSffqitQLrinmgPBP7yu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/N8ZX8h5eeWLojZQYfAS1/wqcTU57bpfgCdO63DFjR6J4i9nA3XfZJIOEPkscZ96tiry07JYQ6RTf6A1Ml+O/Uc9whXsy16OvriEj09Msc21xyy5uC+ich+UblRbUGmgcst+XdZQZEMaxlsrYaJeKuPvmOh9xm96p7Xwl8WbaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HIh9XJsY; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-21f5ab945e9so2306818fac.0
        for <linux-spi@vger.kernel.org>; Mon, 04 Mar 2024 08:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709568416; x=1710173216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yn3BxlJjgBPLtIhw8+vZTdHKWgVz7bubHMhhj+7dA28=;
        b=HIh9XJsYBqEMYRZ8eqTP1tlbkwygZg35Z15NyWUUL9pqFI+K7BC8nxqaRJCUP4bTYa
         fJNFOGfr89S6ZL1dr12WqBLdhoRmjg0PRO0L/Z/tc5HgQB0DA59XtGE5yZKpLjA720Ll
         kTNbBKV90lMMKndvzQ1EJU5DFWuP4+mZ+UivCTHTfN2yywKjzrNayUQh/+JfvQeQYHO3
         tdlRTiY6oiycYraN+2Pa97OQEmeseynPpZ6Zk2HfrkQ/Hij0uByIY0JQivFE0eVqJnUo
         geRetPZWlRrrs22mfqNq862Lw3xhLMKRbg4K9Dg/1zkvr3BVU/X37m3NOYBtGT7c5ixA
         GXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709568416; x=1710173216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yn3BxlJjgBPLtIhw8+vZTdHKWgVz7bubHMhhj+7dA28=;
        b=iIT0KxCwuEB0cSMe/lmbyjszw0clNPx5nYTIKoFLl+weXVqSrPluluQr+/yxKwqFZt
         AFc1yPYUD55tjBCE2oIPV20jApnMS/FD9Unm51OdoNXlOSrMiz1OdsRJh/ErvgV5YaeS
         Rb6IGX9Ho7km5r2/NptstyEueQOdF5dq2P2/NS7oqdb1VakwwY1MuYbeCHqsJwHztVp8
         Kk302HuLwsSmdw+UEtCz88UrzVTbHIak7IqozbXWzUkeKHedNJQ6ItRVE5znuAkIt6nm
         16x03FQhVKC+Bxj0og3jB3ai6Muqf7eu9vqfD3ESmi38CdwaXGhBppFBCYfwmGG3YS2o
         08Ig==
X-Forwarded-Encrypted: i=1; AJvYcCV6v2r6XTDI2+HWqKRQFl+Lbg6SexwHJuAdMNa9nW5bIKCxK6BWcwIUom3n5BZ98tFdxNx2vO8UUY+kTMFzVYzdEbQB7jVQufam
X-Gm-Message-State: AOJu0YzktHDPj8d6vh69BnxvTXoDuuGJyivf/A1/lKhbUo0OUmzUNT0C
	oY30OHy+uKT52uxYJbmCtjGAWoIMCSM/vO6JijXVEmwF9iGotKO5+OJ9LspOgHs=
X-Google-Smtp-Source: AGHT+IEf31u9H/Myq6t1QuUwWolHTsna+Q0D0Xy9VLu1SozYg1bm/W09fH44eW599tqlHTEORQ0BUQ==
X-Received: by 2002:a05:6870:55d2:b0:220:c434:385b with SMTP id qk18-20020a05687055d200b00220c434385bmr4105937oac.0.1709568415975;
        Mon, 04 Mar 2024 08:06:55 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id lu6-20020a056871314600b00221287ebd03sm83392oac.4.2024.03.04.08.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:06:55 -0800 (PST)
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
Subject: [PATCH v2 3/3] spi: axi-spi-engine: use struct_size() macro
Date: Mon,  4 Mar 2024 10:04:25 -0600
Message-ID: <20240304-mainline-axi-spi-engine-small-cleanups-v2-3-5b14ed729a31@baylibre.com>
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

This makes use of the struct_size() macro to calculate the size of the
struct axi_spi_engine when allocating it.

Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index a8f626165f44..7cc219d78551 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
@@ -502,15 +503,13 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
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


