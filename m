Return-Path: <linux-spi+bounces-2318-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493958A1D4D
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 20:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053032833E1
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 18:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70934F1E5;
	Thu, 11 Apr 2024 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GxiyC7EQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A784F205;
	Thu, 11 Apr 2024 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854744; cv=none; b=Q0rNff2XWO9B6qFHOgJLv+dlDDDxmDAA3eJo1jp9ct9v01FCG0nP7J3jpuC65gKyGrpUXs5xAyyMyCgUl96P2LdREvZgP7Hw9cs5G106tTnpYmmwD3yctfUTCZ1LGNInqhgwEG+SeKi/1eEtJA/z11ArWcmnjnTkHcnXj+hdi9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854744; c=relaxed/simple;
	bh=xbEiM9xUy3NOJGsRhtWHIsRIKPYx9ArSddRwpvifTCg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gi7QD6+Ph5+E+vCvatfr0KbPY+2gTKfb+hPgNL8jUmMvmSR1Nwztkl3E5eKMWC5oILtF3Vjj9mQxZu6JcA+XLI7yKeXvUtu2BLMjqWhne4elWwTchYuMx89aDgt9sUxjA/5pD2vLWOXrM5h+Q0IiIDC3dYYYRECkJ8l895yZBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GxiyC7EQ; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B5QWWO021673;
	Thu, 11 Apr 2024 11:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	PODMain02222019; bh=iHoNZcjeHBntqhJWAIHCPvc8a7FFfd+dcbdOUDQoTFA=; b=
	GxiyC7EQ3J/CXzH7sWCPEVp5wMjFAu9bTlP3MkzaL7lnC969tsKN9VOqiYS8XZqk
	+SAidcTepbb15hdcjZ+NF6A1GXO5qaqQOiIPl/2NY01cjGRrLUflPkrGXSVVK5A9
	FGS26mygMRGAL/Guvic28k9rHjURnga1Gm0qC9MrYUWufHxlAz51qjyKAVQuUMGr
	DHuoBTaFP6FFJCUiWnAsF6kKoCN0RsmMmNR9HRvz6YztFKDBtWwJ0G0DUW4WSvJ+
	3j/dLGn3mkRINOSmMWAf2790nqsc/zi5BQ57XGj3DLqISRj0J9EltklUPn3476LO
	vW2kI7z/A2B6+oeTlJ+KVA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxqbj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 11:58:56 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 17:58:54 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 11 Apr 2024 17:58:54 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id A21AE820242;
	Thu, 11 Apr 2024 16:58:54 +0000 (UTC)
Date: Thu, 11 Apr 2024 16:58:53 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <bard.liao@intel.com>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v5 1/4] gpio: swnode: Add ability to specify native chip
 selects for SPI
Message-ID: <ZhgWzflzJnD8pZWh@ediswmail9.ad.cirrus.com>
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
 <20240411090628.2436389-2-ckeepax@opensource.cirrus.com>
 <CAHp75VdV0JEX6NkRz=c1TLc7fxdo9EJeBW++byJ6u7ofrTVsdQ@mail.gmail.com>
 <ZhgTeE1JKAJ4Jhbv@ediswmail9.ad.cirrus.com>
 <CAHp75Vdb7Op-ddo5RxZuMYLFBjGbGxtQaZA0yE8pfXQBcLH5GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vdb7Op-ddo5RxZuMYLFBjGbGxtQaZA0yE8pfXQBcLH5GA@mail.gmail.com>
X-Proofpoint-ORIG-GUID: G19Z21NpyEFnyuK2nlwtcOxBfU83gkfY
X-Proofpoint-GUID: G19Z21NpyEFnyuK2nlwtcOxBfU83gkfY
X-Proofpoint-Spam-Reason: safe

On Thu, Apr 11, 2024 at 07:50:46PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 11, 2024 at 7:44 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Thu, Apr 11, 2024 at 04:25:25PM +0300, Andy Shevchenko wrote:
> > > On Thu, Apr 11, 2024 at 12:06 PM Charles Keepax
> > > <ckeepax@opensource.cirrus.com> wrote:
> 
> ...
> 
> > > > +config GPIO_SWNODE_UNDEFINED
> > > > +       bool
> > >
> > > But why did you remove the help? Please, put it back.
> >
> > Sorry didn't realise you still wanted it will pop it back.
> 
> No, I don't want it to be user-selectable.
> 

Yeah I get that just didn't realise you also wanted the help,
they are technically orthogonal but most non-user selectable
things don't define a help.

> Maybe something like
> 
>     if (IS_ENABLED(...) &&
>         !strcmp(...))
> 

Aye that is what I just added.

> > > > +       ret = software_node_register(&swnode_gpio_undefined);
> > > > +       if (ret < 0)
> > > > +               pr_err("gpiolib: failed to register swnode: %d\n", ret);
> > >
> > > Instead of this prefix, define pr_fmt()
> >
> > Little iffy on this, there are other prints in gpiolib that do it
> > this way as well, I guess I could add a patch to convert
> > everything but its starting to get a little out of the thrust of
> > what I am doing here.
> 
> That's why I'm talking only about this (gpiolib-swnode) module where
> you can have it as
> 
>   "gpiolib: swnode: " fmt
> 
> or alike
> 

Alright will add this too.

Thanks,
Charles

