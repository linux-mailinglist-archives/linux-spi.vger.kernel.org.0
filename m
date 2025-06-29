Return-Path: <linux-spi+bounces-8861-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F6AAECBB9
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 10:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60636189372F
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 08:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7300820E309;
	Sun, 29 Jun 2025 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U42LUMDb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE22A1E51E0;
	Sun, 29 Jun 2025 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751185438; cv=none; b=MdKvYC4GK5uNeHqlXkJvnIsI41sOFltNdZaDDncf21ILTg5EjFaqOOjlrST3K04DP2EV61CNTg/D2+YRTFGF17O2gV4gTXrRUnMd3udVhEo4Hu8/Dfm5wD/bJ6PVmzcZjunE0Qa337dAD9+uhTdJfRiebAH5M38a9//QAI8iy+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751185438; c=relaxed/simple;
	bh=9hfluPES3NJNacigLt9GPHetnqMVb+nAsHw5PVH/j0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9zzTPmsGGMwivKGPJLurEzhgMPmZOuR9Nk2OlnRSYzeorS8JRrRFo2Y3w6FuHIRwSd2ffOljC+qMDbQGkVP5TZUxalvpuOwGZF1fTST5Ot1jBc5mitwJNl0/27ihycFfe9j/gmBjLBM8k175n87aVZicMjg/hK7VeIm+zW5i+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U42LUMDb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso697719a91.1;
        Sun, 29 Jun 2025 01:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751185436; x=1751790236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mt+ql+PrjmzYyafappxb+kroF0DLVLujfMoQHbjak4k=;
        b=U42LUMDbXO7QyXhddxxLR4c4EG1YgCjSarVpqHnWid9hyFPCn3M7iPrDS5PXaozgWr
         lX/k6Et0y3s0pQjs5jWvgjdUk/aYBjwQDyQeReEwosIzqUmL9HO9NIbVxTA6lw4iyY72
         tPRf8Ux0z8Ucr+yEt7c9Op8Mvz5QQXEjcYFSsQ4fwzzexqBRuWL1uzmqi58jfGO6xM+y
         krvOgYHmGdGJDd1qhWtPCsa1gUvT1UBKCScbg4d+7QxiVrhxaB0n+t4q1n1p5bwBR2mI
         R3h/9I1cq85vzrDvTaL6BTMJCFiRfk5IWwQISJy0ztgiAVM/SiE9525FjjdIWBr7Q165
         T9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751185436; x=1751790236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mt+ql+PrjmzYyafappxb+kroF0DLVLujfMoQHbjak4k=;
        b=qvSPVyOLLKOyT0j75sOB9CldHO06ebq6zeNhI/3BRLNEJBmvKwDBv9Ox2uSYH1wMzC
         s72nP4H/0nSvrZHgNHo/gUzH7PQRCdjTfWJA94HI2dQocl+OBZ3abi/1MGYmSAf7WGwO
         ruvliK+DSdMMiJRcpe762K22U5X60cJhqiXFIlVNZv8k13ge0V66unFOK1XyV6Utjw1K
         n5cGgENXZnb3QZv9nRexnbvAfA338v/g2ZWleUcJCfYX/l86oQWeDhJ6Ag6sqUyyN3h0
         kQnvjekqD1w89OOEfnSJqOQVO0oCxt/QLtgZnQU5qcG5195T+RHT7E0zWcmzMSjgrjcr
         /C7g==
X-Forwarded-Encrypted: i=1; AJvYcCUirEiO/S56JDoZO1BcldZYJ51Dvqz8MiOWpLiPpfr7f/ObGoiRLuYJEwSWhy7SDfQ0hpvfh9FZsaa9@vger.kernel.org, AJvYcCVYnjE/mVIh39DjqYVDHvvjZR21L+Bf0kCieJCUd1WPeLgEs8cYfb3oT+6aecLSVC2Ted2Pb3EiK59y@vger.kernel.org, AJvYcCXXDVMmgkcR7RrEcJgcxk9Gakfc9PL15tOhqn9MAh/WXGT1+jh836JKlpFgs5uiXDO0RAfTMOeuRyB99MNK@vger.kernel.org
X-Gm-Message-State: AOJu0YznPJLwXtPnfVCJgU8RCvkn6tLFFic2tIT/gUBMlEhPgI/iUhSR
	G0en8GHkrMJ3QEvY1ny0WH8Pi3KonX4fSFJS7ly2/cKswjx/dKbIC982SzP7jEUOFi8=
X-Gm-Gg: ASbGncuu0hOnyN4M9/BQi5vejqhkIAgTvUXrrByEqgQQPLK271fdC36LsKA59/yPGRi
	3CjXMq5+k8l7/DAy/lk4NIgULkIzn/wZAu5Tnny5Dg/HWQeyAMB1P36T7vv1ujKcPigVGpZ4mNe
	8YyTWdhap4EBH1LlEOLW8hQ3VtOJGf9FLuLNCSkYOXRPyKkVu9E+P4knzL4G9EuEYYRlMUAxR/Y
	SGwyNWvM2mTIqBHbzDso2gXXRRxSy6DfWRNLjvqgfb2t4JNRoUUf57OaV0TDpylqIoRzmNrHGln
	8WpNzCBa+0LZMKfGpAhOeawoyBgpUhnmw9bJzn6NseSPWsbVl8AuXQ==
X-Google-Smtp-Source: AGHT+IGHSGmVXaH1qzRx8krEwxIKwAdC/CaF24fxPdx796M/L8k62EbYQxOG2adPibF6rWxhZKMrig==
X-Received: by 2002:a17:90b:2f88:b0:311:ba32:164f with SMTP id 98e67ed59e1d1-318c9223bc9mr14517657a91.8.1751185435487;
        Sun, 29 Jun 2025 01:23:55 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1000::168a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f542661asm10495839a91.26.2025.06.29.01.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 01:23:55 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Sun, 29 Jun 2025 16:23:12 +0800
Subject: [PATCH v3 3/4] spi: spi-sg2044-nor: Fix reading bytes issue on
 SG2042
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250629-sfg-spifmc-v3-3-28db1f27e999@gmail.com>
References: <20250629-sfg-spifmc-v3-0-28db1f27e999@gmail.com>
In-Reply-To: <20250629-sfg-spifmc-v3-0-28db1f27e999@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Longbin Li <looong.bin@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751185413; l=1655;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=9hfluPES3NJNacigLt9GPHetnqMVb+nAsHw5PVH/j0c=;
 b=R3LSjxSyIuRG9w/LW3zvpCkqpEFDEkeviRHy6Y1wZb2EF5IOFZcZRrcTpA9XenOZVYr94SeIF
 alftbtOoyPEBBnhJa3VJMdnFzrtAvre4ooQIwpIt9DDaVZahZFOQDcW
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

SG2042 spi flash controller specification[1] states that:
> For Receive, an interrupt and DMA request are generated
> when the number of valid bytes in the FIFO is greater than
> or equal to the number of bytes defined by FFTrgLvl.

Auto-detecting flash with SFDP only requires reading 4 bytes
in spi_nor_check_sfdp_signature().
Because of that, no interrupt is triggered and a timeout happens instead.
Since we want to reuse this driver for SG2042, setting FFTrgLvl to a value
which is less than or equal to 4 should solve the issue.

Link: https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/SPI-flash.rst [1]
Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 drivers/spi/spi-sg2044-nor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
index 09a5712822e32c9da818684e7010b70aa94ae347..c1fe43e09c549328c0d046fc95bed130083dbbcb 100644
--- a/drivers/spi/spi-sg2044-nor.c
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -485,8 +485,14 @@ static const struct sg2044_spifmc_chip_info sg2044_chip_info = {
 	.rd_fifo_int_trigger_level = SPIFMC_TRAN_CSR_FIFO_TRG_LVL_8_BYTE,
 };
 
+static const struct sg2044_spifmc_chip_info sg2042_chip_info = {
+	.has_opt_reg = false,
+	.rd_fifo_int_trigger_level = SPIFMC_TRAN_CSR_FIFO_TRG_LVL_1_BYTE,
+};
+
 static const struct of_device_id sg2044_spifmc_match[] = {
 	{ .compatible = "sophgo,sg2044-spifmc-nor", .data = &sg2044_chip_info },
+	{ .compatible = "sophgo,sg2042-spifmc-nor", .data = &sg2042_chip_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sg2044_spifmc_match);

-- 
2.49.0


