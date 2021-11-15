Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4295545050C
	for <lists+linux-spi@lfdr.de>; Mon, 15 Nov 2021 14:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhKONMw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 08:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhKONMq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Nov 2021 08:12:46 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58E2C061200
        for <linux-spi@vger.kernel.org>; Mon, 15 Nov 2021 05:09:47 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id k23so7287696lje.1
        for <linux-spi@vger.kernel.org>; Mon, 15 Nov 2021 05:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdNnu6u0t53RxSPdU4MDPOEl5NW5wFhi+3tVJwsouBE=;
        b=AdlSGIXoBXq0VXgOWXENRxISfNEhM8HAmvts1hlgX2aW8p19gg4TWR8iIt27dsvmv1
         Er40yU2EVPgsKue7HjKRPzcvCEAOuYUSYPQRd7hA06J3e13A1mkLA77EDajw9vHVT420
         Lbp3x0tqpEh+8MBGtUYl/2+fVKsJM1+f+AKqTG6X7Kh0veEaJi77Iw0fl7cmv+hbpWsF
         4j+O7DBKUFLat0Nxi8uwYiTs345Prp9Z/jgqtkOJyAyKfWa7I7unOeTjMa5rmjmc3Xwr
         9Mt+CjQwmzF7FQsUxJSUVdME7aWf6slT3nqVKg54VhTbXds90COzK7cp9x7YBV5y9jx3
         XScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdNnu6u0t53RxSPdU4MDPOEl5NW5wFhi+3tVJwsouBE=;
        b=WgjzXOaRiXDQQfBxPpsj3VGuDeP5lHMqAIjuR/UlHCAnkce+e7ZcZc0NusSV1IymJy
         C9ACJhI+lyRiTdQAsH2TSzK1Q4frLVz6NuMGlq03kn313Mv+/cDN1jtJ5waeRJg1wO94
         akUlTM1FUAePjJBcjPMkjaG3suu8tdWOONooONKa4pYBZTWSVwgAXDX8R6cy+0Giwh9h
         LdcbEAsSVilguLrw6EOwKNi5Jpyu6pVRGlLiIl7YTTlumd2XxQCgCmTKVzzAgOk0GBXw
         C4v1g6a0BPYMaop9aF8qEyk+fwp2Al7ADMyhZdv+3weA13YpMNsGSMtIhIjmtSW6jWr6
         IeBw==
X-Gm-Message-State: AOAM531Doj46svI3q4KoDrHxzEZtv2+SX+spi4f+onEkVZPdmWFFPgPq
        HP2jC+uBhRrld+zKAYjl74p8GW9vzLOMO/VMb+wFHQ==
X-Google-Smtp-Source: ABdhPJxdsC0uW2HE6zj+9SqQN+4ObrVjDxA5TLNECz/k4cRg87wjRG7GU625P/bUeyp/NjunxRKqIwie+Tr+AjkZQG4=
X-Received: by 2002:a2e:80c3:: with SMTP id r3mr38617043ljg.4.1636981785962;
 Mon, 15 Nov 2021 05:09:45 -0800 (PST)
MIME-Version: 1.0
References: <20211115085403.360194-1-arnd@kernel.org> <20211115085403.360194-4-arnd@kernel.org>
In-Reply-To: <20211115085403.360194-4-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Nov 2021 14:09:09 +0100
Message-ID: <CAPDyKFovVgrDxJ5eFgvAzwJNTrYSzjtz7z9UCa3rHMsgkFqsxA@mail.gmail.com>
Subject: Re: [PATCH 03/11] mmc: bcm2835: stop setting chan_config->slave_id
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Gross <agross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jon Hunter <jonathanh@nvidia.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Scott Branden <sbranden@broadcom.com>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 15 Nov 2021 at 09:55, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The field is not interpreted by the DMA engine driver, as all the data
> is passed from devicetree instead. Remove the assignment so the field
> can eventually be deleted.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/bcm2835.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 8c2361e66277..463b707d9e99 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1293,14 +1293,12 @@ static int bcm2835_add_host(struct bcm2835_host *host)
>
>                 host->dma_cfg_tx.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>                 host->dma_cfg_tx.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -               host->dma_cfg_tx.slave_id = 13;         /* DREQ channel */
>                 host->dma_cfg_tx.direction = DMA_MEM_TO_DEV;
>                 host->dma_cfg_tx.src_addr = 0;
>                 host->dma_cfg_tx.dst_addr = host->phys_addr + SDDATA;
>
>                 host->dma_cfg_rx.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>                 host->dma_cfg_rx.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -               host->dma_cfg_rx.slave_id = 13;         /* DREQ channel */
>                 host->dma_cfg_rx.direction = DMA_DEV_TO_MEM;
>                 host->dma_cfg_rx.src_addr = host->phys_addr + SDDATA;
>                 host->dma_cfg_rx.dst_addr = 0;
> --
> 2.30.2
>
