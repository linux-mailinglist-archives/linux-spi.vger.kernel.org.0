Return-Path: <linux-spi+bounces-2370-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BCA8A6D61
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 16:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875781F21481
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 14:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B4E12D1F6;
	Tue, 16 Apr 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="W+Cdt6As"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6616F12CD90;
	Tue, 16 Apr 2024 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276518; cv=none; b=B3TjFc7i9VclSO0+aR3vPoNDHJNbdoa/XaDKuMp7Y7eOthXo7m2eWbcqEVCC7TnfNboLlk+hO41ehZyONCcoPu5BLE86JvJmpRI52XlRHIleFHH+lmy3ntUMtzKnvJZvFYU6Lvp4YekHks22g0d4zeZV2xtWGt6ayGtfAaYjj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276518; c=relaxed/simple;
	bh=8s/8WXuXfhhydmS2bkr1sreOQKFJDW/DwkDi1ejTEyg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIHTwgQcgla2EEHjnviLVz2NMffPAkPoL9dQUW+rSyrRCmY8+h3+EaAB+3/9j49ML7bFBODrmIj1OuyCxED4djjMEkuvof7yRCkKNBkYxE+ckqyLYkaMizbgaueqrWtLaQkj48Dhv5PcCe0BDqBs9Ej50c3xmlb2NxEvD80e2UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=W+Cdt6As; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43G5uYam005067;
	Tue, 16 Apr 2024 09:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	PODMain02222019; bh=w/I27fSXAckxstsH9arR2p6lcMwXlJ4bwWLfxKcSNLo=; b=
	W+Cdt6As759eeKk/fMIl22eGor4Ow2ET1/Bi+veM7Y3dBFavQ9BJ3lUYy1XbwUOt
	oqNZM319xTvwv3224JFdD5fgJVWwKSGWXn2nHjGbJ0JorelvNmRQciIcl9k93REe
	yJxMOgRkgPYyjB3KE6t1I+pYjMYczj45/BI/RADR8/YLt5dW+wtKZj9YTecO/yum
	7zywp9wBuuQEuBVfPAudmMQEsSGJC+cghXjU5dUfPAZGUysDO9BeHOZAhchKTBno
	KthuQvJILLR1pcq0uk9M3wglIzg3Lp6nOdRIz0+kxG1GgMGltJsfq0ee+hFRKqUQ
	jNeVdt+nbph87LCJCQK6NQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xfpfhtmp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 09:08:23 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Apr
 2024 15:08:21 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Tue, 16 Apr 2024 15:08:21 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 5B939820242;
	Tue, 16 Apr 2024 14:08:21 +0000 (UTC)
Date: Tue, 16 Apr 2024 14:08:20 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <bard.liao@intel.com>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v7 4/4] spi: cs42l43: Add bridged cs35l56 amplifiers
Message-ID: <Zh6GVEKQR9xvtZXC@ediswmail9.ad.cirrus.com>
References: <20240416100904.3738093-1-ckeepax@opensource.cirrus.com>
 <20240416100904.3738093-5-ckeepax@opensource.cirrus.com>
 <CAHp75VeSnwqTnpVGdJq33svHk-UnpV8L0JgiRA2MC3ZQy6dA+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeSnwqTnpVGdJq33svHk-UnpV8L0JgiRA2MC3ZQy6dA+Q@mail.gmail.com>
X-Proofpoint-ORIG-GUID: -pBx-4UNPgDPALQBxTRU9wbqqeupzSHt
X-Proofpoint-GUID: -pBx-4UNPgDPALQBxTRU9wbqqeupzSHt
X-Proofpoint-Spam-Reason: safe

On Tue, Apr 16, 2024 at 04:40:39PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 16, 2024 at 1:09 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > From: Maciej Strozek <mstrozek@opensource.cirrus.com>
> 
> > +               ret = devm_add_action(priv->dev, cs42l43_release_sw_node, NULL);
> > +               if (ret) {
> 
> > +                       software_node_unregister(&cs42l43_gpiochip_swnode);
> 
> This is not needed when you use devm_add_action_or_reset(); that's why
> I mentioned that API and not simple devm_add_action(). Can be fixed
> later of course, not a big deal.
> 

Argh... sorry about that, not doing well on this series. Still a
few people to look at the series so I will fix it up and doing
another spin probably the next couple of days.

Thanks,
Charles

