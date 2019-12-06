Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81FFD115554
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2019 17:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfLFQ3q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Dec 2019 11:29:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45389 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfLFQ3q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Dec 2019 11:29:46 -0500
Received: by mail-lj1-f195.google.com with SMTP id d20so8238497ljc.12
        for <linux-spi@vger.kernel.org>; Fri, 06 Dec 2019 08:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLDOIrzTyHs8l3ztkg2SbHaADtEERTGh4fc2alZmQNQ=;
        b=AovdqPJxPvGB0qPkqTEsv39S5uBq373VomY2IfsaZWqdMkaWqfzC9hQFTRHPaNXyw9
         EntsooeqGDn2Mu5pV4WsJNgIZtQafOsfwAMShtXGKrdyG3BkgMXERSNTUc8p4r+/Z1sg
         qRAWQTokevjbXavssM5CSYESTvIZYDdHf2iQRkFeocGTx/5mYK6bYFG0MRFaL1VNoHn2
         U53cOPrnaMM+uZx0KNUgEsXVulaGgDKyTIDF1+YKNWEboSE5mPtKvqORZnbjbB1OPWYU
         hkuwlnpjaXhql5wJzqqIuTMfdeIwDGkVPgjKCex+eB9s1KG/V5XRMp8FvpJZ6ua/rNQi
         IBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLDOIrzTyHs8l3ztkg2SbHaADtEERTGh4fc2alZmQNQ=;
        b=lJ7RlDpIFr9GUTERqznCdSGuEUDBH+sevQZp+CazVfF9E/QIDCJGcyN16y3FcOFHgy
         XbmJiB8erhJCF4sYu9wiIeS3Ac0kR0MmlrXMUMPnu42sc+j5Njuo13Ueah5nbi7rQTNd
         uhXEwLs2uNwCWIEh/G9Feri/7Qms2Qx/xt4D++V3s7az49tt5+gjk29vtnuZlKYues0Y
         ta4koaTrEEd5ur6pX1p7O8rkh61bM7UbUhpiwlwOqnFXACEVQxiFL/Iz5YmWbRd6F1vH
         pQOq10z1M8iGvDz4tfQwektVTeudTcvzIVolcB2qq8ltX2B5/U2mrCrgKSef4+FjjYoD
         bjxw==
X-Gm-Message-State: APjAAAX3aabz8ZWHxT1JeQBi+4dabNawNIlNd9bQxbNFbBu+QNFSTaIl
        AlarvIYDqH4Z0ME2HZQzqc5YIPjhyYa4Z7R6ich7og==
X-Google-Smtp-Source: APXvYqyDkm4S4d2x1Qyqb6joY1dRKa1NLvPIqk02NElzWxqPVa5K/+bYuPRByLhMnpwTCh1PdaoThDVlcraWiN6rTJs=
X-Received: by 2002:a2e:7816:: with SMTP id t22mr9206929ljc.161.1575649783780;
 Fri, 06 Dec 2019 08:29:43 -0800 (PST)
MIME-Version: 1.0
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-2-jean.pihet@newoldbits.com> <20191206162431.GF35479@atomide.com>
In-Reply-To: <20191206162431.GF35479@atomide.com>
From:   Jean Pihet <jean.pihet@newoldbits.com>
Date:   Fri, 6 Dec 2019 17:29:32 +0100
Message-ID: <CAORVsuUBseM3vnZsSajMmUS1O6rEC4U_aa951HwMsGxyEm+t+g@mail.gmail.com>
Subject: Re: [PATCH 1/3] TI QSPI: Fix fclk frequency
To:     Tony Lindgren <tony@atomide.com>
Cc:     Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Vignesh R <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Tony,

On Fri, Dec 6, 2019 at 5:24 PM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi Jean,
>
> * Jean Pihet <jean.pihet@newoldbits.com> [191206 16:01]:
> > The QSPI IP is clocked by two clocks:
> > - CORE_CLKOUTM4 / 2 (L3) as interface clock,
> > - PER_CLKOUTM2 / 4 (L4) as functional clock, which is PER_CLKOUTM2
> >   divided by 4, so at 192Mhz / 4 = 48MHz.
> >
> > Fix the use of the correct fclk by the driver and fix the frequency
> > value so that the divider is correctly programmed to generate the
> > desired frequency of QSPI_CLK.
>
> This source clock can be different between the SoC models, the
> related fck probably needs to be fixed in the SoC specific dtsi
> file.
>
> Currently qspi it's there only in dra7.dtsi, sounds like you
> are using it on am3/am4 based on the clock name?

I am using the AM4376 chipset. Only the interface is fixed in the
hwmod data as fck.
What is the best solution to add the extra fck?

Thank you for reviewing.
Regards,
Jean

>
> Regards,
>
> Tony
>
> > ---
> >  drivers/spi/spi-ti-qspi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> > index 3cb65371ae3b..4680dad38ab2 100644
> > --- a/drivers/spi/spi-ti-qspi.c
> > +++ b/drivers/spi/spi-ti-qspi.c
> > @@ -79,7 +79,7 @@ struct ti_qspi {
> >
> >  #define QSPI_COMPLETION_TIMEOUT              msecs_to_jiffies(2000)
> >
> > -#define QSPI_FCLK                    192000000
> > +#define QSPI_FCLK                    48000000
> >
> >  /* Clock Control */
> >  #define QSPI_CLK_EN                  (1 << 31)
> > @@ -748,7 +748,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
> >               }
> >       }
> >
> > -     qspi->fclk = devm_clk_get(&pdev->dev, "fck");
> > +     qspi->fclk = devm_clk_get(&pdev->dev, "dpll_per_m2_div4_ck");
> >       if (IS_ERR(qspi->fclk)) {
> >               ret = PTR_ERR(qspi->fclk);
> >               dev_err(&pdev->dev, "could not get clk: %d\n", ret);
> > --
> > 2.23.0
> >
