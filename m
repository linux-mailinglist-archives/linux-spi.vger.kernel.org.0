Return-Path: <linux-spi+bounces-2317-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8418A1D43
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 20:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625BD283FF8
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99E94C629;
	Thu, 11 Apr 2024 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Y86EHL74"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5036447F7F;
	Thu, 11 Apr 2024 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854588; cv=none; b=SyC8/x9bw4o+rdG+hFYINEpLMAqA8ntV7IWgimGJa3CJdpHFrEPonAdfFREG5+SC+kb43xvQKngDwMtr/qRNai8SMMIfc/tPAtNUKRPZhd4FcsaBexU4ISJPwFOFV0Kit9kx4/rpcvfbr3H07UApQblmBcBbJGPEiLnQ9hFPqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854588; c=relaxed/simple;
	bh=qtHtnhOWVq51KPSYlpLiZwOQoQMbgcv2R09xnUb3O8w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0dMdpu4Lk7ZY6LQp/CgFGtSEWwFa9xACier0WLkppd87vFSjdFlZlC+/1LhRZ51hQV8+bsXn1DLsmwnMpra2VUrXF/NOVlv+BL/vicdFG+2PyoUWRxewecKETEpD9VDzdXnTHLjrv7t3VORSVBlUoNK2DWr6CxFSUYkrQ98Ylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Y86EHL74; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B40AL0009489;
	Thu, 11 Apr 2024 11:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	PODMain02222019; bh=O3ZfeGqX9EiWLqILfwFJo19Hi1tqEcB6if0881+Mdgc=; b=
	Y86EHL7492rAoKL7dCwzOhNbq2mc0FSxuHYrwgjSPuSm2GMXSDih7bTmQHONtEMC
	pT6cQbNMgvfuT0aMe8sZ/8tOl1G8esBQIq1L1GCD0WXCAuOh7GxULtLjInadwRkW
	ewjoj+G4JlR3xgHmFlerb7Pblht5ZSWWcYTKjd7JaYY50818i18RSdcU94WACKuN
	UjrngjyHiX5WR1Xg9u/Y7MfpQmipOJr0qrmgdNM9+jgkBrPGTPi3JBFjYvpICuc7
	2K92uiIrDNV3N4QnmI2dG0Zt9YlV3jnCFlpcmd8yU5ilZYcjlQKT6dxI4ZDtoUyc
	eAMSLZHrEh6SLhj/L2i3RQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxqbej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 11:56:20 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 17:56:18 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 11 Apr 2024 17:56:18 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id D7103820242;
	Thu, 11 Apr 2024 16:56:17 +0000 (UTC)
Date: Thu, 11 Apr 2024 16:56:16 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <bard.liao@intel.com>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v5 2/4] spi: Switch to using is_acpi_device_node() in
 spi_dev_set_name()
Message-ID: <ZhgWMK7HU2jmsmTq@ediswmail9.ad.cirrus.com>
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
 <20240411090628.2436389-3-ckeepax@opensource.cirrus.com>
 <CAHp75VfAoKvvnQr74-rpJhEv=U=o00Doji-1zuV3-_+n+cbVVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfAoKvvnQr74-rpJhEv=U=o00Doji-1zuV3-_+n+cbVVg@mail.gmail.com>
X-Proofpoint-ORIG-GUID: kOD2hdIchIOQYFSWIuOAVCel7KZHvSf4
X-Proofpoint-GUID: kOD2hdIchIOQYFSWIuOAVCel7KZHvSf4
X-Proofpoint-Spam-Reason: safe

On Thu, Apr 11, 2024 at 04:30:13PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 11, 2024 at 12:06 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > Use the more modern is_acpi_device_node() rather than checking
> > ACPI_COMPANION().
> 
> I don't think it's valuable on its own. There is no clear motivation
> why to do that, I suggested it exactly in the conjunction of not
> introducing two ways of fwnode type check. That said, you probably
> want to elaborate the motivation in the commit message if you want to
> keep it separate.
> 

I am really tempted to just drop this, its not necessary for my
changes and changes something that is unrelated to them. At the
least it belongs in a separate patch.

> ...
> 
> > +#include <linux/fwnode.h>
> 
> This header is not supposed to be included by the end users. property.h is.
> 

Fair enough will update, although I really feel these headers
could use some annotation if they are not supposed to be directly
included. Either include everything you use or just include a top
level header makes sense but this weird mixture we seem to use is
very confusing and I don't have a big enough brain to remember
every header.

Thanks,
Charles

