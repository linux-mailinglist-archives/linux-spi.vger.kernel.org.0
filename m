Return-Path: <linux-spi+bounces-2319-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C2E8A1D65
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 20:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3C31C23F68
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4198F1D8ED6;
	Thu, 11 Apr 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="F2aOskuc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFD51D8ED2;
	Thu, 11 Apr 2024 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855104; cv=none; b=RdSrwkFV+TQbXerrHAi+JKccEmrVRcJKwimN3VJrxVVtUdWoS7bkGVIZPV7Fa25fAXv+HCVIw27n+NQia7Hgj4Hh9/Uqz8hzubiwAfiw6iqL4YdhE+xM0JXHwxD1RL71H6KegyJkE8bKmxsm8T0RL91PTPcN57ZM7Ajx+QipfZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855104; c=relaxed/simple;
	bh=mlkE8gRz6sw5yKI94Hd5c2xEHkeUcNwQ6btavzDN0GA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB2hXSNjhdubYpnyKa6Br2zTP4JeSpnE0NibCE70CYkFSutHEBPUtnQ/E/Ge/F4uTHioQIhlOnhWKIPTvXaTjfudL2UD9296H6iQ8h2WyNdz/2M2C4ikMV58qmyZfWDDf7JK3CuT+rl6G4+4NfV2nJgiB5PBD9iTgl7X+P2ht+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=F2aOskuc; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B5NPXB003127;
	Thu, 11 Apr 2024 12:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	PODMain02222019; bh=oMro0bw4+2e+pBNB2qUEayJ5fFB6CkKoMfyfPkrfV0g=; b=
	F2aOskucomSG1y6HavqcqPfGFcd/3yM8HyR7YZ+L0YrUGLOIB97Sw7VS41lUmatF
	cOrH5Qbfhrn5OK8pGxJsf2MbNSirJyIvlyTxczXeZ0XfEJJz0SK27NuTutHu/M2c
	1hiqpQtbGMzFEJ6tcLfoE4S6hSs/5BpqOCDWT+SnktlJllOS/nuRaZ5JsVFOxte8
	vZ8uWSdJbyh8QfSHveJWbxz1ULp4CtmQq6yd4I+nX4Wy4pvnnEginNVEKGbUzPX4
	nzTghYHn2Xozcmu3PqJsecHeN2VPAAmk2gofRvONBhqG9NSWH3k2L3cdi3yeUT7o
	Uc14vAalWDI8qEnIecLiYg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjqq6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 12:04:56 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 18:04:54 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 11 Apr 2024 18:04:54 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 8347C820242;
	Thu, 11 Apr 2024 17:04:54 +0000 (UTC)
Date: Thu, 11 Apr 2024 17:04:53 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <bard.liao@intel.com>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v5 3/4] spi: Update swnode based SPI devices to use the
 fwnode name
Message-ID: <ZhgYNfSXjqNksKmY@ediswmail9.ad.cirrus.com>
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
 <20240411090628.2436389-4-ckeepax@opensource.cirrus.com>
 <CAHp75VefB7fN8Bf3ZJ6sYnqdiHxoJ87zjDWERoEXNfY+NzosPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VefB7fN8Bf3ZJ6sYnqdiHxoJ87zjDWERoEXNfY+NzosPA@mail.gmail.com>
X-Proofpoint-ORIG-GUID: eiweHwCvqDji0lKWscBu50CvZaEmefji
X-Proofpoint-GUID: eiweHwCvqDji0lKWscBu50CvZaEmefji
X-Proofpoint-Spam-Reason: safe

On Thu, Apr 11, 2024 at 04:33:05PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 11, 2024 at 12:06 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > Update the name for software node based SPI devices to use the fwnode
> > name as the device name. This is helpful since swnode devices are
> > usually added within the kernel, and the kernel often then requires a
> > predictable name such that it can refer back to the device.
> 
> ...
> 
> > +       if (is_software_node(fwnode)) {
> > +               dev_set_name(dev, "spi-%s", fwnode_get_name(fwnode));
> 
> Wouldn't %pfwP / %pfw work?
> 

Oh I was totally unaware of those will have a look, thanks.

> Thinking more about this, maybe even the ACPI case also can be combined?
> See for the details
> 
> 87526603c892 ("irqdomain: Get rid of special treatment for ACPI in
> __irq_domain_add()")
> 9ed78b05f998 ("irqdomain: Allow software nodes for IRQ domain creation")
> 

Maybe, I am not super confident that acpi_dev_name will always
return the same thing as fwnode_get_name and I don't really want
to risk renaming everything on the ACPI side.

Thanks,
Charles

