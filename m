Return-Path: <linux-spi+bounces-5573-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D0D9B797E
	for <lists+linux-spi@lfdr.de>; Thu, 31 Oct 2024 12:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2CA1C20E34
	for <lists+linux-spi@lfdr.de>; Thu, 31 Oct 2024 11:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280E48479;
	Thu, 31 Oct 2024 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GyuoqoGr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6EB1991BA
	for <linux-spi@vger.kernel.org>; Thu, 31 Oct 2024 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373424; cv=none; b=cwBoXnaac14f2wA+cjBzQNToyPPD9sq9uOnfRXdgw5nnaM7FQqUd7M2rKopLNTG3AHr01yaeii4ByNFDPjoaUYs8LlPeRlEtHmgqM9znp6pxFanj2of4ifelUmInm4dtrKrv/VMUBG2+i1i//TX4xCCR9Mp3Og9b0PtCnFLnUVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373424; c=relaxed/simple;
	bh=AU1C6WZByxcu/+1LnkYBiuOlJjGmCMxgkG0ErXzal/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F/Lh98QWqUo+caJ2ePRH4GirNlMkwaogwlo8ltC9rFdly3AJquZTR9iicd20iKJh5rUFeIWyqhe+Urbi+zgQINNcZ/LPc+G+YQwWWvwCe+LHrSa42TRssCk1VCk6tVPDFfYSVRNHSQoPIxR2N/kGEdtUb4SA0vEhwjngEZSZ2jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GyuoqoGr; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d63a79bb6so566491f8f.0
        for <linux-spi@vger.kernel.org>; Thu, 31 Oct 2024 04:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730373419; x=1730978219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1hgK3bgEOYLcZ3+GZtAj9wZF+v4Pmy3y8ET/FkteYCE=;
        b=GyuoqoGrgW3Vjwd+CFuMxk8C/55KkY0quPJB8qB+Eq8KkM0AvcQae94dFmLQdM5ykp
         PZ1GDRzglHLG55GKYFAysxQcVb7CW+QECgZ4jkofLl8yH2fPYNQt16Rz/jpWy9ZCQgLV
         hbrDV7DOKUNIl4uYXOODuifWe6x3gkiGlEB42t+vYbuCegoN6R4jyEEAjdDunGZd0OS9
         1aSedSLNceRua58UbnB2KpvtxIp6LlxhiTmAOcRbr/DIWvs6/zS1SQQKJK0sduXTBBKv
         BwDzYbZmxGSvKuwBULpCjxz4sUrKeRoQTr2FSsy9y0FC7saOJIbMCiC4Vh26AsLod2gi
         gIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730373419; x=1730978219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hgK3bgEOYLcZ3+GZtAj9wZF+v4Pmy3y8ET/FkteYCE=;
        b=krhKJitbemOFyVlil0YvVxnBZtxBe3uYZp/Wr0Mb9lViD9G00FHcyQ+wWMpMYxUdNw
         cNREt7KN26Tax4OmA1VeloMa6urF0tyzy1UVT7fnChY8zUGlu+m/j7Mf9qJx8M82ilvJ
         kAnTh4ZH3zfw9JK3vq1Zv/Fpb0sDFpHUYrGNfhab3jDPI1r0s6N/LcU3oGj/idJuTnCk
         PbqtjjBOI9zxBFFn4i5Ib4qnFr4hq4+UrMlGVKDnr0c99+G9nTapXphLPp9nLEnvRQO7
         Uz+iEeOJEyrngOY34e+5mRxECIbHI4ZVe8jvKAGSqrDXpa2dP93LJHUwqRKSZ9QZSw2H
         opTw==
X-Forwarded-Encrypted: i=1; AJvYcCWSjnE1qW7JDZ3MdO8z5Cl5tj7iIXyCPttM8rDa/RaPsPZcZcnOuzAXSKlk/v/J7pXPNOoaTiRPeK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxPODQTvKaNISOMvt9PGQf739bYqS4nQ5vGJ11/90ksuntucAY
	uDKBSKu9vOKeBFnYUs8lBiDJE6HycpKtNqTpX9McMxiBnESorYEClIr/Ywfefu4=
X-Google-Smtp-Source: AGHT+IFri4cMf29+7JWqBWPWpz3GBXSI5le/c+hDAh/KCAU7WnFzenq0O+/FN0Oc272417lgaHczhw==
X-Received: by 2002:a5d:6d84:0:b0:37d:5129:f45e with SMTP id ffacd0b85a97d-381be7c8137mr2674908f8f.20.1730373418803;
        Thu, 31 Oct 2024 04:16:58 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5ab254sm22594605e9.3.2024.10.31.04.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 04:16:58 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: axi-spi-engine: Emit trace events for spi transfers
Date: Thu, 31 Oct 2024 12:16:45 +0100
Message-ID: <20241031111646.747692-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1836; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=AU1C6WZByxcu/+1LnkYBiuOlJjGmCMxgkG0ErXzal/4=; b=kA0DAAoBj4D7WH0S/k4ByyZiAGcjZx7IsIY0DcVODwag9FFNSgIhnNZXzdnbPmi/IJByviz1a 4kBMwQAAQoAHRYhBD+BrGk6eh5Zia3+04+A+1h9Ev5OBQJnI2ceAAoJEI+A+1h9Ev5Oi9UIAKFA TGz9Oci347ZoBRTdBkjitjoV1faJ80zA3le17wZoSvcpPfVgbXdwBo5YmczdfJ0VPmAHTydu11t w9CDVs30/FhpgHom+8RnUbkgCs/YAMUqi9loDQylIP1tzX0X+PuRuvvwCKuTZ8JiCFgOU3xdZye bL2/TieQC2cz65zWH4kEHw7SRlCPdFrznTeI4HnUDHJB+9QPthWFdTUsRJaPUk4sxC5d4cc3+x0 mSy5St8CRly8uxHmp9hWmHMWTWw5dCqONOt4z6a3jOJt5iyjf/IK1xmuPsd8ThYcl0SwEXNDej9 xdRYzuz5jebhjg+ViiJTrL3inrSRjHp2WD2Dzo4=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

As this spi host controller driver implements the
.transfer_one_message() callback, it has to care about these traces
it-self. With the transfers being compiled it's difficult to determine
where handling of one transfer ends and the next begins, so just
generate the start events in batch before the hardware fifo is fed and
the end events when their completion triggered.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 2dff95d2b3f5..7c252126b33e 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -15,6 +15,7 @@
 #include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <trace/events/spi.h>
 
 #define SPI_ENGINE_REG_RESET			0x40
 
@@ -590,6 +591,13 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 
 	reinit_completion(&spi_engine->msg_complete);
 
+	if (trace_spi_transfer_start_enabled()) {
+		struct spi_transfer *xfer;
+
+		list_for_each_entry(xfer, &msg->transfers, transfer_list)
+			trace_spi_transfer_start(msg, xfer);
+	}
+
 	spin_lock_irqsave(&spi_engine->lock, flags);
 
 	if (spi_engine_write_cmd_fifo(spi_engine, msg))
@@ -617,6 +625,13 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 		msg->status = -ETIMEDOUT;
 	}
 
+	if (trace_spi_transfer_stop_enabled()) {
+		struct spi_transfer *xfer;
+
+		list_for_each_entry(xfer, &msg->transfers, transfer_list)
+			trace_spi_transfer_stop(msg, xfer);
+	}
+
 	spi_finalize_current_message(host);
 
 	return msg->status;

base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.45.2


