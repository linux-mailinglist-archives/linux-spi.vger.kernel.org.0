Return-Path: <linux-spi+bounces-2963-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE86F8CA352
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 22:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697DA2813E3
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 20:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AB4137C50;
	Mon, 20 May 2024 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAip3esm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54BDD27A;
	Mon, 20 May 2024 20:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237362; cv=none; b=tuqb323tmLAJ+CtgrZUZ+Tb12cUZeNzYCReeQhTBc3/jhdHHKG/lntly5QDBjuv5rcKB6FTm7X4vmz+8/jNf5St2kQ+wTjCzGDaMwovBq+fqva44SiyXauuqYf0jb73KeONmBXa6tD3Z4Une2C/zZkrJ2boeWH9N64g/j8Ifqkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237362; c=relaxed/simple;
	bh=e/tOP5Sek+faG3xsBh/Yz8zOqx//+Q/9hHUwA35OWAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGWipimwLaMfX4Tylc0ODgFVJmb23jzP7sZANhoNgg6y3b41/H7WVLkPzo2sd2kKioKtQF7RcXt79HG5kN/JRU4HY26U5fgkItF+NdvGfeG+MkxhdBL3npIdlwXGx8XSipHD8LNL87LfL3V4ImlH/i2lL0yT0K18OxF2AQ14ABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAip3esm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834C1C2BD10;
	Mon, 20 May 2024 20:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716237361;
	bh=e/tOP5Sek+faG3xsBh/Yz8zOqx//+Q/9hHUwA35OWAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAip3esmRhJut2sxDJQe0/veutbOVefJHqUqW0i7oFpw0bPlhtOQI/e4EPD3iSliJ
	 OVUmJQ153eQyiGv0wrrIvZ1ioKJkjIfy1wutTbYBBL6g7w0K8abNhoB6rkPtHkcT4w
	 GeKZ8COhG/WAPVpwsqaUrPaV5d5GSVDpla2eQ2FGkR6YFbomvG4bCmZtSXB197+umS
	 k2GQdRvZS2iGl/Qtc8fXI6kncG3S2vzeyU88jDm8vBtOggCPDlka4LhNq7QwUEJyKY
	 UPerCe9+qsDKlF8h6b4V7w0rAywtVM0XAymwJcDCtAe1Bmoluc4Ugs8AXBHcTske9t
	 UPR3mAgl3rmUA==
Date: Mon, 20 May 2024 15:36:00 -0500
From: Rob Herring <robh@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx: Move PXA SSP bindings to the correct
 folder
Message-ID: <20240520203600.GA1424819-robh@kernel.org>
References: <20240517171103.221856-1-andriy.shevchenko@linux.intel.com>
 <e81d43f8-a3ba-41b4-a86f-af2d6943e917@sirena.org.uk>
 <Zke2yG-WPkaWg5PV@smile.fi.intel.com>
 <CAL_JsqKA7AnY7w3sjrT+khrat348v7uNpAP1+FZ=mdYMhJkf3Q@mail.gmail.com>
 <ZksqPiSLY8OlE5lT@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZksqPiSLY8OlE5lT@smile.fi.intel.com>

On Mon, May 20, 2024 at 01:47:26PM +0300, Andy Shevchenko wrote:
> On Fri, May 17, 2024 at 03:19:51PM -0500, Rob Herring wrote:
> > On Fri, May 17, 2024 at 2:58 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, May 17, 2024 at 06:24:37PM +0100, Mark Brown wrote:
> > > > On Fri, May 17, 2024 at 08:11:03PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > SSP stands for Serial Synchronous Protocol and has nothing to do with
> > > > > UART, also known as USART, where 'A' stands for Asynchronous.
> > > > >
> > > > > Move the SSP bindings to where it belongs.
> > > >
> > > > It's a serial device which is also used for other applications (the
> > > > other one upstream being audio) so I can see where the current binding
> > > > comes from and it's not super obvious that spi is especially better
> > > > here.
> > >
> > > Hmm... okay. Then it's question to DT people. Consider this as a report.
> > > Because UART (aka serial) is definitely not the place for SPI/SSP bindings
> > > either.
> > 
> > Move it when it is converted.
> 
> The problem is that somebody added a binding (in YAML) for SPI PXA2xx
> in the spi/ folder while this one kept unconverted.

Ah, well that detail was missed.

> 
> If it dangles more, it might be that we will have two asynchronous bindings
> for the co-existed drivers.

Looks like all that is needed is adding the compatible strings and 
'dmas' property to spi/marvell,mmp2-ssp.yaml. The examples in the old 
binding have other stuff, but looks like that's garbage.

Rob

