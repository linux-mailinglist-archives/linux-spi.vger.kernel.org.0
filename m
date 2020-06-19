Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C2B1FFF64
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 02:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgFSAlR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 20:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgFSAlP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jun 2020 20:41:15 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFE6C06174E
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 17:41:14 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id s6so1903488vkb.9
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 17:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uy5QSqrLYmnNfM/E3HqOfk0DC/EqnnxRUjL0YSZ6WgA=;
        b=Y7rVoh+ec4gvOWgtKpj1Vsh0QvK0RKO04loIzF9Re5iG2Mn3PaMhiKaKhmQ4K89iQX
         J4y+p2BKyyFUI702a+LS9XzNcrElaD7ju6TRYuaV67aduc1HkNeWl8LB7KG/FwgZP0Lh
         P9C0n/RxLEFHwvxs46VLMJ74VyFL9/O7576nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uy5QSqrLYmnNfM/E3HqOfk0DC/EqnnxRUjL0YSZ6WgA=;
        b=o54lccq/xiCX05vw5A7HCS25sZJe2/vkA+hoWNvEy81bN5571q1wKZrkEsNhZ2qHx0
         IAWch7gu6efz0SRG6h3Hi+SOvggOrz1J1GCWZWBy7k2hnkGXiyDrUEX/gd87affTDRwR
         tTDB7yDRefW5OZ+WrIcoaeN1xvyDgl3ODUv5POvFwrfKfhxFgsmb9kvkklTpMdMQjS0d
         s+T490E5/IfSbYIfB6LmwdemmKwSEoD3MJqRqP7wQh7mPpBD5kA3cIJKOAlBpDM/XEsX
         /jgDFSQnyUMumQJ9fg6rMtrhXo/J5Ep2A07DX088WZXB9U/J9nf3Jf/6QBjY6BLNRhyZ
         CCYA==
X-Gm-Message-State: AOAM530c4hFwct/1NmeO3qYIgKspahO0pTcOhjMgYeGcJHuwIWpR3S5n
        Ts8n3Oo/vqpt7GFDRdQE8gGsIHLtOiQ=
X-Google-Smtp-Source: ABdhPJxxU05BDzEZZW/EXqnhRIgsH9+0AFnzk0nwx/ACjk/ts9TWMBZEoViP9s9lP6eqKXVdwDwvlw==
X-Received: by 2002:a05:6122:106f:: with SMTP id k15mr5477689vko.21.1592527271593;
        Thu, 18 Jun 2020 17:41:11 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id z14sm541761vkd.31.2020.06.18.17.41.10
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 17:41:11 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id r11so4656108vsj.5
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 17:41:10 -0700 (PDT)
X-Received: by 2002:a67:e445:: with SMTP id n5mr5773162vsm.73.1592527270545;
 Thu, 18 Jun 2020 17:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200618150626.237027-1-dianders@chromium.org> <20200618233959.160032-1-swboyd@chromium.org>
In-Reply-To: <20200618233959.160032-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Jun 2020 17:40:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UwXKQcDPhqb0j+x-+kU1ZdBjVx52aY1JHx6oJRMLUPrg@mail.gmail.com>
Message-ID: <CAD=FV=UwXKQcDPhqb0j+x-+kU1ZdBjVx52aY1JHx6oJRMLUPrg@mail.gmail.com>
Subject: Re: [PATCH 6/5] spi: spi-geni-qcom: Simplify setup_fifo_xfer()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Thu, Jun 18, 2020 at 4:40 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The definition of SPI_FULL_DUPLEX (3) is really SPI_TX_ONLY (1) ORed
> with SPI_RX_ONLY (2). Let's drop the define and simplify the code here a
> bit by collapsing the setting of 'm_cmd' into conditions that are the
> same.
>
> This is a non-functional change, just cleanup to consolidate code.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 636c3da15db0..670f83793aa4 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -51,7 +51,6 @@
>  /* M_CMD OP codes for SPI */
>  #define SPI_TX_ONLY            1
>  #define SPI_RX_ONLY            2
> -#define SPI_FULL_DUPLEX                3
>  #define SPI_TX_RX              7
>  #define SPI_CS_ASSERT          8
>  #define SPI_CS_DEASSERT                9
> @@ -357,12 +356,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>
>         mas->tx_rem_bytes = 0;
>         mas->rx_rem_bytes = 0;
> -       if (xfer->tx_buf && xfer->rx_buf)
> -               m_cmd = SPI_FULL_DUPLEX;
> -       else if (xfer->tx_buf)
> -               m_cmd = SPI_TX_ONLY;
> -       else if (xfer->rx_buf)
> -               m_cmd = SPI_RX_ONLY;
>
>         spi_tx_cfg &= ~CS_TOGGLE;
>
> @@ -373,12 +366,14 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>         len &= TRANS_LEN_MSK;
>
>         mas->cur_xfer = xfer;
> -       if (m_cmd & SPI_TX_ONLY) {
> +       if (xfer->tx_buf) {
> +               m_cmd |= SPI_TX_ONLY;
>                 mas->tx_rem_bytes = xfer->len;
>                 writel(len, se->base + SE_SPI_TX_TRANS_LEN);
>         }
>
> -       if (m_cmd & SPI_RX_ONLY) {
> +       if (xfer->rx_buf) {
> +               m_cmd |= SPI_RX_ONLY;

If you're going to touch this, could you change "SPI_TX_ONLY" to
"SPI_TX_ENABLED" and "SPI_RX_ONLY" to 'SPI_RX_ENABLED".  It felt
really weird to me that if you had full duplex you were setting
"RX_ONLY" and "TX_ONLY".

Other than that, your change is nice and cleans things up a bit, so
even if you don't do the extra cleanup:

Reviewed-by: Douglas Anderson <dianders@chromium.org>



-Doug
