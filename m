Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E8C364227
	for <lists+linux-spi@lfdr.de>; Mon, 19 Apr 2021 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbhDSNAy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Apr 2021 09:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbhDSNAx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Apr 2021 09:00:53 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D87C061761
        for <linux-spi@vger.kernel.org>; Mon, 19 Apr 2021 06:00:23 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id x9so3297233uao.3
        for <linux-spi@vger.kernel.org>; Mon, 19 Apr 2021 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNMcn4oglu2NGwzmq9WcTEHn8YHQehABTWuPmJET8B4=;
        b=yndd6T37Aw2eLhE+JRuDr5ab72qnJVSgo9GhZkoptwXoz9S85Hw7A4Nbjrw+DhvLVa
         j5v8psvt9yNWE+yWB8I5Icf/q3ezqDfo35XtPYG3EgCaM5HvZF27sRd7qQsI6oXZvXA7
         dEMwIo84dMSrs8/4UbAQXC/acqXqo/vUvPZQxj3C84OIs2OkP4w/2Nt5kGMN1NY9XI4i
         aebovg1gxswYtHIRzHbH4cJqex29vham5WVGSNyXQWwBsfKuDmmM397vGhOGoWuIh7hW
         vBz+vgWlUEfaUfVB9Q1CF8snTafMMppiRNwpSSyeypv+IzH8r0cufTqSltFeVBwiLxJr
         wAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNMcn4oglu2NGwzmq9WcTEHn8YHQehABTWuPmJET8B4=;
        b=aZ5VkL/E5GHk3vmhaZJD6nXlTvZ0Mc1iQaIIOi6/McZMGzX53GO7G25jXCvBV71yLq
         CUmMOZt18YhyxA7U5HjbI3B4+D1Tcc+sCTytgAo5GcNyBXeP21Zi745VpyyEEDaz7ek8
         BYx71swHfjcNfG/jq3apb3eh/F8Ap8rbFGhJxXKp38hfdmuDlA5c0F2g8ZWcygXr5giB
         12D4BVbs1BRqRzVekxWAVBAs4x4zbZIZTu4ZlwfX/E+DP4rSphG3oO4V7noiUesdVAbO
         Uvo5CyFPRjLvvxi4/2SblYTrHbGLviE1GGVKrsko/v0Pv4QIg8/RiIN9N2EQYYMIZEsZ
         WVIw==
X-Gm-Message-State: AOAM533AXNA7kPof0uWfHvN6Ka04FSLGjWnjmo/PQfPruQ1WOEJpZVCk
        Mmwex3VkGAOuWyTPe3mMG/x2qWYrm/c3mw5ZabOVeA==
X-Google-Smtp-Source: ABdhPJwJvm4R5NxbjLn2MQj05V10FldWtWWpurPZb2rGihrkJUsFuWlmgNAc1rZuP45HV0CTYbYQXmAENNYFQN7x70I=
X-Received: by 2002:ab0:12a:: with SMTP id 39mr6601930uak.19.1618837222948;
 Mon, 19 Apr 2021 06:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210419112459.25241-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210419112459.25241-1-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Apr 2021 14:59:45 +0200
Message-ID: <CAPDyKFoizAhKxfzMzTBdQe6J5rYPLTbBTbn5nM4WAB1QGn9VUw@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] mmc: core: Correct descriptions in mmc_of_parse()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Haibo Chen <haibo.chen@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 19 Apr 2021 at 13:24, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Since it has been converted to use device property API, the function
> and field descriptions become outdated. Correct them.
>
> Fixes: 73a47a9bb3e2 ("mmc: core: Use device_property_read instead of of_property_read")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Series applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/host.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 9b89a91b6b47..ce030c5aa53c 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -209,8 +209,8 @@ mmc_of_parse_clk_phase(struct mmc_host *host, struct mmc_clk_phase_map *map)
>  EXPORT_SYMBOL(mmc_of_parse_clk_phase);
>
>  /**
> - *     mmc_of_parse() - parse host's device-tree node
> - *     @host: host whose node should be parsed.
> + * mmc_of_parse() - parse host's device properties
> + * @host: host whose properties should be parsed.
>   *
>   * To keep the rest of the MMC subsystem unaware of whether DT has been
>   * used to to instantiate and configure this host instance or not, we
> --
> 2.30.2
>
