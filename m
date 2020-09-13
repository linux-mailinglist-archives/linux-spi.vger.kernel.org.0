Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FB4267D68
	for <lists+linux-spi@lfdr.de>; Sun, 13 Sep 2020 05:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgIMDNC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Sep 2020 23:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgIMDNA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Sep 2020 23:13:00 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94459C061757
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 20:12:59 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x69so13857126oia.8
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 20:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+YxXUaWaUQYtZQa9Fpn0ZMzcxX/ZLEWMpqwg81RPTCA=;
        b=lGSRcGwdtrbBLQnfCW7ysJIYPg2WZH6Pwjc1/LIU8UVTGr9R3I2PKlzh88HCbokZaA
         J4rN5qjfVYZx4zypjp+BEQ/YGAgNHJdE8iPWwo807otrovEN1nv8EG7qvxBhVUdBKqLA
         Da94BT2Rss8Q3xnVsuAY5+ShPJ3Z3eEO3fDea4T022E+BMifXa2SP6aBtrU/b2WyVV2O
         H/ulCqOqDRZ1C/XfA008feYXhW9zf9DGruKZbY4auAS2IXjth8rOxr49F1hoFT0Ho1Ve
         e25VeCwsLQwAPRRwKsEMm6wWokkLpA+i+h5NxC/g1/3u9oJ8yo+xRoYWNolGsUoW3/GN
         MbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+YxXUaWaUQYtZQa9Fpn0ZMzcxX/ZLEWMpqwg81RPTCA=;
        b=Y0SkqH9SCzKKgNZcawznYlkdJFa2Ihsb361Dq4fnp/gJ7ygEnQa0esJjZzCeiiGn2B
         3lmbmBdAE4X93QaZAZMODnq0XyodJw7OtKW+WKOZs2GNrbAOARs90PADFrWSm2l3K6nj
         4Ozg9JSxedxz7VZ02bRLNKm9zo23/P+lIgDFf8zo0PCgQGj/RB50jdUXEvFvzOuxkmcn
         lwA0jY7uYGnVDPW0zAT7V1J38EyO79cXQdPnOyKPr5WRtF389tAkemPCHxWRfsaXaT3O
         Hdd6jrhoA4YvFQmmasei5mfEAzVZkkTAw5BNFJQZD0SemS2uShpMd2aUsNGMdmrZQrj4
         0/5g==
X-Gm-Message-State: AOAM530itAaoIEMP7RROSlImE2P1tBQym8kZP3v1knTbk80DgS3EJa9t
        nPnKlkKfW11IfFcJtwXFxCnGSA==
X-Google-Smtp-Source: ABdhPJy9lkysaX6uIzX9aRvWTgjJ2W3zscEaTyTh7ZhN2JIKeZatk5xdX1wXoAakfOvJhMe4iSWPqw==
X-Received: by 2002:a05:6808:6c8:: with SMTP id m8mr5476943oih.142.1599966778559;
        Sat, 12 Sep 2020 20:12:58 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id r132sm1194576oif.24.2020.09.12.20.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 20:12:57 -0700 (PDT)
Date:   Sat, 12 Sep 2020 22:12:55 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 1/3] spi: spi-geni-qcom: Use the FIFO even more
Message-ID: <20200913031255.GR3715@yoga>
References: <20200912140730.1.Ie67fa32009b94702d56232c064f1d89065ee8836@changeid>
 <20200912225302.GA3715@yoga>
 <CAD=FV=VT+7RX=vdy0Ba_AB3dyMKVGu9uwP5bS2eew2W49BdcWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VT+7RX=vdy0Ba_AB3dyMKVGu9uwP5bS2eew2W49BdcWA@mail.gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat 12 Sep 20:11 CDT 2020, Doug Anderson wrote:

> Hi,
> 
> On Sat, Sep 12, 2020 at 3:53 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Sat 12 Sep 16:07 CDT 2020, Douglas Anderson wrote:
> >
> > > In commit 902481a78ee4 ("spi: spi-geni-qcom: Actually use our FIFO") I
> > > explained that the maximum size we could program the FIFO was
> > > "mas->tx_fifo_depth - 3" but that I chose "mas->tx_fifo_depth()"
> > > because I was worried about decreased bandwidth.
> > >
> > > Since that time:
> > > * All the interconnect patches have landed, making things run at the
> > >   proper speed.
> > > * I've done more measurements.
> > >
> > > This lets me confirm that there's really no downside of using the FIFO
> > > more.  Specifically I did "flashrom -p ec -r /tmp/foo.bin" on a
> > > Chromebook and averaged over several runs.
> >
> > Wouldn't there be a downside in the form of setting the watermark that
> > close to the full FIFO we have less room for being late handling the
> > interrupt? Or is there some mechanism involved that will prevent
> > the FIFO from being overrun?
> 
> Yeah, I had that worry too, but, as described in 902481a78ee4 ("spi:
> spi-geni-qcom: Actually use our FIFO"), it doesn't seem to be a
> problem.  From that commit: "We are the SPI master, so it makes sense
> that there would be no problems with overruns, the master should just
> stop clocking."
> 

Actually read the message of the linked commit now. I share your view
that this indicates that the controller does something wrt the clocking
to handle this case.

Change itself looks good, so:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
