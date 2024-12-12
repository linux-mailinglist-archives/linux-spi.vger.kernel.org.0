Return-Path: <linux-spi+bounces-6042-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF949EE46D
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2024 11:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19252163D79
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2024 10:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3BB1EC4F9;
	Thu, 12 Dec 2024 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="JV553TnA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA813C9DE;
	Thu, 12 Dec 2024 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000348; cv=none; b=WZKeFlPqV6C/SSkI/Pc8mx00Ix761uW/NTD401dBBQqxfHG70Y5MwpoLao/OJx0QxQKHLXpT7zrRQVMmIUyf9+o23B9ucvLpQs0W/KCdLNfyGjjsJEhrbslxTzNXmFa9kt1dPDOJTJ0cibfPJOBLe6nZlnwC4xW/eMK3Hz1f/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000348; c=relaxed/simple;
	bh=+ef2vJvZuxSB7+uMzNNKVDg37cZ41z++pT9n0DAt504=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gon+d1cdb8vLFpvjapu9V7htln+AJxXKew5AJAGvwEGNZDPTCSVsLwEa3EV9ZvSeF0HKfalBTZio9cG4v1HABAFQaJ9e1+4+cOFx5tP10g1dDozqz0OaP7StStKi/L0crwV/e5F8gFFGp7twTA/PyFKCLayzDdDc8XqzDAcXI3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=JV553TnA; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC4iuLg014964;
	Thu, 12 Dec 2024 04:45:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=qC5tIgRwbkOKhKAkIN
	p1XaVm8vYjMMo/AtWExSA8MIA=; b=JV553TnAvmsspxVrBHjmvS0ayWBd7cUAdw
	7QAxN26E5Nak8EJNREcSbkGPG6oD2tIe7ZlY9WtFfAhM0Do2vGjeHyR3FwKLHy0O
	u7g0EeRCDEYHrPDf4J2S4+hWrRCF3LcuwvFUjE6T185rP8j6TPNV1gqE/k4Kqs72
	GyyAZ1+XbSv283e4gh6dRKPq8OVmCZNOyJp9i3CiFoNYhjgAC7D/o2+g+eqjWklu
	/Z0t3wvDvUHes4YaO7KH8ubRF5LtU2gREXgAQKYlatOE/RvSudl39fTzQzuO99AK
	pUIX6PC+oyIkNcOT+jY4YN5Fdp+c3FehrvUsDKcHINuhschI4fog==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 43cmn26g0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:45:29 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Thu, 12 Dec
 2024 10:45:27 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Thu, 12 Dec 2024 10:45:27 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 6427D822548;
	Thu, 12 Dec 2024 10:45:27 +0000 (UTC)
Date: Thu, 12 Dec 2024 10:45:26 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] gpio: swnode: Add ability to specify native chip
 selects for SPI
Message-ID: <Z1q+xndn217uF2rr@opensource.cirrus.com>
References: <20240326141108.1079993-1-ckeepax@opensource.cirrus.com>
 <20240326141108.1079993-2-ckeepax@opensource.cirrus.com>
 <Z1jZliSoXziuLt1u@google.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z1jZliSoXziuLt1u@google.com>
X-Proofpoint-GUID: 616hYGeOH9wbeezuHTz5xjXWInlFsFbf
X-Proofpoint-ORIG-GUID: 616hYGeOH9wbeezuHTz5xjXWInlFsFbf
X-Proofpoint-Spam-Reason: safe

On Tue, Dec 10, 2024 at 04:15:18PM -0800, Dmitry Torokhov wrote:
> On Tue, Mar 26, 2024 at 02:11:06PM +0000, Charles Keepax wrote:
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
> 
> I am sorry, I am very late to the party, but wouldn't it all work by
> simply setting ".node" to NULL? As far as I can see we have in
> software_node_get_reference_args():
> 
> 	...
> 
> 	if (index * sizeof(*ref) >= prop->length)
> 		return -ENOENT;
> 
> 	ref_array = prop->pointer;
> 	ref = &ref_array[index];
> 
> 	refnode = software_node_fwnode(ref->node);
> 	if (!refnode)
> 		return -ENOENT;
> 
> if ref->node is NULL then software_node_fwnode(ref->node) will return
> NULL and we'll get -ENOENT which will bubble up to
> gpiod_get_index_optional() in SPI core.
> 

I did definitely try that at the time, and there was definitely
some issue with that approach. I think it might have related to
something around how the GPIO stuff structures things. Alas, it
is long enough ago that the details are escaping me, if I manage
to find a spare minute I will try to refresh my memory and report
back.

Thanks,
Charles

