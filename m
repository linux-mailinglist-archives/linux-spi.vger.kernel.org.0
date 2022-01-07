Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CAA48742C
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jan 2022 09:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345981AbiAGIg3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Jan 2022 03:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbiAGIg2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Jan 2022 03:36:28 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68362C061201
        for <linux-spi@vger.kernel.org>; Fri,  7 Jan 2022 00:36:28 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id h2so12990592lfv.9
        for <linux-spi@vger.kernel.org>; Fri, 07 Jan 2022 00:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vVZIGQpO4cybh1F58lhYGN2Aw4cqAqidnu7imo4TqmI=;
        b=MvBUt7zxF6L9tiAjAJSe8pmrMblL38mDhm8malfZ8P1fhgvpXTOOytqAIF+ZQjKpug
         wbY6KUOhe7lxpObroPJ3GhjVyqU4ymJhTz52SozEvjF3yrVcy/a8wGe8DaoVrZdQNkUO
         3EMJ5mfIe7R+TPG/WY78MQ3F8qddVYDdYgEZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vVZIGQpO4cybh1F58lhYGN2Aw4cqAqidnu7imo4TqmI=;
        b=ATEq96OLZTWpAleje0KiU2uYjxoKJnl5gplQYD+8BaexScinBQdQxglWUMnWuW5/Fc
         mupww17lQfIql6OfzyjpxqZnosWgPNvMBEK2ufVOSJsTyDr7dWFLWM6PdsUCZ1qIu+Gb
         9SlGwC5KXt9JUeUTEPF2bnGaAZKyTqGorFzuoDL1YIH3bOl1D2W6tlW1orE9gw1FvJ1U
         KEcUFNkkeoaXv1uvDclb0wDV/7XgHBg7b/1C31nJWpL4MOO/M0sgq+bD/9vqWTrmssW5
         TGFOluN/DqzZO016NWiFJXoQ6m8zKJyy7fTdlq+CaLyRuFKREk4vPT5BC9qLJItthB6U
         /m8w==
X-Gm-Message-State: AOAM530jLcqCsid+xKpFrhKDpFSHAvH4caiQ+CjSDWUMe7Mq4hS5hJ/C
        CT69W5zGnqP1w8achZ/9QEOv1kIJyfEjFIja+RF+Kg==
X-Google-Smtp-Source: ABdhPJwbMO3nPmHq3UYiC04tI8XJ/H2V1ImVa9SFgE0UWTCDPzZftmUWkNrOf6I+UA8AnpJK6C/hSqiXE+zr1pMseBI=
X-Received: by 2002:a2e:2a84:: with SMTP id q126mr47333341ljq.457.1641544586649;
 Fri, 07 Jan 2022 00:36:26 -0800 (PST)
MIME-Version: 1.0
References: <20211220121825.6446-1-tinghan.shen@mediatek.com>
 <20211220121825.6446-5-tinghan.shen@mediatek.com> <CAGXv+5GaFikojqYYv0TfQsz3NSqn7QPmTWyCJY8V2g8UYoV4OA@mail.gmail.com>
 <18c342b20ccac520eabe8019562432030ddfe017.camel@mediatek.com>
In-Reply-To: <18c342b20ccac520eabe8019562432030ddfe017.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 7 Jan 2022 16:36:15 +0800
Message-ID: <CAGXv+5G45UP=kvk8UOiFWYfdWgdjboL-UfkBbfPuEmQpwKMNHQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] arm64: dts: Add mediatek SoC mt8195 and evaluation board
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, broonie@kernel.org,
        bgolaszewski@baylibre.com, sean.wang@mediatek.com,
        bayi.cheng@mediatek.com, gch981213@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Seiya Wang <seiya.wang@mediatek.com>, chunfeng.yun@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jan 6, 2022 at 7:15 PM Tinghan Shen <tinghan.shen@mediatek.com> wro=
te:
> On Thu, 2021-12-23 at 17:59 +0800, Chen-Yu Tsai wrote:
> > On Mon, Dec 20, 2021 at 8:20 PM Tinghan Shen <tinghan.shen@mediatek.com=
> wrote:

[...]

> > [...]
> >
> > > +               xhci0: usb@11200000 {
> > > +                       compatible =3D "mediatek,mt8195-xhci",
> > > +                                    "mediatek,mtk-xhci";
> > > +                       reg =3D <0 0x11200000 0 0x1000>,
> > > +                             <0 0x11203e00 0 0x0100>;
> > > +                       reg-names =3D "mac", "ippc";
> > > +                       interrupts =3D <GIC_SPI 129
> > > IRQ_TYPE_LEVEL_HIGH 0>;
> > > +                       phys =3D <&u2port0 PHY_TYPE_USB2>,
> > > +                              <&u3port0 PHY_TYPE_USB3>;
> > > +                       assigned-clocks =3D <&topckgen
> > > CLK_TOP_USB_TOP>,
> > > +                                         <&topckgen
> > > CLK_TOP_SSUSB_XHCI>;
> > > +                       assigned-clock-parents =3D <&topckgen
> > > CLK_TOP_UNIVPLL_D5_D4>,
> > > +                                                <&topckgen
> > > CLK_TOP_UNIVPLL_D5_D4>;
> > > +                       clocks =3D <&infracfg_ao CLK_INFRA_AO_SSUSB>,
> > > +                                <&infracfg_ao
> > > CLK_INFRA_AO_SSUSB_XHCI>,
> > > +                                <&topckgen CLK_TOP_SSUSB_REF>,
> > > +                                <&apmixedsys CLK_APMIXED_USB1PLL>;
> > > +                       clock-names =3D "sys_ck", "xhci_ck",
> > > "ref_ck", "mcu_ck";
> >
> > The binding for this needs to be fixed. It expects clocks in the
> > order
> > specified in the binding, and this doesn't match.
>
> ok
>
> > Also, "dma_ck" is missing
> > and will likely cause warnings to be generated.
>
> only sys_ck is required, others are optional as described in binding

I understand, but the bindings language is somewhat limited and right now
is written in a way that if "dma_ck" is missing it would fail the DT
bindings check.

> >
> > This goes for all the xhci device nodes.
> >
> > > +                       status =3D "disabled";
> > > +               };
> > > +
> > > +               mmc0: mmc@11230000 {
> > > +                       compatible =3D "mediatek,mt8195-mmc",
> > > +                                    "mediatek,mt8183-mmc";
> > > +                       reg =3D <0 0x11230000 0 0x10000>,
> > > +                             <0 0x11f50000 0 0x1000>;
> >
> > The binding only allows one entry. Please fix the binding first.
> > This was added with MT8183, and the fix should list the relavent
> > commit.
> >
> > > +                       interrupts =3D <GIC_SPI 131
> > > IRQ_TYPE_LEVEL_HIGH 0>;
> > > +                       clocks =3D <&topckgen CLK_TOP_MSDC50_0>,
> > > +                                <&infracfg_ao CLK_INFRA_AO_MSDC0>,
> > > +                                <&infracfg_ao
> > > CLK_INFRA_AO_MSDC0_SRC>;
> > > +                       clock-names =3D "source", "hclk",
> > > "source_cg";
> > > +                       status =3D "disabled";
> > > +               };
> > > +
> >
> > [...]
> >
> > > +
> > > +               xhci1: usb@11290000 {
> > > +                       compatible =3D "mediatek,mt8195-xhci",
> > > +                                    "mediatek,mtk-xhci";
> > > +                       reg =3D <0 0x11290000 0 0x1000>,
> > > +                             <0 0x11293e00 0 0x0100>;
> > > +                       reg-names =3D "mac", "ippc";
> > > +                       interrupts =3D <GIC_SPI 530
> > > IRQ_TYPE_LEVEL_HIGH 0>;
> > > +                       phys =3D <&u2port1 PHY_TYPE_USB2>;
> >
> > Shouldn't there be a USB3 phy?
>
> currently only enable usb2, usb3 phy is used by pcie.

Got it.

> >
> > > +                       assigned-clocks =3D <&topckgen
> > > CLK_TOP_USB_TOP_1P>,
> > > +                                         <&topckgen
> > > CLK_TOP_SSUSB_XHCI_1P>;
> > > +                       assigned-clock-parents =3D <&topckgen
> > > CLK_TOP_UNIVPLL_D5_D4>,
> > > +                                                <&topckgen
> > > CLK_TOP_UNIVPLL_D5_D4>;
> > > +                       clocks =3D <&pericfg_ao
> > > CLK_PERI_AO_SSUSB_1P_BUS>,
> > > +                                <&topckgen CLK_TOP_SSUSB_P1_REF>,
> > > +                                <&pericfg_ao
> > > CLK_PERI_AO_SSUSB_1P_XHCI>,
> > > +                                <&apmixedsys CLK_APMIXED_USB1PLL>;
> > > +                       clock-names =3D "sys_ck", "ref_ck",
> > > "xhci_ck", "mcu_ck";
> > > +                       status =3D "disabled";
> > > +               };
> > > +
> > > +               xhci2: usb@112a0000 {
> > > +                       compatible =3D "mediatek,mt8195-xhci",
> > > +                                    "mediatek,mtk-xhci";
> > > +                       reg =3D <0 0x112a0000 0 0x1000>,
> > > +                             <0 0x112a3e00 0 0x0100>;
> > > +                       reg-names =3D "mac", "ippc";
> > > +                       interrupts =3D <GIC_SPI 533
> > > IRQ_TYPE_LEVEL_HIGH 0>;
> > > +                       phys =3D <&u2port2 PHY_TYPE_USB2>;
> > > +                       assigned-clocks =3D <&topckgen
> > > CLK_TOP_USB_TOP_2P>,
> > > +                                         <&topckgen
> > > CLK_TOP_SSUSB_XHCI_2P>;
> > > +                       assigned-clock-parents =3D <&topckgen
> > > CLK_TOP_UNIVPLL_D5_D4>,
> > > +                                                <&topckgen
> > > CLK_TOP_UNIVPLL_D5_D4>;
> > > +                       clocks =3D <&pericfg_ao
> > > CLK_PERI_AO_SSUSB_2P_BUS>,
> > > +                                <&topckgen CLK_TOP_SSUSB_P2_REF>,
> > > +                                <&pericfg_ao
> > > CLK_PERI_AO_SSUSB_2P_XHCI>;
> > > +                       clock-names =3D "sys_ck", "ref_ck",
> > > "xhci_ck";
> > > +                       status =3D "disabled";
> > > +               };
> > > +
> > > +               xhci3: usb@112b0000 {
> > > +                       compatible =3D "mediatek,mt8195-xhci",
> > > +                                    "mediatek,mtk-xhci";
> > > +                       reg =3D <0 0x112b0000 0 0x1000>,
> > > +                             <0 0x112b3e00 0 0x0100>;
> > > +                       reg-names =3D "mac", "ippc";
> > > +                       interrupts =3D <GIC_SPI 536
> > > IRQ_TYPE_LEVEL_HIGH 0>;
> > > +                       phys =3D <&u2port3 PHY_TYPE_USB2>;
> > > +                       assigned-clocks =3D <&topckgen
> > > CLK_TOP_USB_TOP_3P>,
> > > +                                         <&topckgen
> > > CLK_TOP_SSUSB_XHCI_3P>;
> > > +                       assigned-clock-parents =3D <&topckgen
> > > CLK_TOP_UNIVPLL_D5_D4>,
> > > +                                                <&topckgen
> > > CLK_TOP_UNIVPLL_D5_D4>;
> > > +                       clocks =3D <&pericfg_ao
> > > CLK_PERI_AO_SSUSB_3P_BUS>,
> > > +                                <&pericfg_ao
> > > CLK_PERI_AO_SSUSB_3P_XHCI>,
> > > +                                <&topckgen CLK_TOP_SSUSB_P3_REF>;
> > > +                       clock-names =3D "sys_ck", "xhci_ck",
> > > "ref_ck";
> > > +                       usb2-lpm-disable;
> >
> > Could you explain why this is needed only for this controller?
>
> This controller is fixed with a BT, there is something issue when
> enable usb2 lpm, so just disabled tmp.

Please add a comment explaining things.

> > > +                       status =3D "disabled";
> > > +               };
> > > +
> > > +               u3phy2: t-phy@11c40000 {
> >
> > Just "phy" for the node name. (Or maybe "serdes".) t-phy is not
> > generic.
>
> following t-phy=E2=80=99s dt-binding.
> here using t-phy is to avoid dt-check warning, because it has some sub-
> phys.

I see. t-phy it is, then.

> > > +                       compatible =3D "mediatek,mt8195-tphy",
> > > "mediatek,generic-tphy-v3";
> > > +                       #address-cells =3D <1>;
> > > +                       #size-cells =3D <1>;
> > > +                       ranges =3D <0 0 0x11c40000 0x700>;
> > > +                       status =3D "disabled";
> > > +
> > > +                       u2port2: usb-phy@0 {
> > > +                               reg =3D <0x0 0x700>;
> > > +                               clocks =3D <&topckgen
> > > CLK_TOP_SSUSB_PHY_P2_REF>;
> > > +                               clock-names =3D "ref";
> > > +                               #phy-cells =3D <1>;
> > > +                       };
> > > +               };
> > > +
> >
> > [...]
> >
> > > +               ufsphy: ufs-phy@11fa0000 {
> >
> > I would have preferred "phy" for the device node, but this seems
> > already
> > defined in the binding.
> >
> > This IP block is not listed in the datasheet I have, so I am unable
> > to
> > verify the properties listed here.
> >
> > > +                       compatible =3D "mediatek,mt8195-ufsphy",
> > > "mediatek,mt8183-ufsphy";
> > > +                       reg =3D <0 0x11fa0000 0 0xc000>;
> > > +                       clocks =3D <&clk26m>, <&clk26m>;
> > > +                       clock-names =3D "unipro", "mp";
> > > +                       #phy-cells =3D <0>;
> > > +                       status =3D "disabled";
> > > +               };
> > > +
> >
> > Most of the issues I raised in this version were issues with things
> > not
> > matching the bindings. Please apply your patches on -next and run
> > `make dtbs_check`.
>
> ok. I'll apply comments at next version. Thank you.
>
> >
> >
> > ChenYu
>
