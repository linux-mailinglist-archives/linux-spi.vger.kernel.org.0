Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A951A41FAAD
	for <lists+linux-spi@lfdr.de>; Sat,  2 Oct 2021 11:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhJBJgB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 2 Oct 2021 05:36:01 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:45243 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhJBJgA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 2 Oct 2021 05:36:00 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9832922221;
        Sat,  2 Oct 2021 11:34:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1633167252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvHAeShfFJTvLzPGYz+Pa0If/DHoYwF1/lealCLdgAQ=;
        b=NX0dCFnM+A1Dutx0l6bwA4qci0Cr+UMwt+7dKBp+iToOwg94jvFXK21KI3gETPMn4xlYbN
        S/qm2D2BZzph0LrcHhHSnUL+ZWdTgDbca3CBhk0r4CA0iuO+bn2PZQy1P5r4VGyiyVk7EV
        07uND/mJLSQEFBcq4w4pw3EBPQuKNdM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 02 Oct 2021 11:34:12 +0200
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [PATCH] spi: spi-nxp-fspi: don't depend on a specific node name
 erratum workaround
In-Reply-To: <20211002092301.ue77mzzwcel76umx@skbuf>
References: <20211001212726.159437-1-michael@walle.cc>
 <20211002013737.hpalogc72umopz4x@skbuf>
 <c5a67c34af869fd93d34320ef181c682@walle.cc>
 <20211002092301.ue77mzzwcel76umx@skbuf>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <c9a4f7cca7d2e3959e20d8098a322562@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-10-02 11:23, schrieb Vladimir Oltean:
> On Sat, Oct 02, 2021 at 10:58:31AM +0200, Michael Walle wrote:
>> Am 2021-10-02 03:37, schrieb Vladimir Oltean:
>> > On Fri, Oct 01, 2021 at 11:27:26PM +0200, Michael Walle wrote:
>> 
>> > > Make the workaround more reliable and just drop the unneeded sysclk
>> > > lookup.
>> > >
>> > > For reference, the error during the bootup is the following:
>> > > [    4.898400] nxp-fspi 20c0000.spi: Errata cannot be executed. Read
>> > > via IP bus may not work
>> >
>> > Well, in Kuldeep's defence, at least this part is sane, right? I mean we
>> > cannot prove an issue => we don't disable reads via the AHB. So it's
>> > just the error message (which I didn't notice TBH, sorry).
>> 
>> Its just an error message in case the platform clock is 400Mhz. But
>> if you have a 300MHz platform clock the workaround wouldn't be 
>> applied.
> 
> Understood, that's why I asked...
> 
>> The reference is just there if someone stumbles over this error and
>> searches for it on google.
>> 
>> > On the other hand, is anyone using LS1028A with a platform clock of 300
>> > MHz? :)
> 
> ...this.

Which I can't answer ;)

> 
>> > > Fixes: 82ce7d0e74b6 ("spi: spi-nxp-fspi: Implement errata workaround
>> > > for LS1028A")
>> > > Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
>> > > Signed-off-by: Michael Walle <michael@walle.cc>
>> > > ---
>> > >  drivers/spi/spi-nxp-fspi.c | 26 +++++++-------------------
>> > >  1 file changed, 7 insertions(+), 19 deletions(-)
>> > >
>> > > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
>> > > index a66fa97046ee..2b0301fc971c 100644
>> > > --- a/drivers/spi/spi-nxp-fspi.c
>> > > +++ b/drivers/spi/spi-nxp-fspi.c
>> > > @@ -33,6 +33,7 @@
>> > >
>> > >  #include <linux/acpi.h>
>> > >  #include <linux/bitops.h>
>> > > +#include <linux/bitfield.h>
>> > >  #include <linux/clk.h>
>> > >  #include <linux/completion.h>
>> > >  #include <linux/delay.h>
>> > > @@ -315,6 +316,7 @@
>> > >  #define NXP_FSPI_MIN_IOMAP	SZ_4M
>> > >
>> > >  #define DCFG_RCWSR1		0x100
>> > > +#define SYS_PLL_RAT		GENMASK(6, 2)
>> >
>> > Ugh. So your solution still makes a raw read of the platform PLL value
>> > from the DCFG, now it just adds a nice definition for it. Not nice.
>> 
>> Keep in mind that this is intended to be a fixes commit. I agree with
>> you that having a new clock in the device tree and checking that would
>> have been better. Feel free to change the workaround after this fix
>> is applied (without a fixes tag), but I don't think introducing a new
>> clock (and you forgot to update the bindings) will qualify as a fixes
>> commit. Esp. when you change the compatible string.
> 
> I think it could be justified as a fixes commit to Shawn Guo - the
> LS1028A is not "compatible" with LX2160A in the sense that it has
> software-visible errata which LX2160A doesn't have.

And you'd need to get Rob into the boat for the dt bindings "fixes",
no? For the new clock.

>> > >  /* Access flash memory using IP bus only */
>> > >  #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
>> > > @@ -926,9 +928,8 @@ static void erratum_err050568(struct nxp_fspi *f)
>> > >  		{ .family = "QorIQ LS1028A" },
>> > >  		{ /* sentinel */ }
>> > >  	};
>> > > -	struct device_node *np;
>> > >  	struct regmap *map;
>> > > -	u32 val = 0, sysclk = 0;
>> > > +	u32 val, sys_pll_ratio;
>> > >  	int ret;
>> > >
>> > >  	/* Check for LS1028A family */
>> > > @@ -937,7 +938,6 @@ static void erratum_err050568(struct nxp_fspi *f)
>> > >  		return;
>> > >  	}
>> > >
>> > > -	/* Compute system clock frequency multiplier ratio */
>> > >  	map = syscon_regmap_lookup_by_compatible("fsl,ls1028a-dcfg");
>> > >  	if (IS_ERR(map)) {
>> > >  		dev_err(f->dev, "No syscon regmap\n");
>> > > @@ -948,23 +948,11 @@ static void erratum_err050568(struct nxp_fspi
>> > > *f)
>> > >  	if (ret < 0)
>> > >  		goto err;
>> > >
>> > > -	/* Strap bits 6:2 define SYS_PLL_RAT i.e frequency multiplier
>> > > ratio */
>> > > -	val = (val >> 2) & 0x1F;
>> > > -	WARN(val == 0, "Strapping is zero: Cannot determine ratio");
>> > > +	sys_pll_ratio = FIELD_GET(SYS_PLL_RAT, val);
>> > > +	dev_dbg(f->dev, "val: 0x%08x, sys_pll_ratio: %d\n", val,
>> > > sys_pll_ratio);
>> >
>> > Do we really feel that this dev_dbg is valuable?
>> 
>> No, I just briefly looked at it to see it prints 4 ;)
>> 
>> > > -	/* Compute system clock frequency */
>> > > -	np = of_find_node_by_name(NULL, "clock-sysclk");
>> > > -	if (!np)
>> > > -		goto err;
>> > > -
>> > > -	if (of_property_read_u32(np, "clock-frequency", &sysclk))
>> > > -		goto err;
>> > > -
>> > > -	sysclk = (sysclk * val) / 1000000; /* Convert sysclk to Mhz */
>> > > -	dev_dbg(f->dev, "val: 0x%08x, sysclk: %dMhz\n", val, sysclk);
>> > > -
>> > > -	/* Use IP bus only if PLL is 300MHz */
>> > > -	if (sysclk == 300)
>> > > +	/* Use IP bus only if platform clock is 300MHz */
>> > > +	if (sys_pll_ratio == 3)
>> > >  		f->devtype_data->quirks |= FSPI_QUIRK_USE_IP_ONLY;
>> > >
>> > >  	return;
>> > > --
>> > > 2.30.2
>> > >
>> >
>> > How about:
>> >
>> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > index 343ecf0e8973..ffe820c22719 100644
>> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > @@ -326,15 +326,17 @@ i2c7: i2c@2070000 {
>> >  		};
>> >
>> >  		fspi: spi@20c0000 {
>> > -			compatible = "nxp,lx2160a-fspi";
>> > +			compatible = "nxp,ls1028a-fspi";
>> 
>> Why not
>>   compatible = "nxp,ls1028a-fspi", "nxp,lx2160a-fspi";
>> to keep at least some compatibility.
> 
> Of course that would be even better. I just wanted to rush to get here
> before Mark, and it looks like I still didn't make it in time.
> 
> Worst case, new (cleaned up to not calculate the platform clock on its 
> own)
> driver will still probe with old device tree, but not apply the ERR
> workaround for 300 MHz systems.

No worst case is, the flexspi driver doesn't probe at all (new 
devicetree,
old kernel ;).

> I may be ignorant here, but I just don't know how many systems use 300
> MHz platform in practice. Anyway, it's always difficult to fix up
> something that came to depend on DT bindings in a certain way.
> 
>> >  			#address-cells = <1>;
>> >  			#size-cells = <0>;
>> >  			reg = <0x0 0x20c0000 0x0 0x10000>,
>> >  			      <0x0 0x20000000 0x0 0x10000000>;
>> >  			reg-names = "fspi_base", "fspi_mmap";
>> >  			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>> > -			clocks = <&fspi_clk>, <&fspi_clk>;
>> > -			clock-names = "fspi_en", "fspi";
>> > +			clocks = <&fspi_clk>, <&fspi_clk>,
>> > +				 <&clockgen QORIQ_CLK_PLATFORM_PLL
>> > +					    QORIQ_CLK_PLL_DIV(2)>;
>> > +			clock-names = "fspi_en", "fspi", "base";
>> >  			status = "disabled";
>> >  		};
>> >
>> > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
>> > index a66fa97046ee..f2815e6cae2c 100644
>> > --- a/drivers/spi/spi-nxp-fspi.c
>> > +++ b/drivers/spi/spi-nxp-fspi.c
>> > @@ -314,8 +314,6 @@
>> >  #define NXP_FSPI_MAX_CHIPSELECT		4
>> >  #define NXP_FSPI_MIN_IOMAP	SZ_4M
>> >
>> > -#define DCFG_RCWSR1		0x100
>> > -
>> >  /* Access flash memory using IP bus only */
>> >  #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
>> >
>> > @@ -922,55 +920,18 @@ static int nxp_fspi_adjust_op_size(struct
>> > spi_mem *mem, struct spi_mem_op *op)
>> >
>> >  static void erratum_err050568(struct nxp_fspi *f)
>> >  {
>> > -	const struct soc_device_attribute ls1028a_soc_attr[] = {
>> > -		{ .family = "QorIQ LS1028A" },
>> > -		{ /* sentinel */ }
>> > -	};
>> 
>> Mh, I see how you came to the conclusion to rename the compatible
>> string. But normally, this also contains a revision check,
>> which is missing here IMHO. It might as well be fixed in the
>> next revision (though we both know, this is highly unlikely; its
>> still wrong). So while you could rename the compatible (oh no!)
>> you'd still have to do the rev 1.0 check here.
> 
> So you want a compatible string a la "fsl,ls1021a-v1.0-dspi", right?
> I don't know, no strong opinion, as you said, we both know that no
> LS1028A rev 2 seems to be planned.

Nooo. No revisions in the compatible string.

const struct soc_device_attribute ls1028a_soc_attr[] = {
	{ .family = "QorIQ LS1028A", .revision = "1.0" },
	{ }
};

Thus you'd still need that check above.

-michael
