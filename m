Return-Path: <linux-spi+bounces-3805-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080C692AD84
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jul 2024 03:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7158282366
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jul 2024 01:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998293E467;
	Tue,  9 Jul 2024 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W6CI5h3l"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3829381BE
	for <linux-spi@vger.kernel.org>; Tue,  9 Jul 2024 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720487151; cv=none; b=oLCFallt925ECTxYtIIJB3KmrbZcK32qOknI5kuikPGkP+2WG9FIZiGaNnsLbZWqglwY/Jkp4/+OYIuyIxxJSy87+0Qw/phbvRqBZSIkmwd+JRvFvWsupkje+1WXGAqWjWwyi0+Qa+anmCivw6CXeauyDGX7FtmOjFGfDnyAp1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720487151; c=relaxed/simple;
	bh=zhXUxg9EOpmx0CiXmSG794sId4TJVZklA0dfYHPw/DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEP/N1zo4Pu0nW1H/EH609ox2VjggIe+Uih56r/SQZeZt2F7lfSIeaegnC6/XHcNpucD7xdvjkbWsZjBv/rqQwNWQjefisTfdty2SJvbIpLE/GVghOFRCVsRQtFNbVGZxNpqmBqQ+hTrBS3ehg5LD7HaKfSsQOo9svI1vMI4t2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W6CI5h3l; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d92e1bc90dso681123b6e.0
        for <linux-spi@vger.kernel.org>; Mon, 08 Jul 2024 18:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720487149; x=1721091949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxt6sRBunEAJdmr/SMQIrLMhyKmCuiWg3A5plz8J5+8=;
        b=W6CI5h3lC1KoLwMAZA9GskkbrMCdqI1bj+tEUVGG+jD4QocknpFzHYI8+SxnES9CCz
         FjgsILHtjKy2eYJBdUSeBM9voUQ5oW2W7V1XKYtvzmsaFuP4SJIyW/11lo8gQer8zPuw
         QY0+ntxDME93cMyG3zezbJ/eUL8JPqYRjioEFlQbtJagPlYOAcTF3J6j6nfGsempqHmK
         R0Ac8kWDhZNe5BQQO0vNX43umzSzxYuqlUdSAkhkZm7i/vT/Vm5zwhPUG54KEpQWA1PN
         XvB06ARd/L/fhjuh1kB7tm6UBJ2ABuwrVKEn9HD9DrygdE7JCXUiAgqbzE525KIJIHZ/
         DdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720487149; x=1721091949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxt6sRBunEAJdmr/SMQIrLMhyKmCuiWg3A5plz8J5+8=;
        b=QjSmidQWVrywzg3lUYGFPJLcG5n0Sl9kNn70fHWquvwIN5TU5NgaMnR4zP0jsI2d0N
         yTkI3tzx9I7e5yT6q4t2RUQEwbZQLiOL7jUmFYnuPMO053IV7u/CeQ778S2/sqcMWb+8
         R1YLe4stsE5kMmSWPEwkoBiUqRFICYft05t31uy63ARX0G8CdlauHTCjwhBjYX/v1/Nv
         H4oMkonuLvi0iSe82UhGps5I1qkUmb55+H1qwgym2eWQhHTWBPlFqOGgIeEJCXr5Eto6
         u7IxvaNm59uN1HXJWzM5lSIDzr+4J9ZlqLAE70SIT+PJ9/kK2pK14F6ff4fLBG30bFtD
         RkZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7GqTlAf7WZcKWqu0Z0FHQ0iEY/+2uxbi7MEB1NiK/GnnzR8BXM0cfAQpQv6lV4t4iN3EDpsO4VCIV0IEKHnH4+MAYMNRfowlf
X-Gm-Message-State: AOJu0YwliM2Xdan0I8EIghcGJrjVwXwI3avMT5pvFCHuyN22Ov7lmIUc
	3z38H8AnxjOZgIjBOJNmAfIoCIFhhRcj7dEbbW34rmD1L/WYhR9z2gQVGBrKY50=
X-Google-Smtp-Source: AGHT+IFZVZrSxg89uP9Je/FmpgZThlv+Nr0TXf60j4XST0/pMpypzFZ30CE5rmjYzzIiFHdN2u8Dcg==
X-Received: by 2002:a05:6808:144f:b0:3d2:95f:da8c with SMTP id 5614622812f47-3d93c4931b3mr371575b6e.18.1720487148945;
        Mon, 08 Jul 2024 18:05:48 -0700 (PDT)
Received: from localhost.localdomain (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93acff694sm215442b6e.3.2024.07.08.18.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 18:05:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] spi: mux: set ctlr->bits_per_word_mask
Date: Mon,  8 Jul 2024 20:05:30 -0500
Message-ID: <20240708-spi-mux-fix-v1-3-6c8845193128@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708-spi-mux-fix-v1-0-6c8845193128@baylibre.com>
References: <20240708-spi-mux-fix-v1-0-6c8845193128@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

Like other SPI controller flags, bits_per_word_mask may be used by a
peripheral driver, so it needs to reflect the capabilities of the
underlying controller.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-mux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index f4b619cc2657..c02c4204442f 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -158,6 +158,7 @@ static int spi_mux_probe(struct spi_device *spi)
 	/* supported modes are the same as our parent's */
 	ctlr->mode_bits = spi->controller->mode_bits;
 	ctlr->flags = spi->controller->flags;
+	ctlr->bits_per_word_mask = spi->controller->bits_per_word_mask;
 	ctlr->transfer_one_message = spi_mux_transfer_one_message;
 	ctlr->setup = spi_mux_setup;
 	ctlr->num_chipselect = mux_control_states(priv->mux);

-- 
2.43.0


