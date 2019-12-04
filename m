Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77C211255A
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 09:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLDIid (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 03:38:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35432 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfLDIid (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Dec 2019 03:38:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id u8so6863033wmu.0
        for <linux-spi@vger.kernel.org>; Wed, 04 Dec 2019 00:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ParemWJI/n3SRaHe2+emu1Uz8fq8wC/gKNUHTDS5UZA=;
        b=I7KtYnyek5P0gcpiPIk3bBEEuE4asY8oupB3ktcj4a+Zlqh3iJEq00gSYseHDHFA1k
         npRaWnG1YQdVAzGC705aKfaffcpFxVFg3EIW5eB08uRvsTwXLJrdA/rKOQODQaaSYp9G
         Bl4wOYG7N75IxhMZvVe/qTQ3Dybq1QU+R/Iq15cm1Wb/SO2XaLWfyRmzPzWY4qTBtvjE
         P9UL817iJzoubCEecetvcYIo9Q5MT+iK6+QI+Gs4DR+nIq7wLkAJTd7Lg7+qwSiBRwG3
         XGxJWSSqTOkTo0xnO5fH8TrN0exJvvhERHsi18OX6rWz6STVCITNp16EkSXl2AgG5IRm
         YlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ParemWJI/n3SRaHe2+emu1Uz8fq8wC/gKNUHTDS5UZA=;
        b=op8AWOLLSQaQW+Q4+UOdmRNUMiPZw/iNLNnj6XXE7f2hPyJCYcCwPF9oN3y0pkPVjk
         nj2+rdJvw8SB1fk3GOV3As5QAINzLa9ZaurlM7nZ3gt7bEo7LozPB9Xi46NLuWbMzALL
         mfgXh/OS6zSXAOV1NAuxYpwiv4nbw7cVleQa9NnxVTcaRP1ojt3EFL9jY1dKIll/RzXv
         sNlh/dgfaeDGTAzZuu/ViK95/h0hETrZkJAZnvz9wg1fO+ht7rDgSOYvfcXnd4ZB57Tm
         VfQjg+d1ZW9vNFgA/2wcOtWEOexX0KZ1lPhSJAqwVf0gRsVPjkeCdqElKjXl98ARCQqp
         0D7A==
X-Gm-Message-State: APjAAAVS7YVuHtIEkwHXSplQ9OIzFyBS6RW9/FmPnrMxOzFheLNAV/Cc
        zFOMF/At+B5BR1MGtwIxVHdPLQ==
X-Google-Smtp-Source: APXvYqxJaxqhbIwl3EXEj5JJcorn8bsz0Y2qMyfYC0/6j9OurqtOKq56dRGJl4zjgTb+4IE9o3KbUA==
X-Received: by 2002:a1c:7e0e:: with SMTP id z14mr40884745wmc.52.1575448711046;
        Wed, 04 Dec 2019 00:38:31 -0800 (PST)
Received: from dell ([2.27.167.28])
        by smtp.gmail.com with ESMTPSA id n30sm5805552wmd.3.2019.12.04.00.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 00:38:30 -0800 (PST)
Date:   Wed, 4 Dec 2019 08:38:21 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Chris Brandt <Chris.Brandt@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/6] ARM: dts: r7s72100: Add SPIBSC clocks
Message-ID: <20191204083821.GA3468@dell>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-3-chris.brandt@renesas.com>
 <CAMuHMdXUVdG_PMQEpz=QWLCaabfK8Mc41zFiymXJ4Rx_C2gzdg@mail.gmail.com>
 <TY1PR01MB1562F44E4FB80788922CE9BE8A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdX_sD+UHnOF+bdbT99zfK1V92+1kVzGnb9JXJyBd-Y5-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdX_sD+UHnOF+bdbT99zfK1V92+1kVzGnb9JXJyBd-Y5-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 03 Dec 2019, Geert Uytterhoeven wrote:

> Hi Chris,
> 
> CC Lee (for clock-critical)
> 
> On Tue, Dec 3, 2019 at 7:58 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> > On Tue, Dec 3, 2019, Geert Uytterhoeven wrote:
> > > > +                       reg = <0x3fefa000 0x100>, <0x18000000
> > > > + 0x4000000>;
> > >
> > > The second region conflicts with the XIP flash@18000000 in
> > > arch/arm/boot/dts/r7s72100-gr-peach.dts.
> > > Yes, I know it is the same device ;-)
> >
> > Is that just an FYI?? Or do you have some suggestion??
> 
> Can the flash subnode be compatible with "mtd-rom", even if the parent node
> is kept disabled?
> 
> > > > +                       clock-critical = <4>; /* spibsc0 */
> > >
> > > Iff we go this clock-critical route, I think this should be specified in the
> > > board-specific .dts instead of in the SoC-specific .dtsi.
> >
> > OK, that's fine. It makes more sense to be in the .dts because it's a board
> > design decision. I will remove it from the patch.
> >
> > The one 'tricky' thing is that the <4> is the index into the number of clocks.
> >
> > So in the Renesas BSP where it includes the VDC5 LCD controllers,
> >
> > clock-output-names = "i2c0", "i2c1", "i2c2", "i2c3", "vdc50", "vdc51", "spibsc0", "spibsc1";
> >
> > the <4> needs to become a <6>.
> 
> Unless you pass "clkidx" instead of "i" to of_clk_detect_critical() in [1],
> and use "clock-critical = <R7S72100_CLK_SPIBSC0>" in DT?
> 
> Unfortunately the exact semantics of clock-critical were never documented.
> Lee?

/**
 * of_clk_detect_critical() - set CLK_IS_CRITICAL flag from Device Tree
 * @np: Device node pointer associated with clock provider
 * @index: clock index
 * @flags: pointer to top-level framework flags
 *
 * Detects if the clock-critical property exists and, if so, sets the
 * corresponding CLK_IS_CRITICAL flag.
 *
 * Do not use this function. It exists only for legacy Device Tree
 * bindings, such as the one-clock-per-node style that are outdated.
 * Those bindings typically put all clock data into .dts and the Linux
 * driver has no clock data, thus making it impossible to set this flag
 * correctly from the driver. Only those drivers may call
 * of_clk_detect_critical from their setup functions.
 *
 * Return: error code or zero on success
 */

If this meets the criteria, the API is pretty simple/self
explanatory.  What are you having trouble with?

> Thanks!
> 
> [1] "[PATCH 1/6] clk: renesas: mstp: Add critical clock from device
> tree support"
>     https://lore.kernel.org/linux-renesas-soc/20191203034519.5640-2-chris.brandt@renesas.com/
> 
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
