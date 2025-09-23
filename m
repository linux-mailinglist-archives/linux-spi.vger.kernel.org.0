Return-Path: <linux-spi+bounces-10228-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B8AB940DE
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 05:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F15188A928
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 03:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4558175D53;
	Tue, 23 Sep 2025 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="iQcMIXuy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A2A63CF;
	Tue, 23 Sep 2025 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596436; cv=none; b=e7usbDsCPu2kHKQPSAw0SYdbmji82GIU2pC3OUg/UoStJQxpVaZ9+NxBixlNmrZvfMemTmHuKDM8vH2Eq33XmF43XYnxwBeP15EsVqUAJviuF+S3QsRiX1l3PkVrIlrnjMOqi2cL148ukyKcFSEUAnyY2zan6OFKiUe0G+nNl2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596436; c=relaxed/simple;
	bh=P5Fc8DgI1Pt521PuZpDDub2ijC4+mnpM9ZtHdfk/cFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9yp3XAuTAy33c5TYQiJSfYPpjDsRqriS1mk9Jbp/BNG3Wy2kwCIPBe1F7BkcZd5dpp1R1+7XQniFlnUkXihMGp2h0Pl/2BuiaN+2wzsVYUn3pWd/wcxeY69Y4tvpomZib82E10FIuD+sE2TRR0D3t0RaZwzUDwS0hlYxItooPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=iQcMIXuy; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1758596392;
	bh=j3ZjDbLr3bk9oP8VaNnloWAFAE6ZFmd5SxI38WMzUrs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=iQcMIXuyCWh3j23wDllpkXO1WdPURPKa8wlkc/ff9xRSZ49tJuu8nTfsuqoHDOSBX
	 h+OIMH6ebnjlTqPDPitJ2r6bkRh/xek7zNRCkl3Q4ThGylgbAF6RYogCO02WWdd3uT
	 KpGo3vgFQp/b0BAgpzkmC5VFuILIiwDjCWusXmxE=
X-QQ-mid: zesmtpsz7t1758596391t52fea924
X-QQ-Originating-IP: nzpaKUhmb4SdUS4Gu0DvPdsaKPvAhj/hmH2eNiRVi4k=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Sep 2025 10:59:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10623942537580946484
EX-QQ-RecipientCnt: 18
Date: Tue, 23 Sep 2025 10:59:48 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Yixun Lan <dlan@gentoo.org>, Alex Elder <elder@riscstar.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v3 3/3] riscv: dts: spacemit: define a SPI controller node
Message-ID: <ED4C67FD136DEB19+aNINJJVYbNnT87va@LT-Guozexi>
References: <20250922161717.1590690-1-elder@riscstar.com>
 <20250922161717.1590690-4-elder@riscstar.com>
 <20250923001930-GYB1303776@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923001930-GYB1303776@gentoo.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: Mga0zcyr3Ge/7qN2aRXFeioRXNoQXS9X/4yc21FiIFy2K5/x3PwrimJY
	h6HnRZaFI61SLeZo9oAT91NhekwjnVce7n+yw593yTW3xCvsXridYWV6YgdhPqDpZJIfJbK
	1BOmNWV9lRFdr3elyidlaO6Ag31NlYmeHSInapyRGVB3jaPB+7UFPIlpd+yfoJ/eUwIBRRY
	alpbb0ApuQGEqwVVbj9MMkOt+ZZP0yVWEweWw6vqhrTXCiX00YWJQgQFWQM/aS76VrhW1GK
	eG7yWl1Emmb0ZzkurvwOyUO0+VxjjvOm38b9tYLvYMBnrlyzbW1nWmQJaZlJO1zTBmbBTTp
	K6S6fof2RblDXu1wunWHBLT+f8pYLMvTzw9HQZBSSpI1bp8D+Zv1wEiNXyEbYai+UZYbdF0
	RGMOKgYRk1w5cNYDWeeoO7RbQZ8fZEa9gWUI2OKnUUH8sbb7VIrAAIdarMywoWWEDBWj81+
	+RzCnVDX02qSPhmwVvfFxzsTcQM6GOjPwk7909Qi4gjBGEIFe6p2cRgbrKjrUqNUk7mmGP/
	1BvkJ/i+RRa0q8klIAIRvgxBsBczxqKCtOFcH1w6IZqERUbEysE6wO39S/CdocgLTK+3zbL
	s2+JdGg1bm262eBxfFem6dpxh+vS7Ht8keKmY3nBQMV6jkkyDLeDyounJPdiLwWTXUp3yfm
	joDZoYFgy0Zp8gD6Q+Nbzk9kwGbU8qsnkP1u/EMrwbDFzEbjVuYMMTMLxFouZkDFZUMQJmH
	PIyGP1A6YgS2C7hjX2G7cMAOgPtEKW92SkROryDP3PKAT+Fyg+f7/2kmiEeJNw0Y2iHBCv/
	oCqFizmLTiBQFBzcs23mBCQ0J5QMuK+hEJlcPxpwIJrevGTo5b6kc1N9/EgWXy5t+67KNr1
	ntxJwITxhqvAlE/o0FRitWmeiz8MYz7KBtJ3x8yuzpCOIJ/rIcpsF9SD0bcXXzoV79kMdiW
	C8Ls0eddJJ2AomIOtGc5N+cpgHdWg2EXUK6AEl2lkOFTk8q0yIS4dbWG99CunvpLuNk7Nmi
	t66UvppI8QMryU8XzGUwah8f7I6XeCryWmQ7nIKBYkwcH2cD+ZopSj782qrhJIXI8XPyBj4
	U2VWfVHH/heAvU821LwQFQicNohXFtW3pl90Qn5DDutSptNgD97qaHcAiI3CREjlQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Tue, Sep 23, 2025 at 08:19:30AM +0800, Yixun Lan wrote:
> Hi Alex,
> 
> On 11:17 Mon 22 Sep     , Alex Elder wrote:
> > Define a node for the fourth SoC SPI controller (number 3) on
> > the SpacemiT K1 SoC.
> > 
> > Enable it on the Banana Pi BPI-F3 board, which exposes this feature
> > via its GPIO block:
> >   GPIO PIN 19:  MOSI
> >   GPIO PIN 21:  MISO
> >   GPIO PIN 23:  SCLK
> >   GPIO PIN 24:  SS (inverted)
> > 
> > Define pincontrol configurations for the pins as used on that board.
> > 
> > (This was tested using a GigaDevice GD25Q64E SPI NOR chip.)
> > 
> > Signed-off-by: Alex Elder <elder@riscstar.com>
> > ---
> > v3: - Moved the SPI controller into the dma-bus memory region
> > 
> >  .../boot/dts/spacemit/k1-bananapi-f3.dts      |  7 +++++++
> >  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 20 +++++++++++++++++++
> >  arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 +++++++++++++++
> >  3 files changed, 43 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > index 2aaaff77831e1..d9d865fbe320e 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > @@ -14,6 +14,7 @@ aliases {
> >  		ethernet0 = &eth0;
> >  		ethernet1 = &eth1;
> >  		serial0 = &uart0;
> > +		spi3 = &spi3;
> >  	};
> >  
> >  	chosen {
> > @@ -92,6 +93,12 @@ &pdma {
> >  	status = "okay";
> >  };
> >  
> > +&spi3 {
> > +	pinctrl-0 = <&ssp3_0_cfg>;
> > +	pinctrl-names = "default";
> > +	status = "okay";
> > +};
> > +
> >  &uart0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&uart0_2_cfg>;
> > diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > index aff19c86d5ff3..205c201a3005c 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > @@ -76,4 +76,24 @@ pwm14-1-pins {
> >  			drive-strength = <32>;
> >  		};
> >  	};
> > +
> > +	ssp3_0_cfg: ssp3-0-cfg {
> ..
> > +		ssp3-0-no-pull-pins {
> I'd prefer not to enforce "pull" info inside the name, you can't embed
> all property info, besides, what's if you want to change/override later?
> 
> how about just name it as ssp3-0-defaul-pins or simply ssp3-0-pins?
uart: uart0_2_cfg and function is 2.
pwm: pwm14_1_cfg and function is 4
spi: ssp3_0_cfg and function is 2

I’m a bit confused about the meaning of the second number here.
Is it intended to be an index, or the function number?

If it’s an index, should it start from 0 or 1?
The starting point seems inconsistent across pwm/spi/uart.
If it’s supposed to be the function number,
then the spi and pwm parts look incorrect.

Could you clarify this? Yixun.

                - Troy
> 
> > +			pinmux = <K1_PADCONF(75, 2)>,	/* SCLK */
> > +				 <K1_PADCONF(77, 2)>,	/* MOSI  */
> > +				 <K1_PADCONF(78, 2)>;	/* MISO */
> > +
> > +			bias-disable;
> > +			drive-strength = <19>;
> > +			power-source = <3300>;
> > +		};
> > +
> > +		ssp3-0-frm-pins {
> > +			pinmux = <K1_PADCONF(76, 2)>;	/* FRM (frame) */
> > +
> > +			bias-pull-up = <0>;
> > +			drive-strength = <19>;
> > +			power-source = <3300>;
> > +		};
> > +	};
> >  };
> > diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > index 6cdcd80a7c83b..eb8a14dd72ea4 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> > +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > @@ -797,6 +797,22 @@ uart9: serial@d4017800 {
> >  				status = "disabled";
> >  			};
> >  
> > +			spi3: spi@d401c000 {
> > +				compatible = "spacemit,k1-spi";
> > +				reg = <0x0 0xd401c000 0x0 0x30>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				clocks = <&syscon_apbc CLK_SSP3>,
> > +					 <&syscon_apbc CLK_SSP3_BUS>;
> > +				clock-names = "core", "bus";
> > +				resets = <&syscon_apbc RESET_SSP3>;
> > +				interrupts = <55>;
> ..
> > +				dmas = <&pdma 20>,
> > +				       <&pdma 19>;
> can we also squash the dmas into one line? but, do split if there are too many..
> 
> yes, it's simply a style change that I'd like to keep them consistent at DT level,
> besides you might also want to adjust dt-binding examples to align with them here..
> 
> thanks
> 
> > +				dma-names = "rx", "tx";
> > +				status = "disabled";
> > +			};
> > +
> >  			/* sec_uart1: 0xf0612000, not available from Linux */
> >  		};
> >  
> > -- 
> > 2.48.1
> > 
> > 
> 
> -- 
> Yixun Lan (dlan)
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

