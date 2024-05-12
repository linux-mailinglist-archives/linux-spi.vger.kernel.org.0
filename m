Return-Path: <linux-spi+bounces-2829-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078E08C3763
	for <lists+linux-spi@lfdr.de>; Sun, 12 May 2024 18:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386B91C20C4A
	for <lists+linux-spi@lfdr.de>; Sun, 12 May 2024 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F35C56B92;
	Sun, 12 May 2024 16:14:55 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66BD4BAA6;
	Sun, 12 May 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715530495; cv=none; b=I4LszjFE9BU7r6E+4nNeoXG7YBomzeuYNO5zzniymlOYU3faOHBnkDd+BA0dwHI2miHxokHwaMUR1uXbrXlbXDevCTfHFqmV0GZBmE99Hj0B2Pcl/cWGjVVYPEH8rPpY874SB5dWYwGYSYWeD5SYg1r1B/qN/oPVIPg4RrzFIGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715530495; c=relaxed/simple;
	bh=3p6RZsaFuqQrcqYg8I7erxfuDReeZqOo7JtbFmK1OW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2W5NiQ21iUceUiVQ9IXvDDZ4nj70DnlZF76BqHqDbfhG5Pp9ZJjHfLGHuwwQqnmvV+RTkcD9FGyZIHf0vg2A3QUWt4iRcXVb2Y2YXR+8b9d1L5nch0dOXX+y4HsyPggqD5loLzT244yH1fK+HJExCMqwiEdX619livsPutZUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.96)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1s6BqR-000DB9-2O;
	Sun, 12 May 2024 18:14:39 +0200
Date: Sun, 12 May 2024 18:14:39 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: imx@lists.linux.dev, Alexander Stein <alexander.stein@ew.tq-group.com>,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: imx: Don't expect DMA for i.MX{25, 35, 50, 51, 53}
 cspi devices
Message-ID: <ZkDq73W7MuyQ4RLj@akranes.kaiser.cx>
References: <20240508095610.2146640-2-u.kleine-koenig@pengutronix.de>
 <ZjuB1Rjyu1ooYvDi@akranes.kaiser.cx>
 <a342h4qn2qkmeimbuanyqh6pxbpqvz7artmodnltcxtbzeo6qn@iyth4xit622f>
 <pof7t5skj6w7to75kynjtck5hh5whc2zm3k3cd3nsz6ogthxi3@2a6at3s4lfpy>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pof7t5skj6w7to75kynjtck5hh5whc2zm3k3cd3nsz6ogthxi3@2a6at3s4lfpy>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Hello,

Thus wrote Uwe Kleine-König (u.kleine-koenig@pengutronix.de):

> Hello,

> On Fri, May 10, 2024 at 02:32:56PM +0200, Uwe Kleine-König wrote:
> > On Wed, May 08, 2024 at 03:44:53PM +0200, Martin Kaiser wrote:
> > > Thus wrote Uwe Kleine-König (u.kleine-koenig@pengutronix.de):
> > > > While in commit 2dd33f9cec90 ("spi: imx: support DMA for imx35") it was
> > > > claimed that DMA works on i.MX25, i.MX31 and i.MX35 the respective
> > > > device trees don't add DMA channels. The Reference manuals of i.MX31 and
> > > > i.MX25 also don't mention the CSPI core being DMA capable. (I didn't
> > > > check the others.)

> > > If I'm not mistaken, the imx25 reference manual

> > > https://www.nxp.com/docs/en/reference-manual/IMX25RM.pdf

> > > does say that CSPI has DMA support. Section 18.1.1 (Features) lists DMA as one
> > > of the features. There's also DMA events (section 3) for CSPI-1/2/3 RX, TX.

> > Oh indeed. I don't know what made me claim that DMA isn't mentioned in
> > the reference manual. Maybe I looked at the i2c chapter.

> > I now did:

> > diff --git a/arch/arm/boot/dts/nxp/imx/imx25.dtsi b/arch/arm/boot/dts/nxp/imx/imx25.dtsi
> > index 4a85684deff8..710b28a41bae 100644
> > --- a/arch/arm/boot/dts/nxp/imx/imx25.dtsi
> > +++ b/arch/arm/boot/dts/nxp/imx/imx25.dtsi
> > @@ -190,6 +190,8 @@ spi1: spi@43fa4000 {
> >  				reg = <0x43fa4000 0x4000>;
> >  				clocks = <&clks 78>, <&clks 78>;
> >  				clock-names = "ipg", "per";
> > +				dmas = <&sdma 8 1 0>, <&sdma 9 1 0>;
> > +				dma-names = "rx", "tx";
> >  				interrupts = <14>;
> >  				status = "disabled";
> >  			};
> > @@ -229,6 +231,8 @@ spi3: spi@50004000 {
> >  				interrupts = <0>;
> >  				clocks = <&clks 80>, <&clks 80>;
> >  				clock-names = "ipg", "per";
> > +				dmas = <&sdma 34 1 0>, <&sdma 35 1 0>;
> > +				dma-names = "rx", "tx";
> >  				status = "disabled";
> >  			};

> > @@ -257,6 +261,8 @@ spi2: spi@50010000 {
> >  				reg = <0x50010000 0x4000>;
> >  				clocks = <&clks 79>, <&clks 79>;
> >  				clock-names = "ipg", "per";
> > +				dmas = <&sdma 6 1 0>, <&sdma 7 1 0>;
> > +				dma-names = "rx", "tx";
> >  				interrupts = <13>;
> >  				status = "disabled";
> >  			};

> Additionally to the above I now did:

> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index c3e5cee18bea..74da1a965a0d 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1428,12 +1428,9 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>  	if (ret)
>  		goto dma_failure_no_start;

> -	if (!spi_imx->devtype_data->setup_wml) {
> -		dev_err(spi_imx->dev, "No setup_wml()?\n");
> -		ret = -EINVAL;
> -		goto dma_failure_no_start;
> +	if (spi_imx->devtype_data->setup_wml) {
> +		spi_imx->devtype_data->setup_wml(spi_imx);
>  	}
> -	spi_imx->devtype_data->setup_wml(spi_imx);

>  	/*
>  	 * The TX DMA setup starts the transfer, so make sure RX is configured


> because there is no .setup_wml() callback for i.MX25 in
> imx31_cspi_devtype_data and the DMA register is already setup in
> mx31_prepare_transfer(). Without this change DMA isn't used.

> However this breaks SPI transfers, when I try to read out an MRAM I get:

> 	root@ecu02:~ hexdump -C /dev/mtd4
> 	[   71.813807] spi_imx 43fa4000.spi: I/O Error in DMA TX
> 	[   71.819173] spi-nor spi0.2: SPI transfer failed: -110
> 	[   71.829129] spi_master spi0: failed to transfer one message from queue
> 	[   71.843962] spi_master spi0: noqueue transfer failed

> So it would indeed be interesting if you ever managed to use DMA on
> i.MX25.

I believe so. Looking into my notes from 2016 (when I last tried this), I got
the -110 error when the SMC bit in CONREG wasn't set. But this should now be
done in mx31_prepare_transfer if DMA is used...

I'll try to set up a test some time next week.

Best regards,
Martin

