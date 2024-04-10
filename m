Return-Path: <linux-spi+bounces-2272-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E52D689EE6D
	for <lists+linux-spi@lfdr.de>; Wed, 10 Apr 2024 11:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7462CB24851
	for <lists+linux-spi@lfdr.de>; Wed, 10 Apr 2024 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47F415E7EF;
	Wed, 10 Apr 2024 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BV5sn5Ea"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D715B136;
	Wed, 10 Apr 2024 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740281; cv=none; b=n1/DyaRrl6Z2RUNWumZSA0pAgDpudTrTWQtVn4bPamXwKg4Eery+W+1lgDmcxhYbCN9hcr3CoP7O9rQhs7R+d78f/RTtHMB+nuUtduU4ot8YtNc2BL8gj+49IxOU7GcS+9GUH6W9syUs34RE0+hrZFGDl6EjEvlrLvxSKtkQJUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740281; c=relaxed/simple;
	bh=p5F27ONbMRrQRdaZ0/ZOdVNjuebqisJicpg9RkysEso=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUqBoyfrv7LDeIrKYVfafhHUQfSSkHS8MBEy+Gb48pyBUpyA+zPN97H4kDocq2EcDzCQAuq6PuvGTtN2dRaVpB/q9nNkJmR800dew9xoN2Eh+zNKjr7itGBif6yyUnPTaTXp7RmoAmau/jmUO3jgXuLdmW1q5XkrsJBFCHVyH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BV5sn5Ea; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43A5xQD4021393;
	Wed, 10 Apr 2024 04:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=CAUqWZKDqMAAw+b
	Psj5Kx0blcFeAd9SEsPTRUe4qNAQ=; b=BV5sn5EaD8z/NgenKsBaKCGmrYZ9+rf
	phA0EiDWJK5ALDf6QG65rWi1RwkpQtxVck8Tfp9FXngOPkdKad3QWkg/vPigjK97
	/p31htNuT5hX5l5GN0OBxE7EMS5kDjz/Zq0ySm0ASKXyAoOMO/ahoudUwLkmbmvK
	i8SI5mc32l8j4RgHNk1Wf4/7GlLqPcif7NHTKwGZ8CrzjLSeTkIbVrkv2tJt3S7A
	8bVb/VtOlETBgHDmhYsAQ3h9/sFVyM7MGVwJXmXxVx5P/l3rcZ0P9QwxDHK82ZLN
	28jnR79LC4HW5Xu85eGFxHZ3WVbU8Y/WXgTVjyR2i94LlleC6DS2TjQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjmpqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 04:11:14 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Apr
 2024 10:11:13 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Wed, 10 Apr 2024 10:11:13 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 4A645820245;
	Wed, 10 Apr 2024 09:11:13 +0000 (UTC)
Date: Wed, 10 Apr 2024 09:11:12 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy@black.fi.intel.com>
CC: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v4 3/3] spi: cs42l43: Add bridged cs35l56 amplifiers
Message-ID: <ZhZXsLj4NSjbpbh1@ediswmail9.ad.cirrus.com>
References: <20240409132126.1117916-1-ckeepax@opensource.cirrus.com>
 <20240409132126.1117916-4-ckeepax@opensource.cirrus.com>
 <ZhWIZFvfYb85Pftm@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZhWIZFvfYb85Pftm@black.fi.intel.com>
X-Proofpoint-ORIG-GUID: kQQFLRptjzAocexBDoUOclU9d9AP-whY
X-Proofpoint-GUID: kQQFLRptjzAocexBDoUOclU9d9AP-whY
X-Proofpoint-Spam-Reason: safe

On Tue, Apr 09, 2024 at 09:26:44PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 09, 2024 at 02:21:26PM +0100, Charles Keepax wrote:
> > From: Maciej Strozek <mstrozek@opensource.cirrus.com>
> > +#include <linux/acpi.h>
> > +#include <linux/array_size.h>
> >  #include <linux/bits.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/device.h>
> >  #include <linux/errno.h>
> > +#include <linux/gpio/machine.h>
> 
> Shouldn't you include gpio/property.h as well?
> Ah, in the previous patch you put swnode to consumer.h instead of
> gpio/property.h. Please, fix that.
> 

Sorry not sure I follow here, nothing is using
PROPERTY_ENTRY_GPIO and not sure why that is needed in the swnode
patch either?

> >  #include <linux/mfd/cs42l43.h>
> >  #include <linux/mfd/cs42l43-regs.h>
> >  #include <linux/mod_devicetable.h>
> 
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/property.h>
> >  #include <linux/regmap.h>
> >  #include <linux/spi/spi.h>
> >  #include <linux/units.h>
> 
> ...
> 
> > +static const struct software_node ampl = {
> > +	.name			= "cs35l56-left",
> > +};
> > +
> > +static const struct software_node ampr = {
> > +	.name			= "cs35l56-right",
> > +};
> 
> What these swnodes are for?
> 

The two amps we are adding, not sure I entirely follow what you
are asking here. We need the software nodes so we can name the
amps something such that we can find them from the machine driver
later.

> ...
> 
> > +static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
> > +{
> > +	static const u32 func_smart_amp = 0x1;
> > +	struct fwnode_handle *child_fwnode, *ext_fwnode;
> > +	unsigned int val;
> > +	u32 function;
> > +	int ret;
> > +
> > +	fwnode_for_each_child_node(fwnode, child_fwnode) {
> > +		struct acpi_device *adev = to_acpi_device_node(child_fwnode);
> > +
> > +		if (!adev)
> > +			continue;
> > +
> > +		ret = acpi_get_local_address(adev->handle, &function);
> > +		if (ret || function != func_smart_amp) {
> 
> > +			fwnode_handle_put(child_fwnode);
> 
> Why?
> 

Ah had missed the fwnode_for_each_child will do the put itself,
will fix that up.

> > +MODULE_IMPORT_NS(GPIO_SWNODE);
> 
> > +
> 
> Stray blank line.
> 

Fair enough will remove.

Thanks,
Charles

