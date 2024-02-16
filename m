Return-Path: <linux-spi+bounces-1386-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D069C857664
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 08:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CE91F225E8
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 07:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE76A14A90;
	Fri, 16 Feb 2024 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKJejbt3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2651314A8B
	for <linux-spi@vger.kernel.org>; Fri, 16 Feb 2024 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067165; cv=none; b=YptXJO1VQ2zc/y0VVKsnriS1IxhDXXWtDIK2N/5wL/2vcxjeYuSd7mOx1qNh9YHKuLnU6BKwrEtGvhFJH6lzK4FoMDHyAtfBQJCkCscTXYvpnCCIasYsm9g1q5K/aLeKjXytRe+iTaH0FMPjNBHyzD24gtSeIgIwULGaQy2Cups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067165; c=relaxed/simple;
	bh=p2Q2nW4uvqPu31oXeDNl/7frQRBtH2FL2b3+8nc0Fo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5huVPZ8U2KgxYAJBekbaIpfoDLXqQAx1XBpk3E36+sWZFdkzZFn3Uy7Obw/WqitU5m+p3Qw1CG97koV1U/EJtXoObpHwrCLXv3jt8gtuY6luTvdYRbalcVT22vU22p4z1iqrPfnwuhaqbWF56WKweEP6zFzkqVaFew3pp3k2Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zKJejbt3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4122a8566e4so8187805e9.2
        for <linux-spi@vger.kernel.org>; Thu, 15 Feb 2024 23:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708067161; x=1708671961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4fweEbO97J5QIjA941SE8yy8/h6DEGER6dvQE2i+PI=;
        b=zKJejbt3F0sw2TkTyfWYiXE7wdwiaJQa5+OIeS+We1wNwxmDYErO848GhgZK32DsBs
         /7AMhwDX1lVYEYH+B6pQra12B/FLGfn8LzjmemOtUFEWuBAHrjAuaZSu5RpVe6PQ9xb0
         OUkmI9/6GBEe9PDipC/ELCoADC5KmTi6GSK7+bNsCeIuCA4Tcpt+d/QGj70B+TXOLzeK
         yLzH8OBXlJ3DdX1e/doO0akIX5JX7s+St6UNb06stphLpRbWCNWRLN6vf3QjRcAE8wBA
         b71VKDEngY19QsjbLu5hChPXmZ0IigJKKCTCyqTFrCaa7DzCKW5hvL/RyOsnKBKl9WzW
         YA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708067161; x=1708671961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4fweEbO97J5QIjA941SE8yy8/h6DEGER6dvQE2i+PI=;
        b=YC0VupQtNlgmDat2BK+EDVEKyNYFpIKoCO9DleP8j4m5sc5lVcsx8U2yXRPcjopWlB
         vsTSYtowpHJJH3JJ8UrLVUkeEGoDDnTq65bd9iIUW74PRLYmMrOBVeFUwdPU/Rh5tYdI
         InCcLlON7vXeCLB8kTvWBhH3XocTJVLHPlGAcqAxQ1bOVJtAAovssvin4Xr7cPypWTE9
         g6RWAaqEBPnO6mWae/HoRYl3jtM8VNzM+cgMrismhogRPkaU5DvqMe0uvT+DI7SCMs0b
         HKBUYhMETUtjtjT37ChAEIei91CpyyCK6oFFYutw312VAJxd1dLO5MjXVjDYnSj201VV
         CyKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYT08RifXXliPkOCCJB8Z/6eA5tJqYUJEKrna2dE3RjizYiwjszYG7tSQKY1/i7mHluzebbVlP9vLEmCVZsuzhf7Q6Vw5iwtrO
X-Gm-Message-State: AOJu0Yxn+VJupBVSNjix6p2nFyyuuDo3pe9PO+MJ3wvhrGC03Z/oGwJZ
	2l/HC+mOJhzp1oW3YZImiTZD+Ut7KvzCMH4QcOq5uFP6T+jkJ8K9qx249mYuR4E=
X-Google-Smtp-Source: AGHT+IGNTDNcX3yLe4cA7IBsE2D0ybjAgGYV+Vet+w3kDi3fkoc8XRRHeXTdsbbg8juxa8VlLjF5Fw==
X-Received: by 2002:adf:fe86:0:b0:33c:f638:ed0b with SMTP id l6-20020adffe86000000b0033cf638ed0bmr3032323wrr.8.1708067161478;
        Thu, 15 Feb 2024 23:06:01 -0800 (PST)
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d66d2000000b0033940016d6esm1298839wrw.93.2024.02.15.23.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 23:06:00 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	robh@kernel.org,
	andi.shyti@kernel.org,
	krzysztof.kozlowski@linaro.org,
	semen.protsenko@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 02/12] spi: s3c64xx: define a magic value
Date: Fri, 16 Feb 2024 07:05:45 +0000
Message-ID: <20240216070555.2483977-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
References: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a magic value, it will be used in the next patch as well.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 6f29dca68491..6ff3b25b6feb 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -78,6 +78,7 @@
 #define S3C64XX_SPI_INT_RX_FIFORDY_EN		(1<<1)
 #define S3C64XX_SPI_INT_TX_FIFORDY_EN		(1<<0)
 
+#define S3C64XX_SPI_ST_TX_FIFO_LVL_SHIFT	6
 #define S3C64XX_SPI_ST_RX_OVERRUN_ERR		(1<<5)
 #define S3C64XX_SPI_ST_RX_UNDERRUN_ERR		(1<<4)
 #define S3C64XX_SPI_ST_TX_OVERRUN_ERR		(1<<3)
@@ -108,7 +109,8 @@
 #define FIFO_LVL_MASK(i) ((i)->port_conf->fifo_lvl_mask[i->port_id])
 #define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & \
 				(1 << (i)->port_conf->tx_st_done)) ? 1 : 0)
-#define TX_FIFO_LVL(v, i) (((v) >> 6) & FIFO_LVL_MASK(i))
+#define TX_FIFO_LVL(v, i) (((v) >> S3C64XX_SPI_ST_TX_FIFO_LVL_SHIFT) &	\
+			   FIFO_LVL_MASK(i))
 #define RX_FIFO_LVL(v, i) (((v) >> (i)->port_conf->rx_lvl_offset) & \
 					FIFO_LVL_MASK(i))
 #define FIFO_DEPTH(i) ((FIFO_LVL_MASK(i) >> 1) + 1)
-- 
2.44.0.rc0.258.g7320e95886-goog


