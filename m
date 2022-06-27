Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ABB55D3F0
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiF0Jk4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 05:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbiF0Jkz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 05:40:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1096337
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 02:40:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id mf9so18027789ejb.0
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 02:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8w4Xd8HO2KMZ2SznJIKXdxvDaJuGbalrivg2cgjpMtA=;
        b=P2y6wXBaX1Tp2M08YJa1SccUleXNyU8wB/IS61X04mzIIQvj8WLEYWmRsroReBrfN4
         vuMqqGW6dhYqXLtb6oBq3aOvKsqOm4GyUrzUTuGI4aUOSRmx7BII2yv3on372cjpuakX
         oLHj+paXdVGyZJAdj4T23rEPWBiWSIxr+CqrOJ6H25TkZ7eoerUfbzo02PPoDfcmHA0n
         RzqI8gPGMEFhP3VD1ak0TFBN+NioJi+qB02j43G9xGxGOKvjb00A7IIU1qasNF6QvvAg
         kuMqaMjrElUUNisMNzRlBvjm4GKz6teLVxLi3xmquP2q+KSp8lm6esTJhXtuHOZffg9m
         yMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8w4Xd8HO2KMZ2SznJIKXdxvDaJuGbalrivg2cgjpMtA=;
        b=2ZW9SqMU812zxYH1/+MrPUd3jKtXFTPWzmAFtRuaxHLFpHGnKWIbyM3nk5xq9Z/Mdm
         ifFmlNUChL6P1nHel80amIQJzafn6mAVMALoMA1MiOyk06QAgx0Ku08bq6ncm//waPL/
         XjDMlnzk+QwwOcNZLrug4W0jINSzXF18vIkMwEspAMqJ6t6VdIe3VU28+26EQCV3K040
         PsJlUuFp5J2w13i0++D13GZV1GXbyplLl8qwBnR3J4pVb3H3tS/FWfmDjOEUeQ5MVQMe
         ff+IrJ/W7lSdQwbKAY6enE8PLijBsPH4CfraoZXl+JwPmVSlsOvgvjI8CSBqjLVm2kF8
         WQkA==
X-Gm-Message-State: AJIora/dmaxiRcbMBM+4mvYIBibA08dueJgpIonn6MfhmpD9WqcxX1Bg
        uxqwCKjP7cp0CpLsBgnncMgfQg==
X-Google-Smtp-Source: AGRyM1szfH/v6uf2DT/NmAsXshg4fNP3SyxfQdiGt3oL4ArVLADr8sFpyki2vY1hNzmPLNzt+hMYkQ==
X-Received: by 2002:a17:907:a424:b0:702:f94a:a897 with SMTP id sg36-20020a170907a42400b00702f94aa897mr11426858ejc.255.1656322851784;
        Mon, 27 Jun 2022 02:40:51 -0700 (PDT)
Received: from [192.168.0.247] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709063a5200b007262d69543fsm4740892ejf.106.2022.06.27.02.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 02:40:51 -0700 (PDT)
Message-ID: <3a7f2faa-0d42-02e6-fb1a-216be1120ff3@linaro.org>
Date:   Mon, 27 Jun 2022 11:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/5] spi: s3c64xx: support custom value of internal clock
 divider
Content-Language: en-US
To:     Chanho Park <chanho61.park@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220627064707.138883-1-chanho61.park@samsung.com>
 <CGME20220627064931epcas2p2e1dc352f41895b294d7945c2239de362@epcas2p2.samsung.com>
 <20220627064707.138883-4-chanho61.park@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220627064707.138883-4-chanho61.park@samsung.com>
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

On 27/06/2022 08:47, Chanho Park wrote:
> Modern exynos SoCs such as Exynos Auto v9 has different internal clock
> divider, for example "4". To support this internal value, this adds
> clk_div of the s3c64xx_spi_port_config and use it if it is specified.
> Otherwise, use "2" which is the previous default value.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index e17c74c0d7de..dd5fc8570bce 100644
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
> +	u32 div = sdd->port_conf->clk_div ? sdd->port_conf->clk_div : 2;

I would prefer to explicitly set '2' as clk_div for existing variants.
Such assignments in the code are usually trickier to find/read.
>  

Best regards,
Krzysztof
