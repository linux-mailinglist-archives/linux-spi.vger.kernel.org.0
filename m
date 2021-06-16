Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45383AA017
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jun 2021 17:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbhFPPon (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Jun 2021 11:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235303AbhFPPmi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 16 Jun 2021 11:42:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AF57613F5;
        Wed, 16 Jun 2021 15:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623857898;
        bh=vZ8ear8SklFFUu79neexW0lLKmB1ja0t2XMihqoEtA8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oAl40Q6w7xbScSERVYRwUNPSyyNN5BRCHZPkfiUZ4ERmhW9ww5s89ccVyJXNTKMku
         Wj3UqV76BSBnHo7L5s78nT0MRLOxMP/c2fPlNj3b/PRfuETA4jzJWVc4FhzMHf1pe4
         eS1W0agrs9rdzoKSGRir6UAhhsDby2c9qBv2AZ5oxLHPM8T8rV4E0Cwgf6HH5qrWBx
         cjmZQz2QIjwUPQzv6e14ATjeTJd7GOhEQAAcyomrvBRtOiTafm/vceYorsY/4zQivf
         rgLaxztQJ0qY7yuB9WRhVtqhg+3oE6OFZh52I6LsMtkqtr/gH3fPZ2jMEMyVRJELaS
         tQDV6N/G4wHWQ==
Received: by mail-ed1-f47.google.com with SMTP id z12so3323879edc.1;
        Wed, 16 Jun 2021 08:38:18 -0700 (PDT)
X-Gm-Message-State: AOAM5309ZTiWV/632J2M+McBdc0SJ7EwC+xcTJ8pWbWKUO+Cl1JxfsPx
        +bwZ8nlsJWV8pzljVXkVbGo9fljSlcJXH1freQ==
X-Google-Smtp-Source: ABdhPJwb7zhZghWVJ1bxExzLMWySZyyjiyfek5zdHJIuKRwqxlr5K6N5iCW4i5jUdJstMUXFm/r41PNiTUAlFxe6Gd8=
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr299824edt.194.1623857896842;
 Wed, 16 Jun 2021 08:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210609140412.16058-1-jon.lin@rock-chips.com>
 <20210609140412.16058-2-jon.lin@rock-chips.com> <20210610024350.GA697147@robh.at.kernel.org>
 <e8e7c8c1-4f71-538c-a8e1-b61a894bd4a8@rock-chips.com> <CAAEAJfCyXWvcqswXfmgXBX-et0mq3vxoUacUmHGso9t+XoNqOg@mail.gmail.com>
In-Reply-To: <CAAEAJfCyXWvcqswXfmgXBX-et0mq3vxoUacUmHGso9t+XoNqOg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 16 Jun 2021 09:38:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL1Sb_TCw6TG7XGBDtmhMVD+_n7d-ii7N9N7w1+A627=w@mail.gmail.com>
Message-ID: <CAL_JsqL1Sb_TCw6TG7XGBDtmhMVD+_n7d-ii7N9N7w1+A627=w@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] dt-bindings: rockchip-sfc: Bindings for Rockchip
 serial flash controller
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Kever Yang <kever.yang@rock-chips.com>
Cc:     Jon Lin <jon.lin@rock-chips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        =?UTF-8?B?6buE5a626ZKX?= <hjc@rock-chips.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jun 11, 2021 at 10:33 AM Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
>
> Hi all,
>
> On Thu, 10 Jun 2021 at 00:04, Kever Yang <kever.yang@rock-chips.com> wrot=
e:
> >
> > Hi Rob,
> >
> > On 2021/6/10 =E4=B8=8A=E5=8D=8810:43, Rob Herring wrote:
> > > On Wed, Jun 09, 2021 at 10:04:04PM +0800, Jon Lin wrote:
> > >> From: Chris Morgan <macromorgan@hotmail.com>
> > >>
> > >> Add bindings for the Rockchip serial flash controller. New device
> > >> specific parameter of rockchip,sfc-no-dma included in documentation.
> > >>
> > >> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > >> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> > >> ---
> > >>
> > >> Changes in v7:
> > >> - Fix up the sclk_sfc parent error in rk3036
> > >> - Unify to "rockchip,sfc" compatible id because all the feature upda=
te
> > >>    will have a new IP version, so the driver is used for the SFC IP =
in
> > >>    all SoCs
> > >> - Change to use node "sfc" to name the SFC pinctrl group
> > >> - Add subnode reg property check
> > >> - Add rockchip_sfc_adjust_op_size to workaround in CMD + DUMMY case
> > >> - Limit max_iosize to 32KB
> > >>
> > >> Changes in v6:
> > >> - Add support in device trees for rv1126(Declared in series 5 but no=
t
> > >>    submitted)
> > >> - Change to use "clk_sfc" "hclk_sfc" as clock lable, since it does n=
ot
> > >>    affect interpretation and has been widely used
> > >> - Support sfc tx_dual, tx_quad(Declared in series 5 but not submitte=
d)
> > >> - Simplify the code, such as remove "rockchip_sfc_register_all"(Decl=
ared
> > >>    in series 5 but not submitted)
> > >> - Support SFC ver4 ver5(Declared in series 5 but not submitted)
> > >> - Add author Chris Morgan and Jon Lin to spi-rockchip-sfc.c
> > >> - Change to use devm_spi_alloc_master and spi_unregister_master
> > >>
> > >> Changes in v5:
> > >> - Add support in device trees for rv1126
> > >> - Support sfc tx_dual, tx_quad
> > >> - Simplify the code, such as remove "rockchip_sfc_register_all"
> > >> - Support SFC ver4 ver5
> > >>
> > >> Changes in v4:
> > >> - Changing patch back to an "RFC". An engineer from Rockchip
> > >>    reached out to me to let me know they are working on this patch f=
or
> > >>    upstream, I am submitting this v4 for the community to see howeve=
r
> > >>    I expect Jon Lin (jon.lin@rock-chips.com) will submit new patches
> > >>    soon and these are the ones we should pursue for mainlining. Jon'=
s
> > >>    patch series should include support for more hardware than this
> > >>    series.
> > >> - Clean up documentation more and ensure it is correct per
> > >>    make dt_binding_check.
> > >> - Add support in device trees for rk3036, rk3308, and rv1108.
> > >> - Add ahb clock (hclk_sfc) support for rk3036.
> > >> - Change rockchip_sfc_wait_fifo_ready() to use a switch statement.
> > >> - Change IRQ code to only mark IRQ as handled if it handles the
> > >>    specific IRQ (DMA transfer finish) it is supposed to handle.
> > >>
> > >> Changes in v3:
> > >> - Changed the name of the clocks to sfc/ahb (from clk-sfc/clk-hsfc).
> > >> - Changed the compatible string from rockchip,sfc to
> > >>    rockchip,rk3036-sfc. A quick glance at the datasheets suggests th=
is
> > >>    driver should work for the PX30, RK180x, RK3036, RK312x, RK3308 a=
nd
> > >>    RV1108 SoCs, and possibly more. However, I am currently only able
> > >>    to test this on a PX30 (an RK3326). The technical reference manua=
ls
> > >>    appear to list the same registers for each device.
> > >> - Corrected devicetree documentation for formatting and to note thes=
e
> > >>    changes.
> > >> - Replaced the maintainer with Heiko Stuebner and myself, as we will
> > >>    take ownership of this going forward.
> > >> - Noted that the device (per the reference manual) supports 4 CS, bu=
t
> > >>    I am only able to test a single CS (CS 0).
> > >> - Reordered patches to comply with upstream rules.
> > >>
> > >> Changes in v2:
> > >> - Reimplemented driver using spi-mem subsystem.
> > >> - Removed power management code as I couldn't get it working properl=
y.
> > >> - Added device tree bindings for Odroid Go Advance.
> > >>
> > >> Changes in v1:
> > >> hanges made in this new series versus the v8 of the old series:
> > >> - Added function to read spi-rx-bus-width from device tree, in the
> > >>    event that the SPI chip supports 4x mode but only has 2 pins
> > >>    wired (such as the Odroid Go Advance).
> > >> - Changed device tree documentation from txt to yaml format.
> > >> - Made "reset" message a dev_dbg from a dev_info.
> > >> - Changed read and write fifo functions to remove redundant checks.
> > >> - Changed the write and read from relaxed to non-relaxed when
> > >>    starting the DMA transfer or reading the DMA IRQ.
> > >> - Changed from dma_coerce_mask_and_coherent to just
> > >>    dma_set_mask_and_coherent.
> > >> - Changed name of get_if_type to rockchip_sfc_get_if_type.
> > >>
> > >>   .../devicetree/bindings/spi/rockchip-sfc.yaml | 88 +++++++++++++++=
++++
> > >>   1 file changed, 88 insertions(+)
> > >>   create mode 100644 Documentation/devicetree/bindings/spi/rockchip-=
sfc.yaml
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml=
 b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
> > >> new file mode 100644
> > >> index 000000000000..42e4198e92af
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
> > >> @@ -0,0 +1,88 @@
> > >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >> +%YAML 1.2
> > >> +---
> > >> +$id: http://devicetree.org/schemas/spi/rockchip-sfc.yaml#
> > >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >> +
> > >> +title: Rockchip Serial Flash Controller (SFC)
> > >> +
> > >> +maintainers:
> > >> +  - Heiko Stuebner <heiko@sntech.de>
> > >> +  - Chris Morgan <macromorgan@hotmail.com>
> > >> +
> > >> +allOf:
> > >> +  - $ref: spi-controller.yaml#
> > >> +
> > >> +properties:
> > >> +  compatible:
> > >> +    oneOf:
> > >> +      - const: rockchip,sfc
> > > Use 'enum' instead of oneOf+const.
> > >
> > > You need an SoC specific compatible.
> >
> >
> > The rockchip sfc controller is a standalone IP with version register,
> > and the driver can
> >
> > handle all the feature difference inside the IP, so we would like to us=
e
> > a more generic

Okay, if the version register can be relied on, then this is fine.
Just add a comment that further differentiation is done using a
version register.

> >
> > compatible name instead of bind to any of SoC name. So can we use
> > "rockchip,sfc"
> >
> > like "snps,designware-spi", which is a generic one, instead of an SoC
> > specific compatible?

That's a licensed IP which is a bit different. Though generic names on
those are useless too. There's different versions and different
integration quirks.

> >
>
> IIUC, the way this works is along these lines:
>
> * The SFC driver can only care for the rockchip,sfc compatible string
> and, if suitable, use the IP version register mentioned by Kever [1].
>
> * The bindings doc specifies both the SoC-specific and the generic one
> with:
>
>       - items:
>           - enum:
>               - rockchip,px30-sfc
>           - const: rockchip,sfc
>
> * The device tree lists both as well:
>
> compatible =3D "rockchip,px30-sfc", "rockchip,sfc";
>
> This can apply to all IP cores really; and will allow some
> compatibility between the downstream/vendor device tree
> and upstream.
>
> This scheme is indeed more convoluted than just
> picking any SoC name for the compatible string, and
> use that compatible string for all the SoCs (given they
> are all compatible, again as per [1]).
>
> IOW, you only have "rockchip,px30-sfc" in the bindings,
> in the devicetree files and in the driver.

This is fine too, but again if a version or capability register is
sufficient, no need to put this into DT. Maybe someday h/w designers
will clue in and always have version and/or capability registers.

Rob
