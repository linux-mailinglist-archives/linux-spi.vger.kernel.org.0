Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B859227D42
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jul 2020 12:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgGUKjz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jul 2020 06:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgGUKjy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jul 2020 06:39:54 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B88C061794;
        Tue, 21 Jul 2020 03:39:54 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id i18so15972875ilk.10;
        Tue, 21 Jul 2020 03:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ThwS3sNnaYzxm6RkRoYdeoF//cTjYR2kssQx54vWp9w=;
        b=DVhxs5ezBobHnE9TBd4flPu5hJQLpMuAU2lC54qqaNv9XMKXCMX5PaT5SlWkqrzxOw
         EL706Ffqv525EBxHSA241prY6WAcYvLU/KkxBqS46cZCyB+AclCVSPiJa8Hoax4XXS0G
         O/BGBd615gOBOmIDHg2fL65Q4IjlGd23UTo9BuOlh2wQWIHEHGUTRbMaVD3dc/fRzwwY
         5kYIGyaFCuRjVqoG1eppc5hn00vDznhO9+puJnS7B6+IoS6uVwu9tLZBw+ZYIyPsOeOv
         iucOa/CI9OxSjLfSl6r7OefuxDuy0H4AnaLeROENvSLMUlYeVtYH+BY5eR1mAVb5fb5v
         b3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ThwS3sNnaYzxm6RkRoYdeoF//cTjYR2kssQx54vWp9w=;
        b=kDOTaCtCtwoJwJKTTqv26+3HATVgLEy4+drRnCu3eyMceaqEUUXg8mPWJhEcikxJab
         oK0I4S8UFQUJLiTjkUtISRPqcbc13yPc+pMcF9ikYpkglFGB3W5KxEJH30LYb/GhOmDS
         oqvuQQCcfFlNHo2o7xpt+RMKkjHK8SRYtbtmQXykIFEg+aEVDQWycCF8EtKA3ABhRUIO
         i1GzZRHlBvtpUlmp46gW7GPwv6DR8FJWENjYSUlqze5z5+oRKYF9f/FGvtqRz+/Reild
         7HGArWFIEJTR+sAlDd2dOqwRoDqv7RGEUuzZMPkesLpP4slB9DHGswRmFQ7c7y+q6V+N
         m0mg==
X-Gm-Message-State: AOAM530GhfySUYduwVXal+TWRD/PZWtCpaG1BynuInegc/oidE67e5ix
        YROOQnlUPp+4I0K9Y1CEPAL4bxCrfhhSMTIei7Q=
X-Google-Smtp-Source: ABdhPJw+/FQVMZplQXPTaorV2hEw8VbZnoDU19wgkFEZlMX3P8qajDscpYadCkFjjbvhCIYI0S6Lg8dGv0Kq5wRCsYI=
X-Received: by 2002:a05:6e02:bcd:: with SMTP id c13mr26319082ilu.184.1595327993883;
 Tue, 21 Jul 2020 03:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <broonie@kernel.org> <1590378062-7965-1-git-send-email-dillon.minfei@gmail.com>
 <198ad79c-ab12-55f0-814f-afc454a7e8ef@st.com>
In-Reply-To: <198ad79c-ab12-55f0-814f-afc454a7e8ef@st.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Tue, 21 Jul 2020 18:39:16 +0800
Message-ID: <CAL9mu0L3ZF5+nh2ENzxnu0f6AAh1ygoWx1bEkS3WkJt8TN7C7Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Enable ili9341 and l3gd20 on stm32f429-disco
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>, p.zabel@pengutronix.de,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        thierry.reding@gmail.com, Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Alexandre,

On Tue, Jul 21, 2020 at 5:19 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:
>
> Hi Dillon
>
> On 5/25/20 5:40 AM, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > V5's update based on Mark Brown's suggestion, use 'SPI_MASTER_MUST_RX'
> > for SPI_SIMPLEX_RX mode on stm32 spi controller.
> >
> > V5:
> > 1 instead of add send dummy data out under SIMPLEX_RX mode,
> >     add flags 'SPI_CONTROLLER_MUST_TX' for stm32 spi driver
> > 2 bypass 'SPI_CONTROLLER_MUST_TX' and 'SPI_CONTROLLER_MUST_RX' under
> > 'SPI_3WIRE' mode
> >
>
> Concerning DT patches, they look goods for me. However I'll merge them
> when drivers parts will be merged.
>
> regards
> Alex
This patchset status is :
dts:
    ARM: dts: stm32: Add dma config for spi5
    ARM: dts: stm32: Add pin map for ltdc & spi5 on stm32f429-disco board
    ARM: dts: stm32: enable ltdc binding with ili9341, gyro l3gd20 on
      stm32429-disco board

panel-bindings: Reviewed-by: Rob Herring=EF=BC=8C need more reviewing to me=
rge
    dt-bindings: display: panel: Add ilitek ili9341 panel bindings

clk: Acked-by: Stephen Boyd , need more reviewing to merge
    clk: stm32: Fix stm32f429's ltdc driver hang in set clock rate,
      fix duplicated ltdc clock register to 'clk_core' case ltdc's clock
        turn off by clk_disable_unused()

drm-panel:  Reviewed-by: Linus Walleij . need more reviewing to merge
    drm/panel: Add ilitek ili9341 panel driver

spi-driver: Acked-by: Mark Brown =EF=BC=8Cmerged into mainline
    spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX' support for stm32f4
    spi: flags 'SPI_CONTROLLER_MUST_RX' and 'SPI_CONTROLLER_MUST_TX' can't
      becoexit with 'SPI_3WIRE' mode

For ili9341 drivers, it seems to need more time to review, or might be drop=
ped.
since the drm maintainer might create a new interface to support
DPI,DBI,DSI in one driver.
Currently it's under discussion. I will rework the ili9341 driver after tha=
t.

But, we can use the existing "drivers/gpu/drm/tiny/ili9341.c" driver to sup=
port
ili9341 on stm32f429-disco board only using the spi bus. except the
display refresh performance is not as good as the ltdc interface.

I can submit a new patch just with dts changed this week for it, if you nee=
d.

Thanks,
Dillon.
>
>
>
> > V4:
> > According to alexandre torgue's suggestion, combine ili9341 and
> > l3gd20's modification on stm32f429-disco board to one patchset.
> >
> > Changes:
> >
> > ili9341:
> >
> > 1 update ili9341 panel driver according to Linus's suggestion
> > 2 drop V1's No.5 patch, sumbit new changes for clk-stm32f4
> > 3 merge l3gd20's change to this patchset
> >
> > V3:
> > 1 merge original tiny/ili9341.c driver to panel/panel-ilitek-ili9341.c
> >    to support serial spi & parallel rgb interface in one driver.
> > 2 update ilitek,ili9341.yaml dts binding documentation.
> > 3 update stm32f429-disco dts binding
> >
> > V2:
> > 1 verify ilitek,ili9341.yaml with make O=3D../linux-stm32
> >    dt_binding_check
> >    DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/display/panel/
> >    ilitek,ili9341.yaml
> >
> > V1:
> > 1 add ili9341 drm panel driver
> > 2 add ltdc, spi5 controller for stm32f429-disco
> > 3 add ltdc, spi5 pin map for stm32f429-disco
> > 4 add docs about ili9341
> > 5 fix ltdc driver loading hang in clk set rate bug
> >
> >
> > L3gd20:
> > V3:
> > 1 merge stm32f429-disco dtbs binding with ili9341 part
> >
> > V2:
> > 1 insert blank line at stm32f420-disco.dts line 143
> > 2 add more description for l3gd20 in commit message
> >
> > V1:
> > 1 enable spi5 controller on stm32f429-disco (dts)
> > 2 add spi5 pinmap for stm32f429-disco  (dts)
> > 3 add SPI_SIMPLEX_RX, SPI_3WIRE_RX support for stm32f4
> >
> >
> > dillon min (8):
> >    ARM: dts: stm32: Add dma config for spi5
> >    ARM: dts: stm32: Add pin map for ltdc & spi5 on stm32f429-disco boar=
d
> >    ARM: dts: stm32: enable ltdc binding with ili9341, gyro l3gd20 on
> >      stm32429-disco board
> >    dt-bindings: display: panel: Add ilitek ili9341 panel bindings
> >    clk: stm32: Fix stm32f429's ltdc driver hang in set clock rate,
> >      fix duplicated ltdc clock register to 'clk_core' case ltdc's clock
> >        turn off by clk_disable_unused()
> >    drm/panel: Add ilitek ili9341 panel driver
> >    spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX' support for stm32f4
> >    spi: flags 'SPI_CONTROLLER_MUST_RX' and 'SPI_CONTROLLER_MUST_TX' can=
't
> >      be     coexit with 'SPI_3WIRE' mode
> >
> >   .../bindings/display/panel/ilitek,ili9341.yaml     |   69 ++
> >   arch/arm/boot/dts/stm32f4-pinctrl.dtsi             |   67 +
> >   arch/arm/boot/dts/stm32f429-disco.dts              |   48 +
> >   arch/arm/boot/dts/stm32f429.dtsi                   |    3 +
> >   drivers/clk/clk-stm32f4.c                          |    7 +-
> >   drivers/gpu/drm/panel/Kconfig                      |   12 +
> >   drivers/gpu/drm/panel/Makefile                     |    1 +
> >   drivers/gpu/drm/panel/panel-ilitek-ili9341.c       | 1301 +++++++++++=
+++++++++
> >   drivers/spi/spi-stm32.c                            |   19 +-
> >   drivers/spi/spi.c                                  |    3 +-
> >   10 files changed, 1521 insertions(+), 9 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/display/panel/il=
itek,ili9341.yaml
> >   create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> >
