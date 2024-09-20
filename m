Return-Path: <linux-spi+bounces-4895-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AB297D308
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 10:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 472C6B215A6
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 08:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5323613541B;
	Fri, 20 Sep 2024 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="OlCvJlWw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73E57333;
	Fri, 20 Sep 2024 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822412; cv=none; b=WS1x1UfhgR3qaf7zT4vmzkNFB6RSpOAB4F6074dqEZ7YCYuT9+wlyMGySZlavGauQqc7xOndA/K1SwheQaRET09+wD/IVw/zbO3Qv1TNZ/bOhomjCp5L/A1B0uuZcj8tFYtFCkYecd5cDn8cTHrVEAufzQ3bpJJHMVs4khFTajY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822412; c=relaxed/simple;
	bh=06Aza0hwJHl/60roi5n0hX/zOGGWRRSAS9IAIWfbmvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG8Zo2JhDtmTkskl1PQmMZSFFzy22J0hNbiCteNOdajN21d7Jm9X24y0eq/eFDeNgoi59SFsJeN0hT8Z+2xtw1ehCZAEcSy0l/Oo8TcoARp13BQI8wZnCBFZAb6yNRwSri/npFFoxcQaIkVGxvVO4uBF3l0jxrVF7SzxYvMBU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=OlCvJlWw; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB3DF14835F8;
	Fri, 20 Sep 2024 10:53:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1726822407; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=f0jGfluGlzeLQ4gmxjqpPWjYguJd2eCjUFaH3XtCLBk=;
	b=OlCvJlWwgRA/y8s508429zpPqfndjLV2Azvb/HuQAw9RRdoMAw0PELGW2Usc9fex3O+oK3
	OZsSmJZ+/horyi2Jqeg0vXN2dWgtnJTKMOH9WSLVuCb4up4r20Y/3GBb1hElgLgd2hrqvO
	x6DsHXqU9amfjp80CMUbcbXyx9aDVlKAzLa0MCZjc+UqU6IgSkxBQIL1fLgs1ZAcLPXaAk
	/tGMbhEdXxoys6MKHBaK1ETc4O0w8f7MOS/aRkd+Wb10qU8jn7uPRhEOkZ5aABf3rhFvi1
	RgSfc+YLSXxVXkhj4aenLFJYuVA/ODrUtIKrlMQk+vj+ylIpTCW5Wkl0IB3OPg==
Date: Fri, 20 Sep 2024 10:53:23 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Mark Brown <broonie@kernel.org>
Cc: Alexander Dahl <ada@thorsis.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] spi: atmel-quadspi: Avoid overwriting delay register
 settings
Message-ID: <20240920-jujitsu-botanical-31a58a1bc1da@thorsis.com>
Mail-Followup-To: Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240918082744.379610-1-ada@thorsis.com>
 <20240918082744.379610-2-ada@thorsis.com>
 <Zu0wu99Hxb-b5Xo1@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zu0wu99Hxb-b5Xo1@finisterre.sirena.org.uk>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Mark,

Am Fri, Sep 20, 2024 at 10:22:19AM +0200 schrieb Mark Brown:
> On Wed, Sep 18, 2024 at 10:27:43AM +0200, Alexander Dahl wrote:
> > Previously the MR and SCR registers were just set with the supposedly
> > required values, from cached register values (cached reg content
> > initialized to zero).
> > 
> > All parts fixed here did not consider the current register (cache)
> > content, which would make future support of cs_setup, cs_hold, and
> > cs_inactive impossible.
> > 
> > Setting SCBR in atmel_qspi_setup() erases a possible DLYBS setting from
> > atmel_qspi_set_cs_timing().  The DLYBS setting is applied by ORing over
> > the current setting, without resetting the bits first.  All writes to MR
> > did not consider possible settings of DLYCS and DLYBCT.
> > 
> > Signed-off-by: Alexander Dahl <ada@thorsis.com>
> > Fixes: f732646d0ccd ("spi: atmel-quadspi: Add support for configuring CS timing")
> 
> This isn't actually a fix AFAICT since nothing yet sets any of these
> fields?

You're right if we just consider board dts files in mainline.  None of
those using the atmel-quadspi driver have a spi-cs-*-delay property
set in a SPI slave device node in current master.

The changes in this patch to MR writes do not change behaviour.

For changes to SCR however I see two possible bugs:

1. if atmel_qspi_set_cs_timing() is called before atmel_qspi_setup(),
   the second call just overwrites what the first call set.

2. if atmel_qspi_set_cs_timing() is called multiple times with
   different values, the values written to the register from the second
   call onwards are just wrong.

Maybe both are scenarios not happening in practice?

Long story short, I could just remove the Fixes line, and the rest is
fine?  Or should I split up with changes for MR and SCR going to
separate patches?

Greets
Alex


