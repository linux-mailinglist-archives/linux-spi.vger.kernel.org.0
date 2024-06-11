Return-Path: <linux-spi+bounces-3368-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAED19038EC
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 12:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03931C21AFE
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 10:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CF3179954;
	Tue, 11 Jun 2024 10:34:34 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494DA13FD86
	for <linux-spi@vger.kernel.org>; Tue, 11 Jun 2024 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102074; cv=none; b=M3BOJmWw72p/yGveb97EbV8ADdYwA3Cz68yHWdOI3Birw55ZDLZb8vRCBK8V9qn9VFVvq8Eosyr0m+ZXpUXP7ju4lJ8kG9YhQA6+iyPCJI+5jviWy6XEzZT6nBP0XdiGktt06qNc3lsMK/lXZ/WXoEmBRRYfCugS3MLc6nEVUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102074; c=relaxed/simple;
	bh=DiUx+fa2fiEm8dYh/SFoSIXBAOSLzwFVSfuuBFb1ZLs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcYJ4L8lEY4wajC5hCHYIBo0JMjxLvGp3r3C6qmaErdpDcQ4bvLDLfyfICMAcI9UCgJPx9sJmT9Kk2JraA/4sHDaKAsbUI1F45RDz2Tm8z/TFUg99XH3lIFbVAxGV7V1uyA9JEeOhc10zFXONwc7aTF27RYyzyjxlFkwkwsGGhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 2edfd6f0-27de-11ef-ab0f-005056bdd08f;
	Tue, 11 Jun 2024 13:34:30 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 11 Jun 2024 13:34:29 +0300
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com,
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 6/6] iio: adc: Add support for AD4000
Message-ID: <ZmgoNRkso4egGWgJ@surfacebook.localdomain>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <e340f48324b0ea3afb1c715cb2fba184c27112a1.1717539384.git.marcelo.schmitt@analog.com>
 <e92871489d416e4f8a350fd24fc5ed0012b3cf2b.camel@gmail.com>
 <20240609102354.02aa1128@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609102354.02aa1128@jic23-huawei>

Sun, Jun 09, 2024 at 10:23:54AM +0100, Jonathan Cameron kirjoitti:

...

> > > +	/*
> > > +	 * In 4-wire mode, the CNV line is held high for the entire
> > > conversion
> > > +	 * and acquisition process. In other modes st->cnv_gpio is NULL and
> > > is
> > > +	 * ignored (CS is wired to CNV in those cases).
> > > +	 */
> > > +	gpiod_set_value_cansleep(st->cnv_gpio, 1);  
> > 
> > Not sure it's a good practise to assume internal details as you're going for
> > GPIO. I would prefer to have an explicit check for st->cnv_gpio being NULL or
> > not.
> 
> Hmm. I had it in my head that this was documented behaviour, but
> I can't find such in the docs, so agreed checking it makes sense.
> 
> I would be very surprised if this ever changed as it's one of the
> things that makes optional gpios easy to work with but who knows!

Not Linus and not Bart, but we have tons of drivers that call GPIO APIs
unconditionally as long as they want optional GPIO.

What I see here is the comment that should be rewritten to say something like

"if GPIO is defined blablabla, otherwise blablabla."

I.o.w. do not mention that implementation detail (being NULL, i.e. optional).

-- 
With Best Regards,
Andy Shevchenko



