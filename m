Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15F2292C5
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 09:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgGVH7D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jul 2020 03:59:03 -0400
Received: from gloria.sntech.de ([185.11.138.130]:41056 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbgGVH7D (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Jul 2020 03:59:03 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jy9eR-0001l3-18; Wed, 22 Jul 2020 09:58:55 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] spi: rockchip: Fix error in SPI slave pio read
Date:   Wed, 22 Jul 2020 09:58:54 +0200
Message-ID: <1605191.QXBl1gRHXa@diego>
In-Reply-To: <20200722065257.17943-3-jon.lin@rock-chips.com>
References: <20200722065257.17943-1-jon.lin@rock-chips.com> <20200722065257.17943-3-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Jon,

Am Mittwoch, 22. Juli 2020, 08:52:57 CEST schrieb Jon Lin:
> The RXFLR is possible larger than rx_left in Rockchip SPI, fix it.
> 
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
>  drivers/spi/spi-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index a451dacab5cf..1f5e613b67d9 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -291,7 +291,7 @@ static void rockchip_spi_pio_writer(struct rockchip_spi *rs)
>  static void rockchip_spi_pio_reader(struct rockchip_spi *rs)
>  {
>  	u32 words = readl_relaxed(rs->regs + ROCKCHIP_SPI_RXFLR);
> -	u32 rx_left = rs->rx_left - words;
> +	u32 rx_left = rs->rx_left > words ? rs->rx_left - words : 0;

I guess for future readability of the code braces might be nice, like

	u32 rx_left = (rs->rx_left > words) ? rs->rx_left - words : 0;

But I stumbled onto (and fixed similarly) that issue yesterday as well, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Heiko


