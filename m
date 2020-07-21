Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864A0228C25
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 00:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgGUWox (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jul 2020 18:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgGUWox (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jul 2020 18:44:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15421C061794;
        Tue, 21 Jul 2020 15:44:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 9so137449wmj.5;
        Tue, 21 Jul 2020 15:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6DknE5QGxTHlZ/zp1raxupBLAZHTzYnP+IplONM/HMs=;
        b=e0nX/psBq57qpJS8FX982l4jvCTI4Bhmbhexi6MOgLdcmnQB38SYWG9Hpk9nuD+aFT
         BkLk0pBBg98pYPUuGEYHc3Bl42Q/vNdsvjSIqDHI57fVeZa5r38zkNdSa1bUILAAQtF2
         Zd3b65laObYxgBghHuq3y5/KFYFcdc3Gftmf4z1kYvUmWyOx3Lg1z9QJ2cG8AjTyLikk
         X483CJyhc2B3rq5i47ar/0uRKrel5xghYIAoOKQfMYaVmeUWY4ox0/vaFDJ58A+2wOPo
         qDc4KFft/HoH54/oJcL605WxE9pcsdgsECiPv/h3RN/0kOF1ACx0x4jCXL8ep6PTZ+lp
         7h/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6DknE5QGxTHlZ/zp1raxupBLAZHTzYnP+IplONM/HMs=;
        b=hszHsqWNWF5KM0ZOlm4hJlRPRW21sCs1i1aTtRAFvWQbOadtEFm36R0s5Ns6crb8O4
         0NTXExrIB8ZFKGnBVxpB/L3mwaNuowWFu+sLBBxRnm0UHtwpmFZY9BcxPDQB9qOFTBbQ
         rUuXSsYo06cehP8RtOfxuanzc3Xx0+9nn8nHxS/dym82Okhblf3sL+/5Ea6CQlumq4Mb
         H21B7H84KHKlaI3LL6KAG8rOXK/nmz15/edG6rNjbTzbKIpKP9RlsHKjtT0KBW1Z8mvs
         tcOis7+rwK9a0OgYAAnIQNxRZweBllacV5ZrsUl21fv9jW0/9Xv2OGDZWHuj5olG5T7v
         0LYQ==
X-Gm-Message-State: AOAM532JyNt8WtWb3BDaLk3/pp7MTZEaB0FHk8TSix3fxPdxaQrxAhBp
        PZcDxKHpE9i5KSpJl8CxYTfqKAPlC8U=
X-Google-Smtp-Source: ABdhPJxoFLjAttL0FPOz9LEBmCq1IlL6eshCp+cMXmdZngfGahGuhZDZJJvN3RpuFddJCaZW8JER1g==
X-Received: by 2002:a1c:9a06:: with SMTP id c6mr5560010wme.23.1595371491277;
        Tue, 21 Jul 2020 15:44:51 -0700 (PDT)
Received: from ziggy.stardust ([213.195.122.158])
        by smtp.gmail.com with ESMTPSA id u17sm39203455wrp.70.2020.07.21.15.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 15:44:50 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] spi: mediatek: add spi support for mt8192 IC
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20200721122436.31544-1-leilk.liu@mediatek.com>
 <20200721122436.31544-2-leilk.liu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <27e48721-5e54-6947-cd8f-669f4da34c4d@gmail.com>
Date:   Wed, 22 Jul 2020 00:44:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200721122436.31544-2-leilk.liu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 21/07/2020 14:24, Leilk Liu wrote:
> From: "leilk.liu" <leilk.liu@mediatek.com>
> 
> This patch add spi support for mt8192 IC.
> 
> Signed-off-by: leilk.liu <leilk.liu@mediatek.com>
> ---
>   drivers/spi/spi-mt65xx.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 6783e12c40c2..3d0d69fe0c69 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -170,6 +170,9 @@ static const struct of_device_id mtk_spi_of_match[] = {
>   	{ .compatible = "mediatek,mt8183-spi",
>   		.data = (void *)&mt8183_compat,
>   	},
> +	{ .compatible = "mediatek,mt8192-spi",
> +		.data = (void *)&mt6765_compat,
> +	},

That's not needed. We will use the fallback compatible which is 
"mediatek,mt6765-spi" which will take the correct DT data. If in the future we 
realize that mt8192 has a difference in the HW we can add the compatible. 
Otherwise with the binding description we should be fine

>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, mtk_spi_of_match);
> 
