Return-Path: <linux-spi+bounces-2315-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ACF8A1CE0
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 19:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9861C217CD
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 17:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D949155354;
	Thu, 11 Apr 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="o3xapNyz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22AE15532D;
	Thu, 11 Apr 2024 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853902; cv=none; b=bLDQY011wfzm86LoCDJdanVNclVbx0DKlM1G2v8snrgPJ2Xuuv1RlogCfhxQsyRhP5z+ekclqOJle6jsjNU95+5CQ1rOClsvcbJhhBZpulAmkQwvuVs46CDHzCExg0GgMUMqZjDKPwK4LsBxx86KeF4QSpBzigt7DC8bZ6/rmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853902; c=relaxed/simple;
	bh=BxT3hWQcZmThWaKU/LoW8Y0EGs6Sfi6mzNtjnpMJNwI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFXzjsn6IljhJ2g4jAaMBl+oqOX0VR4f/42nq/NDdNfg8KWtfI79mywsuwwSTjaX0egDL8PsiO0/zl1aPkZypVLn/Dnx66kXNIhAxF+s1s7lJfnVByIwaJ4voXm3t47cO1v8kPavQtDgrUnJRyouqGjxG4Ajlb/gks3VK4+SNio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=o3xapNyz; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B4mlAv021323;
	Thu, 11 Apr 2024 11:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	PODMain02222019; bh=REZQMvHHvZAoqruLa+nnXTgBIglAXPLLFIs2jRKAOFA=; b=
	o3xapNyzA+V0LkNsUs0YO/rfd/ifecSioUbAvIeZ6F00fQTTAfXJ5HYvOYNswi4J
	x9vINj0oIC5g/oYYWglMxw7QbYy0dl6b/BX7qjcdvgWhXc+5zJvf2VlYNz8mnF9u
	Jx612GpFelej+KEXLkyy3inYz8pp+mf6OFCHl0RE2w1nm1En7KDe9AU3EilRNtyE
	i1zd74qjdagHscYIFQTwbZme29PjiNJG+p/oSGKOGxMyyqnn9lD2GNS9MKTQvpSJ
	buQKjqbf6f06ltBsoojzjDtQIv394xaTQoS3avj9ZZJLHZRb0+ZgZ7y/NPBEQWyg
	8ChEyxH/P7niYeIZppARZQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjqpdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 11:44:42 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 17:44:41 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 11 Apr 2024 17:44:41 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 40866820242;
	Thu, 11 Apr 2024 16:44:41 +0000 (UTC)
Date: Thu, 11 Apr 2024 16:44:40 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <bard.liao@intel.com>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v5 1/4] gpio: swnode: Add ability to specify native chip
 selects for SPI
Message-ID: <ZhgTeE1JKAJ4Jhbv@ediswmail9.ad.cirrus.com>
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
 <20240411090628.2436389-2-ckeepax@opensource.cirrus.com>
 <CAHp75VdV0JEX6NkRz=c1TLc7fxdo9EJeBW++byJ6u7ofrTVsdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdV0JEX6NkRz=c1TLc7fxdo9EJeBW++byJ6u7ofrTVsdQ@mail.gmail.com>
X-Proofpoint-ORIG-GUID: y29WnRCycLUgfMje3gMbZbTs6l6-3uGg
X-Proofpoint-GUID: y29WnRCycLUgfMje3gMbZbTs6l6-3uGg
X-Proofpoint-Spam-Reason: safe

On Thu, Apr 11, 2024 at 04:25:25PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 11, 2024 at 12:06 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > Here the second chip select is native. However, when using swnodes
> 
> Here, the
> 

Can do.

> > +config GPIO_SWNODE_UNDEFINED
> > +       bool
> 
> But why did you remove the help? Please, put it back.
> 

Sorry didn't realise you still wanted it will pop it back.

> ...
> 
> > +       /*
> > +        * Check for special node that identifies undefined GPIOs, this is
> 
> for a special

Can do.

> 
> > +        * primarily used as a key for internal chip selects in SPI bindings.
> > +        */
> > +       if (!strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
> > +               return ERR_PTR(-ENOENT);
> 
> This is a dead code when the respective config option is not selected.
> Or actually a potential flaw if somebody else names their swnode like
> this.
> 

Can add a check for the config.

> ...
> 
> > +       ret = software_node_register(&swnode_gpio_undefined);
> > +       if (ret < 0)
> > +               pr_err("gpiolib: failed to register swnode: %d\n", ret);
> 
> Instead of this prefix, define pr_fmt()
> 

Little iffy on this, there are other prints in gpiolib that do it
this way as well, I guess I could add a patch to convert
everything but its starting to get a little out of the thrust of
what I am doing here.

> > +       return ret;
> 
> ...
> 
> > --- a/include/linux/gpio/consumer.h
> > +++ b/include/linux/gpio/consumer.h
> 
> Why? I already said that the best place is gpio/property.h as it's
> exactly for swnode related code.
> 

Oh I see that's what you meant by those comments, as per my email
I wasn't exactly sure. Will move them I don't mind where they go.

Thanks,
Charles

