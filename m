Return-Path: <linux-spi+bounces-5078-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A4298B833
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 11:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C1F282FE2
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 09:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63DC19D887;
	Tue,  1 Oct 2024 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRJBvk7l"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16819D07A;
	Tue,  1 Oct 2024 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774385; cv=none; b=SUp0jgFhlRCQmLa8T3CFRdkpwMgFVYNoXhTe9yd3uRNkZZcMQc0adtp9XSCDxzJvUb5EvEB0gvjPdRDE78x1LR3Bj0sSfEEIbXT2gNeLDG1NDDeyTyAfS40Pw3p908+QxxdP8W72Fpj8HdP+z9m6TFb6UR046sXC52FN9RcSCbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774385; c=relaxed/simple;
	bh=jl6MYyiBH9F0oeQaI+9FiyGiz3aQifzaLvlhC3dkh5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcTA4znITS8J1apLPIfjuAHpkp3re2ggeKrjZccRb84rx/Byezc0hTvbmpQKS7zrDs8TOLs5bIW9DFdW7RTF74dBLxOVL53uXZyEmss0cg9efkcW1sbFt0dLb+tEWfyDPDRJ1BOjBEQAC7+5OKxJvOU1H+thuSowIVwZ+FtwQGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRJBvk7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845C7C4CECE;
	Tue,  1 Oct 2024 09:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727774385;
	bh=jl6MYyiBH9F0oeQaI+9FiyGiz3aQifzaLvlhC3dkh5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GRJBvk7lZAJ8qFzq5buu1qldodmBsusK2VV2tnmVpT7U4qN3/4mI+AXtpiLMzgQrA
	 mcuLwa5rXtDGw52D0B9S1ZxmmHY/nkr10h9QI8pBZtdeIlRVtzdSbGgS111IGSCIVW
	 EO4AtqF3lThZT5Hc+Uxi2oPe9zvZv4kzdCoxdOZno/CejV4obFdpNJ+2SPehK54sTf
	 cTD5WDpM0qhPtrXYZ8tgNhGsphQD6eDuWD7+zp5NR42CDnrYB7WQyn3ItybyVnMaZw
	 qXpzp7lK5UI0qMrkLIPLViLHAANPFo/1zfvy9EekW5uDLteYwwqmhr0L+M6UHlnIBv
	 sOj4ENtCjvQnA==
Date: Tue, 1 Oct 2024 11:19:41 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Alim Akhtar <alim.akhtar@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] spi: s3c64xx: update flush_fifo timeout code
Message-ID: <4unvnt5gwbhrnrp64jg2uplu4x42vaislarcjkirltjkg6wyk2@jgubgpi7k373>
References: <20240924134009.116247-1-ben.dooks@codethink.co.uk>
 <20240924134009.116247-3-ben.dooks@codethink.co.uk>
 <j53542aqpa72jqowtyinlueefhnwp6upz2li6btezygtjz5bz4@uivxzbfsvhy5>
 <4eb16e57-ac30-45c1-aa02-fb88fc86a881@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eb16e57-ac30-45c1-aa02-fb88fc86a881@codethink.co.uk>

Hi Ben,

On Tue, Oct 01, 2024 at 08:01:48AM GMT, Ben Dooks wrote:
> On 30/09/2024 23:51, Andi Shyti wrote:
> > On Tue, Sep 24, 2024 at 02:40:09PM GMT, Ben Dooks wrote:
> > > The code that checks for loops in the s3c6xx_flush_fifo() checks
> > > for loops being non-zero as a timeout, however the code /could/
> > > finish with loops being zero and the fifo being flushed...
> > 
> > what is the possibility of this case?
> 
> Not sure, currently we're trying to debug a customer's setup where
> we're seeing some weird issues with SPI. This was found during a
> look into the code awaiting hardware access.
> 
> The flush count was simply an inspection and it seemed like a good
> idea to fix the initial issue and then if there was an issue to
> print something more useful than a simple error message.
> 
> > > Also, it would be useful to know what is left in the fifo for this
> > > error case, so update the checks to see what is left, and then also
> > > print the number of entries.
> > > 
> > > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > > ---
> > >   drivers/spi/spi-s3c64xx.c | 8 ++++----
> > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> > > index 6ab416a33966..7b244e1fd58a 100644
> > > --- a/drivers/spi/spi-s3c64xx.c
> > > +++ b/drivers/spi/spi-s3c64xx.c
> > > @@ -247,8 +247,8 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
> > >   		val = readl(regs + S3C64XX_SPI_STATUS);
> > >   	} while (TX_FIFO_LVL(val, sdd) && --loops);
> > > -	if (loops == 0)
> > > -		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO\n");
> > > +	if (TX_FIFO_LVL(val, sdd))
> > > +		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO (%d left)\n", TX_FIFO_LVL(val, sdd));
> > >   	/* Flush RxFIFO*/
> > >   	loops = msecs_to_loops(1);
> > > @@ -260,8 +260,8 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
> > >   			break;
> > >   	} while (--loops);
> > > -	if (loops == 0)
> > > -		dev_warn(&sdd->pdev->dev, "Timed out flushing RX FIFO\n");
> > > +	if (RX_FIFO_LVL(val, sdd))
> > > +		dev_warn(&sdd->pdev->dev, "Timed out flushing RX FIFO (%d left)\n", RX_FIFO_LVL(val, sdd));
> > 
> > This change doesn't super excite me, but it's fine. Please add a
> > comment explaining the case when loops is '0' and the FIFO is
> > flushed.
> > 
> > With the comment given, you can have my r-b.
> 
> Ok, will look at sending a second version later this week.

I actually think that these two patches can be squashed into a
single one, I don't see much reason for having it double.

Even better, I think the first patch is not needed at all with
this new one. Right?

Andi

> > 
> > Thanks,
> > Andi
> > 
> > >   	val = readl(regs + S3C64XX_SPI_CH_CFG);
> > >   	val &= ~S3C64XX_SPI_CH_SW_RST;
> > > -- 
> > > 2.37.2.352.g3c44437643
> > > 
> > 
> 
> 
> -- 
> Ben Dooks				http://www.codethink.co.uk/
> Senior Engineer				Codethink - Providing Genius
> 
> https://www.codethink.co.uk/privacy.html

