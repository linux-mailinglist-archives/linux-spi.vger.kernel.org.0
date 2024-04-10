Return-Path: <linux-spi+bounces-2271-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9287089EDEA
	for <lists+linux-spi@lfdr.de>; Wed, 10 Apr 2024 10:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95CC2825B9
	for <lists+linux-spi@lfdr.de>; Wed, 10 Apr 2024 08:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA42156C61;
	Wed, 10 Apr 2024 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="DiRdS6Fv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4E155722;
	Wed, 10 Apr 2024 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738653; cv=none; b=nTy8dIFWggNqg5NviqURnRsKaTxTKz9SzGGZ6ivBSqj5Sxt7X1rkrtEjktwNsz2XT94gO/B8FzCG5TDMdOZTwjLvQMJkQdV7Qje2k2gaVlUOKzXRBJJFwqO+DpA8VnW/szlPTAe5gwGj6Mn2aCL9COQ3UBeWndV59EeYPTK0aCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738653; c=relaxed/simple;
	bh=GRrY2eFDyBeTxNlqn561u7kYljcuxnbXuZGeUvtiM04=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWrJOjgmwuYHkqhzqtwhM5KpJAWscAcLa7kLWk18YRkiM190nbeFZaJNDLVG6xbB7mQxgqBTkNXbZf0N/GPDhVYpkOiMmOIMo7beBp+6wBva2tE7a9swpOBWpQkSJ/rQNseiKXf4Xo8bDokN0F6TUB2llsGT7OL4XHYOSJxkhSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=DiRdS6Fv; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43A5bIOF024942;
	Wed, 10 Apr 2024 03:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=7+/ppkxS3Q9/TUh
	waGuGZnEzF0f05GFBblnGk2ckVv8=; b=DiRdS6FvSQ4DUt0BK1MY50mpY+C0Z43
	btcG1Q78W6gxvewOXC8q0GZQka8+pgtHAfRjHqn/JSPNc7sZ+4OKvGlhRN7I9lO4
	3Q6jy1hfeDdCBkFCDHtZvJeXGAgUCrBJcUvOX2AWT9JXaHWTF0P/lkikV3pXZZpq
	YrQjgLRAve0dMi7/E0y40eLnqzRteF4p+00mXvsaflf+Kt1cEavWN61opzKJstYs
	E0cjTBd/LvNeNVcetW+hl29ctkeLGdSFmjsMRi0HhjgqontJj3vrFWurmKLkZFDi
	tdoGn1dZPxwmHq4NIzZVzi9QJj0YQ4hEh8gGKLok9kyD6y9IrSpdvFA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjmmrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 03:44:06 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Apr
 2024 09:44:05 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 10 Apr 2024 09:44:05 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 480A1820249;
	Wed, 10 Apr 2024 08:44:05 +0000 (UTC)
Date: Wed, 10 Apr 2024 08:44:04 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy@black.fi.intel.com>
CC: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v4 1/3] gpio: swnode: Add ability to specify native chip
 selects for SPI
Message-ID: <ZhZRVEwfNiS1bdjR@ediswmail9.ad.cirrus.com>
References: <20240409132126.1117916-1-ckeepax@opensource.cirrus.com>
 <20240409132126.1117916-2-ckeepax@opensource.cirrus.com>
 <ZhWC8kAMQ4BS4OaC@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZhWC8kAMQ4BS4OaC@black.fi.intel.com>
X-Proofpoint-ORIG-GUID: oLJc6dh1DePrvrC1meOzG5YCRfMbXsNb
X-Proofpoint-GUID: oLJc6dh1DePrvrC1meOzG5YCRfMbXsNb
X-Proofpoint-Spam-Reason: safe

On Tue, Apr 09, 2024 at 09:03:30PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 09, 2024 at 02:21:24PM +0100, Charles Keepax wrote:
> > SPI devices can specify a cs-gpios property to enumerate their
> > chip selects. Under device tree, a zero entry in this property can
> > be used to specify that a particular chip select is using the SPI
> > controllers native chip select, for example:
> > 
> >         cs-gpios = <&gpio1 0 0>, <0>;
> > 
> > Here the second chip select is native. However, when using swnodes
> > there is currently no way to specify a native chip select. The
> > proposal here is to register a swnode_gpio_undefined software node,
> > that can be specified to allow the indication of a native chip
> > select. For example:
> > 
> > static const struct software_node_ref_args device_cs_refs[] = {
> > 	{
> > 		.node  = &device_gpiochip_swnode,
> > 		.nargs = 2,
> > 		.args  = { 0, GPIO_ACTIVE_LOW },
> > 	},
> > 	{
> > 		.node  = &swnode_gpio_undefined,
> > 		.nargs = 0,
> > 	},
> > };
> > 
> > Register the swnode as the gpiolib is initialised and
> > check in swnode_get_gpio_device if the returned node matches
> 
> swnode_get_gpio_device()
> 

sorry yeah will fix that up.

> > swnode_gpio_undefined and return -ENOENT, which matches the behaviour
> > of the device tree system when it encounters a 0 phandle.
> 
> ...
> 
> > +config GPIO_SWNODE_UNDEFINED
> > +	bool "Undefined swnode GPIOs"
> 
> Why is this user visible?
> 

Yeah a good shout no reason for it to be.

> > +	help
> > +	  This adds a special place holder for software nodes to contain an
> > +	  undefined GPIO reference, this is primarily used by SPI to allow a
> > +	  list of GPIO chip selects to mark a certain chip select as being
> > +	  controlled the SPI device's internal chip select mechanism and not
> > +	  a GPIO.
> 
> How are drivers supposed to work in case this is not selected?
> 
> ...

Well they don't :-)

Thanks,
Charles

