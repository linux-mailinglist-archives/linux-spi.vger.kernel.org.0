Return-Path: <linux-spi+bounces-8399-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED43AD2284
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 17:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03F1163E0D
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164B920C480;
	Mon,  9 Jun 2025 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5UdW6C8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09CA1F3FED
	for <linux-spi@vger.kernel.org>; Mon,  9 Jun 2025 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483221; cv=none; b=p3rRPTdTzTh2kIwSJ9nAxcGQTIC1plCywfVldn3qU+Xa0VdenmwbHX+Qln5T9IdzJcAxwzvwiV+HqCYNIb/nkCDMSaH2lyvUvHgj5lBlKgWzHOmrTFKBQHOAXPRkfMLh8xIOHoZ46BCAsntWG3TmuHartHEdWGyDkorMPHj6iS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483221; c=relaxed/simple;
	bh=4LtVV7NunJznOE+EaQyuaoEsQbLFTKYk/hWx//k49f4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VJmmPIM+RtDM2lMSImDzf44yQwE0ltSyw5XxShzxTEGeWKN2EnEkvJMNvPrqlz4T3S22IA4rz4HL7Z9f4/JeLAsF1bWRPDdLtYHL3zxSygf1dUEly9m69MBkjvPnWxdXGgj0sCMd1F9pNFTJJSfhMLiZNuNmbfDlnj4qhvdVLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z5UdW6C8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so36116145e9.0
        for <linux-spi@vger.kernel.org>; Mon, 09 Jun 2025 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749483218; x=1750088018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w76Nia4/b18xDXgyG3usj9/ef74AF078cya8aFseaFQ=;
        b=Z5UdW6C8UTAf0+LTnPgWxJmqTl2Wc7GWYSZ1K7d7r9W+DpNGkMGD8+e+Pfatnxwuw0
         F/GYES0PUhK9XEDBXOCG7NrMuRgy35k/Vyj51v2WVZlOlzm7Y+X3KUS7CjYcGiBRlKxc
         pLjUjYS2GAEx2g0CwF/rM0R9M7GoLWk+qQbLvDEMr5jKLx+BEiBWhE2cTvphfXf4bg3p
         qbGAjUlxc0x0XQKP65sZ4mD5pTEnXHoEM/RH5TLBn3vhZW8nwZHkVqmuU8zGVk1RHH/a
         MEOUZ8fHa5HEp93BYQHHBr+SKw391YUS9gphwfC4pghSSludhQrbs8j5TqfNZ07cdCGF
         J37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749483218; x=1750088018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w76Nia4/b18xDXgyG3usj9/ef74AF078cya8aFseaFQ=;
        b=eT1jNgSqxMdVF9GRDakyfKTvUa+Mrt236obU5JJ6/rNxH0NRreXMvw5PnUZP9pIv7N
         wh6zDybSkFDyemilWskGsxOmNJf2im4r48jN24KI8Kfy1CMU9Ga3ChdaCxDucVkKNa+8
         bhnXp6+mLQHfu42MoXJwrS8RNSWQMB8PogcWCaj6zupdcgyx8pQFZ7L+ZzjhNhfz0+kO
         r11o+6ERtP7BQWL0Ietb2wpFIxRUc2isT5biV9MfzqsmpL0GqnjMBpcYhPr0zdiJsU/z
         /3Qy4h2J2PDSwGCm9TYnnFxJYB2UXG4SX2FVrYirPfWlTUTUYZwnucE1PxgzoL3Asq51
         trZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVd9Rl7gx7Vx4Bi8Hjq4pSqJM6mDBqSQo1PIlBoVkS6R3b+wD7+rhpdeLsBqsky2EhcUFL+yOwE9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXzcXUmLgkLneSKfp5gER+zM7zT0tazhcihXHW4Fm9Rj4kqfvt
	UMzqk9kk6GWBdEbrBeD6IqOdfahQhcHixNdmgUAbgOGoybG24l3DKwywI+dZhyDaMrQ83IwWpXq
	xYS1/G1o=
X-Gm-Gg: ASbGnctzDuT6SwY4LhJNjWrdK2lAOZl824lCiFwP4Sh/R9PIMmG+H4HEVnMEKcPaqUU
	FtPq2VEvGccG9e8gqBRlVNx03FTSPSHKBzbEnDFnhWXyH47eGDWu2fDNIkTe1ZuksNYOxD4puBE
	Vp2jtj0vcfbgnV/VlsyO4t6KiT0A9yc++Jz2dQQQ7YyFufIKffpVRUjUGVeZO3JTnz5Ua5C0Auk
	7BGiOIiE/OXO+qX5v8AZxfTGA6GVs5GNuScWuFZmfgGLuzaJgy1o/vY4zBFEDJuqOAsc51ZSHjy
	llxzJSbyMyp/WC03sN2GLGx5FhXNGaMVmgo+cSR7N09hpMl4BY0itmaldbLe
X-Google-Smtp-Source: AGHT+IHTutHePoysGpxZsOPgKbbegSZRp1NNHCZCZ3DEAcLjya2vTKpfVY2DnsnGhoEdBoFuhmwPoA==
X-Received: by 2002:a5d:64ed:0:b0:3a3:6a9a:5ebf with SMTP id ffacd0b85a97d-3a531cabb5cmr10875439f8f.20.1749483218204;
        Mon, 09 Jun 2025 08:33:38 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452137277basm115728695e9.32.2025.06.09.08.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 08:33:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 09 Jun 2025 16:32:38 +0100
Subject: [PATCH 1/4] spi: spi-fsl-dspi: Clear completion counter before
 initiating transfer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-james-nxp-spi-dma-v1-1-2b831e714be2@linaro.org>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
In-Reply-To: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
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
 drivers/spi/spi-fsl-dspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 863781ba6c16..386a17871e79 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -983,11 +983,13 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
 			status = dspi_dma_xfer(dspi);
 		} else {
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


