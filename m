Return-Path: <linux-spi+bounces-6222-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A3DA01ABC
	for <lists+linux-spi@lfdr.de>; Sun,  5 Jan 2025 18:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C373A2326
	for <lists+linux-spi@lfdr.de>; Sun,  5 Jan 2025 17:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542D614831D;
	Sun,  5 Jan 2025 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y6xJ4W9Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3595336D;
	Sun,  5 Jan 2025 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736096930; cv=none; b=oq8T42uuPEOJACcuOGkt4IFpvH+i6Rko7KGh9lP3FS4sqfRBjb2Sx7Kh0wHsm9/yCSYj1y2AwXuROWD0K6px96Nr6cILKtixHJ//eBPBz4DZIPCgxdPXf9qM/zUmHsk2bVneWWqzNhJUh468aYgip5TtLuaYIlFXkhgtN5goFLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736096930; c=relaxed/simple;
	bh=b0yXdcl0FQhRZaXYWfu7p7+U1eeapTWa74uhZ7KKUts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdUMshoerKh18ZBBDsP8YgAkWA6u9pmFmT5wrhTIMBiXhQfREm5SGa/rXWtzJY3XkdJekwc1rmSE9kCMTt9G3RmdpIr3Jyxtzuqq9mY9fFmGBRPDvhk2GMKX0dssTJQ9VB0Co+xbBuRHjhqna5Pn2f9bnnf21rv4iFbs/wJc/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y6xJ4W9Z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=HGE42t/8NMJxHFUNmxXVqxt8ki1wLwBn/OH6YlViYJA=; b=Y6
	xJ4W9ZQodTJ7DVSV0KYGQjUBAokfLaihrBo1ehZDqN6s9nJduIpl5iA309a5l5WUsio8CvAz9QtJQ
	bFZvNjkv/j7G0hqlqtN2Ztd1zBjMeQaKbta0CbKGLnfsNs9+9sN2dKoWG4ygti8vIKUI38V7pxUE2
	SaYzk3aOo7nCdbQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUU7C-001cpQ-Qe; Sun, 05 Jan 2025 18:08:38 +0100
Date: Sun, 5 Jan 2025 18:08:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@jo-so.de>
Cc: Christian Eggers <ceggers@arri.de>, Jakub Kicinski <kuba@kernel.org>,
	Tristram Ha <tristram.ha@microchip.com>,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: KSZ8795 not detected at start to boot from NFS
Message-ID: <f26f526c-cb43-4170-8dd4-b7cf6c0d1d5d@lunn.ch>
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
 <5708326.ZASKD2KPVS@n9w6sw14>
 <cxe42bethnzs7f46xxyvj6ok6ve7itssdxyh2vuftnfws4aa3z@2o4njdkw3r5i>
 <2675613.fDdHjke4Dd@n9w6sw14>
 <sqsslcr7fsgqi7fvjpy5xnarhlm76atvatczkzwpn37e7gnsu6@tuy7an7t4gdg>
 <cnmv4ahgyblej7aoknhhb3xyvb67j7t24tug7uoxxtl5s4pjy3@wd3copbtdiec>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cnmv4ahgyblej7aoknhhb3xyvb67j7t24tug7uoxxtl5s4pjy3@wd3copbtdiec>

On Sun, Jan 05, 2025 at 05:33:38PM +0100, Jörg Sommer wrote:
> Hi everyone,
> 
> I've added you to the list of recipients, because you where somehow involved
> in changes of the KSZ-SPI switch code.
> 
> We are debating the SPI mode setting for the microchip ksz8795 and ksz9477
> and possibly others. Since the commit
> 8c4599f49841dd663402ec52325dc2233add1d32 the SPI mode gets fixed to mode 3
> in the code. But at least my ksz8795 works also with mode 0 and shows better
> initialization behaviour with mode 0.
> 
> The big question is: can both (or all ksz) chips work with both modes?
> Should this setting stay in code or moved to the device tree?
> 
> The specs are here, but I found no evidence about the supported/recommended
> SPI modes:
> 
> https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9563R-Data-Sheet-DS00002419D.pdf

Don't trust what i say, i'm not an SPI expert, but i can use grep.

https://www.kernel.org/doc/Documentation/spi/spi-summary says:


I'm confused.  What are these four SPI "clock modes"?
-----------------------------------------------------
It's easy to be confused here, and the vendor documentation you'll
find isn't necessarily helpful.  The four modes combine two mode bits:

 - CPOL indicates the initial clock polarity.  CPOL=0 means the
   clock starts low, so the first (leading) edge is rising, and
   the second (trailing) edge is falling.  CPOL=1 means the clock
   starts high, so the first (leading) edge is falling.

 - CPHA indicates the clock phase used to sample data; CPHA=0 says
   sample on the leading edge, CPHA=1 means the trailing edge.

   Since the signal needs to stablize before it's sampled, CPHA=0
   implies that its data is written half a clock before the first
   clock edge.  The chipselect may have made it become available.

Chip specs won't always say "uses SPI mode X" in as many words,
but their timing diagrams will make the CPOL and CPHA modes clear.

In the SPI mode number, CPOL is the high order bit and CPHA is the
low order bit.  So when a chip's timing diagram shows the clock
starting low (CPOL=0) and data stabilized for sampling during the
trailing clock edge (CPHA=1), that's SPI mode 1.

And in the datasheet it says:

  SCL is expected to stay low when SPI operation is idle.
  
  Input data on SDI is latched on the rising edge of serial clock
  SCL. Output data on SDO is clocked on the falling edge of SCL.

My interpretation of this is that the initial clock priority is low,
so CPOL=0. The rising edge will be the leading edge, so CPHA=0. So
that makes the mode = 0.

Can you hard code this in the driver? I guess that depends on if you
want to support a PCB that puts in a line driver which adds a NOT gate
to the clock?  Does that ever happen? I don't know. The real SPI
experts should answer that.

	Andrew

