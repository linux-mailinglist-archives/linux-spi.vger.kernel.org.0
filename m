Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A9F2D6B69
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 00:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgLJXAi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Dec 2020 18:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgLJW6l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Dec 2020 17:58:41 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC61C0617A6
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 14:58:00 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p6so3580071plr.7
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 14:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=kXkNmQrS5p4AS+jkjXBV5dLrCraHSXJixXeb7T1IEsM=;
        b=JOc5YXzhkQfnLmLtlx0E48GpIWaRhqg/dw5JAaETPdKpJ6eWSDv4q08gcWlhKQmrvy
         j8T8Cauj9D2f/D9Rdc45S2jCMVSeF5asOh8UmqOohgP5kwYTr0h1Wg/dP1TYGsx38WSA
         XK5Otxp5n6C7msDQlM9pVrR8EboiaGgGy3cZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=kXkNmQrS5p4AS+jkjXBV5dLrCraHSXJixXeb7T1IEsM=;
        b=LgGCq8Lvp+42YWtnhpIL25Uggei4cMKDi7UCp+l3XA+l1csXGBEmaoAlasfiAmOFBy
         ual05Q7uZaIZmQEx/aLbuYGPT0f6aQ8Py6PQh7KRRgeBoplsiNfmdmvfcdHljVA0SuY6
         OyD37EGHT01uqUL8oCy9oicN4V6BTmrszEfZvOThmislfNdqZt7UYDIRDvgTygITJk/d
         YL/cu5R7/nA4y2sxUPybDqevqFujJPww3LgCyjqTr4H5yPB8lxakXvhCgRhj/MT5t4Kn
         RbDbpoKHgEdV7CRFhMi1ipiyhJJYLcAyfDto5zoCINF0QYTJSNEqHv/JSWEviioLvTIK
         zCWg==
X-Gm-Message-State: AOAM530V7td+Tr/DpcJidMNSDywqUTdUnafGE+IGr7x5Tta++dJMR21X
        jg+3DUKTgVjqeZH8nzr1PU+ldA==
X-Google-Smtp-Source: ABdhPJwBTh7zZQCv4EdNf7nyPyWxk6VVCtdddzQSYN+RG91XOZKgDYNb/bd5V1TEuLmXRUc3VbxqmQ==
X-Received: by 2002:a17:902:b406:b029:db:3c3:e4cd with SMTP id x6-20020a170902b406b02900db03c3e4cdmr8186850plr.79.1607641080435;
        Thu, 10 Dec 2020 14:58:00 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z13sm7772300pjt.45.2020.12.10.14.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 14:57:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=WtU3cnRe6pDKFMA9_0cnQFtSOyohY_bJwZObK+KrbhVQ@mail.gmail.com>
References: <20201203074459.13078-1-rojay@codeaurora.org> <CAD=FV=XKyXnjsM4iS-ydRWBnmYMojPOaYAdYhOkxkPTCQf0RLQ@mail.gmail.com> <160757022002.1580929.8656750350166301192@swboyd.mtv.corp.google.com> <CAD=FV=WtU3cnRe6pDKFMA9_0cnQFtSOyohY_bJwZObK+KrbhVQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Fix NULL pointer access in geni_spi_isr
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Roja Rani Yarubandi <rojay@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        msavaliy@qti.qualcomm.com
To:     Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Dec 2020 14:57:57 -0800
Message-ID: <160764107797.1580929.14768824290834396298@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Doug Anderson (2020-12-10 09:14:15)
>=20
> This is my untested belief of what's happening
>=20
>  CPU0                                CPU1
>  ----                                ----
>                                      setup_fifo_xfer()
>                                       ...
>                                       geni_se_setup_m_cmd()
>                                       <hardware starts transfer>
>  <unrelated interrupt storm>          spin_unlock_irq()
>  <continued interrupt storm>         <time passes>
>  <continued interrupt storm>         <transfer complets in hardware>
>  <continued interrupt storm>         <hardware sets M_RX_FIFO_WATERMARK_E=
N>
>  <continued interrupt storm>         <time passes>
>  <continued interrupt storm>         handle_fifo_timeout()
>  <continued interrupt storm>          spin_lock_irq()
>  <continued interrupt storm>          mas->cur_xfer =3D NULL
>  <continued interrupt storm>          geni_se_cancel_m_cmd()
>  <continued interrupt storm>          spin_unlock_irq()
>  <continued interrupt storm>          wait_for_completion_timeout() =3D> =
timeout
>  <continued interrupt storm>          spin_lock_irq()
>  <continued interrupt storm>          geni_se_abort_m_cmd()
>  <continued interrupt storm>          spin_unlock_irq()
>  <continued interrupt storm>          wait_for_completion_timeout() =3D> =
timeout
>  <interrupt storm ends>
>  geni_spi_isr()
>   spin_lock()
>   if (m_irq & M_RX_FIFO_WATERMARK_EN)
>    geni_spi_handle_rx()
>     mas->cur_xfer NULL derefrence

Ok so the one line summary is "If geni_spi_isr() is sufficiently delayed
then we may deref NULL in the irq handler because the handler tries to
deref mas->cur_xfer after the timeout handling code has set it to NULL".

  CPU0                                CPU1
  ----                                ----
                                      setup_fifo_xfer()
                                       ...
                                       geni_se_setup_m_cmd()
                                       <hardware starts transfer>
  unrelated_irq_handler()              spin_unlock_irq()
   ...                               =20
                                        <transfer completes in hardware>
                                        <hardware sets M_RX_FIFO_WATERMARK_=
EN>
                                      =20
                                       handle_fifo_timeout()
                                        spin_lock_irq()
                                        mas->cur_xfer =3D NULL
                                        geni_se_cancel_m_cmd()
                                        spin_unlock_irq()
                                        wait_for_completion_timeout() =3D> =
timeout
                                        spin_lock_irq()
                                        geni_se_abort_m_cmd()
                                        spin_unlock_irq()
                                        wait_for_completion_timeout() =3D> =
timeout
   return IRQ_HANDLED;
  gic_handle_irq()
   geni_spi_isr()
    spin_lock()
    if (m_irq & M_RX_FIFO_WATERMARK_EN)
     geni_spi_handle_rx()
      rx_buf =3D mas->cur_xfer->rx_buf <--- OOPS!
=20
> With my proposed fix, I believe that would transform into:
>=20
>  CPU0                                CPU1
>  ----                                ----
>                                      setup_fifo_xfer()
>                                       ...
>                                       geni_se_setup_m_cmd()
>                                       <hardware starts transfer>
>  <unrelated interrupt storm>          spin_unlock_irq()
>  <continued interrupt storm>         <time passes>
>  <continued interrupt storm>         <transfer complets in hardware>
>  <continued interrupt storm>         <hardware sets M_RX_FIFO_WATERMARK_E=
N>
>  <continued interrupt storm>         <time passes>
>  <continued interrupt storm>         handle_fifo_timeout()
>  <continued interrupt storm>          synchronize_irq()
>  <continued interrupt storm>           <time passes>
>  <interrupt storm ends>
>  geni_spi_isr()
>   ...
>                                        <synchronize_irq() finishes>
>                                       spin_lock_irq()
>                                       mas->cur_xfer =3D NULL
>                                       geni_se_cancel_m_cmd()
>                                       spin_unlock_irq()
>  geni_spi_isr()
>    ...
>                                       wait_for_completion_timeout() =3D> =
success
>=20
> The extra synchronize_irq() I was suggesting at the end of the
> function would be an extra bit of paranoia.  Maybe a new storm showed
> up while we were processing the timeout?

Shouldn't we check in the timeout logic to see if m_irq has
M_RX_FIFO_WATERMARK_EN or M_TX_FIFO_WATERMARK_EN set instead? Similarly
for the CS assert/deassert stuff. If the timeout hits but one of those
bits are set then it seems we've run into some poor irqsoff section but
the hardware is still working. Calling synchronize_irq() wouldn't help
if the CPU handling the irqs (i.e. CPU0) had irqs off for a long time,
right? It will only ensure that other irq handlers have completed, which
may be a problem, but not the only one.

TL;DR: Peek at the irq status register in the timeout logic and skip it
if the irq is pending?
