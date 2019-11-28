Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8CFB10C86B
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2019 13:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfK1MO0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Nov 2019 07:14:26 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:2778 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfK1MOZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 Nov 2019 07:14:25 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47NxQR3pVYz9tyK4;
        Thu, 28 Nov 2019 13:14:23 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ian736Ka; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9TlNTN1I8MLW; Thu, 28 Nov 2019 13:14:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47NxQR2kZ7z9tyJ9;
        Thu, 28 Nov 2019 13:14:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574943263; bh=0i7k3mXXptWKOwcJsJpLqVLFHfIqhIoRtVLDX0zBJq0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ian736KazrrbdAl2mMw7jDZeeP/+518s1h7YY7sKwtWw1/kwI+Pe2X9gKRwOxReJq
         A+g2DjpT8AivlgRQfohLzs0GjXGgfQXgqLhMr2H8ncJ2kimR352y3dH+pndiigJvvZ
         aVTJs/QPeLg7d8zsTIZqPVLO7KhCO3aiqvZWvR3k=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A1F158B889;
        Thu, 28 Nov 2019 13:14:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kVZvh0eiX_hF; Thu, 28 Nov 2019 13:14:24 +0100 (CET)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 178398B87E;
        Thu, 28 Nov 2019 13:14:24 +0100 (CET)
Subject: Re: [PATCH 1/3 v3] spi: fsl: Fix GPIO descriptor support
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
References: <20191128083718.39177-1-linus.walleij@linaro.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <2f7d2756-49d6-7338-06e7-13f1666236cb@c-s.fr>
Date:   Thu, 28 Nov 2019 13:14:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191128083718.39177-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 28/11/2019 à 09:37, Linus Walleij a écrit :
> This makes the driver actually support looking up GPIO
> descriptor. A coding mistake in the initial descriptor
> support patch was that it was failing to turn on the very
> feature it was implementing. Mea culpa.
> 
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Fixes: 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO descriptors")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
> ChangeLog v2->v3:
> - Resend with the rest of the patches.
> ChangeLog v1->v2:
> - New patch fixing this specific problem.
> ---
>   drivers/spi/spi-fsl-spi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
> index 114801a32371..c87e9c4506c2 100644
> --- a/drivers/spi/spi-fsl-spi.c
> +++ b/drivers/spi/spi-fsl-spi.c
> @@ -611,6 +611,7 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
>   	master->setup = fsl_spi_setup;
>   	master->cleanup = fsl_spi_cleanup;
>   	master->transfer_one_message = fsl_spi_do_one_msg;
> +	master->use_gpio_descriptors = true;
>   
>   	mpc8xxx_spi = spi_master_get_devdata(master);
>   	mpc8xxx_spi->max_bits_per_word = 32;
> 
