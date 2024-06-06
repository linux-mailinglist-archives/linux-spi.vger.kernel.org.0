Return-Path: <linux-spi+bounces-3320-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AB28FE087
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 10:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2F69B25801
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED04413AD11;
	Thu,  6 Jun 2024 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GBq0ELG7"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3C97346A;
	Thu,  6 Jun 2024 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661173; cv=none; b=nWJpVPe6aWN7m+VGyXpuJfsk6xWWaPMwKa/GFiry4R0QefSz+mYSgTl0F5mrbI4Ns3Ob9SfQRBhOT0CASZG6U4blW9/Ry8INJx+fTSnvW3lg/rs+Cn25592SN8BBou3+gW4I537ecFwWw8ywxREJWbdVr5ZkzOObNFqDRFbf9og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661173; c=relaxed/simple;
	bh=MlXYoE4S46u3YGijpQWCnlS+8eWfmxXXUZ+JW4oQcL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxUw7AAtSPX0AHCbE8LEyXRvuMrj81QzHdE+4PDfA2pmn6QaYyihxYszDsukDmxNrx4PGU2+/f39I7Wr38/87rwSw+f3sJ2cFPSvmJApQAOaqILOJUYgS7R0M0sTwCahqNAX2lAuNLwiRNe/BKdBBiRmoZLgcSqHgB2j0tJYv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GBq0ELG7; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 477D060006;
	Thu,  6 Jun 2024 08:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717661169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4R7MAaaiy+puAV8iRoQQ8CDB5EbvlOFDbc9iX3EQi4o=;
	b=GBq0ELG7UU/VB2lJMHg0p7k8pKcz1Bvlz2PvUHKLBUcfGOjKfEsWdWJdtPXytcBb5lYxLP
	kWoeSxG673+eUjBmQlAjeMZpxfNGG4nvQD5+Gu2PNzvdV+5/FHY94yQ1SuWe8xk7tli4KT
	W4+NWWrdCa4MQCmmaPijZDMw+Ez7/v1sV7j5TKaVZ1+i5Mp/uL30lhZVhrHPQALw8mbPSS
	6c7tXc4X/pB2LKJ1rp3NAxguGQTXYl6Kkr4feN6gSHmPXvn1s2+E5Kt4LFKnO1QY6q+t0O
	mP9wo0wPNED+3t1tfMtje9/z7QnwrpX9LUZe8SPDhnJyVMuqzqxwEoNAObLHGg==
Date: Thu, 6 Jun 2024 10:06:07 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Colin Foster <colin.foster@in-advantage.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com
Subject: Re: omap2-mcspi multi mode
Message-ID: <ZmFt7yfZFFJdsZuJ@localhost.localdomain>
Mail-Followup-To: Colin Foster <colin.foster@in-advantage.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com
References: <Zl/V0dU6SjAMkpLG@colin-ia-desktop>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zl/V0dU6SjAMkpLG@colin-ia-desktop>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 04/06/24 - 22:04, Colin Foster a écrit :
> Hi Louis,

Hi,
 
> I found that commit e64d3b6fc9a3 ("spi: omap2-mcpsi: Enable MULTI-mode
> in more situations") caused a regression in the ocelot_mfd driver. It
> essentially causes the boot to hang during probe of the SPI device.

I don't know what can cause this. My patch can "compact" few words into 
only a bigger one, so the signal on the cable can change, but it follows 
the SPI specification and the device should have the same behavior.

Instead of two very distinct words (for example two 8 bits words):

  <-- first word -->             <-- second word -->
   _   _   _   _   _              _   _   _   _   _
__| |_| |_| ... |_| |____________| |_| |_| ... |_| |_

The signal on the wire will be merged into one bigger (one 16 bits word):

  <-- first word -->  <-- second word -->
   _   _   _   _   _   _   _   _   _   _
__| |_| |_| ... |_| |_| |_| |_| ... |_| |_

> The following patch restores functionality. I can hook up a logic
> analyzer tomorrow to get some more info, but I wanted to see if you had
> any ideas.
 
I don't understand the link between the solution and my patch, can you 
share the logic analyzer results?

Maybe the issue is the same as [1]? Does it solves the issue?

[1]: https://lore.kernel.org/all/20240506-fix-omap2-mcspi-v2-1-d9c77ba8b9c7@bootlin.com/

> --- a/drivers/mfd/ocelot-spi.c
> +++ b/drivers/mfd/ocelot-spi.c
> @@ -225,6 +228,8 @@ static int ocelot_spi_probe(struct spi_device *spi)
>         }
> 
>         spi->bits_per_word = 8;
> +       spi->word_delay.value = 1;
> +       spi->word_delay.unit = SPI_DELAY_UNIT_NSECS;
> 
>         err = spi_setup(spi);
>         if (err)
> 
> 
> Colin Foster
> 
> 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

