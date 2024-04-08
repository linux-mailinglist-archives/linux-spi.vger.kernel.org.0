Return-Path: <linux-spi+bounces-2213-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565A089C4FC
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 15:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B5D1F22F98
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 13:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA7F524AF;
	Mon,  8 Apr 2024 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UhOp5kSr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C20242046;
	Mon,  8 Apr 2024 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584328; cv=none; b=Y2rwEw/iOLsAmmqxAejZ+eN+s5TMwNsV2rijtlaKdbktl4yy/RoKqwyJIgEq151TbkD5rtgjX/Gv1hqje7nAbJB7VDfl0wdh91m5zz2hir3L9bggGAt0GQJNSOv6JYiwT0mJ0QGMiuR2+2fZmBFIh8JM5j60vZKwuR5gkrqi48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584328; c=relaxed/simple;
	bh=hScNN0HYUzamWk/llNxgGUD9v9tyqvTGC+z/Qu9eB9k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWpkycJPjVUhK7bCjcUgUdsgaZGd/9PmcK9Fk6cYbkEFUd8C7KsnvIaWtQGYnsQl1fflgqmLCQXE8AbBXOcPHiM+/FQE+MOXOTHGH3gsr8mGKzRD1wBe+1qS8hZr/CfYyNLLr830WMK3SQAF/IXJuYwbUGBC9lvE4nZh2XPF0pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=UhOp5kSr; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385hdpX025891;
	Mon, 8 Apr 2024 08:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=+/c10AJLr7NTCpE
	00N+TlGmqctFAyufOMmFo7vIntc8=; b=UhOp5kSrjB9uOF4q1raNp0V1FLNjgH7
	1UXwM/cgUd7z/fwWEZracizAYxKHrlaCS8K2Ubp9+FgEBnCQztIr6boy0uQOHIyJ
	VsB/WiSfr4aDIic/D9MEM3zGxaawhKkLO5Qf57KFdWGXlyW65iB3bZnaaD/H4XWm
	aPYl80TzEudsKtEhI33L/yP+1YXYU3y/EdNX+1T/ZYrevNzeNWo8LJSfzvXcgeln
	uWDZMrR7RNFZkSViKbRO6aubtunKR7Kztj/Un41f6jObCfyF39vG5mCFmJd8ErCx
	aUZUmIdOEJ7kDKRzqojKv6Km2nnUDkqF4JzCNHUvxNQpeOy/hSR8CdA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhgqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 08:51:59 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 14:51:57 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Apr 2024 14:51:57 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 52C6C820242;
	Mon,  8 Apr 2024 13:51:57 +0000 (UTC)
Date: Mon, 8 Apr 2024 13:51:56 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v3 2/3] spi: Add a mechanism to use the fwnode name for
 the SPI device
Message-ID: <ZhP2fPYd28sXw7EZ@ediswmail9.ad.cirrus.com>
References: <20240329114730.360313-1-ckeepax@opensource.cirrus.com>
 <20240329114730.360313-3-ckeepax@opensource.cirrus.com>
 <Zg28J59MRvk3B-_J@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zg28J59MRvk3B-_J@surfacebook.localdomain>
X-Proofpoint-ORIG-GUID: Oy083IP-aOlpJ2XYB3MKmg76O9Ff2pdV
X-Proofpoint-GUID: Oy083IP-aOlpJ2XYB3MKmg76O9Ff2pdV
X-Proofpoint-Spam-Reason: safe

On Wed, Apr 03, 2024 at 11:29:27PM +0300, Andy Shevchenko wrote:
> Fri, Mar 29, 2024 at 11:47:29AM +0000, Charles Keepax kirjoitti:
> >  	struct acpi_device *adev = ACPI_COMPANION(&spi->dev);
> > +	struct fwnode_handle *fwnode = dev_fwnode(&spi->dev);
> > +
> > +	if (spi->use_fwnode_name && fwnode) {
> > +		dev_set_name(&spi->dev, "spi-%s", fwnode_get_name(fwnode));
> > +		return;
> > +	}
> >  
> >  	if (adev) {
> >  		dev_set_name(&spi->dev, "spi-%s", acpi_dev_name(adev));
> 
> This should be something like this
> 
> 	struct device *dev = &spi->dev;
> 	struct fwnode_handle *fwnode = dev_fwnode(dev);
> 
> 	if (is_acpi_device_node(fwnode)) {
> 		dev_set_name(dev, "spi-%s", acpi_dev_name(to_acpi_device_node(fwnode)));
> 		return;
> 	}
> 
> 	if (is_software_node(fwnode)) {
> 		dev_set_name(dev, "spi-%s", fwnode_get_name(fwnode));
> 		return;
> 	}
> 
> i.o.w. we don't need to have two ways of checking fwnode type and you may get
> rid of unneeded variable, and always use fwnode name for swnode.
> 
> ...
> 
> > +	proxy->use_fwnode_name = chip->use_fwnode_name;
> 
> Unneeded variable. See above.
> 

Hmm... I guess I was viewing this feature more as something that
users would opt into. So other firmware mechanisms could use it
if required, and so most swnode based controllers would still get
caught by the standard naming at the bottom of the function.

From my perspective it will do what I need either way, so happy
to update it to always use this for software nodes if consensus
goes that way.

Thanks,
Charles

