Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5052AA558
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 14:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgKGN2z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 08:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGN2y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 08:28:54 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183AAC0613CF;
        Sat,  7 Nov 2020 05:28:54 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id v11so2438052qtq.12;
        Sat, 07 Nov 2020 05:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dn/HeCtFRABC/ah/L2n0R362D6f38waNtj4v0HJdssk=;
        b=cPN5CiQPwqDFVdbga3mf9g1vnoSpLPtjYCc/HxBibpMnEaRnpr33do1VW5dfiICuTp
         jEtINCzgBVSdEirrEB2MkxaBSk3sStb8qRwNL7hYWpTOkvgQ+20uCjmn0LpUcuKXcB+8
         X7rcr9H67tt1H4y6iJA5ohPcnsjhX7Pj96O9PVwlO7GW/0btNxuCSsGormYU4UghSiNm
         kWCZQxZfYB/ZuVJZRPGfEW0lIKttInLPzFzvoVN0gneMKZEBF8di96124tIyDCQ3rFPC
         xo1e0R4v3NSrbz13WpomNhr9Ar9ViL/+HWYwYoaGTg4bOgPI7oAyUyZhN3jRF1C9KLup
         bEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dn/HeCtFRABC/ah/L2n0R362D6f38waNtj4v0HJdssk=;
        b=C4iP5ePrtgWXMJrvjUEYbJMHYLHEhodVvp5OIuyOFPF+n84hiE8KTImuzdoC6ruukK
         RIDP4T5wwcKYWuQt3Q04BhaKi1TfZT9Oz+X956rZMBWA/ibsQTZF0KKsNqSQ3IyFYC/A
         9h8Umd7CPSrAMOqGBEtR7/vpnUxwnRqEm225iKYUyAUHycjX2etoBXD8XnwmvOOk+rGT
         dEZk4xpcRSXEyhkL/HAIq4k52FsLO65Ox+EFbkoQrzyCxg9E4csMYL+k6ZyqS0m/2Qq5
         ASfbQnwRbFm3aseDmIawDVA00Ezuiqy5KmOnV6tRapsNeRwUBXojJIVo31riPtStU+ka
         VXmg==
X-Gm-Message-State: AOAM531pJZstT4bEySkTyjFx/VWDtpmohFddqWuuUGFUt+ZKokO+pyFi
        dTbw/ezHnprS/cMA/Yp+jQ8=
X-Google-Smtp-Source: ABdhPJxa0jkI7jybW+0vygF/BSBlg4wHi5TOu+7IGUDmgwmNWnxQbSOqQzhXElvDte5P+hUZEBYnrg==
X-Received: by 2002:ac8:13c1:: with SMTP id i1mr5798465qtj.78.1604755733365;
        Sat, 07 Nov 2020 05:28:53 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id q1sm2346943qti.95.2020.11.07.05.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 05:28:52 -0800 (PST)
Subject: Re: [PATCH 02/32] spi: dw: Add support for 32-bits ctrlr0 layout
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-3-damien.lemoal@wdc.com>
From:   Sean Anderson <seanga2@gmail.com>
Autocrypt: addr=seanga2@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFe74PkBCACoLC5Zq2gwrDcCkr+EPGsT14bsxrW07GiYzQhLCgwnPdEpgU95pXltbFhw
 46GfyffABWxHKO2x+3L1S6ZxC5AiKbYXo7lpnTBYjamPWYouz+VJEVjUx9aaSEByBah5kX6a
 lKFZWNbXLAJh+dE1HFaMi3TQXXaInaREc+aO1F7fCa2zNE75ja+6ah8L4TPRFZ2HKQzve0/Y
 GXtoRw97qmnm3U36vKWT/m2AiLF619F4T1mHvlfjyd9hrVwjH5h/2rFyroXVXBZHGA9Aj8eN
 F2si35dWSZlIwXkNu9bXp0/pIu6FD0bI+BEkD5S7aH1G1iAcMFi5Qq2RNa041DfQSDDHABEB
 AAG0K1NlYW4gR2FsbGFnaGVyIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT6JAVcEEwEK
 AEECGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4ACGQEWIQSQYR1bzo1I0gPoYCg+6I/stKEQ
 bgUCXT+S2AUJB2TlXwAKCRA+6I/stKEQbhNOB/9ooea0hU9Sgh7PBloU6CgaC5mlqPLB7NTp
 +JkB+nh3Fqhk+qLZwzEynnuDLl6ESpVHIc0Ym1lyF4gT3DsrlGT1h0Gzw7vUwd1+ZfN0CuIx
 Rn861U/dAUjvbtN5kMBqOI4/5ea+0r7MACcIVnKF/wMXBD8eypHsorT2sJTzwZ6DRCNP70C5
 N1ahpqqNmXe0uLdP0pu55JCqhrGw2SinkRMdWyhSxT56uNwIVHGhLTqH7Q4t1N6G1EH626qa
 SvIJsWlNpll6Y3AYLDw2/Spw/hqieS2PQ/Ky3rPZnvJt7/aSNYsKoFGX0yjkH67Uq8Lx0k1L
 w8jpXnbEPQN3A2ZJCbeM
Message-ID: <e166976c-5119-a63b-25ff-8c403e4fc0ae@gmail.com>
Date:   Sat, 7 Nov 2020 08:28:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201107081420.60325-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/7/20 3:13 AM, Damien Le Moal wrote:
> Synopsis DesignWare DW_apb_ssi version 4 defines a 32-bit layout of
> the ctrlr0 register for SPI masters. The layout of ctrlr0 is:
> 
> |   31 .. 23  | 22 .. 21 | 20 .. 16 |
> | other stuff | spi_frf  |  dfs_32  |
> 
> |   15 .. 10  | 9 .. 8 | 7 .. 6 | 5 .. 4 | 3 .. 0 |
> | other stuff |  tmod  |  mode  |  frf   |  dfs   |
> 
> Th main difference of this layout with the 16-bits version is the data
> frame format field which resides in bits 16..20 instead of bits 3..0.
> 
> Introduce the DW SPI capability flag DW_SPI_CAP_DFS_32 to let a
> platform signal that this layout is in use. Modify
> dw_spi_update_config() to test this capability flag to set the data
> frame format field at the correct register location.
> 
> Suggested-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/spi/spi-dw-core.c | 8 ++++++--
>  drivers/spi/spi-dw.h      | 9 +++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 2e50cc0a9291..841c85247f01 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -311,8 +311,12 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
>  	u32 speed_hz;
>  	u16 clk_div;
>  
> -	/* CTRLR0[ 4/3: 0] Data Frame Size */
> -	cr0 |= (cfg->dfs - 1);
> +	if (!(dws->caps & DW_SPI_CAP_DFS_32))
> +		/* CTRLR0[ 4/3: 0] Data Frame Size */
> +		cr0 |= (cfg->dfs - 1);
> +	else
> +		/* CTRLR0[20: 16] Data Frame Size */
> +		cr0 |= (cfg->dfs - 1) << DWC_APB_CTRLR0_32_DFS_OFFSET;
>  
>  	if (!(dws->caps & DW_SPI_CAP_DWC_SSI))
>  		/* CTRLR0[ 9:8] Transfer Mode */
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index faf40cb66498..48a11a51a407 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -9,6 +9,7 @@
>  #include <linux/io.h>
>  #include <linux/scatterlist.h>
>  #include <linux/spi/spi-mem.h>
> +#include <linux/bitfield.h>
>  
>  /* Register offsets */
>  #define DW_SPI_CTRLR0			0x00
> @@ -72,6 +73,13 @@
>  #define DWC_SSI_CTRLR0_FRF_OFFSET	6
>  #define DWC_SSI_CTRLR0_DFS_OFFSET	0
>  
> +/*
> + * Bit fields in CTRLR0 for DWC_apb_ssi v4 32-bits ctrlr0.
> + * Based on DW_apb_ssi Databook v4.02a.
> + */
> +#define DWC_APB_CTRLR0_32_DFS_OFFSET	16
> +#define DWC_APB_CTRLR0_32_DFS_MASK	GENMASK(20, 16)
> +
>  /*
>   * For Keem Bay, CTRLR0[31] is used to select controller mode.
>   * 0: SSI is slave
> @@ -121,6 +129,7 @@ enum dw_ssi_type {
>  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
>  #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
>  #define DW_SPI_CAP_DWC_SSI		BIT(2)
> +#define DW_SPI_CAP_DFS_32		BIT(3)
>  
>  /* Slave spi_transfer/spi_mem_op related */
>  struct dw_spi_cfg {
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>
