Return-Path: <linux-spi+bounces-8105-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44409AB5048
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 11:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FAC51B42BD4
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 09:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F1823AE60;
	Tue, 13 May 2025 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="IT2YzIWZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8301D23956A;
	Tue, 13 May 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129793; cv=none; b=gR/Wx5/n0qXdZVLShPO2X/QIQXwUJaBScXAQg/pGPaLLlCZh+Yv43jX3HPO6bm3ZEqVXFdKvL6Jg+dwavrjz/WSoh43NkIDOmbwJ+l1FEOqWUyqxlEr1aSmEIk6a0lyaQ9Czq/KiNqemA1y5qMXdElosGvncRu2FN45MwK37eKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129793; c=relaxed/simple;
	bh=0df2iZqhNWnX66iOE6tpF5amm2TMGGXSugvyX+qs6C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n1gfSpZEtdrvrRjgi6zxBAqDhBYwem7z1sjv5ZuCtkk0kqwwh8GnzX/GD9SVZLgAETw1FPsAUJ3tqpgb9l1gEDsJpQRvQ7SG1pwm/Z/V2pzeCPSIHZ4ZpGK8Hbh2LB/N/cbsQxX2ooGGakt1NQWIO2hU3JcYW1Aw8xa0LK84XA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=IT2YzIWZ; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D854pR017555;
	Tue, 13 May 2025 11:49:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	//ZVoYJE5FD18K2yMTq+UkexofBXdKxadbPDKcichro=; b=IT2YzIWZjRLdKVS9
	rlyeA1yMuLa8XBWwwcqFAxgUcIwADvUuuxavvDjRpzaEmDpI/V7NW8F1LhrVLZqX
	2gZ+f5kLliRBXV7KHmoCvfIomLp+YlegNvHTHAAtPAVxm0OMW4S9BuHOHdod6Rbi
	pM+7XKQHOuI2bVsSY8u8qDN8+h31XEPKNaEPXBHGKYokHObaxn2384Q+4Kv55OCS
	vKuIgnBAurajHWSGHl4nBm0a4LKbiVjWUxsATpr3mF+SDZBdu+/jzjWeDGliqBnR
	OiSLAeeudCEV21LJzimTxpFyigPgj9j+LtABdhFHtAPBRRL3349wOi+6EHRPCAlM
	IlhGCQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46huxab77e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 11:49:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 02C8240056;
	Tue, 13 May 2025 11:47:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 92747B43F56;
	Tue, 13 May 2025 11:47:17 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 11:47:17 +0200
Message-ID: <c4a2ccb6-b052-4cce-8bfc-26bcae2a2e2a@foss.st.com>
Date: Tue, 13 May 2025 11:47:16 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] spi: stm32-ospi: Make usage of
 reset_control_acquire/release() API
To: Mark Brown <broonie@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250512-b4-upstream_ospi_reset_update-v4-1-982c6f7886ef@foss.st.com>
 <aCHlfED7b-W0pGXY@finisterre.sirena.org.uk>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <aCHlfED7b-W0pGXY@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01



On 5/12/25 14:11, Mark Brown wrote:
> On Mon, May 12, 2025 at 09:01:04AM +0200, Patrice Chotard wrote:
>> As ospi reset is consumed by both OMM and OSPI drivers, use the reset
>> acquire/release mechanism which ensure exclusive reset usage.
> 
> This doesn't apply against current code, please check and resend.

Hi Mark

This patch has been submitted on top of reset tag reset-for-v6.16
due to dependency with new reset API devm_reset_control_array_get_exclusive_released().

How do you want to proceed ? Philipp can take it on its reset tree ?

Patrice

