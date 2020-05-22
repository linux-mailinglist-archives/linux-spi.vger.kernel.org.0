Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226961DEAF7
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 16:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbgEVO5t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 10:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbgEVO5r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 May 2020 10:57:47 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAE2C061A0E;
        Fri, 22 May 2020 07:57:47 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id j8so11576754iog.13;
        Fri, 22 May 2020 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4E93R1F4OMg9K2XLuc0UwI5BfmV/kB8DZ8DcAqlj91Q=;
        b=RJh8B/6rHjjbkuji4u+fJ26zGQ2weYdBP8O87V6gBC0R3uO3Cxuxwia4xEC5fiQpVd
         BVao3bcj3EENB6cqKTKGBQu174xQRasXIfU4q+TkCRor9QpUGn/bNvOhtPgxnpksjF4z
         3fsMvYjJfJTHISaJ3cUFiRzeDfD7i3e9PZi6fj0SkJEmzk7TEWtsxWUY/iwJxQpOJ2R4
         T9SYcuC5mIwu3BPDv9d/KbkENTdJY9raVR0/065zsK9r46jPvzUkAxudp8zmyxpkPzW8
         Mh3IcqqBDWoU5MuQNyfGmuqSaUQzuiK4qAbocc1kDDt5QghsG+0LEtcX/A9knBg3T5Ef
         pvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4E93R1F4OMg9K2XLuc0UwI5BfmV/kB8DZ8DcAqlj91Q=;
        b=A8HAwTy87BkFgPBjC5bZ9vWtb7A3CPFHn+mypgqLRaGzLTcx6LaszXDLvCh6yvCPH3
         jM0X6Pmjspr3xcYqx5Qc9pSxKvOa+dGUcCBYjfrACWASbhtJpM8qV5dDph3tN3LxvBDc
         AvvzBnnTteSNlm4wekzi3T/9hnfHfmu4HMiW+J4+GzJPC7gjcRi6GRJHNl2Y/cnghQ80
         PfJJdgnbmq+2OKnpomNjtoe8YQ7q6NjzChJtqOt4NWlzqtZLjnmj7Mpz6VZL817Ck+7x
         5Yquj91e6nEwtkPCXUgXSxPT71obhiQ8eKgFRYqN84MWFnZJPSAzqgogMxp4LpVOrORb
         uflQ==
X-Gm-Message-State: AOAM530iIcwXx0ow2TCegm1QtUIfThknF51Av7FqPMYg08j47eKUk3lM
        O44wTQCrrxMR56+s3QkiFOmGVGrtM5veU/fwpu4=
X-Google-Smtp-Source: ABdhPJzIBFSsXPwSSCGw73KtvrqDIXMGD/+GjvxVG0mSEkFCp7BWwg4nqAvzm+UoIsx0S8/uDt84GiJO2N2vFmJg7HM=
X-Received: by 2002:a05:6602:2ac9:: with SMTP id m9mr3461002iov.68.1590159466755;
 Fri, 22 May 2020 07:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
 <1589800165-3271-4-git-send-email-dillon.minfei@gmail.com> <20200522113634.GE5801@sirena.org.uk>
In-Reply-To: <20200522113634.GE5801@sirena.org.uk>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Fri, 22 May 2020 22:57:10 +0800
Message-ID: <CAL9mu0LAnT+AfjpGs0O-MD2HYrpnQRmrj6qXtJQrJi9kbQLPUw@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX'
 support for stm32f4
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, p.zabel@pengutronix.de,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        thierry.reding@gmail.com, Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

hi Mark,

Thanks for reviewing.

On Fri, May 22, 2020 at 7:36 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, May 18, 2020 at 07:09:20PM +0800, dillon.minfei@gmail.com wrote:
>
> > 2, use stm32 spi's "In full-duplex (BIDIMODE=0 and RXONLY=0)", as tx_buf is
> > null, we must add dummy data sent out before read data.
> > so, add stm32f4_spi_tx_dummy() to handle this situation.
>
> There are flags SPI_CONTROLLER_MUST_TX and SPI_CONTROLLER_MUST_RX flags
> that the driver can set if it needs to, no need to open code this in the
> driver.

Yes, after check SPI_CONTROLLER_MUST_TX in drivers/spi/spi.c , it's
indeed to meet
this situation,  i will try it and sumbmit a new patch.

thanks.

best regards

Dillon
