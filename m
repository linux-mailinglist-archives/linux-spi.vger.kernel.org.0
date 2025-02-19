Return-Path: <linux-spi+bounces-6868-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163A1A3B2FA
	for <lists+linux-spi@lfdr.de>; Wed, 19 Feb 2025 09:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A38172C4C
	for <lists+linux-spi@lfdr.de>; Wed, 19 Feb 2025 07:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D15F1C461F;
	Wed, 19 Feb 2025 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="qrofjjdI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB731C3029;
	Wed, 19 Feb 2025 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951919; cv=none; b=p3YrGsyuMC1vmv1jQHm2kQirlpn29zcBG8O0XvcOfeL1i5KWVCkHR7El0H9WoHtgK2DCWzGNTsgdQ+7vr81yQQu1DChmGQiB8EXYFuYkdfVbibaCsVZs7qDLV6+/p/FWjiev7nNq5msUzV7XxNaHGobbup8VH/u5IZ3Ib5HvE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951919; c=relaxed/simple;
	bh=a2LKr/WX/y4caLjmK7olEcFpRmLm/fSiSAHkL/FlYyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CQVRuaw5ELgK8H0hDpTXss+FdKej1ZQ1BH3X+XomnrXsid6BhX8QicZoalfG23cv1btKvK2Gwm/T0julSaCCW1uS0Va1V5NBu9KczByMLGgDVMdJNNQo5ztS3DIKtio0BKrNsopOpAnDMtJDv52oNxdLvFjO/rKfir6KyNES034=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=qrofjjdI; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J4sKAc024666;
	Wed, 19 Feb 2025 08:58:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	3bBJS43pvAXXysK32UqQ0DdYgo9OZo0TPX7SlCS/zbM=; b=qrofjjdIBjqjCtpb
	eXbj5Hjt98R97RAEso4phh094s2/DGVfjhBk9wOuOFTSjnzyQ5GMt39Hca+VHeI6
	+6F0WqQwbljBlbKo6DUQxa/d/zVrSybRz6RwlkD5sEiYRUcSqf2+q0IpeANXZe5f
	5hY7cOmdN5AmovgJE1ctS/U1beNebFZVyMVEBLJlkbcBdN1b1j6Kr1HwCqdLNL3G
	tkHAg7150dqPbTeV4UPFl9zR2pqPNubn7WuB4ZDo12AdH8eiT26dfvvsUeSbKdYG
	jW57vPUdO4wnQQmlNx1vp4EzwNmWoNEjqdGVx+p5yoLyseOiK4Xw06QG7HfllL7G
	jptJmA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44vyyn25qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 08:58:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BB48C40053;
	Wed, 19 Feb 2025 08:56:46 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0D4984026F8;
	Wed, 19 Feb 2025 08:52:52 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 08:52:51 +0100
Message-ID: <df73976e-12a5-4af9-b312-503ae68edcfc@foss.st.com>
Date: Wed, 19 Feb 2025 08:52:50 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Add STM32MP25 SPI NOR support
To: Rob Herring <robh@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>
References: <20250218130000.87889-1-patrice.chotard@foss.st.com>
 <20250218212138.GA1092771-robh@kernel.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250218212138.GA1092771-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_03,2025-02-18_01,2024-11-22_01



On 2/18/25 22:21, Rob Herring wrote:
> On Tue, Feb 18, 2025 at 01:59:52PM +0100, patrice.chotard@foss.st.com wrote:
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> This series adds SPI NOR support for STM32MP25 SoCs from STMicroelectronics.
>>
>> On STM32MP25 SoCs family, an Octo Memory Manager block manages the muxing,
>> the memory area split, the chip select override and the time constraint 
>> between its 2 Octo SPI children.
>>
>> Due to these depedencies, this series adds support for: 
>>   - Octo Memory Manager driver.
>>   - Octo SPI driver.
>>   - yaml schema for Octo Memory Manager and Octo SPI drivers.
>>
>> The device tree files adds Octo Memory Manager and its 2 associated Octo 
>> SPI chidren in stm32mp251.dtsi and adds SPI NOR support in stm32mp257f-ev1
>> board.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Changes in v4:
>>   - Add default value requested by Krzysztof for st,omm-req2ack-ns, 
>>     st,omm-cssel-ovr and st,omm-mux properties in st,stm32mp25-omm.yaml
>>   - Remove constraint in free form test for st,omm-mux property.
>>   - Fix drivers/memory/Kconfig by replacing TEST_COMPILE_ by COMPILE_TEST.
>>   - Fix SPDX-License-Identifier for stm32-omm.c.
>>   - Fix Kernel test robot by fixing dev_err() format in stm32-omm.c.
>>   - Add missing pm_runtime_disable() in the error handling path in
>>     stm32-omm.c.
>>   - Replace an int by an unsigned int in stm32-omm.c
>>   - Remove uneeded "," after terminator in stm32-omm.c.
>>   - Update cover letter description to explain dependecies between 
>>     Octo Memory Manager and its 2 Octo SPI children.
>>   - Add Reviewed-by Krzysztof Kozlowski for patch 1 and 3.
> 
> No, you didn't.

Argh, sorry, i will send a v5

Patrice

