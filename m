Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D14273B8
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2019 03:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfEWBCl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 May 2019 21:02:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44528 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWBCl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 May 2019 21:02:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id b8so6505448edm.11;
        Wed, 22 May 2019 18:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tA5b54p1qAqxHmO8t68gnIq4GqiDwcEvhH8K1Xe2zjw=;
        b=qnENwEOUwQ0oxBfzZgZVDizpmBDyGrl+bjfNeGAv897O0JjjKvO/YUq6LvV0ePVtJ5
         0Wi0J1qCjbKbV4DAQhSHlLD8iEnyUGUjq3YjunPjjRgx+NwCHRqAmXLs8ISqZscv0Z9c
         kTwTfr+GPcok3Sd8A2U9A64NgglZjfRJeQroLzU9O1xP3AS4uvBPHbvtrID+zyL0YBHM
         EESszfmgC/t4uBWRQrRPCk9jv6WrEHtIJ6cfDasfXxSAEKYDB8K69kmkl7rq6IOhrkXD
         bG1xT3oL8xWv/e96b+LAI0YPGlS5ne04pg1/+jeF63vF2bs0lE8NUqq6XfyoKufrK7cV
         HBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tA5b54p1qAqxHmO8t68gnIq4GqiDwcEvhH8K1Xe2zjw=;
        b=St1heKk9WBK+XNKA97k3vGoohR9MUOTrx/CzFmcf21rdaPVgnE03y8ZD/P/rUvaBWC
         CAvodtI8OICZzYf7Obhuq//joyD7Ed73nfOxmMIJQ949BfWaT/fQRUYcFmPuzXgcXCKx
         JYcKMTRWcz35lmIh4jim4VKX8coOu9UCsmGfOy/GbRBRMADcOtjXc+1jBGhOCs/l9Ywk
         7AtVm9yBMNohe3PPnEGtpUcP1cXNHqLJoNR7C3b0xdcZZdqNuBRzeSA+Zmh+f3/nK62t
         k40dYwx8Nv3IzOrq/dhqregDL3zL43gLYxmqWc24fi6oAeonepd1dwwvE9+rGVILZ1go
         wT6w==
X-Gm-Message-State: APjAAAXpfkTIPejwNcvOZAYEkzTg54z/dfnnYWf1fnVfSx2K3WybiZIs
        UmvST/Y1MDM+DRxE0B9RJHI=
X-Google-Smtp-Source: APXvYqxMd8Rw+eFYKZ3xhYt6YenC9cRk5cOMYV4dwwHFyHns3qasNH6+Ciu3ihv7UDQS2ZFH3fJMog==
X-Received: by 2002:a50:90ea:: with SMTP id d39mr93636417eda.15.1558573359135;
        Wed, 22 May 2019 18:02:39 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id p27sm4098813ejf.65.2019.05.22.18.02.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 18:02:37 -0700 (PDT)
Date:   Wed, 22 May 2019 18:02:35 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        ldewangan@nvidia.com, broonie@kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH V5 4/4] spi: tegra114: add support for TX and RX trimmers
Message-ID: <20190523010235.GA105588@archlinux-epyc>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
 <1557810235-16401-5-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557810235-16401-5-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sowjanya,

On Mon, May 13, 2019 at 10:03:55PM -0700, Sowjanya Komatineni wrote:
> Tegra SPI master controller has programmable trimmers to adjust the
> data with respect to the clock.
> 
> These trimmers are programmed in TX_CLK_TAP_DELAY and RX_CLK_TAP_DELAY
> fields of COMMAND2 register.
> 
> SPI TX trimmer is to adjust the outgoing data with respect to the
> outgoing clock and SPI RX trimmer is to adjust the loopback clock with
> respect to the incoming data from the slave device.
> 
> These trimmers vary based on trace lengths of the platform design for
> each of the slaves on the SPI bus and optimal value programmed is from
> the platform validation across PVT.
> 
> This patch adds support for configuring TX and RX clock delay trimmers
> through the device tree properties.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/spi/spi-tegra114.c | 67 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> index e59ff7c1cee6..253a7f182fc9 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c

<snip>

> +static void tegra_spi_cleanup(struct spi_device *spi)
> +{
> +	struct tegra_spi_client_data *cdata = spi->controller_data;
> +
> +	spi->controller_data = NULL;
> +	if (spi->dev.of_node)
> +		kfree(cdata);
> +}
> +

This function is not called anywhere and it is marked as static so it
triggers an unused function warning. Was that intentional?

drivers/spi/spi-tegra114.c:938:13: warning: unused function 'tegra_spi_cleanup' [-Wunused-function]
static void tegra_spi_cleanup(struct spi_device *spi)
            ^
1 warning generated.

Cheers,
Nathan
