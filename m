Return-Path: <linux-spi+bounces-8823-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB9DAEBB9D
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 17:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1076617C2DC
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 15:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B352E8DF1;
	Fri, 27 Jun 2025 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mm/EsKR7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3242980BF
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751037924; cv=none; b=MRnwQE82uT1Vda8psS9Zb4ydb1ShWWtGXb3Vynr/8/ehXgJTDCv2Kic6a1vGVuqJvzzmGQmBt4M8ec4dkKcnzoUqepvPP0w07ioa9ZsyfzD/R4wr+MAy86hv0OoKwKd5lQjHcz94b/ZBFhdOBP417IZDZudzw6Lb+Ix5d/93aeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751037924; c=relaxed/simple;
	bh=PPP9dYyOg8N2Au2CCDUbGXRJ5XeaAvBQwjH9ODIo3k4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lM7PapGty3GV5tfLQfvAoMTbfVfIpMM+a1DpXs5OjKmYWF6dZMhQ5qZ2VAayPNhGNLDkxgZjuDxrgo65Xe/E1/NUIkUuJsI3ydG0dX+BB5AHJm4vBdPDoHJeUBP97fXTh1zr+fG3CO7ZEghlqqWIpWsfQf4cJNxevFsdgeJ8c1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mm/EsKR7; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-40a4bf1ebb7so10417b6e.0
        for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 08:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751037922; x=1751642722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GL305iW8U70/WbPcKPNqjt0qQFBTkqtisgtq1PzurQ=;
        b=Mm/EsKR7oNzyKnvR576soaIO2Xmst8rjmNCWo6Koh/eCDu8fS9aQa/YFjElqAPx4T1
         q6JfUAc2W6z1pWy+dH9op/uUMqlo6AJmFrppPmFrYifRXtuP93TYRuTVkc4K/Qn9czPl
         3kquyTJXsz3hw7YonxCcMBtx0qoPjpO21laHCCDLYsafL5BmAz751YvdVlPmm7BqzBmW
         qORbx/NFWMuE+KiDAIsgBJ5MnPRYfZXiVZR/dxTGdfOvO7eaPdLJZNQt5cw/7AR75IYY
         EJZo5RJ2c3xQ2OCGnh9l0H0Ykv0cQ8vQMbv9xvHbCd31B+/PELgEhl4x/klNcsvtlwFG
         lswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751037922; x=1751642722;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GL305iW8U70/WbPcKPNqjt0qQFBTkqtisgtq1PzurQ=;
        b=sfMtA+b6PBBqg+20ao6ix6cKYvAZhCFjHVwb0D4DJuyhpsosJBWb8T9fZloc3DpXVU
         SoNfDxX/2wCtyAPKsqcDeM4KwQa4BuLPsm6WINMGXrhMUnW1qpx7RMK4vIJ3YNSnHVLf
         vpsmzezouVYtG32dKgTEGnl6ZgjoSbrL2u0UezZLYJw/6cPpd4aZnO0BYZ728zHrFck2
         e25f1weMqH0O0CuX2AYOJQspoMbwSMRTVtTWafu5+ccUKUTB3SUCpFlo9rHDHxxJO49K
         3lChHrm+2WpCguYbKXsFrSF4qliJEvov0ZjmAJcrD5a3o4LUmahJRfvdZfFCY6zU1kHK
         I+uA==
X-Gm-Message-State: AOJu0YwMYXxb8EFcTm4xEp5n0ng7mXR59fIuIoryRgPEnsavtW0itaPn
	+XOY/rYpyTROl53QMGMqLBYm4K7h4/7k7Zctydh2XPQKpfGYflm+FGqhFBlPItlc5uFWU2fhDiB
	0linjHQY=
X-Gm-Gg: ASbGnctKN0gy2LnFnQ4ob6HiRDedOPOoYX4ApN/vtpYQzwBytVwyYcbB89xGIYW/0Pf
	sn4r5D2TgudqX2Xibe7z7JC7f9K2FQjH2hOcYeQlor4q/CHpTo/4bHPZKDr/hq5eefy33gKdeez
	dS3ZPegHXOzUrCobMYrASAFSHhdwU24HKtZqmhBnB3BJlwgvjgY59G6NmtPl7ZgAcpsLWNnOfGp
	VclBM2GqofHZmJS+GDsLO96WbbIIPC6NnloMplR6X4Jm14E0uVRyRKI47g6/IRgLYPI2IyOe8X6
	ztt3XN+oHK2odNLRo93l996h/A8oeVvX9f/Vs58Gug5kQziDyxn4zSJ0OHAfEVoK6TVPcQ==
X-Google-Smtp-Source: AGHT+IHAUxWWr1y1uxwbsFaIwnq5meydtkfKIk/oo6bIi9Yb+hIAOaEx1JrFYQ6LwNKvCWxfR4SIzQ==
X-Received: by 2002:a05:6808:1902:b0:3fa:3a0:137b with SMTP id 5614622812f47-40b33e37050mr3123295b6e.29.1751037922100;
        Fri, 27 Jun 2025 08:25:22 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:e9c1:9891:4bfd:dadf])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-40b3243dc52sm388059b6e.46.2025.06.27.08.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:25:21 -0700 (PDT)
Date: Fri, 27 Jun 2025 10:25:19 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Cc: linux-spi@vger.kernel.org
Subject: [bug report] spi: stm32: use STM32 DMA with STM32 MDMA to enhance
 DDR use
Message-ID: <ef580688-54a0-44c0-8de0-25303bb021a0@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Clément Le Goffic,

Commit d17dd2f1d8a1 ("spi: stm32: use STM32 DMA with STM32 MDMA to
enhance DDR use") from Jun 16, 2025 (linux-next), leads to the
following Smatch static checker warning:

	drivers/spi/spi-stm32.c:2489 stm32_spi_probe()
	error: we previously assumed 'spi->sram_pool' could be null (see line 2432)

drivers/spi/spi-stm32.c
    2428         if (spi->dma_tx || spi->dma_rx)
    2429                 ctrl->can_dma = stm32_spi_can_dma;
    2430 
    2431         spi->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram", 0);
    2432         if (spi->sram_pool) {

spi->sram_pool can be NULL

    2433                 spi->sram_rx_buf_size = gen_pool_size(spi->sram_pool);
    2434                 dev_info(&pdev->dev, "SRAM pool: %zu KiB for RX DMA/MDMA chaining\n",
    2435                          spi->sram_rx_buf_size / 1024);
    2436                 spi->sram_rx_buf = gen_pool_dma_zalloc(spi->sram_pool, spi->sram_rx_buf_size,
    2437                                                        &spi->sram_dma_rx_buf);
    2438                 if (!spi->sram_rx_buf) {
    2439                         dev_err(&pdev->dev, "failed to allocate SRAM buffer\n");
    2440                 } else {
    2441                         spi->mdma_rx = dma_request_chan(spi->dev, "rxm2m");
    2442                         if (IS_ERR(spi->mdma_rx)) {
    2443                                 ret = PTR_ERR(spi->mdma_rx);
    2444                                 spi->mdma_rx = NULL;
    2445                                 if (ret == -EPROBE_DEFER) {
    2446                                         goto err_pool_free;
    2447                                 } else {
    2448                                         gen_pool_free(spi->sram_pool,
    2449                                                       (unsigned long)spi->sram_rx_buf,
    2450                                                       spi->sram_rx_buf_size);
    2451                                         dev_warn(&pdev->dev,
    2452                                                  "failed to request rx mdma channel, DMA only\n");
    2453                                 }
    2454                         }
    2455                 }
    2456         }
    2457 
    2458         pm_runtime_set_autosuspend_delay(&pdev->dev,
    2459                                          STM32_SPI_AUTOSUSPEND_DELAY);
    2460         pm_runtime_use_autosuspend(&pdev->dev);
    2461         pm_runtime_set_active(&pdev->dev);
    2462         pm_runtime_get_noresume(&pdev->dev);
    2463         pm_runtime_enable(&pdev->dev);
    2464 
    2465         ret = spi_register_controller(ctrl);
    2466         if (ret) {
    2467                 dev_err(&pdev->dev, "spi controller registration failed: %d\n",
    2468                         ret);
    2469                 goto err_pm_disable;
    2470         }
    2471 
    2472         pm_runtime_mark_last_busy(&pdev->dev);
    2473         pm_runtime_put_autosuspend(&pdev->dev);
    2474 
    2475         dev_info(&pdev->dev, "driver initialized (%s mode)\n",
    2476                  STM32_SPI_HOST_MODE(spi) ? "host" : "device");
    2477 
    2478         return 0;
    2479 
    2480 err_pm_disable:
    2481         pm_runtime_disable(&pdev->dev);
    2482         pm_runtime_put_noidle(&pdev->dev);
    2483         pm_runtime_set_suspended(&pdev->dev);
    2484         pm_runtime_dont_use_autosuspend(&pdev->dev);
    2485 
    2486         if (spi->mdma_rx)
    2487                 dma_release_channel(spi->mdma_rx);
    2488 err_pool_free:
--> 2489         gen_pool_free(spi->sram_pool, (unsigned long)spi->sram_rx_buf, spi->sram_rx_buf_size);
                               ^^^^^^^^^^^^^^
Unchecked dereference.

    2490 err_dma_release:
    2491         if (spi->dma_tx)
    2492                 dma_release_channel(spi->dma_tx);
    2493         if (spi->dma_rx)
    2494                 dma_release_channel(spi->dma_rx);
    2495 err_clk_disable:
    2496         clk_disable_unprepare(spi->clk);
    2497 
    2498         return ret;
    2499 }

regards,
dan carpenter

