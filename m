Return-Path: <linux-spi+bounces-2241-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF2989D4C0
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 10:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA031C20C10
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 08:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B362AD2A;
	Tue,  9 Apr 2024 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="LHFH1x7B"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5F1EA74;
	Tue,  9 Apr 2024 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652250; cv=none; b=ivb0TNXyaF3RghC1trz+IY76JdlU+7eHWHbT/xxAt/J4bRQ2n6M9cjQUuLEOhCqijNTj8Q9P+LiPP498+FWoiIpK9V4QdmY+qzrvib2e6IeEXAfSdjymDD/UyyvqaWYtrifBqiAlAGOZEXDk/cFSb9uFBtcCn5LgbSF0F+X+hbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652250; c=relaxed/simple;
	bh=7Lwv8eLes0HmxRquLQUZyVswSF++Qzn156nScIxwADs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQx5GVZlfaHtmP8wN2Vz0p7KdrklNLbQp0KN/QGlatcfPkvikKPAuCnTVMq9PkTPwUiRBH3lH/DKE4kf5D9fz5B1RfZNB3TRbgK1Dt1c5mGlyX7VNfnkpV4vFLfpQivqJqrOjIoyT28G3A/5XAPxQyI8hUhS3bY7T82cea7EO7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=LHFH1x7B; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4394Gg2o018460;
	Tue, 9 Apr 2024 03:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	PODMain02222019; bh=5l/Whko0ftg4GS/sAwghEW7oUxj5RVhyNhBkS3e9Cs8=; b=
	LHFH1x7BvlLoavVTCxj1Ze7lzOWgrRsPQYRaInrUqqJkoHqRmiV2uh4MIW8dMR42
	/5R8czUwh/gVNWMu31L3jcWt6W4mzbcHevAzB4Y/Ya9smOw1r+IUbZUPq00Tc0Uw
	+eV0/49YJEtrF2baYz+XJRurvIF2kE05YdVDuEHVJCtXH2MoYqH+Vt1C3+DsMZhT
	++OkEin9VhIfW1GesUH/rQP8JinoYL1yLYfmp0R1vSJct7dXD/YxLvkrAf0eoZvU
	kP+9fqVBZRoJi8XxHvqMMS+fzTLINW4oL4vVu21D8QhRXb/zH/3fYayDeFjvzgxo
	3Fd1kZKPtKlN/uxzEaiWiw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjjmj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 03:44:03 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Apr 2024
 09:44:01 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 9 Apr 2024 09:44:01 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 8DB7982024A;
	Tue,  9 Apr 2024 08:44:01 +0000 (UTC)
Date: Tue, 9 Apr 2024 08:44:00 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: <broonie@kernel.org>, <brgl@bgdev.pl>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] gpio: swnode: Add ability to specify native chip
 selects for SPI
Message-ID: <ZhT/0H9u28uPZQV2@ediswmail9.ad.cirrus.com>
References: <20240326141108.1079993-1-ckeepax@opensource.cirrus.com>
 <20240326141108.1079993-2-ckeepax@opensource.cirrus.com>
 <CACRpkdZP_9y-Z=eZcbQe=ZF2ejutP6gD2ofTxXNvGTh7CUfwFg@mail.gmail.com>
 <ZhPvW46kGeOnG++E@ediswmail9.ad.cirrus.com>
 <CACRpkdZQNrDt35d30xJSRz=03rhs6vOODWorpqMsJ=Lo4huJmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZQNrDt35d30xJSRz=03rhs6vOODWorpqMsJ=Lo4huJmQ@mail.gmail.com>
X-Proofpoint-ORIG-GUID: vVRR0v8k78eswWYWWtBsTLeuss0ew1M5
X-Proofpoint-GUID: vVRR0v8k78eswWYWWtBsTLeuss0ew1M5
X-Proofpoint-Spam-Reason: safe

On Tue, Apr 09, 2024 at 09:12:01AM +0200, Linus Walleij wrote:
> On Mon, Apr 8, 2024 at 3:21 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Thu, Apr 04, 2024 at 10:16:35AM +0200, Linus Walleij wrote:
> > > On Tue, Mar 26, 2024 at 3:11 PM Charles Keepax
> > > <ckeepax@opensource.cirrus.com> wrote:
> > > > +const struct software_node swnode_gpio_undefined = {
> > > > +       .name = "gpio-internal-undefined",
> > > > +};
> > > > +EXPORT_SYMBOL_GPL(swnode_gpio_undefined);
> > >
> > > This needs a comment in the code telling exactly why this is here.
> > > It is also taking up space and code here on systems that have no use
> > > for it, so I wonder if it is possible to make this optional.
> > >
> >
> > Happy to add the comment, less sure about how to make it
> > optional. I could ifdef it based the SPI config, but whilst that
> > is the current user the mechanism feels like it is more generic
> > than that and could be used in other bindings as well.
> 
> That's a fair point.
> Maybe a new bool Kconfig symbol that the SPI drivers or
> other potential users can select?
> 

OK I will add a Kconfig to enable this feature.

Thanks,
Charles

