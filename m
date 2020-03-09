Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4286517E97B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 20:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgCIT7q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 15:59:46 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35036 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCIT7p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 15:59:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id a20so7545554edj.2;
        Mon, 09 Mar 2020 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VmBXxLKmo+++3JevDuJgXXYNelP3ARfrGqq9jGQ7Y7E=;
        b=ms/8ZoJQ8nLPB660/C1W5wBbhezgkvnTQ4JipsElaAt9WEAK7C3RspKMI05wCln7uH
         vOjrZ+hEU8wRmNb7cV3l0iKwIXxvFNVNWOQmveMjVZUk/BXuAm3qkMYlHX/SHf/B5RRW
         uUFD7T10eBMQNsE+3IvbNRAewmIdNmqoVC+tVMc0glgiOSNnId0iRCT/ALNOOxwVbuIl
         qAUA5E3tQv2ToAcgD9PLekxJJ04FtHSTzWRI0le6cl1qKf4dgfMJfyRVxEbmyGaZlYOF
         AUtRu4kjq46Jn3gTIHNUzDPJFbOQns50H/KyEiTCSboV7UlsQ8zbQDd4MWHpWBh9T1eX
         V9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmBXxLKmo+++3JevDuJgXXYNelP3ARfrGqq9jGQ7Y7E=;
        b=Ble8vhjCq4wmkm7lqc+teYGnlBYDRBZNy2xagLCmerocdu9ePmL9rPjjrI/G7VYc0L
         hmjCAfkt3xWhIQjOfTRalD63ulGXQxWjMJ+/47LDIDNoOdvxg75fpiZCVX+yrAVhwU5v
         RBEjNqtRokjE+REIc7O1T7M3ESRohq3uftTTIrPydbt0V+91hxuVd98JUwCwMgLxuLd9
         XWLgyHu3FTsJAlbPgu0ZGnFHvVBumDKagoA6g/qLOREh8pDGb600/73WzsDKDjfqzyqc
         rxO/qsWopkpAibHomAqiUj0hGYyRTjkuUIbpSDeOgs8sA8kPUIzVMtguqfiasiWXUHQo
         1ZhA==
X-Gm-Message-State: ANhLgQ1yHdaUx4RD+HtS35UGx2BJ9OEXrJdiui/XGQsqglUJXWjufrih
        sSYP9krkkUgQb2zzH2X35wmaw0j6X+tffzZlnbg=
X-Google-Smtp-Source: ADFU+vui/3sVmKBiJj2kgewtRz/H76d3oN3MyBRFSaJd5Yt5pd15za9zixZuGhwGvUsQxOOsjnSrE1+XaMuiRPIv2WQ=
X-Received: by 2002:a17:906:f49:: with SMTP id h9mr16777311ejj.6.1583783983011;
 Mon, 09 Mar 2020 12:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200309145624.10026-1-olteanv@gmail.com> <20200309145624.10026-6-olteanv@gmail.com>
 <83af52172a3cabd662de1ed9574e4247@walle.cc>
In-Reply-To: <83af52172a3cabd662de1ed9574e4247@walle.cc>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 9 Mar 2020 21:59:32 +0200
Message-ID: <CA+h21hp2MxLqLJL9AnufmW_-OQFdiY7p4Db97G3eTr_MUkH4TA@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: ls1028a: Specify the DMA channels for the
 DSPI controllers
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

On Mon, 9 Mar 2020 at 21:06, Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-03-09 15:56, schrieb Vladimir Oltean:
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> >
> > LS1028A has a functional connection to the eDMA module. Even if the
> > spi-fsl-dspi.c driver is not using DMA for LS1028A now, define the
> > slots
> > in the DMAMUX for connecting the eDMA channels to the 3 DSPI
> > controllers.
> >
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > index 515e0a1b934f..18155273a46e 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > @@ -298,6 +298,8 @@
> >                       interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> >                       clock-names = "dspi";
> >                       clocks = <&clockgen 4 1>;
> > +                     dmas = <&edma0 0 62>, <&edma0 0 60>;
> > +                     dma-names = "tx", "rx";
>
> minor nit. Other nodes specified the dma channels as
>
> dma-names = "tx", "rx";
> dmas = <&edma0 0 62>,
>         <&edma0 0 60>;
>
> -michael
>

Does it matter?

Regards,
-Vladimir
