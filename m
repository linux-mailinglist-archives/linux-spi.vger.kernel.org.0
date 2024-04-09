Return-Path: <linux-spi+bounces-2242-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F352689D575
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 11:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E2D2831DF
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 09:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D137F499;
	Tue,  9 Apr 2024 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ye/Tjl9K"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED21B7F474;
	Tue,  9 Apr 2024 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654668; cv=none; b=AghhSE6m2eHb0y9nLlkJ+qyCN28M25d5w3bP+geSDq9SM06OllHXQLSKoU3XCrhzP36fHv4EU8YsUbOcz43hDKiZ+Z2ul6+cy3mv21qybHDJBOYAyf3ELuCoGOLr822BzxmpOQD9Faz5/kb8t3o8xxNBnLo31IQeo5YOgo3/tFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654668; c=relaxed/simple;
	bh=zSow6/2EOmiFUMBDNh+5KokEUO7BZXJgwkcA0qYUBns=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOosStLH2y/Vjz7bRtG0mc5y6dzaD9uzL76yyGEki5oYmtadMZjNrwwjhc9yw3cBFV3t4Wybsed8hnnZ4rPbWAMYanyKS2/aEhw4/5ykouapo+5SMKsyU8F+MnZBMKLPWaO44T5crbbCqpa054EpQ9bvzChX1JLFGqerYRlTW8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ye/Tjl9K; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4395x2ro024985;
	Tue, 9 Apr 2024 04:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	PODMain02222019; bh=lCyxuWlqrCw+1FMsLWKc2fLSOYQm5PkILZGZhOGcr0s=; b=
	Ye/Tjl9KULnhSE5nORff3Y8xh2tyIfMuRpPT3Dq4hayIQdwJC0em8QUXKHQBJohA
	j6mYhJPgccPcPgxOgJYY1B3m1TYpIqeo8HHUUfswpNi/hi1m5+MmNku/IxB3mKkP
	YXiVoxHlzREjTpANHubTpsI0akV0mbbEgNLIbH3rZmdwHKpWnMtrQMV8dpaBVqC2
	XClHS56lcy5i95NE6t32C7up4rIjCcnb9Wvj7MH0aPxTVR+m5oPGVt7BiaTryf4h
	F4eKblaZXPuGjRrKQRCf7Mf72kqCRVFbKS5Tg8anLso7N2RzXAaB+YcNeUjjz8Bo
	D2Gfs8IEFoEK0WPRydqoWQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjjnpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 04:24:21 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Apr 2024
 10:24:20 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 9 Apr 2024 10:24:20 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 0EBA182024A;
	Tue,  9 Apr 2024 09:24:20 +0000 (UTC)
Date: Tue, 9 Apr 2024 09:24:19 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v3 3/3] spi: cs42l43: Add bridged cs35l56 amplifiers
Message-ID: <ZhUJQxss1m8aIvJs@ediswmail9.ad.cirrus.com>
References: <20240329114730.360313-1-ckeepax@opensource.cirrus.com>
 <20240329114730.360313-4-ckeepax@opensource.cirrus.com>
 <Zg3AaNM0eizfC6Bk@surfacebook.localdomain>
 <ZhQO0vTvr67bR2O9@ediswmail9.ad.cirrus.com>
 <CAHp75VdJQd4bcJ4qfMfJvNnNrE46SHmQQiVwyJa-99Y5k50nsg@mail.gmail.com>
 <ZhRKhIJKxUdQpZK0@smile.fi.intel.com>
 <ZhROj-ZfKp_CEcA6@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhROj-ZfKp_CEcA6@smile.fi.intel.com>
X-Proofpoint-ORIG-GUID: Kewa5ScAiS3i2t_6By8QZsSZri6Anq_T
X-Proofpoint-GUID: Kewa5ScAiS3i2t_6By8QZsSZri6Anq_T
X-Proofpoint-Spam-Reason: safe

On Mon, Apr 08, 2024 at 11:07:43PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 08, 2024 at 10:50:28PM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 08, 2024 at 07:07:55PM +0300, Andy Shevchenko wrote:
> > > On Mon, Apr 8, 2024 at 6:35 PM Charles Keepax
> > > <ckeepax@opensource.cirrus.com> wrote:
> > > > On Wed, Apr 03, 2024 at 11:47:36PM +0300, Andy Shevchenko wrote:
> > > > > Fri, Mar 29, 2024 at 11:47:30AM +0000, Charles Keepax kirjoitti:
> 
> ...
> 
> > > > > > +#include <dt-bindings/gpio/gpio.h>
> > > > >
> > > > > Hmm... Is it requirement by gpiolib-swnode? (I haven't looked at the use cases,
> > > > > I'm not the author of this idea, hence the Q).
> > > >
> > > > It's required for the GPIO_ACTIVE_LOW used in the swnode stuff.
> > > 
> > > Seems to me like you are mistaken.
> > > https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib-swnode.c#L85
> > 
> > Okay, I stand corrected, under "native" the GPIO_* are assumed.
> > 
> > But what you need is to include gpio/property.h for that, and not directly
> > the DT header.
> 
> Oh, my, we have two _almost_ identical definitions in machine.h and under DT.
> So, I believe we are using ones from machine.h.
> 

Yeah that is my bad I should be using those instead.

Thanks,
Charles

