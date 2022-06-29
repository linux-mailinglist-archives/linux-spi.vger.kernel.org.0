Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4375355FBB4
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 11:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiF2JUm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 05:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiF2JUl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 05:20:41 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5D7369CF
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 02:20:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z19so21263802edb.11
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 02:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/bGFUVva0+eqpjZbExgqKoAVcxN/oVONvgi4F4arg44=;
        b=t4IGMtdSyE/Wo7kjPAJ53CR2QfXqvh1cbI0QM6qHJEDsxh4FTpOMqTTC7yWSBE5OrF
         GWiXmlYmjE8gKpJOJdQnWsfWNOy0PiLTr6gXdiEiP0ehu7dQKNdvSds4zF3xEU6/PyY8
         8xqXCN6CpWeoOFbULJ7QV2UloefWyunwXOIPVqaXHRnGo3OeJWnFCNBOsS1aZH866RuC
         tsJiIj3wKulYvzImnBe6A+mzOOh7SAn/4KNVWFguXw7ruBwnHXWawMW5bQu5RgzCa5Nb
         fKc67uYmFP//Sy9mIh3aRLL+yW1UGu9aiTjTMnI4dr/ii4la2YHJgbXpVZmP9lEajECO
         1ekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/bGFUVva0+eqpjZbExgqKoAVcxN/oVONvgi4F4arg44=;
        b=mEufk08xK958k29M9Jd7TS1pN8DAqn8kw/1MLfmVAG/yTlfnKJ0qXS4QzQPsIT5eNF
         JvYCTfzqHX7ACpOBWpvYmOCWJppcb0FlLSbATeeuvoupnKKMy5dyEDf1BXm9VN0RWa/E
         h4kRPtKnqkIXtNjB6i8+z/PUgex8ZugydUauMK9Qz6QAOn7lKDoXk2A8/516mgZiBZih
         rRNBdwrGKaRoAdfz8sFIoHN9cB0PDwihWakvobNyq1oxmjbzSSqNOKt4hQuiS/3kr7e0
         fVBsgQWeFCKVuD9+n9UGTZs/7+IXpiKonbOoMr17Mu9cYHPnONnf0iiEQWQqKboPEy1Y
         bxrg==
X-Gm-Message-State: AJIora9zqfRkUJsxWcRHj1y6HGmRyA3Bt22cq0RNiQCRmw0bGuTHiKrJ
        JSbrXfREPqq/zBR5wXCAD3YN/g==
X-Google-Smtp-Source: AGRyM1tLnCrLFBxSD3CTHZS2Sh6m8XGADO7azFSR+gipDQQY0MwG6f87/Kqe5qHGjjI/cHBeJVec8Q==
X-Received: by 2002:a05:6402:538d:b0:435:7ca6:a136 with SMTP id ew13-20020a056402538d00b004357ca6a136mr2945835edb.268.1656494438629;
        Wed, 29 Jun 2022 02:20:38 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id oz20-20020a170906cd1400b006f3ef214dc7sm7416333ejb.45.2022.06.29.02.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 02:20:38 -0700 (PDT)
Message-ID: <da86b25a-097d-63fe-083a-5600b72b0bdb@linaro.org>
Date:   Wed, 29 Jun 2022 11:20:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/4] spi: s3c64xx: support custom value of internal
 clock divider
Content-Language: en-US
To:     Chanho Park <chanho61.park@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220628044222.152794-1-chanho61.park@samsung.com>
 <CGME20220628044432epcas2p11e6f927321c30cf5557dbd41d749ef28@epcas2p1.samsung.com>
 <20220628044222.152794-3-chanho61.park@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220628044222.152794-3-chanho61.park@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 28/06/2022 06:42, Chanho Park wrote:
> Modern exynos SoCs such as Exynos Auto v9 has different internal clock
> divider, for example "4". To support this internal value, this adds
> clk_div of the s3c64xx_spi_port_config and assign "2" as the default
> value to existing s3c64xx_spi_port_config.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index b3c50c7665fc..51a0e830441b 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -131,6 +131,7 @@ struct s3c64xx_spi_dma_data {
>   * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS register.
>   * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
>   * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
> + * @clk_div: Internal clock divider, if not specified, use 2 as the default.
>   * @quirks: Bitmask of known quirks
>   * @high_speed: True, if the controller supports HIGH_SPEED_EN bit.
>   * @clk_from_cmu: True, if the controller does not include a clock mux and
> @@ -148,6 +149,7 @@ struct s3c64xx_spi_port_config {
>  	int	rx_lvl_offset;
>  	int	tx_st_done;
>  	int	quirks;
> +	int	clk_div;
>  	bool	high_speed;
>  	bool	clk_from_cmu;
>  	bool	clk_ioclk;
> @@ -620,6 +622,7 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
>  	void __iomem *regs = sdd->regs;
>  	int ret;
>  	u32 val;
> +	u32 div = sdd->port_conf->clk_div;
>  
>  	/* Disable Clock */
>  	if (!sdd->port_conf->clk_from_cmu) {
> @@ -668,16 +671,15 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
>  	writel(val, regs + S3C64XX_SPI_MODE_CFG);
>  
>  	if (sdd->port_conf->clk_from_cmu) {
> -		/* The src_clk clock is divided internally by 2 */
> -		ret = clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
> +		ret = clk_set_rate(sdd->src_clk, sdd->cur_speed * div);
>  		if (ret)
>  			return ret;
> -		sdd->cur_speed = clk_get_rate(sdd->src_clk) / 2;
> +		sdd->cur_speed = clk_get_rate(sdd->src_clk) / div;
>  	} else {
>  		/* Configure Clock */
>  		val = readl(regs + S3C64XX_SPI_CLK_CFG);
>  		val &= ~S3C64XX_SPI_PSR_MASK;
> -		val |= ((clk_get_rate(sdd->src_clk) / sdd->cur_speed / 2 - 1)
> +		val |= ((clk_get_rate(sdd->src_clk) / sdd->cur_speed / div - 1)
>  				& S3C64XX_SPI_PSR_MASK);
>  		writel(val, regs + S3C64XX_SPI_CLK_CFG);
>  
> @@ -871,6 +873,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>  	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
>  	struct s3c64xx_spi_driver_data *sdd;
>  	int err;
> +	u32 div = 2;

This assignment is not effective - shortly later is being overwritten.

>  
>  	sdd = spi_master_get_devdata(spi->master);
>  	if (spi->dev.of_node) {
> @@ -889,22 +892,24 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>  
>  	pm_runtime_get_sync(&sdd->pdev->dev);
>  
> +	div = sdd->port_conf->clk_div;
> +


Best regards,
Krzysztof
