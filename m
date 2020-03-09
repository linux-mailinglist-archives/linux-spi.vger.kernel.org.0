Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED75B17E696
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 19:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgCISPD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 14:15:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38609 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgCISPD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 14:15:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id h5so2782203edn.5;
        Mon, 09 Mar 2020 11:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xs7r2b9IzlfpQAdeExaqPyMiu2aaclTGgziI7uZf/6s=;
        b=WxvkAOQAuO/cEOwxhw7vHKPvtV7dDzQ2lSV3UO+Y2iakzmbUhmOn8ttTAmVMqHqxnu
         kz/P0iP+Hy9cOSqm5mWZVPTFXWtnp9ZZQ9huvu34iprmrCNI4RynlJnsa7MNM/2+Qslf
         ou18g7F1YhoYvN4/8kcY32A7z1E8/qlUFEpUZWo0q8OwGkTIamUiXPF5mex5yBO4d+4b
         jxq/fhATTHRb/y0xJAoGleyuyOVLCIIFnMUc5eoKSZQ5EdJUASXlcMxpLz949twscU3D
         7yqvDrBptKaJA5i4BGrahUtW+cJHELsGxtneCTRlNwJ6JIj7gIioNCXeTRPRejqb3wgK
         n0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xs7r2b9IzlfpQAdeExaqPyMiu2aaclTGgziI7uZf/6s=;
        b=pnu3b2LHpLJlAevcsxZdzbpW9cVEccyklrtlJRk5BMZE+mIm1ZSvKPSLZ1eT07eAhu
         s9hM7CLMeiqoF7XRWhqCtD4zPRmfwLqOA8Xy0cPAqflXWDmNnaltMpRXCgzEaqJ9JSzQ
         VhqeN/cFGJyAVXJ0yzT29dfINQhCMjPHMTCvSvokksTzkUI/AADvg3Yozbb+PkFxVxSA
         NE2Ov7CoNo6OWYUpTwov/oua4cO740frcbN7O0tpuH2Ivks0k5dCEAp3zSUkJETWLhPN
         IsjUkk7UbaMXruDcI6n7DfIXOSm01J7VikUmhwj83D+l8PEIpqc0+7Kpu1YjQmvESLqr
         dSDA==
X-Gm-Message-State: ANhLgQ1HvRTpfK2d/NFOyXv4jQBgkKmEcA1lCVQ0JakPo9+rPi1RcGsM
        2ul2ze6XKS8kOUTpR4yqYoXfHIZmsrtQiRBUKhk=
X-Google-Smtp-Source: ADFU+vuX+135JLR5eV9PzpXXV/FHyVLVYOJHZDWbj5zoXjOcs3HBVAiRwWM+dfvSFmxVVm5OhztF1vU44B3a0Ykb2kg=
X-Received: by 2002:a17:906:f49:: with SMTP id h9mr16437041ejj.6.1583777701665;
 Mon, 09 Mar 2020 11:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200309145624.10026-1-olteanv@gmail.com> <f530a0740f34b2cf26a8055d4eae2527@walle.cc>
In-Reply-To: <f530a0740f34b2cf26a8055d4eae2527@walle.cc>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 9 Mar 2020 20:14:50 +0200
Message-ID: <CA+h21hrSezjwKJDCd1wN8qk5koWfPmwT0Mx+sR7fHxo1sCGcjw@mail.gmail.com>
Subject: Re: [PATCH 0/6] NXP DSPI bugfixes and support for LS1028A
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

On Mon, 9 Mar 2020 at 20:03, Michael Walle <michael@walle.cc> wrote:
> Am 2020-03-09 15:56, schrieb Vladimir Oltean:
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
>
> If it is not compatible with the LS1021A the second compatible string
> should be removed. Depending on the other remark about the endianess,
> it might still be compatible, though.
>

Please feel free to remove it. I wasn't actually planning to add it in
the first place, but now it that it's there it doesn't really bother
anybody either.

>
> > The device tree for the LS1028A SoC is extended with DMA channels
> > definition, such that even though the default operating mode is XSPI,
> > one can simply change DSPI_XSPI_MODE to DSPI_DMA_MODE in the
> > devtype_data structure of the driver and use that instead.
>
> wouldn't it make more sense, to use DMA is the dma node is present
> in the device tree? otherwise use XSPI mode? I don't think it is
> really handy to change the mode inside the driver.
>

Let's keep it simple. The driver should configure the hardware in the
most efficient and least buggy mode available. Right now that is XSPI.
The hardware description (aka the device tree) is a separate topic. If
there ever arises any situation where there are corner cases with XSPI
mode, it's good to have a fallback in the form of DMA mode, and not
have to worry about yet another problem (which is that there are 2
sets of device tree blobs in deployment).

TL;DR: These DMA channels don't really bother anybody but you never
know when they might come in handy.

> -michael
>
> >
> > For testing, benchmarking and debugging, the mikroBUS connector on the
> > LS1028A-RDB is made available via spidev.
> >
> > Vladimir Oltean (6):
> >   spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
> >   spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
> >   spi: spi-fsl-dspi: Fix oper_word_size of zero for DMA mode
> >   spi: spi-fsl-dspi: Add support for LS1028A
> >   arm64: dts: ls1028a: Specify the DMA channels for the DSPI
> > controllers
> >   arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
> >
> >  .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 14 +++++
> >  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  6 +++
> >  drivers/spi/spi-fsl-dspi.c                    | 54 +++++++++++++++----
> >  3 files changed, 64 insertions(+), 10 deletions(-)

Thanks,
-Vladimir
