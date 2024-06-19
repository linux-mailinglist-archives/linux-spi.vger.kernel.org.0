Return-Path: <linux-spi+bounces-3468-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F80C90EE34
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 15:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9CC28951A
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16216149C43;
	Wed, 19 Jun 2024 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QCiOntyr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F00147C89;
	Wed, 19 Jun 2024 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803604; cv=none; b=P8ubLD3kGmVEqPFTNzsyp/OoL5e13g/r9xGIleKoHYrFOdw8VshVkqsODLg/d5KzPoImQCqy4cNz6ffWkFI0OeK4FJOn30DuXMmvmo7q7KKRMW9T1fnjD+uuKGVMQNxKFvGtzNcSspSPKay0bQFa5tnLOzzJ8I1F9h5zIyoZ72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803604; c=relaxed/simple;
	bh=ZCX2362KyKiOO5p76W62RIQc7GacXvGphGwXPOlawCA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9YoPUa2IPXbPxF1dKlTaYTzWC6TDoAW2lpMMUgkyAbGgFW0yrpx5BPxITq1JDMIEnaGtG53rvN8vtajdVquDbRmrJ26+fA6hSAKWQjlcIjKqfQnXixhd6bzNIvcC84igJiv/ovz3yenHuJT65W6PRsES38gIXRp2YANXyCNFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=QCiOntyr; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J5K7Yx006478;
	Wed, 19 Jun 2024 08:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=RKdI5MFkE251YuBqA3
	0MCnU46Leq7mZB8LDEf5R2yOM=; b=QCiOntyrbmzDX+dro0R8ERq0dCWFbclW+6
	4EEtImMqSMVIqgiWWDmkN8CeI+JeD95dqdF6WjQK75b7WNVF9aQ7owxw8M72CPgP
	O3vFWtwfN7GCOemLYUsTqbpi6AHK8sM2w0BpDA50G2Eyqf99cEpbtpStbZVD+sun
	OXQ1O0FZKoc6xVEd+pqxWTv0pKA9xLSU9GiMnU2pgRXwR8jj0DMXQgBiku4R/98Z
	h/VyRRX1me8kuk2vZq9xDulzO+53rg0hflRKtemca2Re1KTBOjWO2Sj00+zcm1Bo
	AucxhUJo9Qa7bbBkLWy/8KKG4RtLsiTJ0HYFugP8oFKbGbTpVz+Q==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3yuj8m0pbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 08:26:39 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 14:26:37 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 19 Jun 2024 14:26:37 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 1E610820248;
	Wed, 19 Jun 2024 13:26:37 +0000 (UTC)
Date: Wed, 19 Jun 2024 14:26:36 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] spi: cs42l43: Refactor accessing the SDCA
 extension properties
Message-ID: <ZnLcjO67FH2weX+y@opensource.cirrus.com>
References: <20240619121703.3411989-1-ckeepax@opensource.cirrus.com>
 <171880144842.113265.13864100805243474696.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <171880144842.113265.13864100805243474696.b4-ty@kernel.org>
X-Proofpoint-GUID: lu-qZrbKPDzuQ-HeMqgjyWtLF4bOtQQ8
X-Proofpoint-ORIG-GUID: lu-qZrbKPDzuQ-HeMqgjyWtLF4bOtQQ8
X-Proofpoint-Spam-Reason: safe

On Wed, Jun 19, 2024 at 01:50:48PM +0100, Mark Brown wrote:
> On Wed, 19 Jun 2024 13:17:02 +0100, Charles Keepax wrote:
> > Refactor accessing the SDCA extension properties to make it easier to
> > access multiple properties to assist with future features. Return the
> > node itself and allow the caller to read the actual properties.
> > 
> > 
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/2] spi: cs42l43: Refactor accessing the SDCA extension properties
>       commit: 6914ee9cd1b0c91bd2fb4dbe204947c3c31259e1
> [2/2] spi: cs42l43: Add speaker id support to the bridge configuration
>       (no commit info)
> 

Not sure all went smoothly here. This seems to have picked up v1
of the first patch and not picked up the second one.

Thanks,
Charles

