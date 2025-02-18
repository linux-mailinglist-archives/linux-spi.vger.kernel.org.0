Return-Path: <linux-spi+bounces-6851-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B04A4A3995F
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 11:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7E6188BBCB
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 10:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ECD22F16F;
	Tue, 18 Feb 2025 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="APp4fQxu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC551174EE4;
	Tue, 18 Feb 2025 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739875307; cv=none; b=iJ/rkHHyp5mNP6TWM46PgpqvXeAFt6gHjpCb+X7PB/4FDDmcpW2YlUm1ATfgmuSQ9LH1lfZn9GZNMvWhawu9cnLrcsT4o+nfRCGx89EE6mZxA0cFsYYpSRitmaDgGeoLNY17R9ok2ZDSI8j34REgq2SwP9GwsRRgttoB+DhwfyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739875307; c=relaxed/simple;
	bh=D0GdTdYNu5L2ksDF1ryOKiqlJ0F3Vhq7y7mplxbdGLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G9bcTGtlRak6OEIYh9M9j32cCbntDmHVCPvSvQn5RUwFxlMKNCbPcoEMfpiDAZMnoHfZlYCE89ILRbIqZ2W2BEAlq+o4HgflxMJ31Kr72ULkdas5LBlkjcgR5A777v4MSs4Z5flAzqhJstEpgXl/Gcn5Gy5PAtE09hy9B1+7kSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=APp4fQxu; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IAdTCW012257;
	Tue, 18 Feb 2025 11:41:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	V4eYCNtATnwN1ZIKmyX0+Wk2XGtLI3NIn3i0ikesTwU=; b=APp4fQxusozWDrY6
	juXOk6kxHRZCNbdFr2OT91Sr8enp6bZGWGhFyTEGIAte+D8JGCKboLnN71ZQb639
	dohF5cO7IsMWw+dIWHuixxSkC/C0ZEFj+TeQdt13h1rw+kdQFv8iLnfCd7rbm8R8
	gqvNoOand5i3pxQFGHFlpwZMmuzJE0tEQSz0QgYdxjbQDDj0W1JHZ58xrgz45lCb
	o+FPDATKCjr2lRFJhxKeaUdWYIf/1PpGMxt2sdHEEHCtLYRGHQ3sqE5QVtwgN49B
	3J+xOkyEjxOmpXh/uUoRFVdcpjTbHyNIl504sjtgZcQSetZo79h9BJ0k3rovVpdn
	9it76w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44tm1uba39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 11:41:28 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1EA4340047;
	Tue, 18 Feb 2025 11:40:09 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4E91E3BE6A5;
	Tue, 18 Feb 2025 11:39:04 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 11:39:02 +0100
Message-ID: <d2a2feed-a2f0-430d-a872-23d22afd937a@foss.st.com>
Date: Tue, 18 Feb 2025 11:39:01 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Add STM32MP25 SPI NOR support
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>
References: <20250210131826.220318-1-patrice.chotard@foss.st.com>
 <20250213-lush-rainbow-moth-0f5e18@krzk-bin>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250213-lush-rainbow-moth-0f5e18@krzk-bin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_04,2025-02-18_01,2024-11-22_01



On 2/13/25 08:56, Krzysztof Kozlowski wrote:
> On Mon, Feb 10, 2025 at 02:18:18PM +0100, patrice.chotard@foss.st.com wrote:
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> This series adds SPI NOR support for STM32MP25 SoCs from STMicroelectronics,
>> for that it adds support for:
>>   - Octo Memory Manager driver.
>>   - Octo SPI driver.
>>   - yaml schema for Octo Memory Manager and Octo SPI drivers.
>>
> 
> You combined three different subsystems in one patchset and nothing here
> explains why and what is the merging intention. Either split your work
> or explain dependencies/merging.

Ok i will add an explaination about OMM and OSPI relationship.

Thanks
Patrice

> 
> Best regards,
> Krzysztof
> 

