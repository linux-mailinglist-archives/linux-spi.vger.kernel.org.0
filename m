Return-Path: <linux-spi+bounces-137-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1F1803BB8
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 18:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D4C1F21297
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2EC2E848;
	Mon,  4 Dec 2023 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t62f/93W"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6549FE
	for <linux-spi@vger.kernel.org>; Mon,  4 Dec 2023 09:35:15 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1f055438492so2703688fac.3
        for <linux-spi@vger.kernel.org>; Mon, 04 Dec 2023 09:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711315; x=1702316115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5N1ldpj7qSULABUcURbREEv+jtlrcm2xYn7c9FK6Esc=;
        b=t62f/93WGiwsngUH2sUzn2zcoAvV7WrCN5iB23+MTgrEjXHEKSebP/lnImoIx9kuqs
         5TQag0fbT9cAqx2KXOE3mUbiSD0wDPkWKFU5DGAggVlvuoW6ttFgbyoluBUSiaeUt1Y2
         V0SsTKaKMLgHqCI0ERU7pdywfDnHQJZY4MZqr7bQpum0WcbFuk7aPc/BDVhydC9OOHeD
         QiQhOjkKiXdWXI7RMuf0+PyjEtqPAK+ML57Lhses+WlVEZ3270M3EYpP0nVilPMW1T/z
         Auy8gSLyLOEMQkrJyUF4DCOqbONgALYd4dK7AZ9LxJMOkOqVQI0W87VtvDN1Ei579qAA
         Cm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711315; x=1702316115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5N1ldpj7qSULABUcURbREEv+jtlrcm2xYn7c9FK6Esc=;
        b=uKaIxjCgDuSWdZGPZGVRuQ76K3gPMUu3urxrAV8T1WU50rBo3riBad4ep6kPJUaI7j
         eiMh68vOZIjj3/xqrsYosZ7/kzJnApaTPHORFhq92uYngn6taZQQh3CSP5MCcVKsLy9O
         n562HwrR8whcgtGOoPHdAzNtlbV9LQbhUwgL+mqCnapX9lH9iH43JVlFR61Kx/F03Fwc
         g9k6sC0y8PvpWEyuIBu+kRpLQrbcNn214DoHxUrNuT7wplffFPlbzbNbr7ALNlrhYmX1
         7OswA4vJk3lzG0ECq7eU9qrYjtMrbo5Iiyjrd76lg/Vtu8frs/12pHoEhHWvo9RcmlAt
         OpAw==
X-Gm-Message-State: AOJu0Yzo0jV8Q0lf1Th0o0Ek3Z5ubWaV3dqh7oRnKoULnv7u4N/E9A8Y
	voZwu4rf62fIa8EnIKTjfu0xCOozSgPnMvdnU7o=
X-Google-Smtp-Source: AGHT+IFLgXbrPDcQ7k5zqmLeFlbqKW1SnS++SSir5JVeArkwx/BhZ+D10yN+nLAvf36eks4VoFaqhA==
X-Received: by 2002:a05:6870:558c:b0:1ef:b591:5733 with SMTP id qj12-20020a056870558c00b001efb5915733mr5110355oac.15.1701711315270;
        Mon, 04 Dec 2023 09:35:15 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:14 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-spi@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] spi: axi-spi-engine: remove xfer arg from spi_engine_gen_sleep()
Date: Mon,  4 Dec 2023 11:33:31 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-5-063672323fce@baylibre.com>
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

This replaces the xfer parameter of spi_engine_gen_sleep() in the AXI
SPI Engine driver with parameters for the delay in nanoseconds and the
SPI SCLK rate. This will allow this function to be used by callers in
the future that do not have a spi_transfer struct.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index b3e72308fcc5..84ec37732d8b 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -168,17 +168,16 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 }
 
 static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
-	struct spi_transfer *xfer)
+				 int delay_ns, u32 sclk_hz)
 {
 	unsigned int t;
-	int delay_ns;
 
-	delay_ns = spi_delay_to_ns(&xfer->delay, xfer);
+	/* negative delay indicates error, e.g. from spi_delay_to_ns() */
 	if (delay_ns <= 0)
 		return;
 
 	/* rounding down since executing the instruction adds a couple of ticks delay */
-	t = DIV_ROUND_DOWN_ULL((u64)delay_ns * xfer->effective_speed_hz, NSEC_PER_SEC);
+	t = DIV_ROUND_DOWN_ULL((u64)delay_ns * sclk_hz, NSEC_PER_SEC);
 	while (t) {
 		unsigned int n = min(t, 256U);
 
@@ -256,7 +255,8 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 		}
 
 		spi_engine_gen_xfer(p, dry, xfer);
-		spi_engine_gen_sleep(p, dry, xfer);
+		spi_engine_gen_sleep(p, dry, spi_delay_to_ns(&xfer->delay, xfer),
+				     xfer->effective_speed_hz);
 
 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list, &msg->transfers)) {

-- 
2.43.0


