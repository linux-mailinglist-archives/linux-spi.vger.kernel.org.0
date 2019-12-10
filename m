Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA61119087
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 20:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfLJTVf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 14:21:35 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46761 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfLJTVf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 14:21:35 -0500
Received: by mail-lf1-f65.google.com with SMTP id f15so13829862lfl.13
        for <linux-spi@vger.kernel.org>; Tue, 10 Dec 2019 11:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFSuHaOwiwhrcp9I4+lXuxGEmBkGEK6trawqembeyj8=;
        b=toKsGkw5Fjuro3xLLKbqopq2tLYr3lZpIGlGtpfds+pbzCnb8w7ILiTFETOJ+fHrC3
         K9SyV3Z0OQjIO/QsPX7DdRIWGdeN/nItcgHpD53hCxkY/TW0+WdPdB5lR1VQqoU+jBCd
         Lp5hfkZ6oTjyF9LP6nMXLgoWO8aG1cS5h4MuZVcdV9O+LxnE2Yz6pe63+XnCM8XjbkaK
         yX5n1MMhtjpNJ1HixITjF+8SPiwjSPCyuDz+WpUYkxTpZmdy0MIIY7ARfamPsYdH2Yhy
         PM7u7+0i75odsmsft80KvF9eFOivQmRZKejsPlLkQVDLll4+uPJPiBG8/3dWfl5gMvjB
         s14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFSuHaOwiwhrcp9I4+lXuxGEmBkGEK6trawqembeyj8=;
        b=qcx1PWd+K5twLdMkYcGEEA3JsjEvR4qlmajH8N1DasVzp2R/knxLJa1CzMEbXtyL9c
         reThMsMPZRXD/JnFLfEafLKI1dLeAh4HiYtVmujheKaSnjAsqRHBIUTFmgR5pgpK+pwk
         jv6pDeya6p1qiuNmIv3Y9gbMNL6e7lUgvqsHhAKIvzIa03D6U22KaUNy5rF/42BEJlTe
         L3pdevfMS4ZGtyZ5vwIzfKMiVb1Jsrxqqf0TWWz/KUTY0fDYSfkjRzBGGpuW4Q8cxge4
         4ywAYJkSwlWSEsNexhOiS5EXWhcu58wBTqGua/MuMh5zqZR2C0O5Eq5yAx6MkKu9d4ER
         ij0A==
X-Gm-Message-State: APjAAAX31Cd8Vwcfmlu4S80stygU2iEaL2Pfrgb+rjnJp08meq4ZArtv
        qyW6OEeMUj6gsP4hTXoSTgrL/CQG1CMJLAMoDw1Atw==
X-Google-Smtp-Source: APXvYqw1klm+cUI+4xd3W7lXl5hO001z43f4dQJ6au0p+vomFkn6qi+BzRFNvprirz0H0GdhWfVLwqZ3sGvWtgCjmDk=
X-Received: by 2002:ac2:54b4:: with SMTP id w20mr20427922lfk.67.1576005691378;
 Tue, 10 Dec 2019 11:21:31 -0800 (PST)
MIME-Version: 1.0
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-2-jean.pihet@newoldbits.com> <20191206162431.GF35479@atomide.com>
 <CAORVsuUBseM3vnZsSajMmUS1O6rEC4U_aa951HwMsGxyEm+t+g@mail.gmail.com>
 <20191206175731.GG35479@atomide.com> <CAORVsuXe7SyAmzLv4VoKMsf4jcYV1bKoCixhsgZ3U0rBHFJA4Q@mail.gmail.com>
 <20191210170329.GM35479@atomide.com>
In-Reply-To: <20191210170329.GM35479@atomide.com>
From:   Jean Pihet <jean.pihet@newoldbits.com>
Date:   Tue, 10 Dec 2019 20:21:20 +0100
Message-ID: <CAORVsuX_bzzsjh+qg_i_sfc=GR6F=S2wgObZiQTdM=w=ghZ9BA@mail.gmail.com>
Subject: Re: [PATCH 1/3] TI QSPI: Fix fclk frequency
To:     Tony Lindgren <tony@atomide.com>
Cc:     Tero Kristo <t-kristo@ti.com>, Mark Brown <broonie@kernel.org>,
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

On Tue, Dec 10, 2019 at 6:03 PM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * Jean Pihet <jean.pihet@newoldbits.com> [191210 16:24]:
> > On Fri, Dec 6, 2019 at 6:57 PM Tony Lindgren <tony@atomide.com> wrote:
> > > Care to test with the patch below (without your changes) to see if
> > > something else is still needed?
> >
> > With the patch applied fck still is the ick, not the L4 clock as required.
>
> Hmm OK so I think we need fck at both the module level and qspi level.
>
> > Could both ick and fck be defined in the DT files, like here below?
> >    clocks = <&l3s_clkctrl AM4_L3S_QSPI_CLKCTRL 0>,
> >                  <&l4per2_clkctrl AM4_L4PER2_QSPI_CLKCTRL 0>;
> >    clock-names = "ick", "fck";
> > The issue is that there is no l4_per for AM4.
>
> Yes you can configure both fck and ick there, and also additional
> clocks. But the clkctrl clock is the fck clock gate for this module,
> and it's source can be the same as the interface clock for some
> modules.
>
> When I sent the experimental patch I confirmed that just the fck
> as <&l3s_clkctrl AM4_L3S_QSPI_CLKCTRL 0>, ti-sysc.c driver can
> read the qspi module revision register just fine. So that means
> that it's enough for the module, and the spi_clk is another
> clock specific to the child qspi IP in the module.
>
> So based on that, I think we should set up the clocks in the
> following way for the module and it's qspi child:
>
> target-module@47900000 {
>         ...
>         clocks = <&l3s_clkctrl AM4_L3S_QSPI_CLKCTRL 0>;
>         clock-names = "fck";
>         ...
>
>         qspi: spi@0 {
>                 ...
>                 clocks = <&dpll_per_m2_div4_ck>;
>                 clock-names = "fck";
>                 ...
>         };
> };
>
> That way the qspi driver can set the divider on it's fck based
> on "spi-max-frequency" dts property.
>
> > Looking at the DRA7 DT files there is an fck defined (in dra7.dtsi):
> >    clocks = <&l4per2_clkctrl DRA7_L4PER2_QSPI_CLKCTRL 25>;
> >    clock-names = "fck";
>
> Yeah so that's <&l3s_clkctrl AM4_L3S_QSPI_CLKCTRL 0> for
> am437x.
>
> > What is best to do from here?
>
> Well can test again with the patch below to see if that is
> enough to make it work :)

This patch works OK! The correct clock is in use by the driver. The
hwmod warning shows up at boot:
[    0.103567] omap_hwmod: qspi: no dt node
[    0.103599] ------------[ cut here ]------------
[    0.103639] WARNING: CPU: 0 PID: 1 at
arch/arm/mach-omap2/omap_hwmod.c:2414 _init.constprop.29+0x198/0x4a0
[    0.103654] omap_hwmod: qspi: doesn't have mpu register target base

Glad to help to get to the final solution, please let me know how I
can help on that.

Regards,
Jean

>
> Regards,
>
> Tony
>
> 8< -------------------
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -302,17 +302,35 @@ gpmc: gpmc@50000000 {
>                         status = "disabled";
>                 };
>
> -               qspi: spi@47900000 {
> -                       compatible = "ti,am4372-qspi";
> -                       reg = <0x47900000 0x100>,
> -                             <0x30000000 0x4000000>;
> -                       reg-names = "qspi_base", "qspi_mmap";
> +               target-module@47900000 {
> +                       compatible = "ti,sysc-omap4", "ti,sysc";
> +                       //ti,hwmods = "qspi";
> +                       reg = <0x47900000 0x4>,
> +                             <0x47900010 0x4>;
> +                       reg-names = "rev", "sysc";
> +                       ti,sysc-sidle = <SYSC_IDLE_FORCE>,
> +                                       <SYSC_IDLE_NO>,
> +                                       <SYSC_IDLE_SMART>,
> +                                       <SYSC_IDLE_SMART_WKUP>;
> +                       clocks = <&l3s_clkctrl AM4_L3S_QSPI_CLKCTRL 0>;
> +                       clock-names = "fck";
>                         #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       ti,hwmods = "qspi";
> -                       interrupts = <0 138 0x4>;
> -                       num-cs = <4>;
> -                       status = "disabled";
> +                       #size-cells = <1>;
> +                       ranges = <0x0 0x47900000 0x1000>,
> +                                <0x30000000 0x30000000 0x4000000>;
> +
> +                       qspi: spi@0 {
> +                               compatible = "ti,am4372-qspi";
> +                               reg = <0 0x100>,
> +                                     <0x30000000 0x4000000>;
> +                               reg-names = "qspi_base", "qspi_mmap";
> +                               clocks = <&dpll_per_m2_div4_ck>;
> +                               clock-names = "fck";
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               interrupts = <0 138 0x4>;
> +                               num-cs = <4>;
> +                       };
>                 };
>
>                 dss: dss@4832a000 {
> --
> 2.24.0
