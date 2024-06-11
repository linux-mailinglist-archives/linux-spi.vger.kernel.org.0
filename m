Return-Path: <linux-spi+bounces-3369-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E41903917
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 12:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879B32815C0
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 10:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1276176AD4;
	Tue, 11 Jun 2024 10:41:07 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CCE7407C
	for <linux-spi@vger.kernel.org>; Tue, 11 Jun 2024 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102467; cv=none; b=kKYE+2G2sH6JcW5WpoN794Ny9y1526NqDngSzyDfMWuDpQn6xJ3CeYsJov5TZ/VbS+dVcpGBETjxNiH4X6aZddOgzUCSPyTnVLdErxZLJiPFxMj5Se/yEZRzwPzej3rgvfN5KGajEqZOLZEiFc4oEYsII1ME054u1HdL7kieBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102467; c=relaxed/simple;
	bh=GFmbkRe09HBZwt7VYn5nswIr4zPyrh3fFHXv6zNybF4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpCf0EdY7p65QV1a3W510ImJFfq1JfhHWOOqTiy664aT0dUF9tZPP+jWJdwe6Jd5WUfwQRX7y96TnnO7faTPy1GZUh5AdEcWwtrKzBA8oqjUau3VxApnemNvyaCr+t8hcbQc7RwDnhjfXh4AnCU8Rou9wluEKdaBIApJ4CX+jyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 193be238-27df-11ef-8d69-005056bd6ce9;
	Tue, 11 Jun 2024 13:41:03 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 11 Jun 2024 13:41:02 +0300
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Conor Dooley <conor@kernel.org>
Cc: =?utf-8?B?U3rFkWtl?= Benjamin <egyszeregy@freemail.hu>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spidev: Introduce "linux,spidev-name" property for
 device tree of spidev.
Message-ID: <ZmgpvimPgEugxJk4@surfacebook.localdomain>
References: <20240519211346.30323-1-egyszeregy@freemail.hu>
 <1ec9e8e5-0818-42b0-8776-d9cfb0585f42@sirena.org.uk>
 <9ae65e3c-f1fa-4ca9-8d74-12d92c51c5c6@freemail.hu>
 <e8837fe0-e93c-4133-aac1-f8f0a010f6de@sirena.org.uk>
 <30944fda-6d18-4fc1-8c73-bcda4814a417@freemail.hu>
 <20240607-upcoming-tidiness-401e5d0a8af0@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240607-upcoming-tidiness-401e5d0a8af0@spud>

Fri, Jun 07, 2024 at 05:07:23PM +0100, Conor Dooley kirjoitti:
> On Sun, Jun 02, 2024 at 05:31:10PM +0200, Szőke Benjamin wrote:
> 
> >     spidev@0 {
> >         reg = <0>;
> >         compatible = "rohm,dh2228fv";
> >         spi-max-frequency = <1000000>;
> > 
> >         // via my kernel patch -> /dev/spidev-mysensor
> >         // linux,spidev-name = "mysensor";
> 
> Given you are describing a DAC as a "sensor", I doubt you actually even
> have a dh2228fv*. You're looking to have a consistent name here, but you
> can't even rely on Linux even continuing to bind the spidev driver
> against this compatible if somebody comes along and writes an IIO driver
> for this DAC!
> 
> That said, google seems to return no results for a dh2228fv, only for a
> bh2228fv. Makes me wonder if this device actually even exists...

Why not summon Matti?

-- 
With Best Regards,
Andy Shevchenko



