Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8268339FC98
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jun 2021 18:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhFHQdj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 12:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbhFHQdj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Jun 2021 12:33:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09013C061574;
        Tue,  8 Jun 2021 09:31:39 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ba2so23507218edb.2;
        Tue, 08 Jun 2021 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WUaKdqkyjh6EzjeWuZqdi2dYNMKlRLnh+NM1sHEfuao=;
        b=X+CfpsFyq5hloeViHoJlyIds19uSTtUIlXAf7k7HrrJUDrSreBvTIyOHADrMjqCAEq
         No4vVonjSBSX0Ql67lfm9mL8pDnFKjMF3mKZsNVqW/Pq6NBek2wKwW1hxbkgrKzu8tC4
         43kO6TYrViuMaxdFjtiwt6J3TA6tHdQywILSow1IEt3NiZeVn2MTqF/aR0fLIxaGrV1w
         ozG0OpRHBTDGcY06ZL/er2groWt3t9mndbpDjrnFXgIt92u4v22hUGD8Jtr+J3EiYFn7
         eAPF1kPCdip9/viRZCIxtzLQB8eEnh7syshU+OfZSfYsV+FGiRrIs+VEHhi41s8cQ7hf
         c1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WUaKdqkyjh6EzjeWuZqdi2dYNMKlRLnh+NM1sHEfuao=;
        b=HphpeI/aXUYcvWZHcIon2HL5/7g6V2xFf0FX+8p/A6hxWKa49xE50BLFNc7x1l8CaF
         77OWSCB9VkN0KV9bE+X2n0L9Lb1sD9bAYeGj17VWtBjVMEoQSj8AiCa7aaK0jDWhbvCh
         RjSbWOKj3aOzXqa4oKgEjgmF4g9qqnZsxCAO4FMo2+xOpfnuo3g3aa5eSWBuGRSrrEmv
         lGmqxO4QMSzoDI1BWe8r1+L/bBuKNEa7TfARFBi8AH8J05Vfo8e2sP9vmNO7uS5kTSSX
         eHj1QK0c1X/qmbJ+N/ZwiXrTCRifNHNIxULqBG9cze0jHXYF1nenNxbZegAywkeYV0Il
         9KWg==
X-Gm-Message-State: AOAM531Lqas9dpggSS2PT5C8VJgDcN84GlQ/m9hcNaTDmfdy42Nng7lD
        1oFDoDLzX7TaHDIFb1OEieA=
X-Google-Smtp-Source: ABdhPJzzR0UxUuKFEEiY/gFD3U2yfUWNfHociiNEWPmaKlEGhRv6BT2dZsFeIRBn1A82AD/+Z6C00Q==
X-Received: by 2002:a05:6402:1592:: with SMTP id c18mr19539617edv.2.1623169896749;
        Tue, 08 Jun 2021 09:31:36 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f18sm74848ejz.119.2021.06.08.09.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 09:31:36 -0700 (PDT)
Subject: Re: [PATCH v6 4/8] clk: rockchip: Add support for hclk_sfc on rk3036
To:     Jon Lin <jon.lin@rock-chips.com>, linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        hjc@rock-chips.com, yifeng.zhao@rock-chips.com,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        macroalpha82@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
References: <20210608022644.21074-1-jon.lin@rock-chips.com>
 <20210608022644.21074-5-jon.lin@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <4a4524f5-ee85-c7f6-aa95-1df84f2a8a99@gmail.com>
Date:   Tue, 8 Jun 2021 18:31:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608022644.21074-5-jon.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Jon,

For rk3036 we might need another fix added to this serie as well.

clk: rockchip: rk3036: fix up the sclk_sfc parent error
https://github.com/rockchip-linux/kernel/commit/100718ef0d44872db1672b6a88030374c0d1613b

===
Add more people for clk driver changes:

M:	Michael Turquette <mturquette@baylibre.com>
M:	Stephen Boyd <sboyd@kernel.org>
L:	linux-clk@vger.kernel.org

===

Johan

On 6/8/21 4:26 AM, Jon Lin wrote:

> From: Chris Morgan <macromorgan@hotmail.com>

From: Randy Li <randy.li@rock-chips.com>

> 
> Add support for the bus clock for the serial flash controller on the
> rk3036. Taken from the Rockchip BSP kernel but not tested on real
> hardware (as I lack a 3036 based SoC to test).
> 

Signed-off-by: Randy Li <randy.li@rock-chips.com>

Maybe give credit to the original author?
clk: rockchip: rk3036: export the sfc clocks
https://github.com/rockchip-linux/kernel/commit/600925e8ef6edbdda0a4ac6b3c55b0199be1e03e

> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
> 
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> Changes in v1: None
> 
>  drivers/clk/rockchip/clk-rk3036.c      | 2 +-
>  include/dt-bindings/clock/rk3036-cru.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
> index 91d56ad45817..ebb628733f6d 100644
> --- a/drivers/clk/rockchip/clk-rk3036.c
> +++ b/drivers/clk/rockchip/clk-rk3036.c
> @@ -403,7 +403,7 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
>  	GATE(HCLK_OTG0, "hclk_otg0", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 13, GFLAGS),
>  	GATE(HCLK_OTG1, "hclk_otg1", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(7), 3, GFLAGS),
>  	GATE(HCLK_I2S, "hclk_i2s", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),

> -	GATE(0, "hclk_sfc", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 14, GFLAGS),
> +	GATE(HCLK_SFC, "hclk_sfc", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 14, GFLAGS),

Maybe CLK_IGNORE_UNUSED should be changed to 0 ?

>  	GATE(HCLK_MAC, "hclk_mac", "hclk_peri", 0, RK2928_CLKGATE_CON(3), 5, GFLAGS),
>  
>  	/* pclk_peri gates */
> diff --git a/include/dt-bindings/clock/rk3036-cru.h b/include/dt-bindings/clock/rk3036-cru.h
> index 35a5a01f9697..a96a9870ad59 100644
> --- a/include/dt-bindings/clock/rk3036-cru.h
> +++ b/include/dt-bindings/clock/rk3036-cru.h
> @@ -81,6 +81,7 @@
>  #define HCLK_OTG0		449
>  #define HCLK_OTG1		450
>  #define HCLK_NANDC		453
> +#define HCLK_SFC		454
>  #define HCLK_SDMMC		456
>  #define HCLK_SDIO		457
>  #define HCLK_EMMC		459
> 
