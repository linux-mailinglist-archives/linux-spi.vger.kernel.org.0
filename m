Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C482DCB5B
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 04:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgLQDlu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Dec 2020 22:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbgLQDlt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Dec 2020 22:41:49 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F532C061794
        for <linux-spi@vger.kernel.org>; Wed, 16 Dec 2020 19:41:09 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id i7so7706700pgc.8
        for <linux-spi@vger.kernel.org>; Wed, 16 Dec 2020 19:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=wtn+d89VGS+lb6YZs3crTsqm+4MYQQeuZrVND99qLUo=;
        b=gxsXJfxefjaJMNcfm/gip5a68ZfkTRF/+SaT23czhOKHRpv2H0mW6QKhSUgUIDGX0Q
         OEJhCP9EYH9ybW0XbeVqnMBkEuPPOc2srd7DXn+4Aj7ep0L6r1YWGIIgBwxaU//H25fZ
         TaXQjot+OnMi/KZKM+mLD5aTKHeoIR+22VGIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=wtn+d89VGS+lb6YZs3crTsqm+4MYQQeuZrVND99qLUo=;
        b=GOFKdMWHrWcVwSs9oC5i1h0Fr9t1xVJm0daXa+ryvAXJ3U6iSHV+Q7dHZUzAbM1Bps
         hHuaISiZjTlnd/bUuuwVmZdPoxLKhheWyI+bs34VaCdTRdMDwAqqknB0WSna+WiNqSzY
         IWhmLCOx2D4btc/PqVM7cWN77JMQrsh9bktigyUn1hnjVdbcTXvzTO7CZsmyOqr+T3TQ
         gBZByO6x/gKr/Jg3A2nY5FYPeCywxOUkwMazUGGbMxIJQ4aPJK1H29muU/XFHv4//EXp
         RozeBGrlxSv5xgCS5kGys1yePMgO55YfzIAwizI6SUFaNs6LihYXeUvCZYv34/DKlrZ6
         ccnQ==
X-Gm-Message-State: AOAM53109T//jVcXmB4tSRgl4g6vcOjlY9RfB4hNS3n2C/Ds2A/Brn7S
        6ZI/slLYjomyFkbCjg087hHrUw==
X-Google-Smtp-Source: ABdhPJwFTXpdmhGAc2Si0XCM0EJX3RHY29n+XsEKZTFk1jmA2KYSQ5YV01gpec+/X0YqqltMv+FQsw==
X-Received: by 2002:a63:9dcf:: with SMTP id i198mr16768044pgd.242.1608176468464;
        Wed, 16 Dec 2020 19:41:08 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id 3sm4053170pfh.166.2020.12.16.19.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 19:41:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201216144114.v2.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
References: <20201216144114.v2.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
Subject: Re: [PATCH v2 1/4] spi: spi-geni-qcom: Fix geni_spi_isr() NULL dereference in timeout case
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     msavaliy@qti.qualcomm.com, akashast@codeaurora.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Date:   Wed, 16 Dec 2020 19:41:06 -0800
Message-ID: <160817646614.1580929.10863822116174167513@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Douglas Anderson (2020-12-16 14:41:49)
> In commit 7ba9bdcb91f6 ("spi: spi-geni-qcom: Don't keep a local state
> variable") we changed handle_fifo_timeout() so that we set
> "mas->cur_xfer" to NULL to make absolutely sure that we don't mess
> with the buffers from the previous transfer in the timeout case.
>=20
> Unfortunately, this caused the IRQ handler to dereference NULL in some
> cases.  One case:
>=20
>   CPU0                           CPU1
>   ----                           ----
>                                  setup_fifo_xfer()
>                                   geni_se_setup_m_cmd()
>                                  <hardware starts transfer>
>                                  <transfer completes in hardware>
>                                  <hardware sets M_RX_FIFO_WATERMARK_EN in=
 m_irq>
>                                  ...
>                                  handle_fifo_timeout()
>                                   spin_lock_irq(mas->lock)
>                                   mas->cur_xfer =3D NULL
>                                   geni_se_cancel_m_cmd()
>                                   spin_unlock_irq(mas->lock)
>=20
>   geni_spi_isr()
>    spin_lock(mas->lock)
>    if (m_irq & M_RX_FIFO_WATERMARK_EN)
>     geni_spi_handle_rx()
>      mas->cur_xfer NULL dereference!
>=20
> tl;dr: Seriously delayed interrupts for RX/TX can lead to timeout
> handling setting mas->cur_xfer to NULL.
>=20
> Let's check for the NULL transfer in the TX and RX cases and reset the
> watermark or clear out the fifo respectively to put the hardware back
> into a sane state.
>=20
> NOTE: things still could get confused if we get timeouts all the way
> through handle_fifo_timeout() and then start a new transfer because
> interrupts from the old transfer / cancel / abort could still be
> pending.  A future patch will help this corner case.
>=20
> Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI=
 based QUP")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Minor nits below.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 25810a7eef10..bf55abbd39f1 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -354,6 +354,12 @@ static bool geni_spi_handle_tx(struct spi_geni_maste=
r *mas)
>         unsigned int bytes_per_fifo_word =3D geni_byte_per_fifo_word(mas);
>         unsigned int i =3D 0;
> =20
> +       /* Stop the watermark IRQ if nothing to send */
> +       if (!mas->cur_xfer) {
> +               writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> +               return false;
> +       }
> +
>         max_bytes =3D (mas->tx_fifo_depth - mas->tx_wm) * bytes_per_fifo_=
word;
>         if (mas->tx_rem_bytes < max_bytes)
>                 max_bytes =3D mas->tx_rem_bytes;
> @@ -396,6 +402,14 @@ static void geni_spi_handle_rx(struct spi_geni_maste=
r *mas)
>                 if (rx_last_byte_valid && rx_last_byte_valid < 4)
>                         rx_bytes -=3D bytes_per_fifo_word - rx_last_byte_=
valid;
>         }
> +
> +       /* Clear out the FIFO and bail if nowhere to put it */
> +       if (mas->cur_xfer =3D=3D NULL) {

This is still =3D=3D NULL though. :(

> +               while (i++ < DIV_ROUND_UP(rx_bytes, bytes_per_fifo_word))

A for loop is also fine, but I think it would push the 80 character
limit which is probably OK. I'm happy either way, but a for loop is
usually easier to reason about. I suggested while to fit within 80
characters :/

		for (i =3D 0; i < DIV_ROUND_UP(rx_bytes, bytes_per_fifo_word); i++)

> +                       readl(se->base + SE_GENI_RX_FIFOn);
> +               return;
> +       }
