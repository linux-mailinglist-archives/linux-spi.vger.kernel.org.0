Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47545615F6
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jun 2022 11:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiF3JSd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Jun 2022 05:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbiF3JSC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Jun 2022 05:18:02 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3B73FBEF
        for <linux-spi@vger.kernel.org>; Thu, 30 Jun 2022 02:16:47 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-317710edb9dso173256607b3.0
        for <linux-spi@vger.kernel.org>; Thu, 30 Jun 2022 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2VcWUn76owMkahIiSpe6u3dmJvIJ7O7/SunZB5ovaY=;
        b=EIZ5mBcgizaSwAGmq8RVN4Ev0EgefBfQ1Zkam3vTcFZbuOMtG8vnYJWocqRzbgnrqp
         Hyzh/VH2EDFZWQs5uN738AesOeGyPhc5e45LDg+anBaRy2a/EN28QLRuUcxDG6InguBL
         pOALxDvaFC8nD2KIw6whHPam9YQAA4HbTu7zN9ag0BnhNxbWZDVQCAlBupiGGjRkroZc
         zqCG8/QOEmVkq9Rxpb7H/Uk7/vbJqADBHWAqo0UNOxAROQET3/nNxpJmgENWPr6uP2am
         q0DOqGm9kzthmJVC+WO1GuLwK1cWU7dKrDuHI4ShAORa95YMl1DfAI6HD9Z5WInpN8nO
         TWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2VcWUn76owMkahIiSpe6u3dmJvIJ7O7/SunZB5ovaY=;
        b=I13AzihcAqSBg22rlr078HgeMCgvU9A1sr8/zEYybFtXixPkKjTPdh++TgyHLntHYl
         O/HNjzXD+RbTu/x3cgqejmwYWtXl+m1J+Hja1OtOfFOiw26vq+u3sjJbaNqRq2wihcqb
         p8+v/HA96UES+njviIIZ5Jq4ACJ7eG5PKFCnXFQPi/BlU4VNcpAu1xrlbMQw2WUfvOjA
         tOt+3KM+5MRoKXsFDL636kRUIiTAnOrmdxX6boXqryW8W3lWGjOB4RZV5463uOF0j55w
         p1981hHkDwFmO4CDFkfZfOIp6uVqaWgy+z4cwiFxSw1PQzbLmScN9pzlz0GBlDX67gz6
         jMLA==
X-Gm-Message-State: AJIora8G1Om7UfQHpZK+Cx0NWSQe+0h9yypuYE8ulTqSirXepkXNtDkp
        NwyUxoiqe0HqAheFKTQJTqUC6+k9b9naUEUsUUQMfg==
X-Google-Smtp-Source: AGRyM1tjLZ153j7Np3XGNGpSK5G64rKc8JOpc+/Fc3g7HcwAIDXbcAmIMxNFbsul/0N0Bx967t8Cyw5rxHBJe9cOL4w=
X-Received: by 2002:a81:71c6:0:b0:318:38d5:37f3 with SMTP id
 m189-20020a8171c6000000b0031838d537f3mr9507316ywc.268.1656580607004; Thu, 30
 Jun 2022 02:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220629102527epcas2p42e99f44d529d215623bd0e12a082d1dd@epcas2p4.samsung.com>
 <20220629102304.65712-1-chanho61.park@samsung.com> <20220629102304.65712-3-chanho61.park@samsung.com>
In-Reply-To: <20220629102304.65712-3-chanho61.park@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 30 Jun 2022 11:16:35 +0200
Message-ID: <CACRpkdagXnR0jjHNOVgGkh_ZntfzF0h4D_+DX85jNy7q=6DNEw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] spi: s3c64xx: support custom value of internal
 clock divider
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jun 29, 2022 at 12:27 PM Chanho Park <chanho61.park@samsung.com> wrote:

> Modern exynos SoCs such as Exynos Auto v9 have different internal clock
> divider, for example "4". To support this internal value, this adds
> clk_div of the s3c64xx_spi_port_config and assign "2" as the default
> value to existing s3c64xx_spi_port_config.
>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>

While this gives a way to set up the default clock divider (which is
fair) I think
you should probably go the extra mile and make this clock divider a proper
clock abstraction, so the driver can respect the DT standard property
spi-max-frequency
from Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml

This actually isn't very hard: look for example in the PL111 driver,
a hardware block that contains a similar internal clock divider:
drivers/gpu/drm/pl111/pl111_display.c
check how we define a clock from pl111_clk_div_ops.
in pl111_init_clock_divider().

Then the driver probe() just grabs that clock and sets the frequency.
The algorithms should be pretty much copy/paste.

Yours,
Linus Walleij
