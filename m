Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A47F116A8F
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 11:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLIKJG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 05:09:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40007 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfLIKJG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Dec 2019 05:09:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id s22so14906887ljs.7
        for <linux-spi@vger.kernel.org>; Mon, 09 Dec 2019 02:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qFxYVOCFv/IcSY7l7U6uJnkWyj0SJCRuOjbnSm1YePs=;
        b=0yD/xG0BGqJQOa8lh0bjl0BziV/iiF8t7ZnU7N97usjEJwxoPuFq30xWLcbDkYIRzC
         uWsaHqPC47bwqz8TWyIFKjokI0aoh9KDnf/eYwKVS3dkDPVpmXPGd5XD57GdOvuKXcyJ
         6CcnphbPrkVA3oJtO7qUdFF03fGdGxJQiuL1QbqWXCMMtgb5ri9ZfsawQDtVddIaODpp
         MePFL0rGZDGANlR02nlOI6V+EacZE7ugOVcUG98YvCGnKY3qpGixTani2mZ82WezBDFp
         Met5QQjO3RO3R4eIA1Krg6sbUko0+C7TbuDzcVDl3thv+eVtCSgJJQ2p7iBITUaQM2oW
         5qDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qFxYVOCFv/IcSY7l7U6uJnkWyj0SJCRuOjbnSm1YePs=;
        b=bpT6Vjga/QfYJAzMo3XQ51oIpCBNK/6x09EBOay1y4/tZG301gLbEeRkFu+GFh7B5+
         Bm9IlDS9ypaT3w0k1c/uBIp+ZdkxTpwslnheQyybK0NA286sWaC+OUEsFYzwkSkXhoR8
         3bcR7CRRJCLGd+kLymBrpqSrg+6wxwaaXDVebf89QH6/X+evMAIDKb6p7Ckh/vbguKjR
         myc4bhy+zCS4o1KWMYYGAhELCoWX83dl0Zban4aWenFOGYpvCDKXhM9hjWG7ft4NKM3C
         coh3WbOU095sfJ4fRAgY2uv1Uz2IQhejGhFcC8hpsFUj7eGkzNyc1XV5RAa5jYWBECaO
         AtaA==
X-Gm-Message-State: APjAAAWwrLNbsyjRu+eIitDyfTU/gmndZh4oiT4aROVurCnNgJiPKhtq
        A1xlKbOz2sAUXAYGJPtjeDjSIFjOrVhPvs36IHrzHw==
X-Google-Smtp-Source: APXvYqxCGEJyLk0M69YAhpSsMh0T/N2yiFphyss5MStSLd/a+2iUGREL97xCC6L2vq0QyVJCxB9oIjVv21xlZE1G+Ig=
X-Received: by 2002:a2e:99cd:: with SMTP id l13mr2167115ljj.243.1575886144510;
 Mon, 09 Dec 2019 02:09:04 -0800 (PST)
MIME-Version: 1.0
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-2-jean.pihet@newoldbits.com> <451986b2-e4f2-8bb6-fea1-65328b855223@ti.com>
In-Reply-To: <451986b2-e4f2-8bb6-fea1-65328b855223@ti.com>
From:   Jean Pihet <jean.pihet@newoldbits.com>
Date:   Mon, 9 Dec 2019 11:08:49 +0100
Message-ID: <CAORVsuXx1rmOk0Y+DY6fzQWUAjzUFSTZaV_7ookz=UzzmKd21w@mail.gmail.com>
Subject: Re: [PATCH 1/3] TI QSPI: Fix fclk frequency
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Vignesh,

On Mon, Dec 9, 2019 at 10:59 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
>
>
> On 06/12/19 9:30 pm, Jean Pihet wrote:
> > The QSPI IP is clocked by two clocks:
> > - CORE_CLKOUTM4 / 2 (L3) as interface clock,
> > - PER_CLKOUTM2 / 4 (L4) as functional clock, which is PER_CLKOUTM2
> >   divided by 4, so at 192Mhz / 4 = 48MHz.
> >
> > Fix the use of the correct fclk by the driver and fix the frequency
> > value so that the divider is correctly programmed to generate the
> > desired frequency of QSPI_CLK.
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
>
> This macro is unused and should be dropped.
That is correct. It is a left over from older versions. Will remove it.

Thanks,
Jean

>
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
> >
>
> --
> Regards
> Vignesh
