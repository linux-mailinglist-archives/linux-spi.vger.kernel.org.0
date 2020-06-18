Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4EB1FFA96
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 19:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbgFRRwb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 13:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730019AbgFRRw2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jun 2020 13:52:28 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E12C0613ED
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 10:52:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s10so3251559pgm.0
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=C8EgQ5kpJpXbsfnBjGS4DcIUAIAChCYddaoNI74Zmnk=;
        b=itZRM3rj6KxTlC708bquIbtauYcpndzvBnRLoWk73Vw04Xzo4nrbyrXUAMJZ54+QKC
         oqmr4tnXu0I/MELTwHl4WP4Lyta61grpCaJA+gmn8JJsxzW6y+T1Qyif1vIgHt30FoFQ
         kL16p2DFrwm0XpZCqOKpIOBfMNq/35U4JxMo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=C8EgQ5kpJpXbsfnBjGS4DcIUAIAChCYddaoNI74Zmnk=;
        b=gCvFrtOcdNvnJR33bfSFZokkE8Sr98yZokOdNKo5FWwIXG+uXtrE6+HtzNprPKTHn1
         r0mMKsw/DA6rWzfqHu/worzCwuUX3qffa9Tx+LvU62IZQsYOuQFiA6zH0IuHV717GXcH
         SIk7ilMLisiYNYegM3ETSsRHRBFUkBhuWkXln4kmXdnxxYxxsrf6JJDpVPg/ZhYKNYsP
         Nuw9rIUgNuhscuDWbhWwVq04jt2SshMubsr+ialYogrd8VkJ1omTwPY2QR0twdos24Vr
         LY/8PiRKd0bbUcrGptU7FXY7m8ZI9DDCMIQ6Hg2IaQLFX4xg0AnBFtvrshiEcnWE4jSd
         TaBA==
X-Gm-Message-State: AOAM532kcyUbNpHpmtOJKtxMlcUIUU6g8buCnNXBkMkVri/zNQbZAMev
        ViVsv5m+oDWJWnvQGohZxMbLew==
X-Google-Smtp-Source: ABdhPJyHqgGiYugRC2yluT1gIyqjOFp12zlaAsKRmWsOS2rdODxX2vq/08RhYR9Y1gG1mDfsrHa0rQ==
X-Received: by 2002:a62:fc52:: with SMTP id e79mr4548576pfh.5.1592502747459;
        Thu, 18 Jun 2020 10:52:27 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q11sm3114697pjq.52.2020.06.18.10.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 10:52:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200618080459.v4.2.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
References: <20200618150626.237027-1-dianders@chromium.org> <20200618080459.v4.2.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
Subject: Re: [PATCH v4 2/5] spi: spi-geni-qcom: Mo' betta locking
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Date:   Thu, 18 Jun 2020 10:52:25 -0700
Message-ID: <159250274581.62212.7220017192299709142@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Douglas Anderson (2020-06-18 08:06:23)
> If you added a bit of a delay (like a trace_printk) into the ISR for
> the spi-geni-qcom driver, you would suddenly start seeing some errors
> spit out.  The problem was that, though the ISR itself held a lock,
> other parts of the driver didn't always grab the lock.
>=20
> One example race was this:
>   CPU0                                         CPU1
>   ----                                         ----
>   spi_geni_set_cs()
>    mas->cur_mcmd =3D CMD_CS;
>    geni_se_setup_m_cmd(...)
>    wait_for_completion_timeout(&xfer_done);
>                                               <INTERRUPT>
>                                                geni_spi_isr()
>                                                 complete(&xfer_done);
>    <wakeup>
>    pm_runtime_put(mas->dev);
>   ... // back to SPI core
>   spi_geni_transfer_one()
>    setup_fifo_xfer()
>     mas->cur_mcmd =3D CMD_XFER;
>                                                 mas->cur_cmd =3D CMD_NONE=
; // bad!
>                                                 return IRQ_HANDLED;
>=20
> Let's fix this.  Before we start messing with hardware, we'll grab the
> lock to make sure that the IRQ handler from some previous command has
> really finished.  We don't need to hold the lock unless we're in a
> state where more interrupts can come in, but we at least need to make
> sure the previous IRQ is done.  This lock is used exclusively to
> prevent the IRQ handler and non-IRQ from stomping on each other.  The
> SPI core handles all other mutual exclusion.
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

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
