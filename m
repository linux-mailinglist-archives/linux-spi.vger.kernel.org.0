Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E9A767AC2
	for <lists+linux-spi@lfdr.de>; Sat, 29 Jul 2023 03:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjG2BXm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 21:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbjG2BXH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 21:23:07 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9458F3ABF
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 18:22:18 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9bd59d465so40450391fa.3
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 18:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690593733; x=1691198533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oELL12PocfxNRiVtdS2uJl8K6ppRmxz+NAbkW1vFqJ0=;
        b=aMz3eOACYunSzpNa5nER6jG9avA2mk5MqdnjFOImwTVaX+PK6Glg8055T6NW0Uls3J
         wFpsrR/f4c7NKEB2mTbK5dCVRfHybf4q2WaNmxvZ1E5ozVir/tAXMh39Elhx2t8hI3Oi
         5KfbYqW8IzY0+PCxhaD8fmnZItfa1pu/2L/egsh3tvH3JnJ4TTBrbr7a/vBJQaifSYVZ
         V1+8hqYi7tEkBoeZzHYgbCGreonlkzSuo56BLNnbu/nQztzLzybf49QEqh0XHzq7aC1H
         kbnXCbBO42HWAm6wq6MjOx+gwRh3tEbkuW/B54wvetX+nax73QhJ9dI8XoJyAhVuVoIU
         NOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690593733; x=1691198533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oELL12PocfxNRiVtdS2uJl8K6ppRmxz+NAbkW1vFqJ0=;
        b=Ip3oMvNStzlM9ZihMXVAp29cqZ7TR2KbI/2k5V+riI96sbSD/ucvs4jDZXEiu22kbD
         7sKbvRAxe/JEWwGhnm7XEEEu1ZabZB8mWZ8BkpU7f7G5mOYuLykUS2qvTgaNNIMlkA98
         n7DiCofMDGLOWei4vDA3ODeNPuKXrKI5XAeXkeZrlnpvYKw/K8YY6uZNao8aYXSmZacI
         3KLLu+PX5q4yjydnJzxuDf6qqLCRet5BHAEtWp4tgFhcVHCLHJ2hA9KyQE2UDzIFrQG8
         3/1gcyLIWIFjU9r5FLkkpNgFeR2JcDcXgq6+zRKjMnOJtLHfpa2XH6m5su+oQtZK5qSC
         S2tw==
X-Gm-Message-State: ABy/qLZF3GtE3Pg59vqWoSidw4C2+GcNmfA2pxwwnnrW+8P1GcCkSSGY
        1LXIIA8yFKg0QEIKYkCjtNIFyOp95Uc=
X-Google-Smtp-Source: APBJJlEcqnJ3yMHgvfXkQLmFXsvxeFya0TYgSiALzRzmlz6Tw/WNQjcuT74FgWOo6jFpTm1myOtggA==
X-Received: by 2002:a05:6512:3441:b0:4f6:29cf:c0dd with SMTP id j1-20020a056512344100b004f629cfc0ddmr2803261lfr.8.1690593732468;
        Fri, 28 Jul 2023 18:22:12 -0700 (PDT)
Received: from mobilestation ([95.79.172.181])
        by smtp.gmail.com with ESMTPSA id t26-20020ac24c1a000000b004fe202a5c7csm550933lfq.135.2023.07.28.18.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 18:22:11 -0700 (PDT)
Date:   Sat, 29 Jul 2023 04:22:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org,
        geert@linux-m68k.org, lukas@wunner.de
Subject: Re: [PATCH -next 19/21] spi: dw: switch to use modern name
Message-ID: <ocjwutgtf7m5nnrzbdcxad2td2hawlgicadt56jt6ibuebyok2@ixynxjykmztf>
References: <20230728093221.3312026-1-yangyingliang@huawei.com>
 <20230728093221.3312026-20-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728093221.3312026-20-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jul 28, 2023 at 05:32:19PM +0800, Yang Yingliang wrote:
> Change legacy name master to modern name host or controller.
> 
> No functional changed.

I thought the renaming trend got almost fully away... Anyway I have no
objections against this change as long as Mark is ok with the selected
name(s).

-Serge(y)

> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/spi/spi-dw-core.c | 112 +++++++++++++++++++-------------------
>  drivers/spi/spi-dw-dma.c  |  22 ++++----
>  drivers/spi/spi-dw-mmio.c |  10 ++--
>  drivers/spi/spi-dw.h      |   4 +-
>  4 files changed, 74 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 45f5acc26b1d..0274c9295514 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -61,7 +61,7 @@ static void dw_spi_debugfs_init(struct dw_spi *dws)
>  {
>  	char name[32];
>  
> -	snprintf(name, 32, "dw_spi%d", dws->master->bus_num);
> +	snprintf(name, 32, "dw_spi%d", dws->host->bus_num);
>  	dws->debugfs = debugfs_create_dir(name, NULL);
>  
>  	dws->regset.regs = dw_spi_dbgfs_regs;
> @@ -183,25 +183,25 @@ int dw_spi_check_status(struct dw_spi *dws, bool raw)
>  		irq_status = dw_readl(dws, DW_SPI_ISR);
>  
>  	if (irq_status & DW_SPI_INT_RXOI) {
> -		dev_err(&dws->master->dev, "RX FIFO overflow detected\n");
> +		dev_err(&dws->host->dev, "RX FIFO overflow detected\n");
>  		ret = -EIO;
>  	}
>  
>  	if (irq_status & DW_SPI_INT_RXUI) {
> -		dev_err(&dws->master->dev, "RX FIFO underflow detected\n");
> +		dev_err(&dws->host->dev, "RX FIFO underflow detected\n");
>  		ret = -EIO;
>  	}
>  
>  	if (irq_status & DW_SPI_INT_TXOI) {
> -		dev_err(&dws->master->dev, "TX FIFO overflow detected\n");
> +		dev_err(&dws->host->dev, "TX FIFO overflow detected\n");
>  		ret = -EIO;
>  	}
>  
>  	/* Generically handle the erroneous situation */
>  	if (ret) {
>  		dw_spi_reset_chip(dws);
> -		if (dws->master->cur_msg)
> -			dws->master->cur_msg->status = ret;
> +		if (dws->host->cur_msg)
> +			dws->host->cur_msg->status = ret;
>  	}
>  
>  	return ret;
> @@ -213,7 +213,7 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
>  	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
>  
>  	if (dw_spi_check_status(dws, false)) {
> -		spi_finalize_current_transfer(dws->master);
> +		spi_finalize_current_transfer(dws->host);
>  		return IRQ_HANDLED;
>  	}
>  
> @@ -227,7 +227,7 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
>  	dw_reader(dws);
>  	if (!dws->rx_len) {
>  		dw_spi_mask_intr(dws, 0xff);
> -		spi_finalize_current_transfer(dws->master);
> +		spi_finalize_current_transfer(dws->host);
>  	} else if (dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR)) {
>  		dw_writel(dws, DW_SPI_RXFTLR, dws->rx_len - 1);
>  	}
> @@ -248,14 +248,14 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
>  
>  static irqreturn_t dw_spi_irq(int irq, void *dev_id)
>  {
> -	struct spi_controller *master = dev_id;
> -	struct dw_spi *dws = spi_controller_get_devdata(master);
> +	struct spi_controller *host = dev_id;
> +	struct dw_spi *dws = spi_controller_get_devdata(host);
>  	u16 irq_status = dw_readl(dws, DW_SPI_ISR) & DW_SPI_INT_MASK;
>  
>  	if (!irq_status)
>  		return IRQ_NONE;
>  
> -	if (!master->cur_msg) {
> +	if (!host->cur_msg) {
>  		dw_spi_mask_intr(dws, 0xff);
>  		return IRQ_HANDLED;
>  	}
> @@ -408,11 +408,11 @@ static int dw_spi_poll_transfer(struct dw_spi *dws,
>  	return 0;
>  }
>  
> -static int dw_spi_transfer_one(struct spi_controller *master,
> +static int dw_spi_transfer_one(struct spi_controller *host,
>  			       struct spi_device *spi,
>  			       struct spi_transfer *transfer)
>  {
> -	struct dw_spi *dws = spi_controller_get_devdata(master);
> +	struct dw_spi *dws = spi_controller_get_devdata(host);
>  	struct dw_spi_cfg cfg = {
>  		.tmode = DW_SPI_CTRLR0_TMOD_TR,
>  		.dfs = transfer->bits_per_word,
> @@ -440,8 +440,8 @@ static int dw_spi_transfer_one(struct spi_controller *master,
>  	transfer->effective_speed_hz = dws->current_freq;
>  
>  	/* Check if current transfer is a DMA transaction */
> -	if (master->can_dma && master->can_dma(master, spi, transfer))
> -		dws->dma_mapped = master->cur_msg_mapped;
> +	if (host->can_dma && host->can_dma(host, spi, transfer))
> +		dws->dma_mapped = host->cur_msg_mapped;
>  
>  	/* For poll mode just disable all interrupts */
>  	dw_spi_mask_intr(dws, 0xff);
> @@ -464,10 +464,10 @@ static int dw_spi_transfer_one(struct spi_controller *master,
>  	return 1;
>  }
>  
> -static void dw_spi_handle_err(struct spi_controller *master,
> +static void dw_spi_handle_err(struct spi_controller *host,
>  			      struct spi_message *msg)
>  {
> -	struct dw_spi *dws = spi_controller_get_devdata(master);
> +	struct dw_spi *dws = spi_controller_get_devdata(host);
>  
>  	if (dws->dma_mapped)
>  		dws->dma_ops->dma_stop(dws);
> @@ -576,7 +576,7 @@ static int dw_spi_write_then_read(struct dw_spi *dws, struct spi_device *spi)
>  	while (len) {
>  		entries = readl_relaxed(dws->regs + DW_SPI_TXFLR);
>  		if (!entries) {
> -			dev_err(&dws->master->dev, "CS de-assertion on Tx\n");
> +			dev_err(&dws->host->dev, "CS de-assertion on Tx\n");
>  			return -EIO;
>  		}
>  		room = min(dws->fifo_len - entries, len);
> @@ -596,7 +596,7 @@ static int dw_spi_write_then_read(struct dw_spi *dws, struct spi_device *spi)
>  		if (!entries) {
>  			sts = readl_relaxed(dws->regs + DW_SPI_RISR);
>  			if (sts & DW_SPI_INT_RXOI) {
> -				dev_err(&dws->master->dev, "FIFO overflow on Rx\n");
> +				dev_err(&dws->host->dev, "FIFO overflow on Rx\n");
>  				return -EIO;
>  			}
>  			continue;
> @@ -637,7 +637,7 @@ static int dw_spi_wait_mem_op_done(struct dw_spi *dws)
>  		spi_delay_exec(&delay, NULL);
>  
>  	if (retry < 0) {
> -		dev_err(&dws->master->dev, "Mem op hanged up\n");
> +		dev_err(&dws->host->dev, "Mem op hanged up\n");
>  		return -EIO;
>  	}
>  
> @@ -884,56 +884,56 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
>  
>  int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  {
> -	struct spi_controller *master;
> +	struct spi_controller *host;
>  	int ret;
>  
>  	if (!dws)
>  		return -EINVAL;
>  
> -	master = spi_alloc_master(dev, 0);
> -	if (!master)
> +	host = spi_alloc_host(dev, 0);
> +	if (!host)
>  		return -ENOMEM;
>  
> -	device_set_node(&master->dev, dev_fwnode(dev));
> +	device_set_node(&host->dev, dev_fwnode(dev));
>  
> -	dws->master = master;
> +	dws->host = host;
>  	dws->dma_addr = (dma_addr_t)(dws->paddr + DW_SPI_DR);
>  
> -	spi_controller_set_devdata(master, dws);
> +	spi_controller_set_devdata(host, dws);
>  
>  	/* Basic HW init */
>  	dw_spi_hw_init(dev, dws);
>  
>  	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
> -			  master);
> +			  host);
>  	if (ret < 0 && ret != -ENOTCONN) {
>  		dev_err(dev, "can not get IRQ\n");
> -		goto err_free_master;
> +		goto err_free_host;
>  	}
>  
>  	dw_spi_init_mem_ops(dws);
>  
> -	master->use_gpio_descriptors = true;
> -	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
> +	host->use_gpio_descriptors = true;
> +	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
>  	if (dws->caps & DW_SPI_CAP_DFS32)
> -		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
> +		host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
>  	else
> -		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
> -	master->bus_num = dws->bus_num;
> -	master->num_chipselect = dws->num_cs;
> -	master->setup = dw_spi_setup;
> -	master->cleanup = dw_spi_cleanup;
> +		host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
> +	host->bus_num = dws->bus_num;
> +	host->num_chipselect = dws->num_cs;
> +	host->setup = dw_spi_setup;
> +	host->cleanup = dw_spi_cleanup;
>  	if (dws->set_cs)
> -		master->set_cs = dws->set_cs;
> +		host->set_cs = dws->set_cs;
>  	else
> -		master->set_cs = dw_spi_set_cs;
> -	master->transfer_one = dw_spi_transfer_one;
> -	master->handle_err = dw_spi_handle_err;
> +		host->set_cs = dw_spi_set_cs;
> +	host->transfer_one = dw_spi_transfer_one;
> +	host->handle_err = dw_spi_handle_err;
>  	if (dws->mem_ops.exec_op)
> -		master->mem_ops = &dws->mem_ops;
> -	master->max_speed_hz = dws->max_freq;
> -	master->flags = SPI_CONTROLLER_GPIO_SS;
> -	master->auto_runtime_pm = true;
> +		host->mem_ops = &dws->mem_ops;
> +	host->max_speed_hz = dws->max_freq;
> +	host->flags = SPI_CONTROLLER_GPIO_SS;
> +	host->auto_runtime_pm = true;
>  
>  	/* Get default rx sample delay */
>  	device_property_read_u32(dev, "rx-sample-delay-ns",
> @@ -946,14 +946,14 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  		} else if (ret) {
>  			dev_warn(dev, "DMA init failed\n");
>  		} else {
> -			master->can_dma = dws->dma_ops->can_dma;
> -			master->flags |= SPI_CONTROLLER_MUST_TX;
> +			host->can_dma = dws->dma_ops->can_dma;
> +			host->flags |= SPI_CONTROLLER_MUST_TX;
>  		}
>  	}
>  
> -	ret = spi_register_controller(master);
> +	ret = spi_register_controller(host);
>  	if (ret) {
> -		dev_err_probe(dev, ret, "problem registering spi master\n");
> +		dev_err_probe(dev, ret, "problem registering spi host\n");
>  		goto err_dma_exit;
>  	}
>  
> @@ -965,9 +965,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  		dws->dma_ops->dma_exit(dws);
>  	dw_spi_enable_chip(dws, 0);
>  err_free_irq:
> -	free_irq(dws->irq, master);
> -err_free_master:
> -	spi_controller_put(master);
> +	free_irq(dws->irq, host);
> +err_free_host:
> +	spi_controller_put(host);
>  	return ret;
>  }
>  EXPORT_SYMBOL_NS_GPL(dw_spi_add_host, SPI_DW_CORE);
> @@ -976,14 +976,14 @@ void dw_spi_remove_host(struct dw_spi *dws)
>  {
>  	dw_spi_debugfs_remove(dws);
>  
> -	spi_unregister_controller(dws->master);
> +	spi_unregister_controller(dws->host);
>  
>  	if (dws->dma_ops && dws->dma_ops->dma_exit)
>  		dws->dma_ops->dma_exit(dws);
>  
>  	dw_spi_shutdown_chip(dws);
>  
> -	free_irq(dws->irq, dws->master);
> +	free_irq(dws->irq, dws->host);
>  }
>  EXPORT_SYMBOL_NS_GPL(dw_spi_remove_host, SPI_DW_CORE);
>  
> @@ -991,7 +991,7 @@ int dw_spi_suspend_host(struct dw_spi *dws)
>  {
>  	int ret;
>  
> -	ret = spi_controller_suspend(dws->master);
> +	ret = spi_controller_suspend(dws->host);
>  	if (ret)
>  		return ret;
>  
> @@ -1002,8 +1002,8 @@ EXPORT_SYMBOL_NS_GPL(dw_spi_suspend_host, SPI_DW_CORE);
>  
>  int dw_spi_resume_host(struct dw_spi *dws)
>  {
> -	dw_spi_hw_init(&dws->master->dev, dws);
> -	return spi_controller_resume(dws->master);
> +	dw_spi_hw_init(&dws->host->dev, dws);
> +	return spi_controller_resume(dws->host);
>  }
>  EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, SPI_DW_CORE);
>  
> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> index df819652901a..0ecbb6c36e23 100644
> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -139,8 +139,8 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
>  	if (!dws->txchan)
>  		goto free_rxchan;
>  
> -	dws->master->dma_rx = dws->rxchan;
> -	dws->master->dma_tx = dws->txchan;
> +	dws->host->dma_rx = dws->rxchan;
> +	dws->host->dma_tx = dws->txchan;
>  
>  	init_completion(&dws->dma_completion);
>  
> @@ -183,8 +183,8 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
>  		goto free_rxchan;
>  	}
>  
> -	dws->master->dma_rx = dws->rxchan;
> -	dws->master->dma_tx = dws->txchan;
> +	dws->host->dma_rx = dws->rxchan;
> +	dws->host->dma_tx = dws->txchan;
>  
>  	init_completion(&dws->dma_completion);
>  
> @@ -242,10 +242,10 @@ static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
>  	}
>  }
>  
> -static bool dw_spi_can_dma(struct spi_controller *master,
> +static bool dw_spi_can_dma(struct spi_controller *host,
>  			   struct spi_device *spi, struct spi_transfer *xfer)
>  {
> -	struct dw_spi *dws = spi_controller_get_devdata(master);
> +	struct dw_spi *dws = spi_controller_get_devdata(host);
>  	enum dma_slave_buswidth dma_bus_width;
>  
>  	if (xfer->len <= dws->fifo_len)
> @@ -271,7 +271,7 @@ static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
>  					 msecs_to_jiffies(ms));
>  
>  	if (ms == 0) {
> -		dev_err(&dws->master->cur_msg->spi->dev,
> +		dev_err(&dws->host->cur_msg->spi->dev,
>  			"DMA transaction timed out\n");
>  		return -ETIMEDOUT;
>  	}
> @@ -299,7 +299,7 @@ static int dw_spi_dma_wait_tx_done(struct dw_spi *dws,
>  		spi_delay_exec(&delay, xfer);
>  
>  	if (retry < 0) {
> -		dev_err(&dws->master->dev, "Tx hanged up\n");
> +		dev_err(&dws->host->dev, "Tx hanged up\n");
>  		return -EIO;
>  	}
>  
> @@ -400,7 +400,7 @@ static int dw_spi_dma_wait_rx_done(struct dw_spi *dws)
>  		spi_delay_exec(&delay, NULL);
>  
>  	if (retry < 0) {
> -		dev_err(&dws->master->dev, "Rx hanged up\n");
> +		dev_err(&dws->host->dev, "Rx hanged up\n");
>  		return -EIO;
>  	}
>  
> @@ -656,13 +656,13 @@ static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
>  	if (ret)
>  		return ret;
>  
> -	if (dws->master->cur_msg->status == -EINPROGRESS) {
> +	if (dws->host->cur_msg->status == -EINPROGRESS) {
>  		ret = dw_spi_dma_wait_tx_done(dws, xfer);
>  		if (ret)
>  			return ret;
>  	}
>  
> -	if (xfer->rx_buf && dws->master->cur_msg->status == -EINPROGRESS)
> +	if (xfer->rx_buf && dws->host->cur_msg->status == -EINPROGRESS)
>  		ret = dw_spi_dma_wait_rx_done(dws);
>  
>  	return ret;
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index a963bc96c223..3a31ad74a538 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -68,7 +68,7 @@ struct dw_spi_mscc {
>  		((((val) << 1) | BIT(0)) << ELBA_SPICS_OFFSET(cs))
>  
>  /*
> - * The Designware SPI controller (referred to as master in the documentation)
> + * The Designware SPI controller (referred to as host in the documentation)
>   * automatically deasserts chip select when the tx fifo is empty. The chip
>   * selects then needs to be either driven as GPIOs or, for the first 4 using
>   * the SPI boot controller registers. the final chip select is an OR gate
> @@ -76,7 +76,7 @@ struct dw_spi_mscc {
>   */
>  static void dw_spi_mscc_set_cs(struct spi_device *spi, bool enable)
>  {
> -	struct dw_spi *dws = spi_master_get_devdata(spi->master);
> +	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
>  	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
>  	struct dw_spi_mscc *dwsmscc = dwsmmio->priv;
>  	u32 cs = spi_get_chipselect(spi, 0);
> @@ -142,14 +142,14 @@ static int dw_spi_mscc_jaguar2_init(struct platform_device *pdev,
>  }
>  
>  /*
> - * The Designware SPI controller (referred to as master in the
> + * The Designware SPI controller (referred to as host in the
>   * documentation) automatically deasserts chip select when the tx fifo
>   * is empty. The chip selects then needs to be driven by a CS override
>   * register. enable is an active low signal.
>   */
>  static void dw_spi_sparx5_set_cs(struct spi_device *spi, bool enable)
>  {
> -	struct dw_spi *dws = spi_master_get_devdata(spi->master);
> +	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
>  	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
>  	struct dw_spi_mscc *dwsmscc = dwsmmio->priv;
>  	u8 cs = spi_get_chipselect(spi, 0);
> @@ -277,7 +277,7 @@ static void dw_spi_elba_override_cs(struct regmap *syscon, int cs, int enable)
>  
>  static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
>  {
> -	struct dw_spi *dws = spi_master_get_devdata(spi->master);
> +	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
>  	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
>  	struct regmap *syscon = dwsmmio->priv;
>  	u8 cs;
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 3962e6dcf880..6cafeee8ee2a 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -142,14 +142,14 @@ struct dw_spi_dma_ops {
>  	int (*dma_init)(struct device *dev, struct dw_spi *dws);
>  	void (*dma_exit)(struct dw_spi *dws);
>  	int (*dma_setup)(struct dw_spi *dws, struct spi_transfer *xfer);
> -	bool (*can_dma)(struct spi_controller *master, struct spi_device *spi,
> +	bool (*can_dma)(struct spi_controller *host, struct spi_device *spi,
>  			struct spi_transfer *xfer);
>  	int (*dma_transfer)(struct dw_spi *dws, struct spi_transfer *xfer);
>  	void (*dma_stop)(struct dw_spi *dws);
>  };
>  
>  struct dw_spi {
> -	struct spi_controller	*master;
> +	struct spi_controller	*host;
>  
>  	u32			ip;		/* Synopsys DW SSI IP-core ID */
>  	u32			ver;		/* Synopsys component version */
> -- 
> 2.25.1
> 
