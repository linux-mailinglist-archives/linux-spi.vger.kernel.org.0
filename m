Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7022DA658
	for <lists+linux-spi@lfdr.de>; Tue, 15 Dec 2020 03:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgLOCbL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Dec 2020 21:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbgLOCaT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Dec 2020 21:30:19 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD4AC06138C
        for <linux-spi@vger.kernel.org>; Mon, 14 Dec 2020 18:29:35 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id lb18so306356pjb.5
        for <linux-spi@vger.kernel.org>; Mon, 14 Dec 2020 18:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=R317vm0CiY7uwAP0g5dRDwz/Va8bv8HoPU2xwOLWQGM=;
        b=bC0V5JbQhUag6dBTKffQMyhP0+g2vhJIZpYiu+HcMhKp4v5p4rzWobPLz4ki2pv1TG
         0qb9hYvWfqhtZekRNpHLaVQB2i7BR/zNrGcUh4oGR/xWZSEJhEx+hsv6HdtRSGskvYEE
         m5JxsD/f5L98s5y1+RhJmzArGuOtyrDrR7w1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=R317vm0CiY7uwAP0g5dRDwz/Va8bv8HoPU2xwOLWQGM=;
        b=A5J7CA6Horn1b3NrItkpc3nRjL0OWU5QNowJWwv9Lkeh+mRnSh9fE0DZMQiG8QEuYF
         xqiJTVwyzRLhrMTimE7SnQnm2yHrdtad1cTeaCYlcuCxjiC07F/HgzO20GxembjYJ+rR
         ZHdkO6LYX+vvqP597wlJjH0VT+ESXOGk78GuS/6mmks8gsAYabEWbhSjyRnEz0Q1eHpr
         LhoVoJ8ml3mmCgeFBl7vGUHIFhZ+bSZV6zLUUvTjfMnlwuL690hliQbMEO/sKTSlBnn/
         hbu/Vnn3J+TVlc8563/sAKmnSbA93uolYYdwk24OOTGRRJWxsSwGEV03HVWeo9CHX5RL
         fYbA==
X-Gm-Message-State: AOAM530I3OfyvLyvaR02PJYNhsL6Dx6FzVJyr2KLHrlQUEGykbPSvVtT
        VQ8DHsz3nNVTW7OB62tCJnOitw==
X-Google-Smtp-Source: ABdhPJyVx26L4lt7/ql4izUo0E4N0dbTUN3MpPPVWoydnM9Ubyf9ws/VPNQ2fkvKZM5BbBpsXVtXSA==
X-Received: by 2002:a17:90a:a502:: with SMTP id a2mr24162692pjq.155.1607999372623;
        Mon, 14 Dec 2020 18:29:32 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id b26sm21766115pgm.25.2020.12.14.18.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 18:29:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201214162937.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
References: <20201214162937.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
Subject: Re: [PATCH 1/2] spi: spi-geni-qcom: Fix geni_spi_isr() NULL dereference in timeout case
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     msavaliy@qti.qualcomm.com, akashast@codeaurora.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Date:   Mon, 14 Dec 2020 18:29:30 -0800
Message-ID: <160799937019.1580929.2975094455755766017@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Douglas Anderson (2020-12-14 16:30:18)
> In commit 7ba9bdcb91f6 ("spi: spi-geni-qcom: Don't keep a local state
> variable") we changed handle_fifo_timeout() so that we set
> "mas->cur_xfer" to NULL to make absolutely sure that we don't mess
> with the buffers from the previous transfer in the timeout case.
>=20
> Unfortunately, this caused the IRQ handler to dereference NULL in some
> cases.  One case:
>=20
>  CPU0                           CPU1
>  ----                           ----
>                                 setup_fifo_xfer()
>                                  ...
>                                  geni_se_setup_m_cmd()
>                                  <hardware starts transfer>
>  <unrelated interrupt storm>     spin_unlock_irq()
>  <continued interrupt storm>    <time passes>

Use ... for "time passes"

>  <continued interrupt storm>    <transfer complets in hardware>

s/complets/completes/

>  <continued interrupt storm>    <hardware sets M_RX_FIFO_WATERMARK_EN>

I'd rather just say handle_irq() or something instead of have <continued
interrupt storm> over here. Would make it easier to read and we can then
just assume that the geni_spi_isr() hasn't run. Or nothing at all and
just indicate that the irq for geni_spi_isr() comes in after the timeout
handling code.

>  <continued interrupt storm>    <time passes>
>  <continued interrupt storm>    handle_fifo_timeout()
>  <continued interrupt storm>     spin_lock_irq()
>  <continued interrupt storm>     mas->cur_xfer =3D NULL

From here

>  <continued interrupt storm>     geni_se_cancel_m_cmd()
>  <continued interrupt storm>     spin_unlock_irq()
>  <continued interrupt storm>     wait_for_completion_timeout() =3D> timeo=
ut
>  <continued interrupt storm>     spin_lock_irq()
>  <continued interrupt storm>     geni_se_abort_m_cmd()
>  <continued interrupt storm>     spin_unlock_irq()
>  <continued interrupt storm>     wait_for_completion_timeout() =3D> timeo=
ut

to here, these lines can be left out?

>  <interrupt storm ends>
>  geni_spi_isr()
>   spin_lock()
>   if (m_irq & M_RX_FIFO_WATERMARK_EN)
>    geni_spi_handle_rx()
>     mas->cur_xfer NULL derefrence

s/derefrence/dereference/

Here's a shortened version:

  CPU0                           CPU1
  ----                           ----
                                 setup_fifo_xfer()
                                  geni_se_setup_m_cmd()
                                 <hardware starts transfer>
                                 <transfer completes in hardware>
                                 <hardware sets M_RX_FIFO_WATERMARK_EN in m=
_irq>
				 ...
                                 handle_fifo_timeout()
                                  spin_lock_irq(mas->lock)
                                  mas->cur_xfer =3D NULL
                                  geni_se_cancel_m_cmd()
                                  spin_unlock_irq(mas->lock)

  geni_spi_isr()
   spin_lock(mas->lock)
   if (m_irq & M_RX_FIFO_WATERMARK_EN)
    geni_spi_handle_rx()
     mas->cur_xfer NULL dereference!

Two CPUs also don't really matter but I guess that's fine.

>=20
> Specifically it should be noted that the RX/TX interrupts are still
> shown asserted even when a CANCEL/ABORT interrupt has asserted.

Can we have 'TL;DR: Seriously delayed interrupts for RX/TX can lead to
timeout handling setting mas->cur_xfer to NULL.'?

>=20
> Let's check for the NULL transfer in the TX and RX cases.

and reset the watermark or clear out the fifo respectively to put the
hardware back into a sane state.

>=20
> NOTE: things still could get confused if we get timeouts all the way
> through handle_fifo_timeout(), meaning that interrupts are still
> pending.  A future patch will help these corner cases.
>=20
> Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI=
 based QUP")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>=20
>  drivers/spi/spi-geni-qcom.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 25810a7eef10..6f736e94e9f4 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -354,6 +354,12 @@ static bool geni_spi_handle_tx(struct spi_geni_maste=
r *mas)
>         unsigned int bytes_per_fifo_word =3D geni_byte_per_fifo_word(mas);
>         unsigned int i =3D 0;
> =20
> +       /* Stop the watermark IRQ if nothing to send */
> +       if (mas->cur_xfer =3D=3D NULL) {
> +               writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> +               return false;
> +       }
> +
>         max_bytes =3D (mas->tx_fifo_depth - mas->tx_wm) * bytes_per_fifo_=
word;
>         if (mas->tx_rem_bytes < max_bytes)
>                 max_bytes =3D mas->tx_rem_bytes;
> @@ -396,6 +402,17 @@ static void geni_spi_handle_rx(struct spi_geni_maste=
r *mas)
>                 if (rx_last_byte_valid && rx_last_byte_valid < 4)
>                         rx_bytes -=3D bytes_per_fifo_word - rx_last_byte_=
valid;
>         }
> +
> +       /* Clear out the FIFO and bail if nowhere to put it */
> +       if (mas->cur_xfer =3D=3D NULL) {

I think if (!mas->cur_xfer) is more kernel idiomatic, but sure.

> +               unsigned int words =3D DIV_ROUND_UP(rx_bytes, bytes_per_f=
ifo_word);

Any chance to move this define up to the start of the function instead
of putting it here inside the if? Or just stick it into the for loop.
It's to avoid shadow variables.

> +
> +               for (i =3D 0; i < words; i++)

		while (i++ < DIV_ROUND_UP(rx_bytes, bytes_per_fifo_word))
			readl(se->base + SE_GENI_RX_FIFOn);

> +
> +               return;
> +       }
> +
>         if (mas->rx_rem_bytes < rx_bytes)
>                 rx_bytes =3D mas->rx_rem_bytes;
>
