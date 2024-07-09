Return-Path: <linux-spi+bounces-3804-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077F592AD83
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jul 2024 03:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C7B1C213A5
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jul 2024 01:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6A0374EA;
	Tue,  9 Jul 2024 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="flQiI1G6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27E02837D
	for <linux-spi@vger.kernel.org>; Tue,  9 Jul 2024 01:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720487149; cv=none; b=Pvbm9HyRmZ7R0GSqjeGUA/PmUbvlBIpnkfzqMC+XGdZBFse9KNSK395euqVEPzlHth4ROW7JYi13KTIYWbMIKHc5V/LYqcjelOS+PKmls/7RK1ydgaaes6Tx/rSkrPDK/wMyeWMAB/4ZhV8N6EQY2TI9zk7EBGWrJaW73Dya1iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720487149; c=relaxed/simple;
	bh=MCMshjCn4X7qsHq4kXqJP0zCCRHD6RupPbdPAs9uLOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGQcO8BmexFFZTLWZg1UkxQjpWJjH2EKTGi2wDq5WWrh1hNB/eXF1G/1VPcFxhRwavr9AKDVaWv4Juo0ltucCH5Ctr7Puf7XBoiiF0vgjnjVeivqn2yMASgICV8jCqI0G//BNh6RvNL/H8PZu495L7RG2xkYe4xT0gunbKiRysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=flQiI1G6; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d925e50f33so1615886b6e.2
        for <linux-spi@vger.kernel.org>; Mon, 08 Jul 2024 18:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720487146; x=1721091946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pqUInDFYH5yNjfgMFCM2DbLWsqlTAzTUfTi1S8oEnY=;
        b=flQiI1G6Gt8tKkMq14TZ197Kca36qGR25TWjXdj4Ok9kDxlTZKcESVgoA6zF5UmSbS
         2ITQNODMquatcMfHEuJuy9zI4tAKDswks2N3Zwa3eigkcMtgcwP0ou8j8GRjOGYBeA+o
         XSxjHb/hPKZWDjk3/DvSBdDnncE/zyOLAgYEB6TWo1sgQa2wna4TK8CBtABpY9FU4M4h
         fheTH8tEJNUeuYhsvm9syguYKUloUg0qfvTfo1pf9bAXjeUXjs0sld6cXddB1/B44SE1
         KFSKm/9i2rC6iHmIuABTrNVPl7GvmQiRohdA4vFa3fVc2HF0vGcUyYHnwfMsfRaV4jjd
         /7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720487146; x=1721091946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pqUInDFYH5yNjfgMFCM2DbLWsqlTAzTUfTi1S8oEnY=;
        b=B9rgpf7urhoLJ2KGUkIvahLEJDuAKlakSkhXKn3SoTXsgB66Kqv21mHDhzJgLE+nSw
         xuN3LGlePV0drtqJ7XCyCQ9L3LrO73Hbjz/H35YV4L6pJIK6Ogg8BB/S69pUgu5m4EY7
         XRrbCw+Hqtd3zOmb0yyIZ/F0q4UxbdbfaBojRFi27LCS8gffx9Z+25WZ6cojZTurSqP4
         g0oDlUc3dQKeN8FJSjXyQZMBTlbCqY/DFaW/vWaxF6s4xDNk9Br7EHyrUnYOBj4oF9fL
         V72ZDyCD6taQDZGSeO/Ha7RGZ+c6LW2xOYqxcHFCZBs4xUM9lK61mMy8h/IXK2iuSJqR
         KLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwu6NBVZ7c68kunOBIe+BZuDqXwyqowbbHoQxfySPk9+0MtHMP/OCkUY50wOLy+Y68WrC8KcRU1CNq/DN2mhvDwyZW7hm5AEbr
X-Gm-Message-State: AOJu0YyGnsf6M8rlTsr5QQ/mqeMd4ueuKtrYYNszyMxdH0QFIODklcMB
	OIKW/aQ2PlH40BHGnYHeNq3jdYuXv+cHy+GoTHtj9ffbsQyFmEd2zFypNbhLaJQ=
X-Google-Smtp-Source: AGHT+IE04QAcCc+Ka9CUVQ8BW9t27zTe7aVThg+fBFSpAfZ7YHIzZcBJfHAy7mKt7Ub74D1fCpW4tQ==
X-Received: by 2002:a05:6808:1785:b0:3d5:64be:890f with SMTP id 5614622812f47-3d93c0b0401mr1042371b6e.49.1720487146135;
        Mon, 08 Jul 2024 18:05:46 -0700 (PDT)
Received: from localhost.localdomain (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93acff694sm215442b6e.3.2024.07.08.18.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 18:05:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] spi: don't unoptimize message in spi_async()
Date: Mon,  8 Jul 2024 20:05:28 -0500
Message-ID: <20240708-spi-mux-fix-v1-1-6c8845193128@baylibre.com>
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

Calling spi_maybe_unoptimize_message() in spi_async() is wrong because
the message is likely to be in the queue and not transferred yet. This
can corrupt the message while it is being used by the controller driver.

spi_maybe_unoptimize_message() is already called in the correct place
in spi_finalize_current_message() to balance the call to
spi_maybe_optimize_message() in spi_async().

Fixes: 7b1d87af14d9 ("spi: add spi_optimize_message() APIs")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5e715a640237..e48c2fdd7204 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4436,8 +4436,6 @@ int spi_async(struct spi_device *spi, struct spi_message *message)
 
 	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
 
-	spi_maybe_unoptimize_message(message);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_async);

-- 
2.43.0


