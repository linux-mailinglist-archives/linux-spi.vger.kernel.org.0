Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EB445EC53
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 12:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhKZLUM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 06:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhKZLSK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 06:18:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FB0C061396;
        Fri, 26 Nov 2021 02:34:33 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id t5so37197326edd.0;
        Fri, 26 Nov 2021 02:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=81whHpSDsob0IoHAmEe+eg2AiiGPOkCyVnPHcxLW+D8=;
        b=FQSL/MoMSE3/m4IZpoWlj1dwZILSvRANWyDj9tKEhxGzILxDi6x/CxbpcVeaDn/YmD
         oaGWDNJQF6JpvCpsGiDrECohMbYUu1b315sEBNx13I11G3RH+qHYuI2aFfKBEr7CY7nY
         6DSeFJUJrH9P5Ss2r876H0TcM/ygkZutevLFa2fqRZ23HCpj1j5r9HykmQPyyHX6z3Jf
         4hmESC/LYoLfTVSu/iiArUlghk1JNZAgwRkmDjbbjyMZY8zbJMbGnxqkQnJ4DqQlfuC1
         tt1IVA6CRdZt+Ll73Rx73GU4B9Gcs5mutw+Rrklg1WuUZtOd8Pjoer0SHcAuI+1Iycbs
         DEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=81whHpSDsob0IoHAmEe+eg2AiiGPOkCyVnPHcxLW+D8=;
        b=OqszZZPosAZKRloHoInMEhfMJChEw4vICDCwp0C6MArf/zdI60rVENxaZ+RJuHRCpK
         +xz/+chaBRoB+l/MoLxj9VEHvQRVAVJduDCTg9miKW82vxgTe8jlDYuxhJxhuR8G93Zc
         hq+HLvAS43IJZYUn7Bm0goYI1SHSz6h80YeolpJq3wiLwv4nRz33mKiNVS5/lXRLlM95
         TdbnpZ4Il/6xblQmXBg48sZhu62h/KrYVSC69xTe7fEbe8eFSVcpM3J3iUONc2H5mboT
         WOlvQrmjxAH9woBhhCA3VLju0MIL+6Rqc8KMssTroZWb6vlniKqHfba5xB8XRrOXjY68
         /gcg==
X-Gm-Message-State: AOAM532INUTSnLRJUA7PLG3uD0txfOnh2Q4g6ebhAFHOld1Q/mUqLAIG
        +Mlg2ax213p2vM6rMnk8m39d2X5HMP2xVxn1edk=
X-Google-Smtp-Source: ABdhPJxUsJbx2/+nLLkqrI0oro6WVqm/DMJR3zBG8P3PGeirJAWrWLQu7Nlo8zgd9vex19GJffJTqdXPwk3ZcVx7uio=
X-Received: by 2002:a50:d741:: with SMTP id i1mr45959283edj.37.1637922871770;
 Fri, 26 Nov 2021 02:34:31 -0800 (PST)
MIME-Version: 1.0
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <cover.1637547799.git.lh.kuo@sunplus.com> <e5f2549224cf875d81306ef5f6e98db1cfd81c2e.1637547799.git.lh.kuo@sunplus.com>
 <CAHp75Vd2=OHbrpGtsU8AMXdtNfvSPhpc7vhzkWnahaV48XbfUQ@mail.gmail.com>
 <YZz0n6Mpjl3tKmMe@sirena.org.uk> <CAHp75Vf6+monqu4Hq-yoFSohD9tNFqZTuKjqDDKAJE3Om2BUYQ@mail.gmail.com>
 <6eb68a8153ba46c48862d00f7aa6e0fe@sphcmbx02.sunplus.com.tw>
 <CAHp75VftSORts5cbDxvfyHgqhxmb7K74BfPd=mST+75C+Ch9dQ@mail.gmail.com> <33d50e94059b4734939db60b5c531bc9@sphcmbx02.sunplus.com.tw>
In-Reply-To: <33d50e94059b4734939db60b5c531bc9@sphcmbx02.sunplus.com.tw>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Nov 2021 12:33:56 +0200
Message-ID: <CAHp75Vf61h9sBRdipM-9A1fiyy6PjSr1b2Fo1+VG09tLbaetWw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] SPI: Add SPI driver for Sunplus SP7021
To:     =?UTF-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
Cc:     Mark Brown <broonie@kernel.org>, "LH.Kuo" <lhjeff911@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "dvorkin@tibbo.com" <dvorkin@tibbo.com>,
        "qinjian@cqplus1.com" <qinjian@cqplus1.com>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 26, 2021 at 9:49 AM Lh Kuo =E9=83=AD=E5=8A=9B=E8=B1=AA <lh.Kuo@=
sunplus.com> wrote:

(Uncommented is okay)

...

> > >         ret =3D devm_request_irq(dev, pspim->mas_irq, sp7021_spi_mas_=
irq
> > >                                                 , IRQF_TRIGGER_RISING=
,
> > > pdev->name, pspim);
> >
> > Ugly indentation.
> >
>
> Amended as follows, is it okay?
>
>         ret =3D devm_request_irq(dev, pspim->mas_irq, sp7021_spi_mas_irq
>                         , IRQF_TRIGGER_RISING, pdev->name, pspim);
>         if (ret)
>                 return ret;

Still not okay. Have you seen this style somewhere in the kernel?
Hint: something is really wrong with comma's location.

...

> > >         pm_runtime_enable(dev);
> > >
> > >         ret =3D devm_spi_register_controller(dev, ctlr);
> >
> > You can't mix non-devm with devm APIs. Either all non-devm, or devm fol=
lowed by non-devm.

>   I don't understand so I need to change to spi_register_controller(ctlr)=
?   why?

I haven't told you that. What I'm saying is this:
1) all calls are devm_*() - OK!
2) all calls are non-devm_*() OK!
3) devm_*() followed by non-devm_*() OK!
4) non-devm_*() call followed by devm_*() call  NOT okay!

You need to fulfil your homework (see plenty of the examples in the
Linux kernel source tree on how to proceed).

> I modified the remove-function as follows. I think devm_spi_register_cont=
roller(dev, ctlr); should be no problem in the probe funciton.

It has ordering issues. That's why 4) above is not okay.

> static int sp7021_spi_controller_remove(struct platform_device *pdev)
> {
>         struct spi_controller *ctlr =3D dev_get_drvdata(&pdev->dev);
>         struct sp7021_spi_ctlr *pspim =3D spi_master_get_devdata(ctlr);
>
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_set_suspended(&pdev->dev);
>         reset_control_assert(pspim->rstc);
>         clk_disable_unprepare(pspim->spi_clk);
>
>         return 0;
> }

--=20
With Best Regards,
Andy Shevchenko
