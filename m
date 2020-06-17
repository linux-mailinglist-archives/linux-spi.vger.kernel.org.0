Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D041FD665
	for <lists+linux-spi@lfdr.de>; Wed, 17 Jun 2020 22:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgFQUxK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Jun 2020 16:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgFQUxK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Jun 2020 16:53:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8899EC06174E
        for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2020 13:53:10 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r18so1850993pgk.11
        for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2020 13:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=QnReyXxnOu9ZZjgV+0fELmFBwkF8t9sS5NXbAXaUWrU=;
        b=gjcf4NZZMPS/xxo/MEuRK7uaEen6br1tQkcKD5yijmxio5vLdECcP+aSbIWeRjCx/b
         NlAV2NUWyZ94TjFrq0dy46OI8j5tp/dLwbwKETZPL8g7FBo9F/9PObvOAjkPYbfLOAR3
         9OcA/XGNM7veXfhq9dPzOxnL3VYn1fTd56S6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=QnReyXxnOu9ZZjgV+0fELmFBwkF8t9sS5NXbAXaUWrU=;
        b=PwHI51EBof4OpaWN8SL2XyZ9hvciNPFIvS0YvnDi7DM0UZ/rr+7SkrPZocMQR/dmHX
         6GZ0yztqTp5YCTlbnT6f6z+l1VrSrarlMBJXSZ75FTiqIEb0gXWjFWZa2dJpVxTC/SLS
         yMXhP4A16R3Z8WdNu+laTut/4EmOysTCKx5WCmo+enlnm3Sfz6RbBgGOUhtMQN7JUVns
         iUP6uTJow3PLvd1YB9oIMTQhcNpI3dl+3lXBVNTD8WttzTfPIqFWPZMcNUO3WHZIgS9s
         hlFJsJfQ2vHDCM+xWaTw247O9G6lv4vuyNPJe1yfO6MTVSS7J1A975V3i7TY8N59oYrl
         5u6A==
X-Gm-Message-State: AOAM530lElquaVR7lChInFvMhqw7agtlJ7IppSM763RStgX/HpcHTKYC
        fTwVpKBfjJ2WCCMMjJ6Yojmz+A==
X-Google-Smtp-Source: ABdhPJw75FLzMY2EKLhIE4fbWx+vsu2fEfVEDYxgCAyGOn+B2hfOzc2yzg04DadvCVQtW9r1VEj5FA==
X-Received: by 2002:a63:1a11:: with SMTP id a17mr552466pga.227.1592427189951;
        Wed, 17 Jun 2020 13:53:09 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k101sm406682pjb.26.2020.06.17.13.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:53:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200616034044.v3.2.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
References: <20200616104050.84764-1-dianders@chromium.org> <20200616034044.v3.2.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
Subject: Re: [PATCH v3 2/5] spi: spi-geni-qcom: Mo' betta locking
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Date:   Wed, 17 Jun 2020 13:53:08 -0700
Message-ID: <159242718864.62212.18160698526818943096@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Douglas Anderson (2020-06-16 03:40:47)
> If you added a bit of a delay (like a trace_printk) into the ISR for
> the spi-geni-qcom driver, you would suddenly start seeing some errors
> spit out.  The problem was that, though the ISR itself held a lock,
> other parts of the driver didn't always grab the lock.
>=20
> One example race was this:
> a) Driver queues off a command to set a Chip Select (CS).
> b) ISR fires indicating the CS is done.
> c) Done bit is set, so we complete().
> d) Second CPU gallops off and starts a transfer.
> e) Second CPU starts messing with hardware / software state (not under
>    spinlock).
> f) ISR now does things like set "mas->cur_mcmd" to CMD_NONE, prints
>    errors if "tx_rem_bytes" / "rx_rem_bytes" have been set, and also
>    Acks all interrupts it handled.

Can we get a CPU0/CPU1 diagram here? At point e) I got sort of lost. And
maybe it's not even a dual CPU problem? i.e. it can happen on one CPU?

    CPU0
    ----
 a) spi_geni_set_cs()
     mas->cur_mcmd =3D CMD_CS
     wait_for_completion_timeout(&xfer_done)
 b)  <INTERRUPT>
     geni_spi_isr()
 c)   complete(&xfer_done);
     <END INTERRUPT>
     pm_runtime_put(mas->dev);
 d) galloping?

I got lost... Sorry!
   =20
>=20
> Let's fix this.  Before we start messing with hardware, we'll grab the
> lock to make sure that the IRQ handler from some previous command has
> really finished.  We don't need to hold the lock unless we're in a
> state where more interrupts can come in, but we at least need to make
> sure the previous IRQ is done.  This lock is used exclusively to
> prevent the IRQ handler and non-IRQ from stomping on each other.  The
> SPI core handles all other mutual exclusion.

Ok maybe the problem is the completion at c) never happens until the
wait_for_completion_timeout() times out?

>=20
> As part of this, we change the way that the IRQ handler detects
> spurious interrupts.  Previously we checked for our state variable
> being set to IRQ_NONE, but that was done outside the spinlock.  We
> could move it into the spinlock, but instead let's just change it to
> look for the lack of any IRQ status bits being set.  This can be done
> outside the lock--the hardware certainly isn't grabbing or looking at
> the spinlock when it updates its status register.
>=20
> It's possible that this will fix real (but very rare) errors seen in
> the field that look like:
>   irq ...: nobody cared (try booting with the "irqpoll" option)
>=20
> NOTE: an alternate strategy considered here was to always make the
> complete() / spi_finalize_current_transfer() the very last thing in
> our IRQ handler.  With such a change you could consider that we could
> be "lockless".  In that case, though, we'd have to be very careful w/
> memory barriers so we made sure we didn't have any bugs with weakly
> ordered memory.  Using spinlocks makes the driver much easier to
> understand.
>=20
> Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI=
 based QUP")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>=20
> Changes in v3:
> - Split out some lock cleanup to previous patch.
> - Don't need to read IRQ status register inside spinlock.
> - Don't check for state CMD_NONE; later patch is removing state var.
> - Don't hold the lock for all of setup_fifo_xfer().
> - Comment about why it's safe to Ack interrupts at the end.
> - Subject/desc changed since race is definitely there.
>=20
> Changes in v2:
> - Detect true spurious interrupt.
> - Still return IRQ_NONE for state machine mismatch, but print warn.
>=20
>  drivers/spi/spi-geni-qcom.c | 45 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index c7d2c7e45b3f..e0f0e5c241f3 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -367,6 +384,12 @@ static void setup_fifo_xfer(struct spi_transfer *xfe=
r,
>         }
>         writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
>         mas->cur_mcmd =3D CMD_XFER;
> +
> +       /*
> +        * Lock around right before we start the transfer since our
> +        * interrupt controller could come in at any time now.

drop 'controller'?

> +        */
> +       spin_lock_irq(&mas->lock);
>         geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
> =20
>         /*
