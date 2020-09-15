Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC90326A352
	for <lists+linux-spi@lfdr.de>; Tue, 15 Sep 2020 12:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgIOKkh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Sep 2020 06:40:37 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:61760 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbgIOKkf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Sep 2020 06:40:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600166434; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=RGfRESai5R6+4YAD/QGq49W8IJ+1ZKr/4GkZuaDnj2I=; b=KVEeZUJS+6qbYlmuEp7ielkfVz0AYyer/mNJH83SjutHlHtvGXuXns6Rdg1k44N+j/KSVH85
 cpJGHaNnYilqFezU1KNrBi+2s+yWMvDWwb6posECkaWU8wNBkmaUhQ4pv5H1ia8PR6OHvahv
 c9ql1KXcoOsvWNom0xt14qmvIMY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f609a18ba408b30ce2846aa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 10:40:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 71AF0C43382; Tue, 15 Sep 2020 10:40:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.100] (unknown [47.8.151.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE1DAC433C8;
        Tue, 15 Sep 2020 10:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE1DAC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH 2/3] spi: spi-geni-qcom: Don't program CS_TOGGLE again and
 again
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     swboyd@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20200912140730.1.Ie67fa32009b94702d56232c064f1d89065ee8836@changeid>
 <20200912140730.2.I33e571179986850b4ec17042e813d0b08fb1b9c1@changeid>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <42d9b988-23fd-7090-341f-95e2ea3265a5@codeaurora.org>
Date:   Tue, 15 Sep 2020 16:10:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200912140730.2.I33e571179986850b4ec17042e813d0b08fb1b9c1@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 9/13/2020 2:38 AM, Douglas Anderson wrote:
> We always toggle the chip select manually in spi-geni-qcom so that we
> can properly implement the Linux API.  There's no reason to program
> this to the hardware on every transfer.  Program it once at init and
> be done with it.
>
> This saves some part of a microsecond of overhead on each transfer.
> While not really noticeable on any real world benchmarks, we might as
> well save the time.

Yeah this is configuration part, can be moved to one time init function, 
as per HPG CS_TOGGLE bit of SPI_TRANS_CFG register is used to instruct 
FW to toggle CS line btw each words. We never came across any 
usecase/slave who needs this.

Reviewed-by: Akash Asthana <akashast@codeaurora.org>

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>   drivers/spi/spi-geni-qcom.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 7f0bf0dec466..92d88bf85a90 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -290,6 +290,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
>   {
>   	struct geni_se *se = &mas->se;
>   	unsigned int proto, major, minor, ver;
> +	u32 spi_tx_cfg;
>   
>   	pm_runtime_get_sync(mas->dev);
>   
> @@ -322,6 +323,11 @@ static int spi_geni_init(struct spi_geni_master *mas)
>   
>   	geni_se_select_mode(se, GENI_SE_FIFO);
>   
> +	/* We always control CS manually */
> +	spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
> +	spi_tx_cfg &= ~CS_TOGGLE;
> +	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
> +
>   	pm_runtime_put(mas->dev);
>   	return 0;
>   }
> @@ -331,7 +337,7 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>   				u16 mode, struct spi_master *spi)
>   {
>   	u32 m_cmd = 0;
> -	u32 spi_tx_cfg, len;
> +	u32 len;
>   	struct geni_se *se = &mas->se;
>   	int ret;
>   
> @@ -350,7 +356,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>   	spin_lock_irq(&mas->lock);
>   	spin_unlock_irq(&mas->lock);
>   
> -	spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
>   	if (xfer->bits_per_word != mas->cur_bits_per_word) {
>   		spi_setup_word_len(mas, mode, xfer->bits_per_word);
>   		mas->cur_bits_per_word = xfer->bits_per_word;
> @@ -364,8 +369,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>   	mas->tx_rem_bytes = 0;
>   	mas->rx_rem_bytes = 0;
>   
> -	spi_tx_cfg &= ~CS_TOGGLE;
> -
>   	if (!(mas->cur_bits_per_word % MIN_WORD_LEN))
>   		len = xfer->len * BITS_PER_BYTE / mas->cur_bits_per_word;
>   	else
> @@ -384,7 +387,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>   		writel(len, se->base + SE_SPI_RX_TRANS_LEN);
>   		mas->rx_rem_bytes = xfer->len;
>   	}
> -	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
>   
>   	/*
>   	 * Lock around right before we start the transfer since our

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

