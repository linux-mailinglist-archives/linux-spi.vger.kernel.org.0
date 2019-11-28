Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97B8610C872
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2019 13:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfK1MQa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Nov 2019 07:16:30 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:43439 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1MQa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 Nov 2019 07:16:30 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47NxSq3Qb8z9tyK4;
        Thu, 28 Nov 2019 13:16:27 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=fqyawkEx; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HCcKSAb7yUZB; Thu, 28 Nov 2019 13:16:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47NxSq2FGlz9tyJ9;
        Thu, 28 Nov 2019 13:16:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574943387; bh=Kg+5fDgIEkRSw2aNDBS2kLviOmU65tx2CObAGHh4HKk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=fqyawkExtf/8Kq1394kq7H9khCPnT+RJRG2TwkFljMTCHYw537NiBBWiUwtWLReEe
         9Z2tZxLw+I/oLqBnPkRn4N5haEuTbk64L+/YJUkOKPv5V5igpOdM1HKKgzo89ZUXVa
         qY/b8qGZgQcfaV6bOvu4SUseAvZ9Jt7O7pKp30qs=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8FFFA8B889;
        Thu, 28 Nov 2019 13:16:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GB8OA_lS5x1M; Thu, 28 Nov 2019 13:16:28 +0100 (CET)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6981E8B87E;
        Thu, 28 Nov 2019 13:16:28 +0100 (CET)
Subject: Re: [PATCH 3/3 v3] spi: fsl: Handle the single hardwired chipselect
 case
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
References: <20191128083718.39177-1-linus.walleij@linaro.org>
 <20191128083718.39177-3-linus.walleij@linaro.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <895ee6ae-88f6-653b-35ec-87a74b84f29e@c-s.fr>
Date:   Thu, 28 Nov 2019 13:16:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191128083718.39177-3-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 28/11/2019 à 09:37, Linus Walleij a écrit :
> The Freescale MPC8xxx had a special quirk for handling a
> single hardwired chipselect, the case when we're using neither
> GPIO nor native chip select: when inspecting the device tree
> and finding zero "cs-gpios" on the device node the code would
> assume we have a single hardwired chipselect that leaves the
> device always selected.
> 
> This quirk is not handled by the new core code, so we need
> to check the "cs-gpios" explicitly in the driver and set
> pdata->max_chipselect = 1 which will later fall through to
> the SPI master ->num_chipselect.
> 
> Make sure not to assign the chip select handler in this
> case: there is no handling needed since the chip is always
> selected, and this is what the old code did as well.
> 
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Fixes: 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO descriptors")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> (No tested the 
single hardwired chipselect case, only tested that this patch doesn't 
prevent the common case to work)


> ---
> ChangeLog v2->v3:
> - Resend with the other patches.
> ChangeLog v1->v2:
> - Reordered patches.
> - Expanded comment a bit.
> ---
>   drivers/spi/spi-fsl-spi.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
> index c87e9c4506c2..4b70887cf443 100644
> --- a/drivers/spi/spi-fsl-spi.c
> +++ b/drivers/spi/spi-fsl-spi.c
> @@ -728,8 +728,18 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
>   			}
>   		}
>   #endif
> -
> -		pdata->cs_control = fsl_spi_cs_control;
> +		/*
> +		 * Handle the case where we have one hardwired (always selected)
> +		 * device on the first "chipselect". Else we let the core code
> +		 * handle any GPIOs or native chip selects and assign the
> +		 * appropriate callback for dealing with the CS lines. This isn't
> +		 * supported on the GRLIB variant.
> +		 */
> +		ret = gpiod_count(dev, "cs");
> +		if (ret <= 0)
> +			pdata->max_chipselect = 1;
> +		else
> +			pdata->cs_control = fsl_spi_cs_control;
>   	}
>   
>   	ret = of_address_to_resource(np, 0, &mem);
> 
