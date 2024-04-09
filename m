Return-Path: <linux-spi+bounces-2253-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B72089DD2C
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 16:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE0A1C236FD
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8754C4F8A0;
	Tue,  9 Apr 2024 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gQRkUozU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF27E4AED6;
	Tue,  9 Apr 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674016; cv=none; b=N9l/ldIcfvb5EsdH8yuFyV9YfYhusVBDyUNrrCEk0AQRsTs5FoyLT9TVKRYUb2kH42IJE7pJMgKIK9MqQKkvyOFSuLpYKrR/XQGjYZN3cePLNTRclY0MdVWPWZGbvQWeMwXPzhbNEIwNG+8cCUALmGzUOBPrfV04WFDkq6ZIA1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674016; c=relaxed/simple;
	bh=BWVCdwaC4GmD8YcGR8jGJ7wgG3+7C56FaooXFqYmk9Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgKJ+cAx7OcON7ALq7MazEiqAgLUaYybJO/EFqpG5XqO7tmLFVenN/bMVcAWm+00OVTsX0qEyaq2DjwPgWPmYjR/ylBcn903R3Nj3aHatR7VjI7cdsHKV5LXXBX0vvwdIGPEhBsOFuFeIN2oknGKRXEIHV+O9vZXE0QfmH9sAvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gQRkUozU; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4394GgMO018460;
	Tue, 9 Apr 2024 09:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=S9sAqbv6Po9AMNW
	mJuDHwqAVsAsTZHg+rdoYaa5AYaU=; b=gQRkUozUSrfRDlxi2XvorNrH+5oifXR
	0CD37y5JpRK6fqTmW5IbS8q7mkQoe7RrjmRcqLCix0Vz+kuCIVWUQ4m59ucVH5Gj
	VQ40RBBRWjpDUWBmShs2QuEw4VVxQLhB4cT7IExlgP/yhX/uvCIJG9LJL5iL8nSp
	ithg38UH5Ugb5sJNLOk777iNUrjxXPp6BP4A4Xfuy+a/OuTj/f4tYXIWdAu46T2M
	8nnERjwKPt7avnYMT5c/yrjQi+ASOWiWZUI4+LhinrdnPA3wNm9yfjFHf2SJJJa2
	S4fhnJWIBbuN/Fdxk43TWU2HHqOKtIjw+zL/AFvqwVIyfGOGZ01fwVA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjjyv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 09:46:50 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Apr 2024
 15:46:48 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Tue, 9 Apr 2024 15:46:48 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 9B6F482024A;
	Tue,  9 Apr 2024 14:46:48 +0000 (UTC)
Date: Tue, 9 Apr 2024 14:46:47 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v4 2/3] spi: Add a mechanism to use the fwnode name for
 the SPI device
Message-ID: <ZhVU165FxJEZTRJ0@ediswmail9.ad.cirrus.com>
References: <20240409132126.1117916-1-ckeepax@opensource.cirrus.com>
 <20240409132126.1117916-3-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240409132126.1117916-3-ckeepax@opensource.cirrus.com>
X-Proofpoint-ORIG-GUID: JNHpiD_Hr2E3n0NO821I-es28mDlWaIR
X-Proofpoint-GUID: JNHpiD_Hr2E3n0NO821I-es28mDlWaIR
X-Proofpoint-Spam-Reason: safe

On Tue, Apr 09, 2024 at 02:21:25PM +0100, Charles Keepax wrote:
> Add a mechanism to force the use of the fwnode name for the name of the
> SPI device itself. This is useful when devices need to be manually added
> within the kernel.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---

Apologies looking at this I really should have updated the commit
message as well. I will send a new rev soon if there are no new
comments.

Thanks,
Charles

