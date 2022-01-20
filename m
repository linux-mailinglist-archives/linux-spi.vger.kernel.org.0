Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609FF4951B5
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jan 2022 16:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346176AbiATPpu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jan 2022 10:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346016AbiATPpu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jan 2022 10:45:50 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFCCC061574;
        Thu, 20 Jan 2022 07:45:50 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m11so30352234edi.13;
        Thu, 20 Jan 2022 07:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bojt1cq8eqmehCFdf7q2oCFRQ8rKvEo0i4l4sBwygPU=;
        b=qAYNgaEozdsfpabfPMCYsQnCjsGbRoQL3GhRsCiNxa78wkEQV0XxJZyA0taRKwd3od
         7Si2s3y3I/5mp2hyJVM34lWEpuygDUJ8Q6nZvDB4Zqw3mMM8z/GYBHfmKoruMiZc7buI
         CSnD4pn1VSfSnDPrZna+hS/zkxCH2MStkU4hWyp3Llg+eOXr0TUTMMixFl9t8e3GMF3d
         eMy8xL+4eznGE949RJyHvWDumiohU5aIFvjY5Hthppky+OavJRTz5J115kseQnRkGx8E
         f95LOFnq7nnPPdHGG6QMxP6bZy3MFP5sC/uFFACjPyc+uKBvPU6G1eHaZd/SuGNPpKRG
         Czxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bojt1cq8eqmehCFdf7q2oCFRQ8rKvEo0i4l4sBwygPU=;
        b=8BuwgRC6hizRxy71cvvHI3tg5cKN4YXqQU++4F43zRrj0NOyw4R3n5q0bEO9wa03S+
         2rUvuxkiRlX5zlu4PMytyna883Mb1CzzIBAmW44wC8NKch7B1hQ0oCXY1j2WkFJYr8FP
         BhMDxG1Bu0Wf4k0Qb0KmZMc5jmuJJuDG1pgPhZlvgtQDpV7EgCzFvEI0JzAuyhmF4nGI
         UnkDjwL6OsTX+yivAj3x/WemUmjrntzz4OHl4XGcL8vgr6W4eZGsBieRkIWo379PK6r9
         qtXAp0nRiSkqgoGhI7ZBywf/eM7vL453xmY47/RHENiFWaz7N+ObCn5WQMxQvM2jjmBR
         QiJg==
X-Gm-Message-State: AOAM530xxgJVA2GKvzeJCZqaf6s8tk9FmaZInvFdhht+TBH13ExHVLGE
        Y5YFEldz0hyPtrnv44PksJzgZInvpRF7BYFc7RI=
X-Google-Smtp-Source: ABdhPJwSlmq5dL42E/rJ/5HNGr0ky2W7IX4dNnb+7dy+H7+8bfDWemciLlOKSVFP2kfwc8pIeNknLGlmldEhwnzPVZs=
X-Received: by 2002:a17:906:7948:: with SMTP id l8mr11438618ejo.636.1642693548839;
 Thu, 20 Jan 2022 07:45:48 -0800 (PST)
MIME-Version: 1.0
References: <20220118110928.120640-1-linus.walleij@linaro.org> <20220118110928.120640-3-linus.walleij@linaro.org>
In-Reply-To: <20220118110928.120640-3-linus.walleij@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Jan 2022 17:44:06 +0200
Message-ID: <CAHp75Vev_xH_MPe0S1CDfC5tUetzfZEQVJpNsePRddK6czLnPA@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] spi: s3c64xx: Convert to use GPIO descriptors
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jan 20, 2022 at 9:40 AM Linus Walleij <linus.walleij@linaro.org> wrote:

...

> +static struct gpiod_lookup_table crag_spi0_gpiod_table = {
> +       .dev_id = "s3c6410-spi.0",
> +       .table = {
> +               GPIO_LOOKUP_IDX("GPIOC", 3, "cs", 0, GPIO_ACTIVE_LOW),
> +               GPIO_LOOKUP_IDX("GPION", 5, "cs", 1, GPIO_ACTIVE_LOW),

> +               { },

Since it will be v3 of the series, can we remove the comma in the
terminator line?

> +       },
> +};

...

> +       /* This was dynamically allocated on the DT path */

> +       if (spi->dev.of_node)

I believe we may survive w/o this check(s).

> +               kfree(cs);

--
With Best Regards,
Andy Shevchenko
