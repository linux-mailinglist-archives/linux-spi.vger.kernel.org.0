Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9453530FF64
	for <lists+linux-spi@lfdr.de>; Thu,  4 Feb 2021 22:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBDVfc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Feb 2021 16:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhBDVfb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Feb 2021 16:35:31 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1BFC061788
        for <linux-spi@vger.kernel.org>; Thu,  4 Feb 2021 13:34:50 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id l12so5253620ljc.3
        for <linux-spi@vger.kernel.org>; Thu, 04 Feb 2021 13:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BCno6Ao+dwCVXfvTIIoqfVrP6GUQPTZVIPIC7Z6fmno=;
        b=BZOz6UaayRrtBM/evJF7kodBQxJhWGPCHVI2t097sAYuulXR8u02ZfuBKw5zaXFbn9
         PFirLtNtBcle8UsXYmPksbaJM2bfWX+9Bdk+IPTMvWmHOVRu8NwRGdUEHtfEFxiJxihO
         B4o2FCVq/8Tb55huK2zS+6GFwpJat6/241fnu0lCxzTbuhoHBirr2Wz2/xRAFvlUT0xV
         CVMfIBqTqQpb/AY8m9Srg1+X4AIzajKf+2Tq4WPquGirA2NF1lZ7o26SfGxVPA9r0gYF
         nS55UBQfH9R+82EJRf8D/YHalynvu/ZyB7rvY5vKZu2dHiWck4c62yvaKg/mgIL9LUmj
         YvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BCno6Ao+dwCVXfvTIIoqfVrP6GUQPTZVIPIC7Z6fmno=;
        b=cBgFWIXP7TQYbzyyxbZI2nHdR4MmG/t8BHKtMU57YfbYy2C/nkvOrhEPFsX5N1rbM4
         MAT36vBwvSxSzw0AlcMleg8Q1A4ti+fIYYgWGHeEDTP3vYfPDAxeh+3cG/rG6DCYzIWa
         S9J2HbZG8ktXAn0ZYn05WRTIz09VScihRJDRVZvd/6Aydh269akHrV6u2QvU9oWbTnmc
         l+VjFrefTgG1Qjyh1/izXUs36yhvwy9kXJkCCEilFu4sjItoEeOVHsAe07qg81e+lwVh
         oTUNVsPU8O0Ca4cTOoOm5nh0Ui/DrLazmMQXk9v6PYwXeyXCP9kIIfrQoAnlYTCo57vU
         +1jQ==
X-Gm-Message-State: AOAM532CIsu51GyHg7j6DtygA0bCHnn+E/6KZ3g+WtXKKomH1or1V63n
        4aWmyCHe5aVzjQXyyUKLRieCFw==
X-Google-Smtp-Source: ABdhPJwKUWSgvkl+QDCXohVE2j8HxXVX0EEU8jhBEYfSjwR2RJ6yEaMjEmXlDauz9H4svNTK1hCO+A==
X-Received: by 2002:a2e:a550:: with SMTP id e16mr770611ljn.197.1612474489012;
        Thu, 04 Feb 2021 13:34:49 -0800 (PST)
Received: from [192.168.1.211] ([188.162.64.67])
        by smtp.gmail.com with ESMTPSA id h15sm747258lfc.221.2021.02.04.13.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 13:34:48 -0800 (PST)
Subject: Re: [PATCH 4/7] spi: spi-geni-qcom: Add support for GPI dma
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210111151651.1616813-1-vkoul@kernel.org>
 <20210111151651.1616813-5-vkoul@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <14dbf839-a9f9-73b6-8de3-cdb2f6353833@linaro.org>
Date:   Fri, 5 Feb 2021 00:34:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210111151651.1616813-5-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/01/2021 18:16, Vinod Koul wrote:
> We can use GPI DMA for devices where it is enabled by firmware. Add
> support for this mode
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   drivers/spi/spi-geni-qcom.c | 395 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 384 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 512e925d5ea4..5bb0e2192734 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c

[skipped]

> @@ -328,8 +609,34 @@ static int spi_geni_init(struct spi_geni_master *mas)
>   	spi_tx_cfg &= ~CS_TOGGLE;
>   	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
>   
> +	mas->tx = dma_request_slave_channel(mas->dev, "tx");
> +	if (IS_ERR_OR_NULL(mas->tx)) {

dma_request_slave_channel() is deprecated. Also it does not return an 
actualy error, it always returns NULL. So the error path here is bugged.
Judging from the rest of the driver, it might be logical to select the 
transfer mode at the probe time, then it would be possible to skip 
checking for DMA channels if FIFO mode is selected.

> +		dev_err(mas->dev, "Failed to get tx DMA ch %ld", PTR_ERR(mas->tx));
> +		ret = PTR_ERR(mas->tx);
> +		goto out_pm;
> +	} else {
> +		mas->rx = dma_request_slave_channel(mas->dev, "rx");
> +		if (IS_ERR_OR_NULL(mas->rx)) {
> +			dev_err(mas->dev, "Failed to get rx DMA ch %ld", PTR_ERR(mas->rx));
> +			dma_release_channel(mas->tx);
> +			ret = PTR_ERR(mas->rx);
> +			goto out_pm;
> +		}
> +
> +		gsi_sz = sizeof(struct spi_geni_gsi) * NUM_SPI_XFER;
> +		mas->gsi = devm_kzalloc(mas->dev, gsi_sz, GFP_KERNEL);
> +		if (IS_ERR_OR_NULL(mas->gsi)) {
> +			dma_release_channel(mas->tx);
> +			dma_release_channel(mas->rx);
> +			mas->tx = NULL;
> +			mas->rx = NULL;
> +			goto out_pm;
> +		}
> +	}
> +
> +out_pm:
>   	pm_runtime_put(mas->dev);
> -	return 0;
> +	return ret;
>   }
>   
>   static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
> @@ -420,6 +727,7 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>   {
>   	u32 m_cmd = 0;
>   	u32 len;
> +	u32 m_param = 0;
>   	struct geni_se *se = &mas->se;
>   	int ret;
>   
> @@ -457,6 +765,11 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>   		len = xfer->len / (mas->cur_bits_per_word / BITS_PER_BYTE + 1);
>   	len &= TRANS_LEN_MSK;
>   
> +	if (!xfer->cs_change) {
> +		if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
> +			m_param |= FRAGMENTATION;
> +	}
> +
>   	mas->cur_xfer = xfer;
>   	if (xfer->tx_buf) {
>   		m_cmd |= SPI_TX_ONLY;
> @@ -475,7 +788,7 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>   	 * interrupt could come in at any time now.
>   	 */
>   	spin_lock_irq(&mas->lock);
> -	geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
> +	geni_se_setup_m_cmd(se, m_cmd, m_param);
>   
>   	/*
>   	 * TX_WATERMARK_REG should be set after SPI configuration and
> @@ -494,13 +807,52 @@ static int spi_geni_transfer_one(struct spi_master *spi,
>   				struct spi_transfer *xfer)
>   {
>   	struct spi_geni_master *mas = spi_master_get_devdata(spi);
> +	unsigned long timeout, jiffies;
> +	int ret = 0i, i;
>   
>   	/* Terminate and return success for 0 byte length transfer */
>   	if (!xfer->len)
> -		return 0;
> +		return ret;
> +
> +	if (mas->cur_xfer_mode == GENI_SE_FIFO) {
> +		setup_fifo_xfer(xfer, mas, slv->mode, spi);
> +	} else {
> +		setup_gsi_xfer(xfer, mas, slv, spi);
> +		if (mas->num_xfers >= NUM_SPI_XFER ||
> +		    (list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))) {
> +			for (i = 0 ; i < mas->num_tx_eot; i++) {
> +				jiffies = msecs_to_jiffies(SPI_XFER_TIMEOUT_MS);
> +				timeout = wait_for_completion_timeout(&mas->tx_cb, jiffies);
> +				if (timeout <= 0) {
> +					dev_err(mas->dev, "Tx[%d] timeout%lu\n", i, timeout);
> +					ret = -ETIMEDOUT;
> +					goto err_gsi_geni_transfer_one;
> +				}
> +				spi_finalize_current_transfer(spi);
> +			}
> +			for (i = 0 ; i < mas->num_rx_eot; i++) {
> +				jiffies = msecs_to_jiffies(SPI_XFER_TIMEOUT_MS);
> +				timeout = wait_for_completion_timeout(&mas->tx_cb, jiffies);
> +				if (timeout <= 0) {
> +					dev_err(mas->dev, "Rx[%d] timeout%lu\n", i, timeout);
> +					ret = -ETIMEDOUT;
> +					goto err_gsi_geni_transfer_one;
> +				}
> +				spi_finalize_current_transfer(spi);
> +			}
> +			if (mas->qn_err) {
> +				ret = -EIO;
> +				mas->qn_err = false;
> +				goto err_gsi_geni_transfer_one;
> +			}
> +		}
> +	}
>   
> -	setup_fifo_xfer(xfer, mas, slv->mode, spi);
> -	return 1;
> +	return ret;
> +
> +err_gsi_geni_transfer_one:
> +	dmaengine_terminate_all(mas->tx);
> +	return ret;
>   }
>   
>   static irqreturn_t geni_spi_isr(int irq, void *data)
> @@ -595,6 +947,15 @@ static int spi_geni_probe(struct platform_device *pdev)
>   	if (irq < 0)
>   		return irq;
>   
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +		if (ret) {
> +			dev_err(&pdev->dev, "could not set DMA mask\n");
> +			return ret;
> +		}
> +	}
> +
>   	base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
> @@ -632,15 +993,18 @@ static int spi_geni_probe(struct platform_device *pdev)
>   	spi->num_chipselect = 4;
>   	spi->max_speed_hz = 50000000;
>   	spi->prepare_message = spi_geni_prepare_message;
> +	spi->unprepare_message = spi_geni_unprepare_message;
>   	spi->transfer_one = spi_geni_transfer_one;
>   	spi->auto_runtime_pm = true;
>   	spi->handle_err = handle_fifo_timeout;
> -	spi->set_cs = spi_geni_set_cs;
>   	spi->use_gpio_descriptors = true;
>   
>   	init_completion(&mas->cs_done);
>   	init_completion(&mas->cancel_done);
>   	init_completion(&mas->abort_done);
> +	init_completion(&mas->xfer_done);
> +	init_completion(&mas->tx_cb);
> +	init_completion(&mas->rx_cb);
>   	spin_lock_init(&mas->lock);
>   	pm_runtime_use_autosuspend(&pdev->dev);
>   	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
> @@ -661,6 +1025,15 @@ static int spi_geni_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto spi_geni_probe_runtime_disable;
>   
> +	/*
> +	 * query the mode supported and set_cs for fifo mode only
> +	 * for dma (gsi) mode, the gsi will set cs based on params passed in
> +	 * TRE
> +	 */
> +	mas->cur_xfer_mode = get_xfer_mode(spi);
> +	if (mas->cur_xfer_mode == GENI_SE_FIFO)
> +		spi->set_cs = spi_geni_set_cs;
> +
>   	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
>   	if (ret)
>   		goto spi_geni_probe_runtime_disable;
> 


-- 
With best wishes
Dmitry
