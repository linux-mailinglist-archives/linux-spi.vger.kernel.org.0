Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF00B4D9A
	for <lists+linux-spi@lfdr.de>; Tue, 17 Sep 2019 14:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfIQMPa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Sep 2019 08:15:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44122 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfIQMPa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Sep 2019 08:15:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id i18so2858615wru.11
        for <linux-spi@vger.kernel.org>; Tue, 17 Sep 2019 05:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=XTkEiDr+Efjwc1YXx3Nos3anR5keJEKk4IdJ0xKDQqQ=;
        b=Z9hnNWDFFYfXXZtUmieLU1+17tbedb1QQZe6lQmZlJi2KQTfmukKD4mYpdD87AKp8f
         v70NBwT1bNf0l7pPBtJvRwMbn7MYuKKKse4TSQISZwzayJC9r8gAKN1GrfvJSpGbK4Uo
         GBJK4yaLWvNwxUgm7MCh4HBPOox79mFdatyuKM/5FekdfhyBWmA4WUDaUWaRr9e6kgTv
         jDwR02MeGt/Xy7yV59hUfxxvUUW6pVx5yexGyMQQJnVvoyxRh0Y+8dc0O4qz+qHYQMF6
         W3/hvjexZH5ZkAGfaKExu73hfGrho6DTILoKAqHFq2saAtrhIzT8FBGHMakAm1Hf09Tk
         ubQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=XTkEiDr+Efjwc1YXx3Nos3anR5keJEKk4IdJ0xKDQqQ=;
        b=QJBQRehGbCtewfKkoyxhJ5p5TB4AzSwKWtlmtS//RStaQ6CzMDdwlkH4WxbzuH60iP
         GoJintKIAgChlTxIK2XhS+7Cf222cZvA0Wj8T5wX2D+5oRyXjPyewxslKuXAg6H5NO7G
         lZwRsNL3WO2GUliTcNrkSSdZ6srv6/H6gVFKo4ND/rkrKAX9Hi+jgAXKx/E2cItwRAO5
         2a3aaoWOUhJ46rFVDxRPiZYaj/uSohPO9DPXwxGRad5tQ+V75zGr2hEaaYF/uUqXlvWe
         fxJg/X3WFEDFzNDkMUqK6hBOFnh1DjtpoDsBJsyMzZJ6lr7RGYgc6wKlMAlc+3p3PJt8
         skqg==
X-Gm-Message-State: APjAAAVvCHYc2Wa6PEgHgHDgoWVAdaMt9d3J9zA4c91gQn9JluIBEq3Q
        hV5vkREQ+SuRWy/1Zjk0NPlG0g==
X-Google-Smtp-Source: APXvYqybIIJ4Qs9uNxPcmswpxKdrs6cGATqMPNepsGv9voMWM8blurF16GmXEfIxIJJPNBriP4ED2Q==
X-Received: by 2002:adf:f150:: with SMTP id y16mr2587728wro.71.1568722528223;
        Tue, 17 Sep 2019 05:15:28 -0700 (PDT)
Received: from localhost ([195.200.173.126])
        by smtp.gmail.com with ESMTPSA id y186sm4139994wmb.41.2019.09.17.05.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 05:15:27 -0700 (PDT)
Date:   Tue, 17 Sep 2019 05:15:26 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Baolin Wang <baolin.wang@linaro.org>,
        Aurabindo Jayamohanan <mail@aurabindo.in>
cc:     Mark Brown <broonie@kernel.org>, palmer@sifive.com,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: sifive: check return value for
 platform_get_resource()
In-Reply-To: <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1909170514130.11980@viisi.sifive.com>
References: <20190917085627.4562-1-mail@aurabindo.in> <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 17 Sep 2019, Baolin Wang wrote:

> On Tue, 17 Sep 2019 at 17:12, Aurabindo Jayamohanan <mail@aurabindo.in> wrote:
> >
> > platform_get_resource() may return NULL. If it is so, return -ENXIO
> >
> > Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>
> > ---
> >  drivers/spi/spi-sifive.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> > index 93ec2c6cdbfd..67485067a694 100644
> > --- a/drivers/spi/spi-sifive.c
> > +++ b/drivers/spi/spi-sifive.c
> > @@ -308,6 +308,12 @@ static int sifive_spi_probe(struct platform_device *pdev)
> >         platform_set_drvdata(pdev, master);
> >
> >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!res) {
> > +               dev_err(&pdev->dev, "no IOMEM resource found\n");
> > +               ret = -ENXIO;
> > +               goto put_master;
> > +       }
> 
> Seems unnecessary, the devm_ioremap_resource() already validated if
> the resource is available.

Just doublechecked lib/devres.c and I agree with you.

Aurobindo, is this a patch for a real problem that you've encountered?


- Paul
