Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B468F1B0F5E
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 17:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgDTPKt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 11:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbgDTPKt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Apr 2020 11:10:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA42C061A0C;
        Mon, 20 Apr 2020 08:10:48 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id pg17so8209165ejb.9;
        Mon, 20 Apr 2020 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9p5YSZ4+mi/e7FFFEHIrB7QFMMbbaz2S5WA2HGT9XH0=;
        b=s7ViBweoBfolqtUE1Dw+S7+3GkaeERdZbkylc7Ai1AdgnOZfN65hg71OXW2rVO1/hU
         ROT1CPA181AXr4yd0UPHspj7hazs1F+i3kUgTTZmg6M3RdHYZgnM8vBDyfvpEX1i75yo
         UwzqsxsY7lQpOBva7nO3k53ypxyz09Hvq6rn4E2QLPHERcYMiqNDY6QqG0q9hiK9XJbD
         pJ37ogZ12tshixBKhmzU0osoY6T9h+atrk/L0AfZkFeWZ7rcWBRlAQeVTZ92fwy0eDof
         mMP8lFJLRiU93vpaLiJyXh4wt7SLDINfUqFKY0JfpCuo/anSJvB6VMwTcwWsbMhVetbR
         1pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9p5YSZ4+mi/e7FFFEHIrB7QFMMbbaz2S5WA2HGT9XH0=;
        b=fTTNuIivmIbOgAt5hWnQtO9Lxv3KloHsYxg9yzRdkPB5KiDM0CzKTpKAhf9eERqHYj
         mDTJR2ul4OnUN4KBSe1u47+l2gwN4x0KuHZvE6ZrwKgUydzZvt/NVo2YGjvjwyJ3xu8O
         wgFnJ9Lo3iZMjNUk8NLK4xaW0KZ4Imt411vnP11FVL4711BRoVnmPLXu3jcqYG5E61bI
         mLQ5UFOI7SSc3IFnYmCNYKVGtVeWhw41NEdNOq7WtmnFL2Yibr74abT0KWVJ2qsICtCF
         gMxWkBMffFtaeiL8ChLVNPcm4x80f6+EBLeVJ6/YB2G4zq6138dwEDAzBDLKItwJCMMg
         tgYw==
X-Gm-Message-State: AGi0PuaURLQVAcRNppy/ZWHonbBunYmfdObZufUZMRytzuxhjEMUlS2a
        s+mywqjWZ9ypTW71m4veoQSoOa9og2dOKACrsGs=
X-Google-Smtp-Source: APiQypKoDW/toyMfK3ngXt0Qzk4fYcwRXK1MtxzKr+4ijH8KGhOQCargMvQmSlg/UhgArVHds5aJa6yamXfVVFNdTzs=
X-Received: by 2002:a17:906:78c:: with SMTP id l12mr15719453ejc.189.1587395447071;
 Mon, 20 Apr 2020 08:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200318001603.9650-1-olteanv@gmail.com> <20200318001603.9650-13-olteanv@gmail.com>
 <20200420143831.GB32419@dragon>
In-Reply-To: <20200420143831.GB32419@dragon>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 20 Apr 2020 18:10:35 +0300
Message-ID: <CA+h21hrfwJ7LMjj=sy7LG3D-FFhVSRuM5TwqfX9LvW4XKarUWA@mail.gmail.com>
Subject: Re: [PATCH v5 12/12] arm64: dts: ls1028a-rdb: Add a spidev node for
 the mikroBUS
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        Michael Walle <michael@walle.cc>, peng.ma@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 20 Apr 2020 at 17:38, Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Wed, Mar 18, 2020 at 02:16:03AM +0200, Vladimir Oltean wrote:
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> >
> > For debugging, it is useful to have access to the DSPI controller
> > signals. On the reference design board, these are exported to either the
> > mikroBUS1 or mikroBUS2 connector (according to the CPLD register
> > BRDCFG3[SPI3]).
> >
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> > Changes in v5:
> > None.
> >
> > Changes in v4:
> > None.
> >
> > Changes in v3:
> > None.
> >
> > Changes in v2:
> > Change compatible string for spidev node.
> >
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > index 6d05b76c2c7a..0d27b5667b8c 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > @@ -83,6 +83,20 @@
> >       };
> >  };
> >
> > +&dspi2 {
> > +     bus-num = <2>;
> > +     status = "okay";
> > +
> > +     /* mikroBUS1 */
> > +     spidev@0 {
> > +             compatible = "rohm,dh2228fv";
>
> Is the compatible documented?
>
> Shawn
>
> > +             spi-max-frequency = <20000000>;
> > +             fsl,spi-cs-sck-delay = <100>;
> > +             fsl,spi-sck-cs-delay = <100>;
> > +             reg = <0>;
> > +     };
> > +};
> > +
> >  &esdhc {
> >       sd-uhs-sdr104;
> >       sd-uhs-sdr50;
> > --
> > 2.17.1
> >

I don't really know what's the status with spidev compatibles. I do
see other device trees are using this one, I thought it should be
fine.

Thanks,
-Vladimir
