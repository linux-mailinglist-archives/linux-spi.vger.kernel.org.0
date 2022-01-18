Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5245F49315E
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jan 2022 00:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345706AbiARXYU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 18:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344681AbiARXYU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 18:24:20 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DAFC061574
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 15:24:19 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id r15so1176568uao.3
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 15:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMJuEKQzDsNV5RvN7JiQJe6mgU0c87m5Lu3hXCmCIGM=;
        b=Bc6ilZLCc+8vO6GzqBPlkYgt00kvCclp1EEm1gbOPKcItDGV/u1zyjWwLT1/M+VSiQ
         I7Zu+fDVeptwcyMUfaekk8U17vYlCeFlzR8nTivYx78oOeTYTko7Fgl06wKHMEYoKLh4
         XWHx+Bb9nejCOrwQw35IuztGPji9rQPlSiLEi5mpbF2miN6GmWp+56BoJaKGDIi2P+lG
         Y0l2HzkNDs3N5rLWZ6rH0phJZCnavuUX/zSD/GQXXcTHRzrIifm1xhgblZ6CPHhUzAut
         yb1lBFyFCGdH4rUqdnyI9Jc5xKkpOT5M5iIdn7sm9DsQsCyfHyBF/0zGvBdjDGOlnkyw
         fqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMJuEKQzDsNV5RvN7JiQJe6mgU0c87m5Lu3hXCmCIGM=;
        b=QpNAGVmcLsSbrIROz/HtaXa74mHJEMyrQPCjxdJFnCaK+VvywtlzeQ/q2d0qlGhAHL
         5Kg2usM0skom8ElGMCHHMytcgAzoITmMUY3ZxWs320JBhe22AOw0Zl2u4uiYflkkr4Dm
         phErOGXi6cmgz9fPgz30cbV1ggDnAx0uLEN0z6V+pgUz3hYTLJHj3KqEHzkg2zDU/MVZ
         sMoK6R8tD2SvWpnamIjaMBA4BaZRKiEW/CD7llRvyz9JVUKHGulvbCxE12Yzvhz4NWvL
         0TYH0uO0m9xuEcsnM/X+Wqzw2YNQa2EXi+2Tssx6CbBPqBMth7QiJ0ZRG7edvfkOqNpo
         l/NQ==
X-Gm-Message-State: AOAM530Rdi7rLU/Fh/p14zNWS7NXxF+9ZokhzvGHiuh8gBmJXCJdYSbr
        7mWhm1qyc6yWw0rjBQUfGpbON8y+oJNwdchpao9/3Q==
X-Google-Smtp-Source: ABdhPJzdoQRyROq2JobfgwUOS3eHIknonMV7vuNy8Vo9yVVZimVwgrTJEnjsFQBcLWJfBWkI+Ybu7bX+pDtFq5GEcME=
X-Received: by 2002:a67:dd90:: with SMTP id i16mr10657565vsk.86.1642548259013;
 Tue, 18 Jan 2022 15:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20220118230915.157797-1-linus.walleij@linaro.org> <20220118230915.157797-3-linus.walleij@linaro.org>
In-Reply-To: <20220118230915.157797-3-linus.walleij@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 19 Jan 2022 01:24:07 +0200
Message-ID: <CAPLW+4=6A=FLKOum48VNUaGBUUXBa=sMYRn4n1_nTtR8a+0YQA@mail.gmail.com>
Subject: Re: [PATCH 3/3 v3] spi: s3c64xx: Convert to use GPIO descriptors
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 19 Jan 2022 at 01:11, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Convert the S3C64xx SPI host to use GPIO descriptors.
>
> Provide GPIO descriptor tables for the one user with CS
> 0 and 1.
>
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

R-b tags for 1/3 and 2/3 seem to be lost.

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Make sure to write a zero to the fb_delay if unused.
> - Drop changes to chipselect data comments.
> - Collect Review tags.
> ChangeLog v1->v2:
> - Split off code cleaning to separate patches
> ---

[snip]

> @@ -656,7 +654,11 @@ static int s3c64xx_spi_prepare_message(struct spi_master *master,
>         struct s3c64xx_spi_csinfo *cs = spi->controller_data;
>
>         /* Configure feedback delay */
> -       writel(cs->fb_delay & 0x3, sdd->regs + S3C64XX_SPI_FB_CLK);
> +       if (!cs)
> +               /* No delay if not defined */
> +               writel(0, sdd->regs + S3C64XX_SPI_FB_CLK);
> +       else
> +               writel(cs->fb_delay & 0x3, sdd->regs + S3C64XX_SPI_FB_CLK);
>

Looks good to me. I'd add {} braces and change "if (!cs)" to "if
(cs)", but that's hair splitting and not worth v4, it's fine as it is.

[snip]
