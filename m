Return-Path: <linux-spi+bounces-2340-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 081BA8A51F4
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 15:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D52F1F238F4
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E90371759;
	Mon, 15 Apr 2024 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QJLJevb4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2BD78C9F;
	Mon, 15 Apr 2024 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188395; cv=none; b=fD8G/seudMH+4N71MT3skIHSIlI4xSfMsEVmceJhSa5YmG9JdNyPsVJCs9hxF1ShfkQUvT7GD+nptsh/j0V2w7+9gCmCGCxkmD/1zAGnOlucUqERmuZtBC8vR3ltB6dRB/RrDpRGlXC/iIcGrjRRgc0nq2dEQWrZB//S5KbdlY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188395; c=relaxed/simple;
	bh=PRv7pytBiOkLz7PrwuDdb9f+phDFiWKLJnUWoVPh+Uw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqYyL9iOIxzUwMZEcLSzb3hpF9r+KzADELwcD0vuYvdkXa6/yY8s6JIc9Wqp1DARA5YDySSdtQP7n0nh3vzV+AJlMjrR4PPRnWOA7SQQdRbs/1NTcrp2mGHS+AIq0eXLn9VY4745IxGMK1PKKcd9Iw1URUqckuQ7LggoqqPIrdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=QJLJevb4; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43F7ttqX007088;
	Mon, 15 Apr 2024 08:39:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	PODMain02222019; bh=43jG4b5GQ1petJnjZztW1SdBS9xSETSJDVBcQuPTL6Y=; b=
	QJLJevb4fOiZNxCaclLbyb80QBuFEFLAAl/tY4AQ+gB/6TESNRfKtLvMFCQ/Qpo4
	0EIDCduLjzuRryR2iuAGJBczQbu+7Rdpq2ackt+9D0gdVv9SWtltWV4jg7v865g+
	Juxw2HyxuRO0aiboSZxYCbZ9ooAvhLTBRTwfNqYPFJLlGc/QZJTeXCMgBYRlV8p7
	eH3naoMCXtM81qw+YNkcQpkFT+8CVnIoB/IgPuz4NM6uu1+/hmYDmjZdifue0koJ
	HimH6m74eZ849+YTiak6mcYe7ZPF4LnSZ1NMupyrf29WMD5RQVfRXJ44kqB9njqj
	stmY3Q3Tk2Vcfs0SaE9T0A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xfqey9g8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 08:39:46 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 14:39:44 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Mon, 15 Apr 2024 14:39:44 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 5FD1C820244;
	Mon, 15 Apr 2024 13:39:44 +0000 (UTC)
Date: Mon, 15 Apr 2024 13:39:43 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <bard.liao@intel.com>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v5 4/4] spi: cs42l43: Add bridged cs35l56 amplifiers
Message-ID: <Zh0uH64AlEMJQyzz@ediswmail9.ad.cirrus.com>
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
 <20240411090628.2436389-5-ckeepax@opensource.cirrus.com>
 <CAHp75Ve00EuT0AdZy0b6OfqHySNkxTBuUbrv7z+mUgcrT56QWw@mail.gmail.com>
 <ZhgaK9vhtvy3/YpU@ediswmail9.ad.cirrus.com>
 <CAHp75Vc-f13sOghXkuqEVYsmnP3hT6ewLZwLr4mJJbruSqoxXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vc-f13sOghXkuqEVYsmnP3hT6ewLZwLr4mJJbruSqoxXw@mail.gmail.com>
X-Proofpoint-GUID: dfa4mVWMkbXvteXPtX7iOLK5Feoz88yp
X-Proofpoint-ORIG-GUID: dfa4mVWMkbXvteXPtX7iOLK5Feoz88yp
X-Proofpoint-Spam-Reason: safe

On Thu, Apr 11, 2024 at 09:17:53PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 11, 2024 at 8:13 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Thu, Apr 11, 2024 at 05:04:33PM +0300, Andy Shevchenko wrote:
> > > On Thu, Apr 11, 2024 at 12:06 PM Charles Keepax
> > > <ckeepax@opensource.cirrus.com> wrote:
> > > > +       if (has_sidecar) {
> > > > +               ret = software_node_register(&cs42l43_gpiochip_swnode);
> > > > +               if (ret) {
> > > > +                       return dev_err_probe(priv->dev, ret,
> > > > +                                            "Failed to register gpio swnode\n");
> > > > +               }
> > > > +
> > > > +               ret = device_create_managed_software_node(&priv->ctlr->dev,
> > > > +                                                         cs42l43_cs_props, NULL);
> > > > +               if (ret) {
> > > > +                       dev_err_probe(priv->dev, ret, "Failed to add swnode\n");
> > > > +                       goto err;
> > > > +               }
> > >
> > > Wouldn't it miss the parent fwnode? I mean that you might probably
> > > need to call...
> > >

Ok I am pretty sure this is all fine, I don't think we can pass a
parent into device_create_managed_software_node since it requires
a parent software node, but in this case there isn't one. This is
the root node here, since the "parent" would be ACPI stuff here.

> > > > +       } else {
> > > > +               device_set_node(&priv->ctlr->dev, fwnode);
> > >
> > > ...this one always. Have you checked it? How does sysfs look like
> > > before and after this change on the device in question?
> >
> > I will check this.
> 

We can't always call device_set_node. Firstly, we would need to
set it to the software node, however that is never returned from
device_create_managed_software_node. Secondly, the set_secondary_node
called in device_create_managed_software_node will set the primary
node anyway since there isn't a valid primary node on the device.
Finally, we don't want the primary node set to the ACPI node anyway
since we want to override those settings here with our bridged amp
settings.

> Basically in the expected case there should be two symlinks: to
> physical node and to swnode.
> 

I think the sysfs all looks reasonable to me, I can see the SPI
devices in /sys/bus/spi/devices, under those devices I can see a
symlink to the software node.

Thanks,
Charles

