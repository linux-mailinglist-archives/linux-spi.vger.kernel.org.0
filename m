Return-Path: <linux-spi+bounces-1625-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF8587068F
	for <lists+linux-spi@lfdr.de>; Mon,  4 Mar 2024 17:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC89B2529C
	for <lists+linux-spi@lfdr.de>; Mon,  4 Mar 2024 16:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C914AEEE;
	Mon,  4 Mar 2024 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kMgmySUD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85A8482FA
	for <linux-spi@vger.kernel.org>; Mon,  4 Mar 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568417; cv=none; b=qfmj2QyReADX0q2ZwO0IJAefxT8VOa206vbZqIbEstjAfxY1l+oL4E2vBVJ0/1muNsIuQB/xB/Zs8PZ98GJwWxdHlP/sSFTfHyV9pUIFLVjqnpy3umrHYDsb5dzfgZq963p4CKx7FFbAAM5n9D4W/xzQxgj3VHqNvhvgiRsorbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568417; c=relaxed/simple;
	bh=Iov+SLQtBZ5UAEb6YDKr9rdAOJnCjM7+0r7ET3OF5dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMBtEKjqaC6TVF1/6fr7mZxt/i86IxVnd6ZECD/QpF9CeU/BBZ6CaMW17xPP2Ffhz6E+celfnR7K7uH6OpB/0LvGLRHz5uajRTMXIahL82l6at2VyZiL5zcHeTqwR/hoGbhXVpHy8X80mmEGiMO/LcEaTQK8bcAZRMJy5IR3y0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kMgmySUD; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-21fd278aa74so2760446fac.3
        for <linux-spi@vger.kernel.org>; Mon, 04 Mar 2024 08:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709568415; x=1710173215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCP8eJQPKeVzox/Qa6ATJPu9ofpJI+UjARSHWwbkYKs=;
        b=kMgmySUDd6O8PX8aZH+RTbu1pDkEu0602rzF0RZRHJsRu4qGQNunJnnXLtipR3zewS
         wudzqWiofmjMNNUVMgtY7Rsx1WWgVagTE0fMDXzme2u3vIfkKxhlvA5cqi7c0lXA26uN
         y0clrAfkJneiS9oRsotjBlVGooQslWkaqL9N0aFqCfHhSzLtDUsRtGnbMuoFBtBQxckU
         ycpLLjNCitB39uZRl6Ga/3ZFfnuird0GXYSPffj5taiyqoWVAgVtrnChW5VmbdAXkdoP
         /kQz/bEgW1xySjiGu4oW7LeFAxZOu5M3a+b2ZMDC8fUkInSLsvhEInoAjJ0u/dDt9Ms6
         OMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709568415; x=1710173215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCP8eJQPKeVzox/Qa6ATJPu9ofpJI+UjARSHWwbkYKs=;
        b=h4SmJaQM92IA4qsDC2/XKeQ6rF7M16/MhwhEGKPtK1duHUM1X/SPFlzj+k3CAJP7fO
         /n0788HZ43vaQuylUutK0mHI4ppQF6xzB0p+WRSyy+dKN3fQVcUAwj14JzfOdVAPiX7Q
         0ZGwBIv9GrtTeaBr2SxHM0nfZgfEe80Emj0C5JIk7GbV2IyNqdHk+0qhxI4huE5AH9iq
         lICBvbIeBHEWLg+rp+aci0GJcczrQ+OxG8a6IrIuIzyBu3cTa3uzU4WfRaH8aUsQ5Xig
         ScRqY/SFVo0aIx9UAtACf9uQxfokxDhlIPzffaMlfwuHZyBmXn7yybDT0m4oKh/Nagks
         6Ueg==
X-Forwarded-Encrypted: i=1; AJvYcCUjRn4XVqsxJMm5tyJXPWwdImNBkgAr93PJuUvq2umEfRtBQCyWV4yaeukLz1nJOaQXuBkl7OIw+1Liw82+Le7kyNr8E1XlDElD
X-Gm-Message-State: AOJu0YxDNCvsgDiR8nQgin42FlMbiXdi2kuiVCVKr1+eVQFxifjlyqs5
	EsN8HrNqJYreOHebSD78ypox82b0ziei0F4bxNN6crqGHx6yQXUxC/hksO1jLXc=
X-Google-Smtp-Source: AGHT+IHdqhPGLcqP8KvM0oEOY4dxrGT/0OINH0urzsMtnq4EMXL6ZM/tA2tvq5C6ZZ2itfpQXPu/MA==
X-Received: by 2002:a05:6870:b526:b0:21e:8afd:65d0 with SMTP id v38-20020a056870b52600b0021e8afd65d0mr10111952oap.52.1709568415111;
        Mon, 04 Mar 2024 08:06:55 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id lu6-20020a056871314600b00221287ebd03sm83392oac.4.2024.03.04.08.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:06:54 -0800 (PST)
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
Subject: [PATCH v2 2/3] spi: axi-spi-engine: use __counted_by() attribute
Date: Mon,  4 Mar 2024 10:04:24 -0600
Message-ID: <20240304-mainline-axi-spi-engine-small-cleanups-v2-2-5b14ed729a31@baylibre.com>
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

This adds the __counted_by() attribute to the flex array at the end of
struct spi_engine_program in the AXI SPI Engine controller driver.

The assignment of the length field has to be reordered to be before
the access to the flex array in order to avoid potential compiler
warnings/errors due to adding the __counted_by() attribute.

Suggested-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v2 changes:
* Reordered assignment of length field.
---
 drivers/spi/spi-axi-spi-engine.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index d89f75170c9e..a8f626165f44 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -75,7 +75,7 @@
 
 struct spi_engine_program {
 	unsigned int length;
-	uint16_t instructions[];
+	uint16_t instructions[] __counted_by(length);
 };
 
 /**
@@ -115,9 +115,10 @@ struct spi_engine {
 static void spi_engine_program_add_cmd(struct spi_engine_program *p,
 	bool dry, uint16_t cmd)
 {
-	if (!dry)
-		p->instructions[p->length] = cmd;
 	p->length++;
+
+	if (!dry)
+		p->instructions[p->length - 1] = cmd;
 }
 
 static unsigned int spi_engine_get_config(struct spi_device *spi)

-- 
2.43.2


