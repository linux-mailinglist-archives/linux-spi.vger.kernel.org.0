Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8C7D18A2D8
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 20:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCRTFR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 15:05:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33887 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRTFQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 15:05:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id i24so28423400eds.1;
        Wed, 18 Mar 2020 12:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0sz4ViQPxV1OKy/Sfpvc+qvxTLbOx7/VLo/KKfzKpZU=;
        b=Yx74f807xVtY8/7ZBJzBctZuiqtqTD7isX6W3ff4nbMhn/UqYNH/98oRQ8H3jVx8/q
         5B8uGPNdqUaQedmXOB9bsD6+9/sZBU1QVYJlVNU6j0+jqcjCasvkiF2HcthZYOe+udNk
         ZHD6T7A7Z7TtCXCamQWHrEHIj7sbYh1x8T9tIEfqCeaaFS9G89iyOdYvq0Hl/FcWTdRg
         0+zp6HnTmxHK3q9c5fwsTNooHog2xFqIcpg6NloXHOvk2qx+gO1DE3pPP8wbjuv/y+z8
         +F60/GlFpcKxtMJ8jucThKWw4y86HfvDn+lTYG9M40iijhun0tQ6YGQA9POyKSn/upZS
         C60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0sz4ViQPxV1OKy/Sfpvc+qvxTLbOx7/VLo/KKfzKpZU=;
        b=picccOPiSJsco2enK6aBwiPn19n4d4tSM39DKMMsHGynVL6Qklm1Cd/HX625P+2rS9
         lQG8yRMSoH62LZYhVGa5tH2ffOW7xf6E13dFHLtgBwvv+b13/ST8xUImTKs/9klOK1A7
         5DckpNV0G1hl2GVWGNVJQ/F4aBkZn06qCFgH7LJbnoi1o1QI+smJCOVLOGujekJUsE5B
         2s/0WlirNa3c6nzgZvr1XS78XMSmC/VkCnTDgysVJBUh+ZxbCoEV2spC42zQA4IiU0kR
         qc6GKPiL/4XGnJIjGgxQ3O4Jp//LMJX/LgDKn1eQ2YeMH2pv7lAh5KHOKaahzVkcarkE
         1ZKQ==
X-Gm-Message-State: ANhLgQ0oW3XuedWSDmL3Il4GhAkfZZuZPmOVSrKq1QMeHbs7wcMScmR0
        BmLdGVVGIedlWPR1e02OUyCydzEiTMPznbX+dLA=
X-Google-Smtp-Source: ADFU+vvY+VF0GFSdPoG/dxm7knFVmdMw33uwrMf4PWaHsX/+gTSg/gAGE+l8QyZ5jnoZ8IzCy2+t52g1zS1UKTJAEMY=
X-Received: by 2002:a05:6402:c:: with SMTP id d12mr5597168edu.337.1584558313927;
 Wed, 18 Mar 2020 12:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200318001603.9650-1-olteanv@gmail.com> <d37b6e0f8a35ae61bbfe147cd5809ec2@walle.cc>
In-Reply-To: <d37b6e0f8a35ae61bbfe147cd5809ec2@walle.cc>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Wed, 18 Mar 2020 21:05:02 +0200
Message-ID: <CA+h21hrd9CduD-Gw17HjALdP2u8b+iXnpdQadM+jra-zsidYjA@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] NXP DSPI bugfixes and support for LS1028A
To:     Michael Walle <michael@walle.cc>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 18 Mar 2020 at 21:03, Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-03-18 01:15, schrieb Vladimir Oltean:
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> >
> > This series addresses a few issues that were missed during the previous
> > series "[PATCH 00/12] TCFQ to XSPI migration for NXP DSPI driver", on
> > SoCs other than LS1021A and LS1043A. DMA mode has been completely
> > broken
> > by that series, and XSPI mode never worked on little-endian
> > controllers.
> >
> > Then it introduces support for the LS1028A chip, whose compatible has
> > recently been documented here:
> >
> > https://lore.kernel.org/linux-devicetree/20200218171418.18297-1-michael@walle.cc/
> >
> > The device tree for the LS1028A SoC is extended with DMA channels
> > definition, such that even though the default operating mode is XSPI,
> > one can simply change DSPI_XSPI_MODE to DSPI_DMA_MODE in the
> > devtype_data structure of the driver and use that instead.
> >
> > Compared to earlier v4, the only change is in patch 05/12 to fix a race
> > condition signaled by Michael Walle here:
> > https://lkml.org/lkml/2020/3/17/740
> >
> > I don't expect the "fixes" patches to reach very far down the stable
> > pipe, since there has been pretty heavy refactoring in this driver.
> >
> > For testing, benchmarking and debugging, the mikroBUS connector on the
> > LS1028A-RDB is made available via spidev.
>
> Patches 1-11:
> Tested-by: Michael Walle <michael@walle.cc>
>
> Thanks Vladimir for the great work.
>

Excellent! Thanks Michael for the patience!

> -michael
>
> >
> > Vladimir Oltean (12):
> >   spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
> >   spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
> >   spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
> >   spi: spi-fsl-dspi: Avoid reading more data than written in EOQ mode
> >   spi: spi-fsl-dspi: Protect against races on dspi->words_in_flight
> >   spi: spi-fsl-dspi: Replace interruptible wait queue with a simple
> >     completion
> >   spi: spi-fsl-dspi: Avoid NULL pointer in dspi_slave_abort for non-DMA
> >     mode
> >   spi: spi-fsl-dspi: Fix interrupt-less DMA mode taking an XSPI code
> >     path
> >   spi: spi-fsl-dspi: Move invariant configs out of
> >     dspi_transfer_one_message
> >   spi: spi-fsl-dspi: Add support for LS1028A
> >   arm64: dts: ls1028a: Specify the DMA channels for the DSPI
> > controllers
> >   arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
> >
> >  .../boot/dts/freescale/fsl-ls1028a-rdb.dts    |  14 +
> >  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   6 +
> >  drivers/spi/spi-fsl-dspi.c                    | 324 +++++++++---------
> >  3 files changed, 182 insertions(+), 162 deletions(-)

-Vladimir
