Return-Path: <linux-spi+bounces-8153-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 328AFAB9CCD
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 14:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDE11BA80BF
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A5223F421;
	Fri, 16 May 2025 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="h6kvDvfd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136361DFDE;
	Fri, 16 May 2025 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747400315; cv=none; b=kBmYNZV2ZyZQFbvqAi5uIeA9KIevf6lNCVnOWQXeFnB+gu/YKBCs5RHdiVXwWWdX1K0RrRhURx1nUWeY6MQj2pJIKRxMOuM9TltKFSJl6+xdjBvgovsiD2RGU2lNjD8JM3FV99PVsu5s7sbWUIbchncgBvSChrlFQPjwl07NeHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747400315; c=relaxed/simple;
	bh=Ymo/u6vYKJNNE7DarQjuIGwdjzxN7gU7VNb+iJ+1k+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BotAAyUEGDYCsz+v1iVre6/fQTxwncHJzfHivjCda+EWMRxjCTaxKXre0et9/Wa8OJ97UbpObflf54Mr/coOAVFNPli4ztUGX603+72VlmUnJbrp0qtHVgQ0EClAqHhsivvc4eu/DIs88PLENWYp/Ax3L/JUhqzBVPX+mUMyj7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=h6kvDvfd; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GB2cC6002118;
	Fri, 16 May 2025 14:58:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	3vjseJYbJT5ETJFPoncHRVVX4/JCv6agmUw3wmhKosc=; b=h6kvDvfd3E/ew6uD
	kIA4mZS2tnjaseju95OgnOlcaevnuXwOZJvA36MXrggZ/Hr7PdgvofDVTarF8Ygx
	KFMVVv8lABPdDH6QhBWt1yNLdOHWgCjglzDTT6MURdczeInpIVdBFl1U6j2eriHK
	ga0oVq4B+n0RWP2EFXFlCK3S/xisYYw8Z9soT15E74cr1eRFcDn6onQcZqPOqaNO
	i9mY5whVoiTkjperNXUXlhd8t1trzhw3qYmuAK3KX22+sCEJOu9DDTeAmUAO9XAj
	A3A4/C457uS9c3CjHYHd1EtwweqJdhzUQ41LXkiZ8iXL51uhSuD++EGj2trv82u/
	bWkdYA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46mbdwe848-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 14:58:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F01D740063;
	Fri, 16 May 2025 14:57:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C4D70B44890;
	Fri, 16 May 2025 14:56:23 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 14:56:23 +0200
Message-ID: <ae7b8134-923c-4967-b25c-fc1411fd0602@foss.st.com>
Date: Fri, 16 May 2025 14:56:22 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] spi: stm32-ospi: Make usage of
 reset_control_acquire/release() API
To: Mark Brown <broonie@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250514-b4-upstream_ospi_reset_update-v5-1-7b5de0552c8c@foss.st.com>
 <aCWxusdUYgeGRaqk@finisterre.sirena.org.uk>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <aCWxusdUYgeGRaqk@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_02,2025-03-28_01



On 5/15/25 11:19, Mark Brown wrote:
> On Wed, May 14, 2025 at 03:56:01PM +0200, Patrice Chotard wrote:
> 
>> This patch is dependent on commit 6b3754009f87
>> ("reset: Add devm_reset_control_array_get_exclusive_released()")
>> available on tag reset-for-v6.16.
> 
> When telling people about dependencies like this the standard thing is
> to also specify the repostiory, or link to a pull request.  The git
> repository is needed to actually pull the tag.  This appears to be the
> PR at:
> 
>    https://lore.kernel.org/all/20250513092516.3331585-1-p.zabel@pengutronix.de/
> 
> which is the full reset pull request for v6.16.  The commit you
> referenced isn't the tagged commit, it's further back in the history
> but still has a whole new reset driver backed up behind it.  I'd have
> expected that if this was expected to be pulled into other subsystems
> it'd be on a topic branch and directly tagged?

Hi Mark

Sorry for that, how do you want me to proceed ?

Thanks
Patrice

