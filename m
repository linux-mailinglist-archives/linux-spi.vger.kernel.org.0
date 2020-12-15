Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62EC2DA67F
	for <lists+linux-spi@lfdr.de>; Tue, 15 Dec 2020 03:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgLOC6R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Dec 2020 21:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgLOC6J (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Dec 2020 21:58:09 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D84EC0617B0
        for <linux-spi@vger.kernel.org>; Mon, 14 Dec 2020 18:57:24 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f17so14248281pge.6
        for <linux-spi@vger.kernel.org>; Mon, 14 Dec 2020 18:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=ngKY0Sjn9qWLku97jsHe4L0Y1G8xgTpbdWeiQvrtJZA=;
        b=A5h100jwQmONz3XmfNS8GRWoYi7ZTywRZsmI+q0Hwih7yPCRHYLfrj3s548Y9gglr4
         cxdD35mvQZ3LhNjMquBdNfhvNO3dj09dAwQbq3aczvAORsknhwcIjGLybGRkx+IvpGlb
         LF+gzyEQdH7Naul99k8ImBzW2/EYOWHDchpVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=ngKY0Sjn9qWLku97jsHe4L0Y1G8xgTpbdWeiQvrtJZA=;
        b=FUbB+iQj+36EFFnJArqJgJ0CBXPC/BDwUFvQo4CsoR8cwMBMX591epBo5u9zS0/5di
         +NyUJCMfaEu6MOEAhQwooOqfE+uLkiuW8e5x2V0tnWXffd6GFxe8H15ep4phZBfmcMHI
         eSbICZcLH85XX1RChJl6rVIbfyUyAhLmE6hvG4RQtF6zBMl0AwfoSw2l8lGIuyDSfc3c
         kuS4Oy0vkF1XYEJtKVMC4Esudkx6L78Y7CS4VN/mC3DPDVu5fs6kKh+2ULMvq5AMPSBs
         RggWrMhSlp678eVmN9mVdHkQevJ+JguBCkYezaCY/dQe5nrtm1qui+IHcA4QKr57jgvw
         74lw==
X-Gm-Message-State: AOAM531UFszuejg1WC8W5Vq0s2JxQvif2SaF7BKrm3nGJl3tZiHaeVXK
        GCWIz6Q2jzcENifyUFkwRhF4iA==
X-Google-Smtp-Source: ABdhPJxlStPt4pO2SlFIFrSVwp4iTXPBbIgqES7FvxYcwuoq9OJtC9GC0yXF2ACgC6aCoETruX7dKg==
X-Received: by 2002:a63:e:: with SMTP id 14mr27227067pga.253.1608001043616;
        Mon, 14 Dec 2020 18:57:23 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id i7sm2823074pfc.50.2020.12.14.18.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 18:57:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201214162937.2.Ibade998ed587e070388b4bf58801f1107a40eb53@changeid>
References: <20201214162937.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid> <20201214162937.2.Ibade998ed587e070388b4bf58801f1107a40eb53@changeid>
Subject: Re: [PATCH 2/2] spi: spi-geni-qcom: Really ensure the previous xfer is done before new one
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
Date:   Mon, 14 Dec 2020 18:57:21 -0800
Message-ID: <160800104145.1580929.10562113130948868794@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Douglas Anderson (2020-12-14 16:30:19)
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 6f736e94e9f4..5ef2e9f38ac9 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -145,12 +145,49 @@ static void handle_fifo_timeout(struct spi_master *=
spi,
>                 dev_err(mas->dev, "Failed to cancel/abort m_cmd\n");
>  }
> =20
> +static int spi_geni_check_busy(struct spi_geni_master *mas)

Maybe spi_geni_is_busy() and return bool?

> +{
> +       struct geni_se *se =3D &mas->se;
> +       u32 m_irq, m_irq_en;
> +
> +       /*
> +        * We grab the spinlock so that if we raced really fast and the I=
RQ
> +        * handler is still actually running we'll wait for it to exit.  =
This
> +        * can happen because the IRQ handler may signal in the middle of=
 the
> +        * function and the next transfer can kick off right away.
> +        *
> +        * Once we have the spinlock, if we're starting a new transfer we
> +        * expect nothing is pending.  We check this to handle the case w=
here
> +        * the previous transfer timed out and then handle_fifo_timeout()=
 timed
> +        * out.  This can happen if the interrupt handler was blocked for
> +        * a long time and we don't want to start any new transfers until=
 it's
> +        * all done.
> +        *
> +        * We are OK releasing the spinlock after we're done here since (=
if
> +        * we're returning 0 and going ahead with the transfer) we know t=
hat
> +        * the SPI controller must be in a quiet state.
> +        */
> +       spin_lock_irq(&mas->lock);
> +       m_irq =3D readl(se->base + SE_GENI_M_IRQ_STATUS);
> +       m_irq_en =3D readl(se->base + SE_GENI_M_IRQ_EN);
> +       spin_unlock_irq(&mas->lock);
> +
> +       if (m_irq & m_irq_en) {

Is this really "busy" though? If we canceled something out then maybe
the irq has fired but what if it's to tell us that we have some
available space in the TX fifo? Does that really matter? It seems like
if we have an RX irq when we're starting a transfer that might be bad
too but we could forcibly clear that by acking it here and then setting
the fifo word count that we're expecting for rx?

Put another way, why isn't this driver looking at the TX and RX fifo
status registers more than in one place?

> +               dev_err(mas->dev, "Busy, IRQs pending %#010x\n",
> +                       m_irq & m_irq_en);
> +               return -EBUSY;
> +       }
> +
> +       return 0;
> +}
> +
>  static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
>  {
>         struct spi_geni_master *mas =3D spi_master_get_devdata(slv->maste=
r);
>         struct spi_master *spi =3D dev_get_drvdata(mas->dev);
>         struct geni_se *se =3D &mas->se;
>         unsigned long time_left;
> +       int ret;
> =20
>         if (!(slv->mode & SPI_CS_HIGH))
>                 set_flag =3D !set_flag;
> @@ -158,6 +195,12 @@ static void spi_geni_set_cs(struct spi_device *slv, =
bool set_flag)
>         if (set_flag =3D=3D mas->cs_flag)
>                 return;
> =20
> +       ret =3D spi_geni_check_busy(mas);
> +       if (ret) {

	if (spi_geni_is_busy())

> +               dev_err(mas->dev, "Can't set chip select\n");
> +               return;
> +       }
> +
>         mas->cs_flag =3D set_flag;
> =20
>         pm_runtime_get_sync(mas->dev);
> @@ -277,8 +320,12 @@ static int setup_fifo_params(struct spi_device *spi_=
slv,
>  static int spi_geni_prepare_message(struct spi_master *spi,
>                                         struct spi_message *spi_msg)
>  {
> -       int ret;
>         struct spi_geni_master *mas =3D spi_master_get_devdata(spi);
> +       int ret;
> +
> +       ret =3D spi_geni_check_busy(mas);
> +       if (ret)

	if (spi_geni_is_busy())
		return -EBUSY;

> +               return ret;
> =20
>         ret =3D setup_fifo_params(spi_msg->spi, spi);
>         if (ret)
> @@ -440,21 +487,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfe=
r,
>         struct geni_se *se =3D &mas->se;
>         int ret;
> =20
> -       /*
> -        * Ensure that our interrupt handler isn't still running from some
> -        * prior command before we start messing with the hardware behind
> -        * its back.  We don't need to _keep_ the lock here since we're o=
nly
> -        * worried about racing with out interrupt handler.  The SPI core
> -        * already handles making sure that we're not trying to do two
> -        * transfers at once or setting a chip select and doing a transfer
> -        * concurrently.
> -        *
> -        * NOTE: we actually _can't_ hold the lock here because possibly =
we
> -        * might call clk_set_rate() which needs to be able to sleep.
> -        */
> -       spin_lock_irq(&mas->lock);
> -       spin_unlock_irq(&mas->lock);
> -
>         if (xfer->bits_per_word !=3D mas->cur_bits_per_word) {
>                 spi_setup_word_len(mas, mode, xfer->bits_per_word);
>                 mas->cur_bits_per_word =3D xfer->bits_per_word;
> @@ -511,6 +543,11 @@ static int spi_geni_transfer_one(struct spi_master *=
spi,
>                                 struct spi_transfer *xfer)
>  {
>         struct spi_geni_master *mas =3D spi_master_get_devdata(spi);
> +       int ret;
> +
> +       ret =3D spi_geni_check_busy(mas);
> +       if (ret)
> +               return ret;

	if (spi_geni_is_busy())
		return -EBUSY;
> =20
>         /* Terminate and return success for 0 byte length transfer */
>         if (!xfer->len)
