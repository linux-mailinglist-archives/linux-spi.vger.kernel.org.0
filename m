Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3525318909F
	for <lists+linux-spi@lfdr.de>; Tue, 17 Mar 2020 22:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgCQVgI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 17:36:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46066 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQVgI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 17:36:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id m15so12426963pgv.12
        for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2020 14:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=BuwvsZeimQDkQpev+Q7S5dE+q3GCnNEjp38tniCRzYI=;
        b=SkHfn5G49XpURGYF4oS6Y9PMvk2G2jCEMH8gBg9h7SWE8wcXcGCpg21f9dVUbbg42n
         M4yYiYT+x/b/hUAwITmtqePe3Hg5i8Ur2tKmTVMOifCzD604epWzds7NEioAECB/9Bj0
         EDJqCBsNp6FU3pQYB4lj49gMh0oVMWqhVAdlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=BuwvsZeimQDkQpev+Q7S5dE+q3GCnNEjp38tniCRzYI=;
        b=cWmGayDtrqsXkXELUYOFenEh84nB0a0tyWRor3Bzvmcy/JKBDlxjcV5IRAmWJCabDj
         axj4hhpYQXLWVhxY2OJoEcXmr4iR0nXeaxcNPOBj1nifCFzhPaRXSh6pt5LiXFacxn5k
         k7BzzQaHlxOK6A9R2gJrfIA/1VLa+NzTNIbvXNW1VyWAfT0z5c1Qdq4Hk5bmypcSGE4P
         vTckHnYaYuBqkkFspsEHVekSqttSMhSD71+W7wL1Nvinu8Py6MxLVuGBfaZKS2nnUd4n
         uD8ZYI+qcGFia75YF7QoLSXn55At2VTg21CoUpGRLT2PdO4EVHwWRFozOP9qCNvbpLX0
         hdCQ==
X-Gm-Message-State: ANhLgQ0zu4ascuChXGxXhYsUBBAHqiR9nuUQukDHXHY5aQbp9p3TaiCd
        mfE2RJPSntpV+kmnSDsL9vcvMw==
X-Google-Smtp-Source: ADFU+vsFZ92/8CyAY2RwaYMNsT84OqbrxUqYGUqZ3oUYdEsUIdaVGFdW3NqTO8uLEHP/8rkDVtL1zw==
X-Received: by 2002:a63:5f51:: with SMTP id t78mr1234895pgb.362.1584480966732;
        Tue, 17 Mar 2020 14:36:06 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w128sm3499640pgb.55.2020.03.17.14.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 14:36:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200317133653.v2.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
References: <20200317133653.v2.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
Subject: Re: [PATCH v2] spi: spi-geni-qcom: Speculative fix of "nobody cared" about interrupt
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Date:   Tue, 17 Mar 2020 14:36:05 -0700
Message-ID: <158448096503.88485.8894151453752608519@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Douglas Anderson (2020-03-17 13:37:06)
> Every once in a while (like once in a few months on a device) people
> have seen warnings on devices using spi-geni-qcom like:
>=20
>   irq ...: nobody cared (try booting with the "irqpoll" option)
>=20
> ...where the interrupt number listed matches up with "spi_geni" in
> /proc/interrupts.
>=20
> You can get "nobody cared" if the interrupt handler returns IRQ_NONE.
> Once you get into this state the driver will just stop working.
>=20
> Auditing the code makes me believe that it's probably not so good
> checking "cur_mcmd" in the interrupt handler not under spinlock.
> Let's move it to be under spinlock.  Looking more closely at the code,
> it looks as if there are some other places that could be under
> spinlock, so let's add.  It looks as if the original code was assuming
> that by the time that the interrupt handler got called that the write
> to "cur_mcmd" (to make it not CMD_NONE anymore) would make it to the
> processor handling the interrupt.  Perhaps with weakly ordered memory
> this sometimes (though very rarely) happened.
>=20
> Let's also add a warning (with the IRQ status) in the case that we
> ever end up getting an interrupt when we think we shouldn't.  This
> would give us a better chance to debug if this patch doesn't help the
> issue.  We'll also try our best to clear the interrupt to hopefully
> get us out of this state.
>=20
> Patch is marked "speculative" because I have no way to reproduce this
> problem, so I'm just hoping this fixes it.  Weakly ordered memory
> makes my brain hurt.

It could be that. It could also be the poor design of geni_se_init() and
how it enables many interrupts that this driver doesn't look to handle?
Why do we allow the wrapper to enable all those bits in
M_COMMON_GENI_M_IRQ_EN and S_COMMON_GENI_S_IRQ_EN if nobody is going to
handle them?

>=20
> Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI=
 based QUP")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>=20
> Changes in v2:
> - Detect true spurious interrupt.
> - Still return IRQ_NONE for state machine mismatch, but print warn.
>=20
>  drivers/spi/spi-geni-qcom.c | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index c3972424af71..92e51ccb427f 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -151,16 +151,19 @@ static void spi_geni_set_cs(struct spi_device *slv,=
 bool set_flag)
>         struct geni_se *se =3D &mas->se;
>         unsigned long time_left;
> =20
> -       reinit_completion(&mas->xfer_done);
>         pm_runtime_get_sync(mas->dev);
>         if (!(slv->mode & SPI_CS_HIGH))
>                 set_flag =3D !set_flag;
> =20
> +       spin_lock_irq(&mas->lock);

Why is this spin_lock_irq() vs. spin_lock_irqsave()? This isn't possible
to be called from somewhere that hasn't changed irq flags?

> +       reinit_completion(&mas->xfer_done);
> +
>         mas->cur_mcmd =3D CMD_CS;
>         if (set_flag)
>                 geni_se_setup_m_cmd(se, SPI_CS_ASSERT, 0);
>         else
>                 geni_se_setup_m_cmd(se, SPI_CS_DEASSERT, 0);
> +       spin_unlock_irq(&mas->lock);

This will force on interrupts if they were masked.

> =20
>         time_left =3D wait_for_completion_timeout(&mas->xfer_done, HZ);
>         if (!time_left)
> @@ -307,6 +310,8 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>         u32 spi_tx_cfg, len;
>         struct geni_se *se =3D &mas->se;
> =20
> +       spin_lock_irq(&mas->lock);
> +
>         spi_tx_cfg =3D readl(se->base + SE_SPI_TRANS_CFG);
>         if (xfer->bits_per_word !=3D mas->cur_bits_per_word) {
>                 spi_setup_word_len(mas, mode, xfer->bits_per_word);
> @@ -376,6 +381,8 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>          */
>         if (m_cmd & SPI_TX_ONLY)
>                 writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
> +
> +       spin_unlock_irq(&mas->lock);
>  }
> =20
>  static int spi_geni_transfer_one(struct spi_master *spi,
> @@ -478,13 +485,29 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>         struct geni_se *se =3D &mas->se;
>         u32 m_irq;
>         unsigned long flags;
> -
> -       if (mas->cur_mcmd =3D=3D CMD_NONE)
> -               return IRQ_NONE;
> +       irqreturn_t ret =3D IRQ_HANDLED;
> =20
>         spin_lock_irqsave(&mas->lock, flags);
>         m_irq =3D readl(se->base + SE_GENI_M_IRQ_STATUS);

Does this read need to be inside the lock?

> =20
> +       /* Check for spurious interrupt */
> +       if (!m_irq) {
> +               ret =3D IRQ_NONE;
> +               goto exit;

I ask because it could be simplified by reading the status and then
immediately returning IRQ_NONE if no bits are set without having to do
the lock/unlock dance. And does writing 0 to the irq clear register do
anything?

> +       }
> +
> +       /*
> +        * If we got a real interrupt but software state machine thinks
> +        * we were idle then give a warning.  We'll do our best to clear
> +        * the interrupt but we'll still return IRQ_NONE.  If this keeps
> +        * happening the system will eventually disable us.
> +        */
> +       if (mas->cur_mcmd =3D=3D CMD_NONE) {
> +               pr_warn("Unexpected SPI interrupt: %#010x\n", m_irq);
> +               ret =3D IRQ_NONE;
> +               goto exit;
> +       }
> +
>         if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_E=
N))
>                 geni_spi_handle_rx(mas);
> =20
> @@ -523,9 +546,11 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>                 complete(&mas->xfer_done);
>         }
> =20
> +exit:
>         writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
>         spin_unlock_irqrestore(&mas->lock, flags);
> -       return IRQ_HANDLED;
> +
> +       return ret;
>  }
> =20
>  static int spi_geni_probe(struct platform_device *pdev)
