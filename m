Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E3E41FBD1
	for <lists+linux-spi@lfdr.de>; Sat,  2 Oct 2021 14:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhJBMm6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 2 Oct 2021 08:42:58 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:36447 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhJBMm6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 2 Oct 2021 08:42:58 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D1F7022247;
        Sat,  2 Oct 2021 14:41:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1633178470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7LTWfcj1Mgl8Q6Bw62IIEi4P7ppF7NVVDvnDHKB+EVA=;
        b=UvkwuRFpPhkrCQPkAXfLanvaQySWxG9VoqKXUFc1rwpiFXjLyz6yppW95xXUeHJcZN1TSy
        HynqbontRW6B0wIVIpuQThFecKfXbzJiN5JVAYq/bwFRm/az3J/X1rKP9JeZQUDnAigzyI
        IFw2jWj9ru+lm8KBk0IzhZjR5PKmZmE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 02 Oct 2021 14:41:10 +0200
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [PATCH] spi: spi-nxp-fspi: don't depend on a specific node name
 erratum workaround
In-Reply-To: <20211002095515.iw5rgakysyusvqte@skbuf>
References: <20211001212726.159437-1-michael@walle.cc>
 <20211002013737.hpalogc72umopz4x@skbuf>
 <c5a67c34af869fd93d34320ef181c682@walle.cc>
 <20211002092301.ue77mzzwcel76umx@skbuf>
 <c9a4f7cca7d2e3959e20d8098a322562@walle.cc>
 <20211002095515.iw5rgakysyusvqte@skbuf>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <1ce9c7be1c486e412c1d0326fa00ca54@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-10-02 11:55, schrieb Vladimir Oltean:
> On Sat, Oct 02, 2021 at 11:34:12AM +0200, Michael Walle wrote:
>> > > > Ugh. So your solution still makes a raw read of the platform PLL value
>> > > > from the DCFG, now it just adds a nice definition for it. Not nice.
>> > >
>> > > Keep in mind that this is intended to be a fixes commit. I agree with
>> > > you that having a new clock in the device tree and checking that would
>> > > have been better. Feel free to change the workaround after this fix
>> > > is applied (without a fixes tag), but I don't think introducing a new
>> > > clock (and you forgot to update the bindings)
> 
> I don't think I'm the one who forgot to update the bindings, btw.
> In Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt (still not
> using JSON schema), the "clocks" are not documented as to what they 
> want
> and why do both "fspi" and "fspi_en" even exist. The only mention you
> see of the "fspi" and "fspi_en" clocks in that file is an _example_.
> And that example remains correct, because it is for the LX2160A.

That doesn't mean you shouldn't document it in the bindings.

I just wanted to point out that for a fixes commit, you'd
have to consider that change, too.

>> > > will qualify as a fixes
>> > > commit. Esp. when you change the compatible string.
>> >
>> > I think it could be justified as a fixes commit to Shawn Guo - the
>> > LS1028A is not "compatible" with LX2160A in the sense that it has
>> > software-visible errata which LX2160A doesn't have.
>> 
>> And you'd need to get Rob into the boat for the dt bindings "fixes",
>> no? For the new clock.
> 
> Yup.
> 
>> > > > How about:
>> > > >
>> > > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > > > b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > > > index 343ecf0e8973..ffe820c22719 100644
>> > > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > > > @@ -326,15 +326,17 @@ i2c7: i2c@2070000 {
>> > > >  		};
>> > > >
>> > > >  		fspi: spi@20c0000 {
>> > > > -			compatible = "nxp,lx2160a-fspi";
>> > > > +			compatible = "nxp,ls1028a-fspi";
>> > >
>> > > Why not
>> > >   compatible = "nxp,ls1028a-fspi", "nxp,lx2160a-fspi";
>> > > to keep at least some compatibility.
>> >
>> > Of course that would be even better. I just wanted to rush to get here
>> > before Mark, and it looks like I still didn't make it in time.
>> >
>> > Worst case, new (cleaned up to not calculate the platform clock on its
>> > own)
>> > driver will still probe with old device tree, but not apply the ERR
>> > workaround for 300 MHz systems.
>> 
>> No worst case is, the flexspi driver doesn't probe at all (new 
>> devicetree,
>> old kernel ;).
> 
> Well, if you're going to take my patch as is, sure. But the device tree
> can still be modified in such a way that old kernels keep seeing what
> they saw before - the fallback compatibility string, and ignore the
> third clock provider.

Ack.

> With even more care and consideration for new kernels operating with 
> old
> DT blobs, the ERR workaround could check for the clock provider in the
> device tree first, then fall back to open-coding its own deductions of
> the platform clock if that fails. After a grace period of one or two
> years or so, maybe the open-coding could then be removed.

Mh, do you really want to go that extra mile for something you don't
even know is used? It's up to you, I wouldn't do it ;)

>> > I may be ignorant here, but I just don't know how many systems use 300
>> > MHz platform in practice. Anyway, it's always difficult to fix up
>> > something that came to depend on DT bindings in a certain way.
>> >
>> > > >  			#address-cells = <1>;
>> > > >  			#size-cells = <0>;
>> > > >  			reg = <0x0 0x20c0000 0x0 0x10000>,
>> > > >  			      <0x0 0x20000000 0x0 0x10000000>;
>> > > >  			reg-names = "fspi_base", "fspi_mmap";
>> > > >  			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>> > > > -			clocks = <&fspi_clk>, <&fspi_clk>;
>> > > > -			clock-names = "fspi_en", "fspi";
>> > > > +			clocks = <&fspi_clk>, <&fspi_clk>,
>> > > > +				 <&clockgen QORIQ_CLK_PLATFORM_PLL
>> > > > +					    QORIQ_CLK_PLL_DIV(2)>;
>> > > > +			clock-names = "fspi_en", "fspi", "base";
>> > > >  			status = "disabled";
>> > > >  		};
>> > > >
>> > > > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
>> > > > index a66fa97046ee..f2815e6cae2c 100644
>> > > > --- a/drivers/spi/spi-nxp-fspi.c
>> > > > +++ b/drivers/spi/spi-nxp-fspi.c
>> > > > @@ -314,8 +314,6 @@
>> > > >  #define NXP_FSPI_MAX_CHIPSELECT		4
>> > > >  #define NXP_FSPI_MIN_IOMAP	SZ_4M
>> > > >
>> > > > -#define DCFG_RCWSR1		0x100
>> > > > -
>> > > >  /* Access flash memory using IP bus only */
>> > > >  #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
>> > > >
>> > > > @@ -922,55 +920,18 @@ static int nxp_fspi_adjust_op_size(struct
>> > > > spi_mem *mem, struct spi_mem_op *op)
>> > > >
>> > > >  static void erratum_err050568(struct nxp_fspi *f)
>> > > >  {
>> > > > -	const struct soc_device_attribute ls1028a_soc_attr[] = {
>> > > > -		{ .family = "QorIQ LS1028A" },
>> > > > -		{ /* sentinel */ }
>> > > > -	};
>> > >
>> > > Mh, I see how you came to the conclusion to rename the compatible
>> > > string. But normally, this also contains a revision check,
>> > > which is missing here IMHO. It might as well be fixed in the
>> > > next revision (though we both know, this is highly unlikely; its
>> > > still wrong). So while you could rename the compatible (oh no!)
>> > > you'd still have to do the rev 1.0 check here.
>> >
>> > So you want a compatible string a la "fsl,ls1021a-v1.0-dspi", right?
>> > I don't know, no strong opinion, as you said, we both know that no
>> > LS1028A rev 2 seems to be planned.
>> 
>> Nooo. No revisions in the compatible string.
>> 
>> const struct soc_device_attribute ls1028a_soc_attr[] = {
>> 	{ .family = "QorIQ LS1028A", .revision = "1.0" },
>> 	{ }
>> };
>> 
>> Thus you'd still need that check above.
> 
> Ok, the idea of changing the compatible string was to make the driver
> search for the third "base" clock. But the bindings document can simply
> say that the "base" clock is optional for all SoCs - with the caveat
> that the LS1028A ERR workarounds will not be applied if not provided.
> And in that case, not even a SoC specific compatible string is needed.

Ack.

-michael
