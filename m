Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAA1216DE4
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jul 2020 15:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgGGNiD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jul 2020 09:38:03 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:37828 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728029AbgGGNiC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jul 2020 09:38:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594129081; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=LZZpM5Sq9nJUd9VR8NYFaZSzGprpVL3iGnjSrySQ+fM=; b=lPqdr84fi/lBdULFmXGL+S8mItlIPfA9ru+CErukbzdVBGiTdNZy+sv9CxeUlwtA6eQ1c1X0
 /NKv6QcF1jnanpbp9mZesTPBPUOLDpD1Ony7YJv3bZrJr8pocUgKbs7m+/OeJwvOYKHWGpsH
 lWc4qXpzeO6DBmSzCHsiu3sEsH0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f047aaef97e988aabc8b7d1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 07 Jul 2020 13:37:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 76C63C433CB; Tue,  7 Jul 2020 13:37:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.0.15] (unknown [183.83.138.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2208EC433C8;
        Tue,  7 Jul 2020 13:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2208EC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH 3/3] spi: spi-geni-qcom: Get rid of most overhead in
 prepare_message()
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, mkshah@codeaurora.org,
        swboyd@chromium.org, georgi.djakov@linaro.org,
        ctheegal@codeaurora.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20200702004509.2333554-1-dianders@chromium.org>
 <20200701174506.3.I2b3d7aeb1ea622335482cce60c58d2f8381e61dd@changeid>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <2d54dadc-5e73-f40a-aa08-7c0cf4d16886@codeaurora.org>
Date:   Tue, 7 Jul 2020 19:07:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701174506.3.I2b3d7aeb1ea622335482cce60c58d2f8381e61dd@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 7/2/2020 6:15 AM, Douglas Anderson wrote:
> There's a bunch of overhead in spi-geni-qcom's prepare_message.  Get
> rid of it.  Before this change spi_geni_prepare_message() took around
> 14.5 us.  After this change, spi_geni_prepare_message() takes about
> 1.75 us (as measured by ftrace).
>
> What's here:
> * We're always in FIFO mode, so no need to call it for every transfer.
>    This avoids a whole ton of readl/writel calls.
> * We don't need to write a whole pile of config registers if the mode
>    isn't changing.  Cache the last mode and only do the work if needed.
> * For several registers we were trying to do read/modify/write, but
>    there was no reason.  The registers only have one thing in them, so
>    just write them.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>   drivers/spi/spi-geni-qcom.c | 54 +++++++++++++++++--------------------
>   1 file changed, 24 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index f51279608fc7..97fac5ea6afd 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -77,6 +77,7 @@ struct spi_geni_master {
>   	u32 tx_fifo_depth;
>   	u32 fifo_width_bits;
>   	u32 tx_wm;
> +	u32 last_mode;
>   	unsigned long cur_speed_hz;
>   	unsigned int cur_bits_per_word;
>   	unsigned int tx_rem_bytes;
> @@ -177,8 +178,6 @@ static void spi_setup_word_len(struct spi_geni_master *mas, u16 mode,
>   	struct geni_se *se = &mas->se;
>   	u32 word_len;
>   
> -	word_len = readl(se->base + SE_SPI_WORD_LEN);
> -
>   	/*
>   	 * If bits_per_word isn't a byte aligned value, set the packing to be
>   	 * 1 SPI word per FIFO word.
> @@ -187,10 +186,9 @@ static void spi_setup_word_len(struct spi_geni_master *mas, u16 mode,
>   		pack_words = mas->fifo_width_bits / bits_per_word;
>   	else
>   		pack_words = 1;
> -	word_len &= ~WORD_LEN_MSK;
> -	word_len |= ((bits_per_word - MIN_WORD_LEN) & WORD_LEN_MSK);
>   	geni_se_config_packing(&mas->se, bits_per_word, pack_words, msb_first,
>   								true, true);
> +	word_len = (bits_per_word - MIN_WORD_LEN) & WORD_LEN_MSK;
>   	writel(word_len, se->base + SE_SPI_WORD_LEN);
>   }
>   
> @@ -238,38 +236,34 @@ static int setup_fifo_params(struct spi_device *spi_slv,
>   {
>   	struct spi_geni_master *mas = spi_master_get_devdata(spi);
>   	struct geni_se *se = &mas->se;
> -	u32 loopback_cfg, cpol, cpha, demux_output_inv;
> +	u32 loopback_cfg = 0, cpol = 0, cpha = 0, demux_output_inv = 0;
>   	u32 demux_sel;
>   
> -	loopback_cfg = readl(se->base + SE_SPI_LOOPBACK);
> -	cpol = readl(se->base + SE_SPI_CPOL);
> -	cpha = readl(se->base + SE_SPI_CPHA);
> -	demux_output_inv = 0;
> -	loopback_cfg &= ~LOOPBACK_MSK;
> -	cpol &= ~CPOL;
> -	cpha &= ~CPHA;
> +	if (mas->last_mode != spi_slv->mode) {
> +		if (spi_slv->mode & SPI_LOOP)
> +			loopback_cfg = LOOPBACK_ENABLE;
>   
> -	if (spi_slv->mode & SPI_LOOP)
> -		loopback_cfg |= LOOPBACK_ENABLE;
> +		if (spi_slv->mode & SPI_CPOL)
> +			cpol = CPOL;
>   
> -	if (spi_slv->mode & SPI_CPOL)
> -		cpol |= CPOL;
> +		if (spi_slv->mode & SPI_CPHA)
> +			cpha = CPHA;
>   
> -	if (spi_slv->mode & SPI_CPHA)
> -		cpha |= CPHA;
> +		if (spi_slv->mode & SPI_CS_HIGH)
> +			demux_output_inv = BIT(spi_slv->chip_select);
>   
> -	if (spi_slv->mode & SPI_CS_HIGH)
> -		demux_output_inv = BIT(spi_slv->chip_select);
> +		demux_sel = spi_slv->chip_select;
> +		mas->cur_bits_per_word = spi_slv->bits_per_word;
>   
> -	demux_sel = spi_slv->chip_select;
> -	mas->cur_bits_per_word = spi_slv->bits_per_word;
> +		spi_setup_word_len(mas, spi_slv->mode, spi_slv->bits_per_word);
> +		writel(loopback_cfg, se->base + SE_SPI_LOOPBACK);
> +		writel(demux_sel, se->base + SE_SPI_DEMUX_SEL);
> +		writel(cpha, se->base + SE_SPI_CPHA);
> +		writel(cpol, se->base + SE_SPI_CPOL);
> +		writel(demux_output_inv, se->base + SE_SPI_DEMUX_OUTPUT_INV);
>   
> -	spi_setup_word_len(mas, spi_slv->mode, spi_slv->bits_per_word);
> -	writel(loopback_cfg, se->base + SE_SPI_LOOPBACK);
> -	writel(demux_sel, se->base + SE_SPI_DEMUX_SEL);
> -	writel(cpha, se->base + SE_SPI_CPHA);
> -	writel(cpol, se->base + SE_SPI_CPOL);
> -	writel(demux_output_inv, se->base + SE_SPI_DEMUX_OUTPUT_INV);
> +		mas->last_mode = spi_slv->mode;
> +	}
>   
>   	return geni_spi_set_clock_and_bw(mas, spi_slv->max_speed_hz);
>   }

Yeah looks good to me, the default/reset value of these registers are 0 
we don't have to preserve any bits here.

We can directly update the register with required value.

Reviewed-by: Akash Asthana <akashast@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

