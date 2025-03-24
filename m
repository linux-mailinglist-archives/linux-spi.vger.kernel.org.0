Return-Path: <linux-spi+bounces-7289-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9C9A6D831
	for <lists+linux-spi@lfdr.de>; Mon, 24 Mar 2025 11:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8F0C7A5F01
	for <lists+linux-spi@lfdr.de>; Mon, 24 Mar 2025 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F7725DCF0;
	Mon, 24 Mar 2025 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XdTQiGyN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4091E522;
	Mon, 24 Mar 2025 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742811686; cv=none; b=MOuQ6ShN24i4AlKjgxBtOejnKl7/+HCCP/40CMKQdEVCWbgtF8h3g0ACBNLG8vRkdkQkmP9rHlWROGvB+l/Y8tT6Y65fepK12baLsBrXLDXZf2qmCzywC3hX1OScJV7/+TbaXu+1hzZOkuJ1C9kLYFycDF1R8L/4JZorkhq6xvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742811686; c=relaxed/simple;
	bh=ox3nsjplR00PH6bCPDedTPwGXbTcF87dCS2/KJ6ajis=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MyLoNAZ+b6dh+NSEuPqPjtwP8Vn1acuoaEoEaG39e1thJJCyrt3bM7/NOD/N8apFg0whSy5Uvgr+CmQBFp9LJcyB1ACIxKAMGOuRmpKv9OER+Bvh4n6vINxvdkU0iNf9A9P5ieD7RQbKv1FrNI/ir8mPKdrede25AGtkC0gb34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=XdTQiGyN; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O7ilKu011526;
	Mon, 24 Mar 2025 11:21:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	VgcK61C1ClW+Bsv+nkLDe43OxgHSNo7fk3rpTcQgFK8=; b=XdTQiGyNpFJcJ7Yz
	4ms/Nfk+xdVzp//FaxZbXEnnZlCWPLaMUALtg+cNzN1CFTwz5Aad33+EEUWSjJfT
	i0Bc5Qdo9DQmkk1Y2Z7Xh2CQ2Hj8ePd7NFad5mlw4wc/u6NCeWpOuyicdiPrA/Li
	6LjfyNBHNrMcpX38nb33bNf0Hs97xU9PbqmfHaSN0iNiGM3zMiJKITo37bGKytwl
	0sW4leqlqZQF0R57dPQTBPzFAvyn4UDKTczlBiW7HAJ86cf9NJ30AvueWDApCTR/
	z4tY9Nku9xrIBUiJ3gjyx1t/A3ZA30OkLvCUUyN61k3+wybe8uYsUnPgVVj4NkYc
	svyLpQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45hkgr78c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 11:21:09 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4E7114004A;
	Mon, 24 Mar 2025 11:20:00 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 359C580B78C;
	Mon, 24 Mar 2025 11:19:07 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 11:19:06 +0100
Message-ID: <b99576c5-cc9f-455a-aa58-ce5a0489a5a9@foss.st.com>
Date: Mon, 24 Mar 2025 11:19:05 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: dt-bindings: st,stm32mp25-ospi: Make "resets" a
 required property
To: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <christophe.kerello@foss.st.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250321-upstream_ospi_required_resets-v1-0-9aa4702e3ae2@foss.st.com>
 <20250321-upstream_ospi_required_resets-v1-1-9aa4702e3ae2@foss.st.com>
 <688c619d-0e20-496a-ae24-d62ab34f93ab@kernel.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <688c619d-0e20-496a-ae24-d62ab34f93ab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01



On 3/21/25 11:13, Krzysztof Kozlowski wrote:
> On 21/03/2025 10:44, Patrice Chotard wrote:
>> Make "resets" a required property.
> 
> Please explain why. This is technically an ABI break, so you please
> provide explanation what sort of issue is being fixed.

Hi

Right, i will add more details

Thanks
Patrice

> 
>>
>> Fixes: bed97e35786a ("dt-bindings: spi: Add STM32 OSPI controller")
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>  Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml | 1 +
>>  1 file changed, 1 insertion(+)
> 
> 
> Best regards,
> Krzysztof

