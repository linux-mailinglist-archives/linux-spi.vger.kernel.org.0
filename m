Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF8E2AA55B
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 14:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgKGNaY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 08:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGNaX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 08:30:23 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5375EC0613CF;
        Sat,  7 Nov 2020 05:30:23 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id i21so3742650qka.12;
        Sat, 07 Nov 2020 05:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aH9ahL2m2DlHuwZs2NqTSjAIDujecJY29VfTCOj5jeU=;
        b=VAYpZIFpKxEuxOQAeStWmuFaDWxD6BnD9LnhR6Qw0B4UuSTVaJGuga2JpzdGAXoZZX
         iEr8M06RRg/pr7SEvHg6iIKsqGR3sI8Kq1kpshcuOXgZfZMiFE9GTs5rmrHnyA0UwDxs
         YI2c0S2Xwaa9EVrHZg/37eafdSe/L5L1WAvQXHlGHcLH6kT/xF8rNWTBAo5GUFwb1lKp
         OMFYu3ZhQQCzZe9lXhD0KEsuJEu0pCxDgN50qziRUqGfb3DzmxX721vIwSVV5TzxNnO2
         y56yKdGr/RWw1DUiie76feZXnE4YEK8q6SXLO6gOzgfMsVo7xXCUOa4QJpv1H5enubQq
         AKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aH9ahL2m2DlHuwZs2NqTSjAIDujecJY29VfTCOj5jeU=;
        b=NUPY3zG1+9T7K7GlknQOUQrOJM9dNmSaxcsUh+sKPoVJk+i000KG3ANbA5GNiP6wPH
         DHinHs7i40n6zSpco3ZAQk8xhiR2Mhm8m97mCr/xssZItTdAKKT9uc2/hfwkiI8AD2lW
         hfhyCFZoXEpL5AzRDb3tslpSw4zxzftZXt7bjQEv6i5YU0wMtATtF48jnVs1hGbNvCFX
         T8Vsf+X5mHDP22nWPiWQo23I7EZd8cwOn8wbs8VIVHAxoPUIU1OaU7X43bIh1M0Ywgp8
         4IE0XoP8p+HLztOMeIK9Ot3BXGxEDSoOOy+nWpd9UfBJLE12gkQCGeBUnguoRnBEEn83
         ZPdQ==
X-Gm-Message-State: AOAM533b7d9shWNJ/XVzMVSZ3s7bSuYicHeLKIFPNH6S+cjlK+UONuAz
        AoS+Hc9DyQhliY6Vsth0P7I=
X-Google-Smtp-Source: ABdhPJxOT/pYuXPyEgZh5TmoJxgfExJ8PLvUKy/bvI3d5LIGOh4LPdRHV+esMbz8yiqk6VeaczLyXg==
X-Received: by 2002:a37:41d2:: with SMTP id o201mr5819416qka.425.1604755822578;
        Sat, 07 Nov 2020 05:30:22 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id k15sm2513306qtk.64.2020.11.07.05.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 05:30:22 -0800 (PST)
Subject: Re: [PATCH 03/32] spi: dw: Fix driving MOSI low while recieving
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
 <20201107081420.60325-4-damien.lemoal@wdc.com>
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
Message-ID: <2f2acc07-aa00-5d21-e8f6-d99407bf9590@gmail.com>
Date:   Sat, 7 Nov 2020 08:30:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201107081420.60325-4-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/7/20 3:13 AM, Damien Le Moal wrote:
> Fix for the Synopsis DesignWare SPI mmio driver taken from the work
> by Sean Anderson for the U-Boot project. Sean comments:
> 
> The resting state of MOSI is high when nothing is driving it. If we
> drive it low while recieving, it looks like we are transmitting 0x00
> instead of transmitting nothing. This can confuse slaves (like SD cards)
> which allow new commands to be sent over MOSI while they are returning
> data over MISO. The return of MOSI from 0 to 1 at the end of recieving
> a byte can look like a start bit and a transmission bit to an SD card.
> This will cause the card to become out-of-sync with the SPI device, as
> it thinks the device has already started transmitting two bytes of a new
> command. The mmc-spi driver will not detect the R1 response from the SD
> card, since it is sent too early, and offset by two bits. This patch
> fixes transfer errors when using SD cards with dw spi.
> 
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/spi/spi-dw-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 841c85247f01..c2ef1d8d46d5 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -137,7 +137,7 @@ static inline u32 rx_max(struct dw_spi *dws)
>  static void dw_writer(struct dw_spi *dws)
>  {
>  	u32 max = tx_max(dws);
> -	u16 txw = 0;
> +	u16 txw = 0xffff;
>  
>  	while (max--) {
>  		if (dws->tx) {
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>
