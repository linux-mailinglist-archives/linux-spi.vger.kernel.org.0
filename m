Return-Path: <linux-spi+bounces-8733-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1033FAE629A
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 12:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C277B5699
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 10:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4D728688D;
	Tue, 24 Jun 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MTsaeuoh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF9E8634F
	for <linux-spi@vger.kernel.org>; Tue, 24 Jun 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761397; cv=none; b=AdFg3qBk1QI+XKt+A/pbBy+9Qpu9cS+E9cAS8fXBIQUvLpSNY/Op9wrQLioxtuj7aA9bXVtLkMqVN3+0cMLK4Ek6j0I+ZQeKkW6z4y+kwDEPbHJPrKq0S6afYl6vlVQQW1GDN+EKV0lhAbumKI93ONHdp+rubp37w+ES/CptQq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761397; c=relaxed/simple;
	bh=I6Uh0W1U/pEscoVd7miIYAu5wzDsffordzyPGY3jblE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lu/4aAPE8yfAfwoBpUTonFOW2xb7TiJxw7v3IQmNYDgJYgCn/dH4CXG2KoSYETErbnqfHNWO3haftHdsLy9hNntfb5e0TiYuEATcyJWrvZnFQHhZu90LoMZMS1yv4sFnezRfTaSkZx69N2W+mVYChSbQbisNsQzsO4Wy3TIlo+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MTsaeuoh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d3f72391so47344825e9.3
        for <linux-spi@vger.kernel.org>; Tue, 24 Jun 2025 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750761394; x=1751366194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkMuSosV7oMRxRtp9yYE+2UdziIG4xoxewf16F9X2EY=;
        b=MTsaeuohoQk6rMfnmVu/5ocbrCIwViKarJ+wRU+41QIl2B2E5VEZej+r9pBCBxwSZq
         4TmPFyxtmjLJ4Q3t4/ZT5YmJ5JBzfN6sbCVwg/ZBRegEU5APkC7uInrK0tBe19V8xrmq
         eFSrTWJFbDp+CY5wmFc1gayPNsAnJQPg2Pyg9/RfE4wfTjMM+f9jG8SCbwMBKcQAL4XD
         F/i9NnYLPDJtduMkY1LsD8mufwXlsbv0Eu0WWE+qXOsK5mEgI6pUYLqWhwrI97sczJcu
         tDouJ6bNfLyfpKRz7OvgiCWbLadw2TYulyPBZjn+BzMuu4ddCGbYFp2QncodqzMTJBbu
         K7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750761394; x=1751366194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkMuSosV7oMRxRtp9yYE+2UdziIG4xoxewf16F9X2EY=;
        b=FNlPlO//gZiq0wy2va8qWbqcA6B437iBHxWkFYSalKAxFkkfepS2E6osgCXNpJJD72
         Y6L5NSTdi2DMPpeqWCaYq+twkxUm6VTTeTWxIdypTHv/+1z6jACMpCHsfBr6UumFlWwQ
         Zvb3lq5FmOOAdzkdhesgLiA89VbUwJdwP3hIyg+eq7j9Nq6hnFLu2Cj76+lpkq5cKnJa
         wJBZn/PFVMLr4yMCDqBODgPtzLsk/WVaf7hAGwVH6QFnH9K9/PJDNh3Y14yyuFboF/Lz
         sf5VQhyvixLizLo6Q72uL9vHjU2MNhMRxPCx+0sD/xo95DNYVFY3f8Qb4YSPxpKRkU3b
         J5Lg==
X-Gm-Message-State: AOJu0YzzVBfsnXuo803wov9oshNYSaHiVCBIGVxKVoWlzjk01vrkMjq8
	kwCcvPhTm1SYZOszIZ97NE1LGEruKu7XWfNDoix+F8Z1JWeBNG1AqNUiFVZfeMAMpOk=
X-Gm-Gg: ASbGncs2Bamoib+7nf/0nLFWqwu/6am2LAVlbWAvFxnMwyhz9+hJ+zcRP1wcwdDtgla
	AdhC0vURfG9r1jH/7EKFL0KsOrNzJknuCgE6qGYI23mBDqVf2AKVZdpz9DFgzU9Dj7Z2T1u4GYJ
	n9gwYYqVf8ajQ8cfpRkPfPk1L32oNt4HeXnH+zSC1XgJa9AgTgYk5pCYs0PLL1V10RUbZU4JFMw
	WvEEhbtdWPA6UxE1T1I19wQJ+WvyFLjeqQGRo5mscnLonA+FwtNUS1cJxN5NiVccND5xr8/gMmf
	KV2WG77FWjnnRCFotFIOEZ1QB62L5tCVxNGGKA901UAef5eRzafFcLaKQwKsK39+c2BT0Dw=
X-Google-Smtp-Source: AGHT+IE1yzuJW1JyGG/GLYl2/Ucg2KNK2xeS+Q9P5XhB9Map8hlfvdK3p5oXRvu10nUbdGxDztsgdQ==
X-Received: by 2002:a05:600c:8b14:b0:453:a88:d509 with SMTP id 5b1f17b1804b1-453659ca92cmr182600865e9.10.1750761393938;
        Tue, 24 Jun 2025 03:36:33 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb641sm143398245e9.3.2025.06.24.03.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 03:36:33 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 24 Jun 2025 11:35:31 +0100
Subject: [PATCH v3 1/6] spi: spi-fsl-dspi: Clear completion counter before
 initiating transfer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-james-nxp-spi-dma-v3-1-e7d574f5f62c@linaro.org>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
In-Reply-To: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

In target mode, extra interrupts can be received between the end of a
transfer and halting the module if the host continues sending more data.
If the interrupt from this occurs after the reinit_completion() then the
completion counter is left at a non-zero value. The next unrelated
transfer initiated by userspace will then complete immediately without
waiting for the interrupt or writing to the RX buffer.

Fix it by resetting the counter before the transfer so that lingering
values are cleared. This is done after clearing the FIFOs and the
status register but before the transfer is initiated, so no interrupts
should be received at this point resulting in other race conditions.

Fixes: 4f5ee75ea171 ("spi: spi-fsl-dspi: Replace interruptible wait queue with a simple completion")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 04c88d090c4d..744dfc561db2 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1122,11 +1122,19 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
 			status = dspi_dma_xfer(dspi);
 		} else {
+			/*
+			 * Reset completion counter to clear any extra
+			 * complete()s from spurious interrupts that may have
+			 * happened after the last message's completion but
+			 * before the module was fully in stop mode.
+			 */
+			if (dspi->irq)
+				reinit_completion(&dspi->xfer_done);
+
 			dspi_fifo_write(dspi);
 
 			if (dspi->irq) {
 				wait_for_completion(&dspi->xfer_done);
-				reinit_completion(&dspi->xfer_done);
 			} else {
 				do {
 					status = dspi_poll(dspi);

-- 
2.34.1


