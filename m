Return-Path: <linux-spi+bounces-6475-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1859A1B9CA
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jan 2025 16:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9E916D54C
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jan 2025 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E008316190B;
	Fri, 24 Jan 2025 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ieJDbpw+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129B15C158;
	Fri, 24 Jan 2025 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734182; cv=none; b=PE+ZFdeViiKei5TWfkI6mBFjARaplBct31UrjNDwCBtuCgWlZQGzrrTE/BoaWwhjiUrgJFxucVhO/DL6KLpQU854psDmwjLYoYse7dJkNauzagac44+xWSZP6LjPL/rUbSzPdXyZ0dOQD0bIVfcT53czYceCCwfWJtjxXSNz58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734182; c=relaxed/simple;
	bh=TPX1l+SdRIztwMtC4rMs0NLe2T3z4RcX/+NrtMVFUV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R7eu0kdtpdtKfohC5B9Pejp2N52ntmqymrfzawCAGjOda49Do8zTt3wgtq2XVP44CkDd75G2CWOwlhfgmR6as6kGG/wnD4sC37+92UNzrzUIx2ACoyg5EY4C7dNb6zVVjJ2Popr8jiktN1vA+06Bc7ab/RQ29XmoJ0Y1QMdQs18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ieJDbpw+; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ODxT21020338;
	Fri, 24 Jan 2025 16:56:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	uQJZ2/IQ+I2p2Ev80yrRLDK6uoLc+JB+saQGoWGX9Ko=; b=ieJDbpw+v0XmJCbj
	nqWoYbSg0U9tI5gJ86lpMlxkANGFkz/xY7sihPc0Cuo0niayH1GJRA43V2Vc7IFI
	+unl2mdy8XQkvwV3yF7XPJ3AcJe/su9q8MQS4bXpviGiotw4t9IfOG6bejzeZu13
	cgnc62DZbOsj9VMJQRPvvwmk4YswWFKLGRsVEAjjny+g9dkhbSwalq+/v4QKLQaY
	V8lVIMJrwEL5CHMD40ta+q8fHozvS/kps3i0uMx60ten/yqSOI033frL8LfxejdM
	cG1YeLtd2DVsN/a/rdf4Rkz7V8Ut0MNGL2Xhsw/0fCfsbApyf58HPmSkv2h12PJK
	27MwLg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44cc7x8dqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:56:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 73A1640049;
	Fri, 24 Jan 2025 16:54:53 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3B82628DEDE;
	Fri, 24 Jan 2025 16:53:48 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 24 Jan
 2025 16:53:47 +0100
Message-ID: <5def1249-627b-4daa-a1e5-c0df161dafab@foss.st.com>
Date: Fri, 24 Jan 2025 16:53:46 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] arm64: defconfig: Enable STM32 Octo Memory Manager
 driver
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
References: <20250122141037.953934-1-patrice.chotard@foss.st.com>
 <20250122141037.953934-9-patrice.chotard@foss.st.com>
 <ac9bafad-62b8-433e-be43-96a6f9276141@kernel.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <ac9bafad-62b8-433e-be43-96a6f9276141@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_06,2025-01-23_01,2024-11-22_01



On 1/22/25 16:23, Krzysztof Kozlowski wrote:
> On 22/01/2025 15:10, patrice.chotard@foss.st.com wrote:
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Enable STM32 Octo Memory Manager (OMM) driver which is needed
>> for OSPI usage on STM32 platforms.
> ... And which upstream boards need it?

Right, i will add that is needed for stm32mp257f-ev1 board

> 
> Best regards,
> Krzysztof

