Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3E8249E35
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgHSMhu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 19 Aug 2020 08:37:50 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:41099 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgHSMhh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:37:37 -0400
Received: by mail-ej1-f65.google.com with SMTP id t10so26087374ejs.8;
        Wed, 19 Aug 2020 05:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6FCKFOV4tXuhe4ALaKK45GgE/rtv2KFtTsBAHakWHm4=;
        b=CocKN0U5OmS0A9cRNxM7XxA7kFlY1XGFx/vS47SaPi+ke1XyjYcuyi84gaHrjyvkh/
         dvPCBmaVxEFZKYWYoT/fSALggJBilw9EpuMBcxuZbffjIHIPoJQy5z0TWM/uOQrU77X4
         +7uKkrakBmB98YCmfhsvGprQ5exW+z9neYLOD+41qTYSRb8B1Ep+kgbwERT1NVgc91dz
         WA0nNFcNWEUdk4oz1H5Mpz4lUsGcNHsCTnqvxNm+gKLWoV+t5nK9ENXD8vhMS9e1hFZU
         Z1q7OW+ldGcO//JpkTmDUXDMLKuq6VnHv10RbpIArho++lzE6s79kgmRDpU47wFnORKq
         QV6A==
X-Gm-Message-State: AOAM5327rMf1eoWeNlrjJoxqEPQusspEMU7OljDXBFgKJIUbUxb3gea6
        zSMTbtd8CWWgQ4PMYblmT4U=
X-Google-Smtp-Source: ABdhPJw9xEf2bvQxWdoKfV7GBCyYJK5pCq04/DM+3vXVGjGug31Euua3pze+tmiaLYIlaBLh8/tQsA==
X-Received: by 2002:a17:906:cc51:: with SMTP id mm17mr25546416ejb.137.1597840654741;
        Wed, 19 Aug 2020 05:37:34 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id pv28sm18391843ejb.71.2020.08.19.05.37.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 05:37:34 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:37:32 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 5/8] spi: spi-s3c64xx: Fix doc comment for struct
 s3c64xx_spi_driver_data
Message-ID: <20200819123732.GA18122@kozik-lap>
References: <20200819123208.12337-1-l.stelmach@samsung.com>
 <CGME20200819123227eucas1p11cd47cf281a035ed02d5fc819a0370c1@eucas1p1.samsung.com>
 <20200819123208.12337-6-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200819123208.12337-6-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 19, 2020 at 02:32:05PM +0200, Łukasz Stelmach wrote:
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>

Hi,

Missing commit msg - fix what exactly?

You need to rebase your patch as most of these were already fixed by Lee
Jones.

However he did not remove the @rx_dmach and tx entries...

Best regards,
Krzysztof

> ---
>  drivers/spi/spi-s3c64xx.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 6fe896f2be18..505789f91fdf 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -155,19 +155,21 @@ struct s3c64xx_spi_port_config {
>   * @clk: Pointer to the spi clock.
>   * @src_clk: Pointer to the clock used to generate SPI signals.
>   * @ioclk: Pointer to the i/o clock between master and slave
> + * @pdev: Pointer to the SPI controller platform device
>   * @master: Pointer to the SPI Protocol master.
>   * @cntrlr_info: Platform specific data for the controller this driver manages.
>   * @lock: Controller specific lock.
>   * @state: Set of FLAGS to indicate status.
> - * @rx_dmach: Controller's DMA channel for Rx.
> - * @tx_dmach: Controller's DMA channel for Tx.
> + * @rx_dma: Controller's DMA channel for Rx.
> + * @tx_dma: Controller's DMA channel for Tx.
>   * @sfr_start: BUS address of SPI controller regs.
>   * @regs: Pointer to ioremap'ed controller registers.
> - * @irq: interrupt
>   * @xfer_completion: To indicate completion of xfer task.
>   * @cur_mode: Stores the active configuration of the controller.
>   * @cur_bpw: Stores the active bits per word settings.
>   * @cur_speed: Stores the active xfer clock speed.
> + * @port_conf: Pointer to the SPI port configuration
> + * @port_id: SPI port ID number
>   */
