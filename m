Return-Path: <linux-spi+bounces-2270-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5527589EDE6
	for <lists+linux-spi@lfdr.de>; Wed, 10 Apr 2024 10:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC16B21DD6
	for <lists+linux-spi@lfdr.de>; Wed, 10 Apr 2024 08:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88A01552E0;
	Wed, 10 Apr 2024 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="D3/lL6ys"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAA2154C04;
	Wed, 10 Apr 2024 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738589; cv=none; b=WrotxjfjAUjF86vCoXxinQcd9rKzLrgsaFdOPFeGRsMq9WkC6K7usi58PzAHTJNxDObucOIUkTHXUdutQPpHq3x8nVjL1wGhvibAoMGsul3ZW4DMEq+ec9k6e4FSJM6ZVG9zFa5EYCVcL4Q5Dadpyztj/PMuSnawB+n2nBGrFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738589; c=relaxed/simple;
	bh=dj8witDzggfhOjSBa1kj0ziy8a26QI2QLL0gZgScn2U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohjESAMVMMhu1N/NtNhOx6DFUvzCIUN0tDHZnMHiogu3kBdiPGaKRMbSUgxQXM1Ek1FbftXDa3NeR2RS5CbSnpkCLWfjI1JAoA7xTvB+S1O6OdseF7wGaUfHdPa0Tz7Qs0mo9oqcnkOc9kFQfHsaFK8GAUahenqhbggc+cgMzvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=D3/lL6ys; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43A7njFQ022491;
	Wed, 10 Apr 2024 03:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=B+MhqvTg5bAYURL
	dw2NHKGqHG5JBG8bCOwLFvKSBw8w=; b=D3/lL6ysvXaQdtLYIt3o1crhSHNueJP
	Vf6QkYcbNPilwizfvknYysAaahIb5NcHyzwkutg2NKeDr5iCPhlgYDpTexiwSGnT
	aXhjWOG/E0LIVnv5NRvsyU3tBdNzEVGInMlMFf5t5vb9buNfEG4FTousoPFvfmAw
	PlDfMm0CVv/o+NxMftScIm/NeJse6tQvJ1Mr1yTLWgUCbD8yghXqIkQTbqvdHScy
	Wmd9x/NU8T8exia7StmvI6NqqhKyFNQykJH1lnNToBshQTkO45Uvb/fwozgkbpUq
	S2KoG7L0J/M0xQpYUoMqKL0lqMDiNHd5Td0KW965IBRfTALjoG14hVQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxm9pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 03:43:03 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Apr
 2024 09:42:45 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 10 Apr 2024 09:42:45 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 86234820249;
	Wed, 10 Apr 2024 08:42:45 +0000 (UTC)
Date: Wed, 10 Apr 2024 08:42:44 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy@black.fi.intel.com>
CC: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v4 2/3] spi: Add a mechanism to use the fwnode name for
 the SPI device
Message-ID: <ZhZRBEAsfSUw1i2g@ediswmail9.ad.cirrus.com>
References: <20240409132126.1117916-1-ckeepax@opensource.cirrus.com>
 <20240409132126.1117916-3-ckeepax@opensource.cirrus.com>
 <ZhWDwIZe8b0lqe8o@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZhWDwIZe8b0lqe8o@black.fi.intel.com>
X-Proofpoint-ORIG-GUID: ouuiqdjnlFs1jy4MnUQcoU_en1jmqYNg
X-Proofpoint-GUID: ouuiqdjnlFs1jy4MnUQcoU_en1jmqYNg
X-Proofpoint-Spam-Reason: safe

On Tue, Apr 09, 2024 at 09:06:56PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 09, 2024 at 02:21:25PM +0100, Charles Keepax wrote:
> > Add a mechanism to force the use of the fwnode name for the name of the
> > SPI device itself. This is useful when devices need to be manually added
> > within the kernel.
> 
> Same comment, we don't need two ways to handle fwnode type
> (and effectivelly code duplication to some extent).
> 
> ...
> 
> >  	struct acpi_device *adev = ACPI_COMPANION(&spi->dev);
> 
> >  	if (adev) {
> 
> Replace this to be is_acpi_device_node() check...
> 
> >  		dev_set_name(&spi->dev, "spi-%s", acpi_dev_name(adev));
> 
> ...and derive adev from fwnode.
> 

I had been hoping to not modify the path I wasn't using but fair
enough if you are sure this is a fine substitution.

> >  		return;
> >  	}
> 
> > +	if (is_software_node(fwnode)) {
> > +		dev_set_name(&spi->dev, "spi-%s", fwnode_get_name(fwnode));
> 
> While at this, you can also introduce
> 
> 	struct device *dev = &spi->dev;
> 
> to make these dev_set_name() be shorter.
> 

Sure.

Thanks,
Charles

