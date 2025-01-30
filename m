Return-Path: <linux-spi+bounces-6585-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29805A229F4
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2025 09:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 964987A19BC
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2025 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43D81B394B;
	Thu, 30 Jan 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="d3G/Qm44"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D3F374CB;
	Thu, 30 Jan 2025 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738227520; cv=none; b=VhIk6Ce4U684FVu9Ns+uyGk5kaIbj8mSUdcSRK8aP43dQ2m2B/4qTlz+6KKa9iH3zseETVccip/F+54Q3mNu+CeoDCEugIu4GPpGIJUptYnqaxF9huXM7BnIHHZiwLDBuU6kqdn0GJ2uDpmMc6Bp83xYGfXxTnPi2EKEzXLIPKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738227520; c=relaxed/simple;
	bh=yYtS3K+t42uGIONk28Q40gyS7TOi4vva0f1ffHG/B2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rn982zwtDmL2zW5THaFlPLCEOS/4LeR/b6/2974rpgJQUaOeFfarQEa/mXwE9WCJ3ZKlXiAKkfwQZRstJW0x1b79q4OWVzPMxl2ClWcYeZscDwP8GlWns2vgFGJDnJhsIcspZaFWlHpylrzJ3aOKfV0dXWrcr8ebk63qLuca0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=d3G/Qm44; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U6Qiup019883;
	Thu, 30 Jan 2025 09:58:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	s976OaYE2e3BsM2Yyt8pmWRwKwvFpBCgGfn39LD9zkw=; b=d3G/Qm44ZvEs6Pm1
	MFIt92MrrZ7GkJEc1sMOsAsWaPjDpugbhSSWoD5CB/JjJEwBd5HOC/kB7O0wDcIe
	Mto+B7CcU9xb+DYxKAd//M/HIupe0ifZzjajnMAYL1QkYMqHkCXwsTESRyhSeOp7
	+BDxhIEVuA5BOdxoWMjBcQ6GwYqZ8wsd5bOv/9iif0e5Fa1WtwLjc5o96HmybiLr
	aVawqJDqZ+YjjyVbhk4vqRR9meCxiwF1LpJL76uweEmGEOAEzW7KAJ1FxIovGQDy
	BnQQRYrx/zdyXT5QCo7ZTJ4WFkMEDNJr7GYYpHWePrdt+eTQhJnpMfwIIeGI5DNo
	zeivdg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44f26x6wd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 09:58:24 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1A47F4002D;
	Thu, 30 Jan 2025 09:57:06 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4DE822D5871;
	Thu, 30 Jan 2025 09:56:02 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 30 Jan
 2025 09:56:01 +0100
Message-ID: <b5d7fce0-f726-4b54-a038-d3e0526cdde0@foss.st.com>
Date: Thu, 30 Jan 2025 09:56:00 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] arm64: defconfig: Enable STM32 OctoSPI driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
        Will Deacon <will@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>
References: <20250128081731.2284457-1-patrice.chotard@foss.st.com>
 <20250128081731.2284457-10-patrice.chotard@foss.st.com>
 <df76be38-cf62-417a-85f4-a1a95af0db74@kernel.org>
 <36560385-ff90-4f7c-8e5c-2bfb014a4c7f@kernel.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <36560385-ff90-4f7c-8e5c-2bfb014a4c7f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_05,2025-01-29_01,2024-11-22_01



On 1/29/25 11:30, Krzysztof Kozlowski wrote:
> On 29/01/2025 10:36, Krzysztof Kozlowski wrote:
>> On 28/01/2025 09:17, patrice.chotard@foss.st.com wrote:
>>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>>
>>> Enable the STM32 OctoSPI driver.
>>>
>> Please squash this patches. It's not one driver per one defconfig change.
> 
> 
> s/this/these two/
> 
> So only one defconfig patch.

ok

Thanks
Patrice

> 
> Best regards,
> Krzysztof

