Return-Path: <linux-spi+bounces-9271-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8FBB19D6D
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 10:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94A51899929
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 08:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8CF23ABAB;
	Mon,  4 Aug 2025 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D6/rmPVL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317D23C511
	for <linux-spi@vger.kernel.org>; Mon,  4 Aug 2025 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295251; cv=none; b=eMgjfsPF4SSl80BDIkY0b0zRs2iZoqnfxz+D1WuXZMfiB2Jn/+AsqW8m3DMKv5dXNsoUU5YAGjs96U0Kan9vF6FQ6PxtdI2piYnAXqwKZkPOvgx56a/aUEo86W6uMVHjWUPMEWhfJMAs7JXCqumEhJJBQByPUa3zUcZJ2CtAue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295251; c=relaxed/simple;
	bh=pptH2NH4Z3zkGfNYWBXszyOjxuBjuXDQlq3svK2Ozq4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UafP1Ql28rYkjbj5ffp0158T348X+oA+aEdTktvoe0kPv+QOP/jhAcILpaZBnY/k8d8OEfi39dq39ks5m4GPnToyaZruehInem1p9zJkY1N5qhU6FpxOGuHnbwwFxrkyQQUpcZtGKdpi7eMI7ZGJhZxxjAZfH3jpfsZjE3OX9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D6/rmPVL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so28200665e9.1
        for <linux-spi@vger.kernel.org>; Mon, 04 Aug 2025 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754295247; x=1754900047; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aIs0VZsx9ne5+u8erw4jNU+9U75wvlH5jVml9RCdY5w=;
        b=D6/rmPVLC5wD8GwEDBVlv5jyNitufsYizvkJZ1cctJN+sxvuBn18yNNwFYn4aLLPaU
         7uLelwawHK1BUiO72cHQj38TmpKbA0i5eACWqRbLEib30C/y7yxJUO8qCI89bEfKzfCi
         /3Ibg2+npyg9s75FPiO5zxFM5RTt5B9nJhAoEFEAJtNcOeQS0wpV7I8L8SIQWTzVzkwz
         K5AHkBuTmeeOgWtQEwhv8sUiEQWIU6sI8X0dMZtM7kff/R0iHJAOPe0u0kGWdaE/xBRn
         v72LIOsRqEAhyKSjCjTwmB0enAgoYmf7I6Q9wQu0+hXnlSD8Bd9q3aprBmZGMbxTCSlj
         0Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754295247; x=1754900047;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIs0VZsx9ne5+u8erw4jNU+9U75wvlH5jVml9RCdY5w=;
        b=vPpfLJqhBayUOdHcv3/CZwJUW3cmDmbtDtfy7WwIECfd4YORa/gzegEjv+GQ2UwgFx
         XWlgwO5rDoPv4lgad7JnHEKDKdaeBgaV03mxRhsyGSTJZ7MKKgDhJ5S4tAjEA4s8EhtE
         r9roqOdrvO08Bx4N3qYZMN8HaiB6S5bTaukvpYuRl0ZWifQMigf3QP1gUzKc9Oa7Tap/
         kD/c4D5Wm9D3/ZT6yo07PTMh455YcKaP9dVrL4kLq7//d8+r6EhKqI3bJbD1554O1U7W
         /otKSknFCWZlhVJhgjhShQymaMJyvSLF+XoBROD7uVdP9TF5w/5QZgf4LtCPmYASf4jY
         zM3A==
X-Forwarded-Encrypted: i=1; AJvYcCUsL+TIo2pbHH+5TPk3GGUGhsu6MnOCrx8BQqyAEfzBLxxG3Nca5N3TTCQJD5aPYnscaWpK9Hb4rAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoktFXFrShPxGwLEqwyAF7G6ay5A5rrJX5jcVhJt/QEhZxD9UG
	zNLEJpKQQxPvdCEK5Oi6wqN9605eQ1gBW53LgkKdluH5gHf+YWRnnLsAE8lfrm84bdJ+o+IZZHx
	bwj5l
X-Gm-Gg: ASbGncua6qzZUgVDpNWf+LXdWJa57CCvP6fG4sHodVsq36xmJ8Saqs7wtCeBGcTNpDh
	D9TD54+goypdHmZZlUxm+FT3FFNevsGpz5Ovc5WRqC7K122nYCSUDPjmQkObefxay04GEsmy8qQ
	esTSpqiQCvR3zyifW+QVRCVv27o71Xhdp+B9cWaIWGZq9muJAsUv0mf7GhVyDR5ekroFNy6nnvR
	5pL2wAaMJaRPxLk2pV2b/nIgI+FbfbxrYBKB45mpywfn7smsBqB5GXfHdWGLLf2qHbbK02PZF4I
	VCKJYVW5lG0nOyG8iV4S7R/3guBWc6YAUlA9sglcAKOdFkjws7bO4KXIgLm08KPuRijkr0Lq90D
	MDuTb7242pOMfsuHB5eUYhn3KUo0=
X-Google-Smtp-Source: AGHT+IEeeJkFKsl7/38jlJguNroD6DzRmQgXbAi7gRxUyE2DHkd/n/ytZVazRk0tnMc3kTWnIPGKwQ==
X-Received: by 2002:a05:600c:a01:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-458b6b57100mr61139955e9.30.1754295245801;
        Mon, 04 Aug 2025 01:14:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4589ee4f239sm156065575e9.21.2025.08.04.01.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 01:14:05 -0700 (PDT)
Date: Mon, 4 Aug 2025 11:14:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sunny Luo <sunny.luo@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [bug report] spi: Add Amlogic SPISG driver
Message-ID: <aJBryDMreHB9dI_i@stanley.mountain>
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

	drivers/spi/spi-amlogic-spisg.c:314 aml_spisg_setup_transfer()
	error: we previously assumed 'exdesc' could be null (see line 261)

drivers/spi/spi-amlogic-spisg.c
    248 static int aml_spisg_setup_transfer(struct spisg_device *spisg,
    249                                     struct spi_transfer *xfer,
    250                                     struct spisg_descriptor *desc,
    251                                     struct spisg_descriptor_extra *exdesc)
    252 {
    253         int block_size, blocks;
    254         struct device *dev = &spisg->pdev->dev;
    255         struct spisg_sg_link *ccsg;
    256         int ccsg_len;
    257         dma_addr_t paddr;
    258         int ret;
    259 
    260         memset(desc, 0, sizeof(*desc));
    261         if (exdesc)
                    ^^^^^^
Checked for NULL

    262                 memset(exdesc, 0, sizeof(*exdesc));
    263         aml_spisg_set_speed(spisg, xfer->speed_hz);
    264         xfer->effective_speed_hz = spisg->effective_speed_hz;
    265 
    266         desc->cfg_start = spisg->cfg_start;
    267         desc->cfg_bus = spisg->cfg_bus;
    268 
    269         block_size = xfer->bits_per_word >> 3;
    270         blocks = xfer->len / block_size;
    271 
    272         desc->cfg_start |= FIELD_PREP(CFG_EOC, 0);
    273         desc->cfg_bus |= FIELD_PREP(CFG_KEEP_SS, !xfer->cs_change);
    274         desc->cfg_bus |= FIELD_PREP(CFG_NULL_CTL, 0);
    275 
    276         if (xfer->tx_buf || xfer->tx_dma) {
    277                 desc->cfg_bus |= FIELD_PREP(CFG_LANE, nbits_to_lane[xfer->tx_nbits]);
    278                 desc->cfg_start |= FIELD_PREP(CFG_OP_MODE, SPISG_OP_MODE_WRITE);
    279         }
    280         if (xfer->rx_buf || xfer->rx_dma) {
    281                 desc->cfg_bus |= FIELD_PREP(CFG_LANE, nbits_to_lane[xfer->rx_nbits]);
    282                 desc->cfg_start |= FIELD_PREP(CFG_OP_MODE, SPISG_OP_MODE_READ);
    283         }
    284 
    285         if (FIELD_GET(CFG_OP_MODE, desc->cfg_start) == SPISG_OP_MODE_READ_STS) {
    286                 desc->cfg_start |= FIELD_PREP(CFG_BLOCK_SIZE, blocks) |
    287                                    FIELD_PREP(CFG_BLOCK_NUM, 1);
    288         } else {
    289                 blocks = min_t(int, blocks, SPISG_BLOCK_MAX);
    290                 desc->cfg_start |= FIELD_PREP(CFG_BLOCK_SIZE, block_size & 0x7) |
    291                                    FIELD_PREP(CFG_BLOCK_NUM, blocks);
    292         }
    293 
    294         if (xfer->tx_sg.nents && xfer->tx_sg.sgl) {
    295                 ccsg_len = xfer->tx_sg.nents * sizeof(struct spisg_sg_link);
    296                 ccsg = kzalloc(ccsg_len, GFP_KERNEL | GFP_DMA);
    297                 if (!ccsg) {
    298                         dev_err(dev, "alloc tx_ccsg failed\n");
    299                         return -ENOMEM;
    300                 }
    301 
    302                 aml_spisg_sg_xlate(&xfer->tx_sg, ccsg);
    303                 paddr = dma_map_single(dev, (void *)ccsg,
    304                                        ccsg_len, DMA_TO_DEVICE);
    305                 ret = dma_mapping_error(dev, paddr);
    306                 if (ret) {
    307                         kfree(ccsg);
    308                         dev_err(dev, "tx ccsg map failed\n");
    309                         return ret;
    310                 }
    311 
    312                 desc->tx_paddr = paddr;
    313                 desc->cfg_start |= FIELD_PREP(CFG_TXD_MODE, SPISG_DATA_MODE_SG);
--> 314                 exdesc->tx_ccsg = ccsg;
                        ^^^^^^^^
Unchecked dereference

    315                 exdesc->tx_ccsg_len = ccsg_len;
    316                 dma_sync_sgtable_for_device(spisg->controller->cur_tx_dma_dev,
    317                                             &xfer->tx_sg, DMA_TO_DEVICE);
    318         } else if (xfer->tx_buf || xfer->tx_dma) {
    319                 paddr = xfer->tx_dma;
    320                 if (!paddr) {
    321                         paddr = dma_map_single(dev, (void *)xfer->tx_buf,
    322                                                xfer->len, DMA_TO_DEVICE);
    323                         ret = dma_mapping_error(dev, paddr);
    324                         if (ret) {
    325                                 dev_err(dev, "tx buf map failed\n");
    326                                 return ret;
    327                         }
    328                 }
    329                 desc->tx_paddr = paddr;
    330                 desc->cfg_start |= FIELD_PREP(CFG_TXD_MODE, SPISG_DATA_MODE_MEM);
    331         }
    332 
    333         if (xfer->rx_sg.nents && xfer->rx_sg.sgl) {
    334                 ccsg_len = xfer->rx_sg.nents * sizeof(struct spisg_sg_link);
    335                 ccsg = kzalloc(ccsg_len, GFP_KERNEL | GFP_DMA);
    336                 if (!ccsg) {
    337                         dev_err(dev, "alloc rx_ccsg failed\n");
    338                         return -ENOMEM;
    339                 }
    340 
    341                 aml_spisg_sg_xlate(&xfer->rx_sg, ccsg);
    342                 paddr = dma_map_single(dev, (void *)ccsg,
    343                                        ccsg_len, DMA_TO_DEVICE);
    344                 ret = dma_mapping_error(dev, paddr);
    345                 if (ret) {
    346                         kfree(ccsg);
    347                         dev_err(dev, "rx ccsg map failed\n");
    348                         return ret;
    349                 }
    350 
    351                 desc->rx_paddr = paddr;
    352                 desc->cfg_start |= FIELD_PREP(CFG_RXD_MODE, SPISG_DATA_MODE_SG);
    353                 exdesc->rx_ccsg = ccsg;
    354                 exdesc->rx_ccsg_len = ccsg_len;
    355                 dma_sync_sgtable_for_device(spisg->controller->cur_rx_dma_dev,
    356                                             &xfer->rx_sg, DMA_FROM_DEVICE);
    357         } else if (xfer->rx_buf || xfer->rx_dma) {
    358                 paddr = xfer->rx_dma;
    359                 if (!paddr) {
    360                         paddr = dma_map_single(dev, xfer->rx_buf,
    361                                                xfer->len, DMA_FROM_DEVICE);
    362                         ret = dma_mapping_error(dev, paddr);
    363                         if (ret) {
    364                                 dev_err(dev, "rx buf map failed\n");
    365                                 return ret;
    366                         }
    367                 }
    368 
    369                 desc->rx_paddr = paddr;
    370                 desc->cfg_start |= FIELD_PREP(CFG_RXD_MODE, SPISG_DATA_MODE_MEM);
    371         }
    372 
    373         return 0;
    374 }

regards,
dan carpenter

