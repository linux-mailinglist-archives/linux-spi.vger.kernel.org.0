Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87F745D7F5
	for <lists+linux-spi@lfdr.de>; Thu, 25 Nov 2021 11:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351862AbhKYKMR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Nov 2021 05:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244132AbhKYKKQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Nov 2021 05:10:16 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E83C061757;
        Thu, 25 Nov 2021 02:07:05 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v1so23263602edx.2;
        Thu, 25 Nov 2021 02:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tIPuoEGGl3rHozJHiwHRScnLRDDOqtNdMuXjLxGZ2X0=;
        b=Whdva+N2tVDW1lSbZnSXjKpZ9qP9sC/nbcbBmvEOQPkKGEpAodbPmC5964Xg2CMQPb
         SDoy40QRmTEXexz0U0H9XvkCMUXI/1Na4cjIQQC/ukbwQCyjmgdqobwvap5oMTLW6Ppf
         dH4Vstugvs8AHRVrNLjsnALh1dGWFKV63VsBvY2H62NygT85e0pCjKYt9O1U4S9uzcnQ
         DwG+IufbZ2halbwJ7E1zKZZhVuIjRHMHKZhdV6Fb5CKsT/rEhLLbVwd/rc22zafsBz/Z
         l+1AamKm0MS9ODoWP1OHrcO0CApbtYvl+5Ygdt6Ycuagswn/GY3BguGTiYgKrC6wB8LC
         /rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tIPuoEGGl3rHozJHiwHRScnLRDDOqtNdMuXjLxGZ2X0=;
        b=bL+SjHwc2nwb2tNnXUtRPHQRIV+52B5IBDJgWvZIBMmVRa7QInOzd8el2zUkPsvdA4
         EanJLliLBf5o07GKfkrHM8GHwSKHZPwlY57RExNDB5f3zA5OvkKCfSUc5ll7kKMEdiJ4
         SUqJcbqp3EHY0fQoLkevF1ChQs8NkcEfc802br2Zip+CJnlrYKXP9FghZirjLTqWycZG
         DJBWH1AhTfuBk7v4JqWtvNJQrfWKyfkx+USJ+iT39Tvyz5DQEiHDKMUig7A7Nrq3QAhv
         mXmHy2my1g5mmFAD2P1vYhnuDjgbuMIYljStYuuSPsQrXfBJyUhIw9KfxOIGmeKAtFDx
         jumQ==
X-Gm-Message-State: AOAM531US+9WLLSYeUPVpupRaYGoxGWSuuBChkBLPW1FxmhZ2eMbChB0
        LiFQ7xBbL/i15m6TzXxRxMwlnyiUduq6/n631YM=
X-Google-Smtp-Source: ABdhPJx8PxgUcMnxoDsENWlav2EDs7/Xs92zGWvl8WeSEPqYjji/OTmedmaVPTGL4A4IJkPfiFyFuGn2mqYxddQ8l7g=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr28694756ejb.69.1637834823276;
 Thu, 25 Nov 2021 02:07:03 -0800 (PST)
MIME-Version: 1.0
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <cover.1637547799.git.lh.kuo@sunplus.com> <e5f2549224cf875d81306ef5f6e98db1cfd81c2e.1637547799.git.lh.kuo@sunplus.com>
 <CAHp75Vd2=OHbrpGtsU8AMXdtNfvSPhpc7vhzkWnahaV48XbfUQ@mail.gmail.com>
 <YZz0n6Mpjl3tKmMe@sirena.org.uk> <CAHp75Vf6+monqu4Hq-yoFSohD9tNFqZTuKjqDDKAJE3Om2BUYQ@mail.gmail.com>
 <6eb68a8153ba46c48862d00f7aa6e0fe@sphcmbx02.sunplus.com.tw>
In-Reply-To: <6eb68a8153ba46c48862d00f7aa6e0fe@sphcmbx02.sunplus.com.tw>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Nov 2021 12:06:27 +0200
Message-ID: <CAHp75VftSORts5cbDxvfyHgqhxmb7K74BfPd=mST+75C+Ch9dQ@mail.gmail.com>
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

On Thu, Nov 25, 2021 at 11:47 AM Lh Kuo =E9=83=AD=E5=8A=9B=E8=B1=AA <lh.Kuo=
@sunplus.com> wrote:

>     I have already modified most of the driver. And the probe function is=
 as follows. Is it okay?

Can be done a bit better, see below (seems you missed few of the comments)

> static int sp7021_spi_controller_probe(struct platform_device *pdev)
> {
>         int ret;
>         int mode;
>         struct spi_controller *ctlr;
>         struct sp7021_spi_ctlr *pspim;
>         struct device *dev =3D &pdev->dev;

Other way around, or i.o.w. "reversed tree".

>         mode =3D SP7021_MASTER_MODE;
>         pdev->id =3D of_alias_get_id(pdev->dev.of_node, "sp_spi");
>
>         if (of_property_read_bool(pdev->dev.of_node, "spi-slave"))
>                 mode =3D SP7021_SLAVE_MODE;

         pdev->id =3D of_alias_get_id(pdev->dev.of_node, "sp_spi");

         mode =3D SP7021_MASTER_MODE;
         if (of_property_read_bool(pdev->dev.of_node, "spi-slave"))
                 mode =3D SP7021_SLAVE_MODE;

>         if (mode =3D=3D SP7021_SLAVE_MODE)
>                 ctlr =3D devm_spi_alloc_slave(dev, sizeof(*pspim));
>         else
>                 ctlr =3D devm_spi_alloc_master(dev, sizeof(*pspim));
>         if (!ctlr)
>                 return -ENOMEM;
>
>         ctlr->dev.of_node =3D pdev->dev.of_node;
>         ctlr->bus_num =3D pdev->id;
>         ctlr->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_F=
IRST;
>         ctlr->auto_runtime_pm =3D true;
>         ctlr->prepare_message =3D sp7021_spi_controller_prepare_message;
>         if (mode =3D=3D SP7021_SLAVE_MODE) {
>                 ctlr->transfer_one =3D sp7021_spi_sla_transfer_one;
>                 ctlr->slave_abort =3D sp7021_spi_sla_abort;
>                 ctlr->flags =3D SPI_CONTROLLER_HALF_DUPLEX;
>         } else {
>                 ctlr->bits_per_word_mask =3D SPI_BPW_MASK(8);
>                 ctlr->min_speed_hz =3D 40000;
>                 ctlr->max_speed_hz =3D 25000000;
>                 ctlr->use_gpio_descriptors =3D true;
>                 ctlr->flags =3D SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_M=
UST_TX;
>                 ctlr->transfer_one =3D sp7021_spi_mas_transfer_one;
>         }
>         platform_set_drvdata(pdev, ctlr);
>         pspim =3D spi_controller_get_devdata(ctlr);
>         pspim->ctlr =3D ctlr;
>         pspim->dev =3D dev;
>         spin_lock_init(&pspim->lock);
>         mutex_init(&pspim->buf_lock);
>         init_completion(&pspim->isr_done);
>         init_completion(&pspim->sla_isr);
>         pspim->mas_base =3D devm_platform_ioremap_resource_byname(pdev, "=
spi_master");
>         pspim->sla_base =3D devm_platform_ioremap_resource_byname(pdev, "=
spi_slave");
>
>         pspim->mas_irq =3D platform_get_irq_byname(pdev, "mas_risc_intr")=
;
>         if (pspim->mas_irq < 0) {

>                 dev_err(dev, "failed to get mas intr\n");

Dup. No need to repeat what's done by platform core.

>                 return pspim->mas_irq;
>         }
>
>         pspim->sla_irq =3D platform_get_irq_byname(pdev, "slave_risc_intr=
");
>         if (pspim->sla_irq < 0) {

>                 dev_err(dev, "failed to get sla intr\n");

Dup.

>                 return pspim->sla_irq;
>         }
>
>         ret =3D devm_request_irq(dev, pspim->mas_irq, sp7021_spi_mas_irq
>                                                 , IRQF_TRIGGER_RISING, pd=
ev->name, pspim);

Ugly indentation.

>         if (ret) {
>                 dev_err(dev, "mas intr devm_request_irq fail\n");
>                 return ret;
>         }
>
>         ret =3D devm_request_irq(dev, pspim->sla_irq, sp7021_spi_sla_irq
>                                                 , IRQF_TRIGGER_RISING, pd=
ev->name, pspim);

Ditto.

>         if (ret) {
>                 dev_err(dev, "slave intr devm_request_irq fail\n");
>                 return ret;
>         }
>
>         pspim->spi_clk =3D devm_clk_get(dev, NULL);

>         if (IS_ERR(pspim->spi_clk)) {
>                 return dev_err_probe(dev, PTR_ERR(pspim->spi_clk), "clk g=
et fail\n");
>         }

Does checkpatch compains on this?
Hint: {} around a single statement shouldn't be added.

>         pspim->rstc =3D devm_reset_control_get_exclusive(dev, NULL);
>         if (IS_ERR(pspim->rstc)) {
>                 return dev_err_probe(dev, PTR_ERR(pspim->rstc), "rst get =
fail\n");

Ditto.

>         }
>
>         ret =3D clk_prepare_enable(pspim->spi_clk);
>         if (ret)

>                 return dev_err_probe(dev, ret,
>                         "failed to enable clk\n");

One line

>         ret =3D reset_control_deassert(pspim->rstc);
>         if (ret) {
>                 dev_err_probe(dev, ret,
>                         "failed to deassert reset\n");

One line.

>                 goto free_reset_assert;

>

Really, pay attention to a stray blank line here and there.

>         }
>
>         pm_runtime_enable(dev);
>
>         ret =3D devm_spi_register_controller(dev, ctlr);

You can't mix non-devm with devm APIs. Either all non-devm, or devm
followed by non-devm.

>         if (ret) {
>                 dev_err(dev, "spi_register_master fail\n");
>                 goto err_disable_pm_runtime;
>         }
>
>         return ret;
>
> err_disable_pm_runtime:
>         pm_runtime_disable(dev);
> free_reset_assert:
>         reset_control_assert(pspim->rstc);
>         clk_disable_unprepare(pspim->spi_clk);
>
>         return ret;
> }

--=20
With Best Regards,
Andy Shevchenko
