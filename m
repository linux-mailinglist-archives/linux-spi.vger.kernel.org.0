Return-Path: <linux-spi+bounces-138-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82C1803BBC
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 18:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C388B209FF
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 17:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373082E82B;
	Mon,  4 Dec 2023 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PZiPpMir"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4967101
	for <linux-spi@vger.kernel.org>; Mon,  4 Dec 2023 09:35:16 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6d852e06b07so1659018a34.3
        for <linux-spi@vger.kernel.org>; Mon, 04 Dec 2023 09:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711316; x=1702316116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXeaz0oJETMI/MHvKzRwvujLRc0Q8q0D/J+Fpu3YNWU=;
        b=PZiPpMirR3Gl9heMvlIQieYCy8omL3SrUQrCIXXVPvaNxu+42Fgr18EInypPDF7pap
         ETWVE6h62+yDSFr2/kKoMFlrXDflNTSYun3pBy/IPY1n437caTImiQHixSGUcAegNy1J
         qOMc5Y6pCZbiEFC0jBpHD6vswNzh7T4Mw+ycKo+uK3NAuOw8dFdRSbZ78EWBgpILSDB3
         lsItHaS1VlyHbfHQY8f39/j/9J5bwX2g4kqZQDKK3Z4qaJcfrXKj18ni6l+h4r0iE944
         lSXFNUW5YXBUFvDkieUSpPGA+VDz9kDTE7YOO09R8rWbxtwXY6fI8leqI+WEyGx2kt8R
         xhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711316; x=1702316116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXeaz0oJETMI/MHvKzRwvujLRc0Q8q0D/J+Fpu3YNWU=;
        b=KbrVaOvXQ6nYzMuVcUnRHRLWuKVsLUwT6IxAgynw0PBO+NvJZCIsXcne9m2fXfEoYB
         5VfqX1obz+l8mR9JELVAiWczlBBVSx+APEuaZRVClV0cAiVwAT7j4GO2I7TrIeqJx7oS
         Wxr3gEMbKQb7E9zDsn/ny17ZZIaugZrt0e9fJqJtIimyl14GLU7ABNQ5GoC2bYnPNrCn
         OVODPD9a20c+PLJ+uapefduqqpvM6QiXWTNpGqkU7WkOLlMXNp2PfH8RGFBAQx+6nC4v
         K4dBchEO1XkNniWVXptR2a+JbY+aF38xB4ivnV3O2rp+jWSjdBBQN8/KO3eZyGBb54pn
         G9Ag==
X-Gm-Message-State: AOJu0YxuRVAOWBOP8lNsQEH8uPJoxfv6mlTLKHgipH/UrzgIi55LoSpk
	bByUqwwTPv5gKD4Dl5IyauvfWfWIBoPB0qNwgm4=
X-Google-Smtp-Source: AGHT+IEbHY8B3HhnvuqLpnt7QMdgLQokFYwpaYG6qQiY3g06vhxSnhXGbt+H28bPcfWacemrIuX9Hw==
X-Received: by 2002:a05:6830:660a:b0:6d8:74e2:94f3 with SMTP id cp10-20020a056830660a00b006d874e294f3mr2897548otb.57.1701711316259;
        Mon, 04 Dec 2023 09:35:16 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:15 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-spi@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] spi: axi-spi-engine: implement xfer->cs_change_delay
Date: Mon,  4 Dec 2023 11:33:32 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-6-063672323fce@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
References: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds handling of xfer->cs_change_delay to the AXI SPI Engine
driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 84ec37732d8b..3437829ef8b1 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -265,6 +265,10 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 				if (!xfer->cs_off)
 					spi_engine_gen_cs(p, dry, spi, false);
 
+				spi_engine_gen_sleep(p, dry, spi_delay_to_ns(
+					&xfer->cs_change_delay, xfer),
+					xfer->effective_speed_hz);
+
 				if (!list_next_entry(xfer, transfer_list)->cs_off)
 					spi_engine_gen_cs(p, dry, spi, true);
 			}

-- 
2.43.0


