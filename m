Return-Path: <linux-spi+bounces-6226-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37969A024C2
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 13:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC471650BF
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 12:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EE91DD529;
	Mon,  6 Jan 2025 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="iCpYwVj4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1A1DB95E;
	Mon,  6 Jan 2025 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165055; cv=none; b=tEvypgq6Ed0HIgbnA4QRVC50tlVkQAwA/g/4/pMfzrXW2hOMa7qTtYxtzlbun5qmJBWY0YQGuQ89WsKRqNh56wvIQpVpL71H+Xg60J2WB8y9A7eymIH++8HTRLYiIbhXtk2q/6SRkJ9V4KcnLuQZp2KJlnG+H+tqgvI5Tv4ZK58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165055; c=relaxed/simple;
	bh=ySPlKT7q/5kFyWZC9KwN4ZVNWRjjqJOJMrFFlP+mbbc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXQHg6L/W8LsJG8KamxGhoeBMLWVsLhFNbU+BiTaBq7MBkTZmy5Ike3qgdpCcO++0Xu91w5k3dV12VDyO7+JHUzLAPyYx+k+vRDOSQDxD0VvLowwl/NLI9W8vN3jyAm6kFkVViJKngLIigJgoONxacBOeosnFYKsW3BOxGghg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=iCpYwVj4; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5064rhaA021827;
	Mon, 6 Jan 2025 05:32:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=2uYJOiM/HbfgHfKrJI
	1xrTj5cr9v5VZf2W3BJkrW/wE=; b=iCpYwVj4vBbQzhXeGv7EHzyI5VlgS7kpRR
	8s4EsgjuikitbrZBjkNeKjSA1ITMimEIUy3W7njEMe36Uk0xtYogChunI6et2j84
	ONhUEoodlSZUwYk+u3rY7G6JjsgljyOFRginAXu1SBWUSHDxi6FHFgwYbzOpkOGN
	BCakjF8JtACf5tuONR0Hk7UCz0DC5jCmtMWxdEf6Nhgp7ExQ0h1819cxei6sf+qR
	ZLuDnUmjrQtD1/Yeprnm5eUtYXQxYeKBE0ZFAKL6+8yqKRDGe+01fCt2E2b0pAJH
	xNrU17Hl1NBjbA+pt12aKwPsv8Q5gT5hgz6lINtUPD+R6nAMqN9A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 43y3929mx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 05:32:15 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Mon, 6 Jan
 2025 11:32:13 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Mon, 6 Jan 2025 11:32:13 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 23024820248;
	Mon,  6 Jan 2025 11:32:13 +0000 (UTC)
Date: Mon, 6 Jan 2025 11:32:12 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Mark Brown <broonie@kernel.org>,
        Nicolas Ferre
	<nicolas.ferre@microchip.com>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>,
        <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 3/4] spi: cs42l43: Make handling missing spk-id GPIOs
 explicit
Message-ID: <Z3u/PNryXkda7GyO@opensource.cirrus.com>
References: <20250104205437.184782-1-krzysztof.kozlowski@linaro.org>
 <20250104205437.184782-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250104205437.184782-3-krzysztof.kozlowski@linaro.org>
X-Proofpoint-GUID: h7sDSYWgJBRQ--r7QsqI2YX9f7ladere
X-Proofpoint-ORIG-GUID: h7sDSYWgJBRQ--r7QsqI2YX9f7ladere
X-Proofpoint-Spam-Reason: safe

On Sat, Jan 04, 2025 at 09:54:36PM +0100, Krzysztof Kozlowski wrote:
> gpiod_get_array_optional() for spk-id GPIOs can return NULL, if they are
> missing, so do not pass the value to PTR_ERR but instead explicitly
> treat NULL as acceptable condition.  The old code was correct, but
> misleading because PTR_ERR usually is used on errors.
> 
> Reported by Smatch:
>   drivers/spi/spi-cs42l43.c:241 cs42l43_get_speaker_id_gpios() warn: passing zero to 'PTR_ERR'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/spi/spi-cs42l43.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
> index ceefc253c549..90180662c4c2 100644
> --- a/drivers/spi/spi-cs42l43.c
> +++ b/drivers/spi/spi-cs42l43.c
> @@ -237,7 +237,9 @@ static int cs42l43_get_speaker_id_gpios(struct cs42l43_spi *priv, int *result)
>  	int i, ret;
>  
>  	descs = gpiod_get_array_optional(priv->dev, "spk-id", GPIOD_IN);
> -	if (IS_ERR_OR_NULL(descs))
> +	if (!descs)
> +		return 0;
> +	else if (IS_ERR_OR_NULL(descs))

Should switch to using just IS_ERR() if adding an explicit case
for the NULL. Otherwise looks good to me.

Thanks,
Charles

