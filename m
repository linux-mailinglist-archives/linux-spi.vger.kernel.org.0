Return-Path: <linux-spi+bounces-3472-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3746790EF52
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 15:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3CC281F4E
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7658514AD35;
	Wed, 19 Jun 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="lbkx4zEI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195E14388B;
	Wed, 19 Jun 2024 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804857; cv=none; b=Ei/+wszURw/EkamFMp3O0Sfsyf2lwCCZ8OnnjunSoNv4eFuhYc8+W83VLobozECmATYBxfo76dSnvRz6Ob8tmEjsaiVySHnmDYt+AOWyyHL04I87bxnGkz0gQqtra9DRsZ4IQbSzyZWvrl2yLEc5gjj46xaaqyVyuEEOQCsgMyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804857; c=relaxed/simple;
	bh=jsZENImBZW43nGr5HqI/nt7WIW6WfHEagBJZNonooFc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgJT0zb47FPVTewUpfvoQ0YY+w0m+tLQODdYlgRgdipIjJtoxxdS2P4vEBiUtxOm0kbM/+yZnH6tvy8DEggWG00puCfRPvG/gN57G9/ODCNUx0wQvO9EzY0wXJPy5FYsEOAxWQQOPyFG885cw60jBvp6KyJexrMwqzEiV5LcPRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=lbkx4zEI; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J6sYqX029887;
	Wed, 19 Jun 2024 08:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=jzNUhH+kUMk2lk9uuN
	YTD1bzhW+e/ZFDyCCuRdR/518=; b=lbkx4zEIg3WK3kBAHNx8IHC8iOOF4AwbZO
	2+1TISyoJJSY28Zqgr/luVo5gHBbehm9JcIVK+PqztzVMVzhhlKFNJ1ENifR6gaT
	9mKTPk9Y2GH1SRfdtjQnVpou0PrIMfINW8lYfdNY9pk5ScK/rdPHUkLcMnAhRJjg
	Ncz4EYV7C+qhlGag3sEPOG3nagtgbRTnif2tWd9MJSaRNcL9j2EIxIyUmBaUPIMb
	SN+WoAuXAXHVQUcIqzHioGrgqChXC96yX0Xk/RefMmSxGcjTOcaTfOUy7cfyWEw1
	dPhOp68K36VIMA/fzRhEpkyOn7DcbqCvF0dM/HAp7mUKRVb4nHdg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3yuj8m0q4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 08:47:30 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 14:47:27 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 19 Jun 2024 14:47:27 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id EAE92820248;
	Wed, 19 Jun 2024 13:47:26 +0000 (UTC)
Date: Wed, 19 Jun 2024 14:47:25 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] spi: cs42l43: Refactor accessing the SDCA
 extension properties
Message-ID: <ZnLhbQmxyMJ9SAhq@opensource.cirrus.com>
References: <20240619121703.3411989-1-ckeepax@opensource.cirrus.com>
 <171880144842.113265.13864100805243474696.b4-ty@kernel.org>
 <ZnLcjO67FH2weX+y@opensource.cirrus.com>
 <d7502ea4-03bd-425a-8566-9ab0a6ea32e1@sirena.org.uk>
 <ZnLftHS7RLRRQSk/@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZnLftHS7RLRRQSk/@opensource.cirrus.com>
X-Proofpoint-GUID: h0YQBU60kAPmRnYzjXF7CFTEnidPq_5z
X-Proofpoint-ORIG-GUID: h0YQBU60kAPmRnYzjXF7CFTEnidPq_5z
X-Proofpoint-Spam-Reason: safe

On Wed, Jun 19, 2024 at 02:40:04PM +0100, Charles Keepax wrote:
> On Wed, Jun 19, 2024 at 02:30:33PM +0100, Mark Brown wrote:
> > On Wed, Jun 19, 2024 at 02:26:36PM +0100, Charles Keepax wrote:
> > > On Wed, Jun 19, 2024 at 01:50:48PM +0100, Mark Brown wrote:
> > 
> > > > [1/2] spi: cs42l43: Refactor accessing the SDCA extension properties
> > > >       commit: 6914ee9cd1b0c91bd2fb4dbe204947c3c31259e1
> > > > [2/2] spi: cs42l43: Add speaker id support to the bridge configuration
> > > >       (no commit info)
> > 
> > > Not sure all went smoothly here. This seems to have picked up v1
> > > of the first patch and not picked up the second one.
> > 
> > That's because when I told you that the second patch didn't apply I left
> > the other one in the queue, and what you sent now didn't apply either.
> 
> Hmm... what branch are you applying this to? Pulling the patch
> off the list and git am-ing it onto your spi for-next branch
> works fine for me.
> 
> I mean I can just resend it but presumably we will hit the same
> issue again.
> 

Ah I see I think your applying to the for-6.11 branch, which is
missing 60980cf5b8c8 ("spi: cs42l43: Drop cs35l56 SPI speed down
to 11MHz"). I can send a version based not on that but might make
a bit of an annoying merge conflict later?

Thanks,
Charles

