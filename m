Return-Path: <linux-spi+bounces-9262-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 974C4B1821D
	for <lists+linux-spi@lfdr.de>; Fri,  1 Aug 2025 15:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B4318833CD
	for <lists+linux-spi@lfdr.de>; Fri,  1 Aug 2025 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1315236457;
	Fri,  1 Aug 2025 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yrapqs/M"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1A31798F
	for <linux-spi@vger.kernel.org>; Fri,  1 Aug 2025 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053461; cv=none; b=CA2nleRq34BGC4jzk86+YZBJB2iclyRKtSa1ErfYyWX65UvkDXcf+cdPnxMQnLSHVwsN9Aj/fb3DdVMo3cmx17E1K7BBFSw4dbTgwbi+O/7FkSNmjKfb6iuNs5igqPIZRDanrAA4BfvoAC1/xh6FEbYw+hnNcPw1Ihu/uISJQjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053461; c=relaxed/simple;
	bh=T9hyIeYye3d9Hl6lTOS+tCZwciGog+jI2NNkKQW3LG8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AfVl31Kmy1G93MUJz5WYu2ezRfw9QVheZNOixhMp2OkATMcTA4WU/yZG+3smRNO8+ng3Vx+uqkbJhpEZgDCspZmXG9TYdRWJy7eIIDWPFP/eXb6IiAx7vuUcJLpjZOkXL1qqU1uvDQ8p7FiBOZ8xwDR00JlbAwUjmnvix1ePPWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yrapqs/M; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b7825e2775so1377635f8f.2
        for <linux-spi@vger.kernel.org>; Fri, 01 Aug 2025 06:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754053456; x=1754658256; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUSYOILDQLOqm3Jp5VBECuVpBi3LVOVdI7HglhfyqwQ=;
        b=Yrapqs/MWyARK3c/DzOLgXS172rsChBa/OSaVTSrO0U6Wsc+qeslEHjxiei6Fz7yDI
         bPWGyMrOCxuQxuQ9MxzMOR6vMG3e0LlsAfGBsFRbKa7tAp/rkrJmdH1vSZDe44rtc4mz
         lE0syqRqmBmVIzKjvji00BT4y/6asH5lBOeBndPH13SBxslLcUGw/vApmyvweKBdh5bf
         1c/zvDPKBFX8YibZxsE3HOGtuBp1WSWKGEQ93kPOaGEsimqd4YU5lvolwJMJDSGbLVVB
         qYIgW1IbJmqArChcjXQUPaZwc7e/NNBR/NXt5ETz5THWTJnouq6MFEJMSyHN0+FlKOzH
         BE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754053456; x=1754658256;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nUSYOILDQLOqm3Jp5VBECuVpBi3LVOVdI7HglhfyqwQ=;
        b=tBm3f1hXqZG7dacUDpTbi0bpyaTYVL9sIpWjf0yGH/EN450dNnFMV4EKoYzmPjKC2S
         51qR6cTUBmNrMCGRQV9sxGlD81ngnR7FuDZd705leJaWdcp61BGq1B84P93bTQqJiGzM
         0z7AbsyJKY/8mzOvb3NkDXe4FB1avkpw5s9xR3RexWpdif5RknPZBFdveKuzDgn0uUBD
         AJZQnMZ3wJG4NTZ5+47jcJ3cudXc0CXSqYaXcEpgJ0YskzDWcU/nQcCe2vPu9cR2EbW4
         twtf1aMAXh4NlFN09x3X40B3SoQ/njFoqzgydwGgSBX24QzIrFgo1DZMsLZy7bN6zL/m
         cJmw==
X-Forwarded-Encrypted: i=1; AJvYcCX+eKsG17EMA92WC8HjeBW1qdfr0vCUEWsl1tEoxKg9T/O7pXqmfWNCBarjsQV+GosGW9alVvamGvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytkrjCPhH7JCl/sMhY6NlT4X10h7dHcp1hAfEl5ucKozNouo7x
	I4ereDTHuJekGU+43un7XqL9YRxkmzBpfLfGgunR7EjcM0aOpfeBdTzTyflHNyBrCtI=
X-Gm-Gg: ASbGnctNZ9XsT25Z1ceOCT6wYXB/Vugbkzta9D3a6HUPejkB7YURY7wo2eOFCoKT7Cv
	d0qQG8U8eHWk3ENpPEOXm1ZDf2OC3bhMGt101XXa/Q63PygYFpk/P8CpNb292IkXIPhWMDhgDfH
	JQN0LedO7Cev0rnA0GIi/MlDyFoiQd/qbgWjo/eeaUbUQTsjREjEJnF8ZGA0Bq1vwW9FqStliRN
	7BYdtIh2Ysg0wVkX311U5JlPblUDHK2QOyIu7G+Mf6eE0IwB2mPZo3TfB63FZ1w/5fGOi0028AU
	ssr9iFBByBd8sWUnmI+u8l/dE5ugDkCs8e9TzWLMXRwC6RP+84fn7DW4bafGROsBC3GNGkE/SwR
	yJ/EwJ64K917h5k8zxQbL9yQnem4=
X-Google-Smtp-Source: AGHT+IHpDgWolR8XIipY+aOHmaz5kNZzJI/RRwdtHRCBa4uOijtBoftGHDMG4/QsqTSDwHF72vlpZg==
X-Received: by 2002:a05:6000:2013:b0:3b7:94c3:277d with SMTP id ffacd0b85a97d-3b8d344703cmr2151657f8f.20.1754053455897;
        Fri, 01 Aug 2025 06:04:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c453c75sm5909716f8f.41.2025.08.01.06.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:04:15 -0700 (PDT)
Date: Fri, 1 Aug 2025 16:04:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sunny Luo <sunny.luo@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [bug report] spi: Add Amlogic SPISG driver
Message-ID: <aIy7TOKt1_sdIfcH@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Sunny Luo,

Commit cef9991e04ae ("spi: Add Amlogic SPISG driver") from Jul 18,
2025 (linux-next), leads to the following Smatch static checker
warning:

	drivers/spi/spi-amlogic-spisg.c:764 aml_spisg_probe()
	warn: missing unwind goto?

drivers/spi/spi-amlogic-spisg.c
    716 static int aml_spisg_probe(struct platform_device *pdev)
    717 {
    718         struct spi_controller *ctlr;
    719         struct spisg_device *spisg;
    720         struct device *dev = &pdev->dev;
    721         void __iomem *base;
    722         int ret, irq;
    723 
    724         const struct regmap_config aml_regmap_config = {
    725                 .reg_bits = 32,
    726                 .val_bits = 32,
    727                 .reg_stride = 4,
    728                 .max_register = SPISG_MAX_REG,
    729         };
    730 
    731         if (of_property_read_bool(dev->of_node, "spi-slave"))
    732                 ctlr = spi_alloc_target(dev, sizeof(*spisg));
    733         else
    734                 ctlr = spi_alloc_host(dev, sizeof(*spisg));
    735         if (!ctlr)
    736                 return dev_err_probe(dev, -ENOMEM, "controller allocation failed\n");
    737 
    738         spisg = spi_controller_get_devdata(ctlr);
    739         spisg->controller = ctlr;
    740 
    741         spisg->pdev = pdev;
    742         platform_set_drvdata(pdev, spisg);
    743 
    744         base = devm_platform_ioremap_resource(pdev, 0);
    745         if (IS_ERR(base))
    746                 return dev_err_probe(dev, PTR_ERR(base), "resource ioremap failed\n");

This should be goto out_controller

    747 
    748         spisg->map = devm_regmap_init_mmio(dev, base, &aml_regmap_config);
    749         if (IS_ERR(spisg->map))
    750                 return dev_err_probe(dev, PTR_ERR(spisg->map), "regmap init failed\n");
    751 
    752         irq = platform_get_irq(pdev, 0);
    753         if (irq < 0) {
    754                 ret = irq;
    755                 goto out_controller;
    756         }
    757 
    758         ret = device_reset_optional(dev);
    759         if (ret)
    760                 return dev_err_probe(dev, ret, "reset dev failed\n");

Same

    761 
    762         ret = aml_spisg_clk_init(spisg, base);
    763         if (ret)
--> 764                 return dev_err_probe(dev, ret, "clock init failed\n");

Same.

    765 
    766         spisg->cfg_spi = 0;
    767         spisg->cfg_start = 0;
    768         spisg->cfg_bus = 0;
    769 
    770         spisg->cfg_spi = FIELD_PREP(CFG_SFLASH_WP, 1) |
    771                          FIELD_PREP(CFG_SFLASH_HD, 1);
    772         if (spi_controller_is_target(ctlr)) {
    773                 spisg->cfg_spi |= FIELD_PREP(CFG_SLAVE_EN, 1);
    774                 spisg->cfg_bus = FIELD_PREP(CFG_TX_TUNING, 0xf);
    775         }
    776         /* default pending */
    777         spisg->cfg_start = FIELD_PREP(CFG_PEND, 1);
    778 
    779         pm_runtime_set_active(&spisg->pdev->dev);
    780         pm_runtime_enable(&spisg->pdev->dev);
    781         pm_runtime_resume_and_get(&spisg->pdev->dev);
    782 
    783         ctlr->num_chipselect = 4;
    784         ctlr->dev.of_node = pdev->dev.of_node;
    785         ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST |
    786                           SPI_3WIRE | SPI_TX_QUAD | SPI_RX_QUAD;
    787         ctlr->max_speed_hz = 1000 * 1000 * 100;
    788         ctlr->min_speed_hz = 1000 * 10;
    789         ctlr->setup = aml_spisg_setup;
    790         ctlr->cleanup = aml_spisg_cleanup;
    791         ctlr->prepare_message = aml_spisg_prepare_message;
    792         ctlr->transfer_one_message = aml_spisg_transfer_one_message;
    793         ctlr->target_abort = aml_spisg_target_abort;
    794         ctlr->can_dma = aml_spisg_can_dma;
    795         ctlr->max_dma_len = SPISG_BLOCK_MAX;
    796         ctlr->auto_runtime_pm = true;
    797 
    798         dma_set_max_seg_size(&pdev->dev, SPISG_BLOCK_MAX);
    799 
    800         ret = devm_request_irq(&pdev->dev, irq, aml_spisg_irq, 0, NULL, spisg);
    801         if (ret) {
    802                 dev_err(&pdev->dev, "irq request failed\n");
    803                 goto out_clk;
    804         }
    805 
    806         ret = devm_spi_register_controller(dev, ctlr);
    807         if (ret) {
    808                 dev_err(&pdev->dev, "spi controller registration failed\n");
    809                 goto out_clk;
    810         }
    811 
    812         init_completion(&spisg->completion);
    813 
    814         pm_runtime_put(&spisg->pdev->dev);
    815 
    816         return 0;
    817 out_clk:
    818         if (spisg->core)
    819                 clk_disable_unprepare(spisg->core);
    820         clk_disable_unprepare(spisg->pclk);
    821 out_controller:
    822         spi_controller_put(ctlr);
    823 
    824         return ret;
    825 }

regards,
dan carpenter

