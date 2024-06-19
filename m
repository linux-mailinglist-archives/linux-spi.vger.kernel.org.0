Return-Path: <linux-spi+bounces-3470-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3EE90EF2F
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 15:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1AE51F226EC
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 13:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB48614EC42;
	Wed, 19 Jun 2024 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="h3/MJhnb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F5514E2FA;
	Wed, 19 Jun 2024 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804412; cv=none; b=GPGTcE5eouuBsyOTMVJoYW+vEFAykz1nXaNY+kcm/UokCzT7PTcgTksgAfgFNBH0UfNoJo2qILnEHwQurak01i4saM8HTmnhTv9NNpYATQEku0RmTQvigcPTGkzxvyVG++anbPDlFnRoMp1Rbd5JgAEpIwFZWxSza0zch8BHLMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804412; c=relaxed/simple;
	bh=9XTFzNenZVnBtZtYQrfLs2GuQRgQL1Y763n8xKB7jQw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pa3QKMZtIHD1flmpZtapgsJ50PqDyyBj9Ij879UfLlmCXCWQWQ7jesJ9/89G8kM7B93FkuwfQ8rBFzQ0pdCCHtJ9J9PUa7JzLgy/gbLydcuqE37Lo3GCFlkS/9ncQVH0ycZNBZkXW4cphaDmu1gpypY+l77OGiK4QXXCKfSiyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=h3/MJhnb; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JC1C48003623;
	Wed, 19 Jun 2024 08:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=ciDQ9HxYDaZTNNuigB
	Uabs2anNyAP+09ApTmCC+FRfI=; b=h3/MJhnbfttg4psdcvGa5E01v1V6qrCRoY
	JhIUjjpGpbnAsZOG63YaUVcli4g0+lN/6FY50yFDNnkFNZ2h7xX47YJbMrnF8dXf
	UMbWow4OVNtUIhS5Xs/EF1PObkIT0LE+bSxaASFrxBndgUdEMVOmrdQZjhzD8KjU
	tFYRrDiLCwLhTWA6+LSqzZ++BMdg48feDGOoF9lP2wE6eat7GMGRYBOxEkq9JN+g
	XkxxJlkFU9BdLaIRM2/Upm2rG/IBOgNUYQHxAsNKKBab6WEVnIB6YsNuZJ37gavd
	SnYZWqkSYqwQMmV1Ad4xAoUf2Smof3RzlnetNqEHC6bqP2KuBW1A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3yujb10qbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 08:40:07 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 14:40:06 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 19 Jun 2024 14:40:06 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 0616D820248;
	Wed, 19 Jun 2024 13:40:06 +0000 (UTC)
Date: Wed, 19 Jun 2024 14:40:04 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] spi: cs42l43: Refactor accessing the SDCA
 extension properties
Message-ID: <ZnLftHS7RLRRQSk/@opensource.cirrus.com>
References: <20240619121703.3411989-1-ckeepax@opensource.cirrus.com>
 <171880144842.113265.13864100805243474696.b4-ty@kernel.org>
 <ZnLcjO67FH2weX+y@opensource.cirrus.com>
 <d7502ea4-03bd-425a-8566-9ab0a6ea32e1@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d7502ea4-03bd-425a-8566-9ab0a6ea32e1@sirena.org.uk>
X-Proofpoint-ORIG-GUID: Sq7IpnBa3qpnQ2PCmMwwP9cHqd8vbCjg
X-Proofpoint-GUID: Sq7IpnBa3qpnQ2PCmMwwP9cHqd8vbCjg
X-Proofpoint-Spam-Reason: safe

On Wed, Jun 19, 2024 at 02:30:33PM +0100, Mark Brown wrote:
> On Wed, Jun 19, 2024 at 02:26:36PM +0100, Charles Keepax wrote:
> > On Wed, Jun 19, 2024 at 01:50:48PM +0100, Mark Brown wrote:
> 
> > > [1/2] spi: cs42l43: Refactor accessing the SDCA extension properties
> > >       commit: 6914ee9cd1b0c91bd2fb4dbe204947c3c31259e1
> > > [2/2] spi: cs42l43: Add speaker id support to the bridge configuration
> > >       (no commit info)
> 
> > Not sure all went smoothly here. This seems to have picked up v1
> > of the first patch and not picked up the second one.
> 
> That's because when I told you that the second patch didn't apply I left
> the other one in the queue, and what you sent now didn't apply either.

Hmm... what branch are you applying this to? Pulling the patch
off the list and git am-ing it onto your spi for-next branch
works fine for me.

I mean I can just resend it but presumably we will hit the same
issue again.

Thanks,
Charles

