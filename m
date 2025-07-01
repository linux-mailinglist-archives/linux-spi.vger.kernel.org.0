Return-Path: <linux-spi+bounces-8935-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F461AEEF89
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 09:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C131BC02C5
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 07:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9830258CD0;
	Tue,  1 Jul 2025 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Jn7H8vOc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4B1E515;
	Tue,  1 Jul 2025 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751353920; cv=none; b=Ma6eGaTUmXNJ+L8EqFaOQy0Fe2Yi44AYazRvMbH49JJnqJvu5ip+LOwTMTXBjUJSA3b5n77K0wWf6VxuA6PsMziX++37JRlt5vkVQngrqbXdvjKNLIFoeiWVv9iaSJ2hu7G8bYzi31F050LROaygUbEs1aM7TvJl4FZVARTqdtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751353920; c=relaxed/simple;
	bh=r9eNb2w072WvQ8hTLi0qds1C3mGmLZw/n+2hp5N2wPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h2K/43qZ/PD0U2T3prN+36s2CHRi/mqovLZdQJfr/lQt3mtJB87oqHPA4uYbB9P+4o5tf48btw/HlR4UqVS/dgLnO/zrmUWXSWO5n61/STDFYQfTn78AZIrOPvn+0qzFOMCymqWD33iz5At76mgLhj+9w1P2KTa4jfIwrM5JaCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Jn7H8vOc; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5612IZfh012666;
	Tue, 1 Jul 2025 09:11:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	pjEU9ubolXq6bNyzBdOl3AlCHglaTXh8+re7Vdnli3k=; b=Jn7H8vOcNMzX2slj
	XzBW1YVZpqYxreG+phG/EWQUK5cjaSMAFvyr4ircFjTLgeyKt/K/GVEr9JmSJ7H+
	sZ0DgzlhQ2WFAoKx1IXs9k4bktUtqGc18MBGdoNiEzPCWWQp4BZ/g7/rgiwwOVqT
	XzRf3NYqKYM60MspwnJpyyBGLV1eyk04Aa0O7UFWXEjt+mnlXnUHfHsZLqUPPS3v
	SHd2IL+MfukystmnC4Od8EGySAYy0Hv8ItD5EstgTqqcfEfG/0emb5z2TjW8nI1q
	dtQzGNLKNIXjV7wTNqjZ2nbXLW7YGFK62EuOBrnheoU3cLfAoh7QBK09MaokwTFI
	xRoIhg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47j7r637m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 09:11:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5F4CC40058;
	Tue,  1 Jul 2025 09:10:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8B1A5B83746;
	Tue,  1 Jul 2025 09:09:33 +0200 (CEST)
Received: from [10.48.86.185] (10.48.86.185) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 09:09:32 +0200
Message-ID: <cd2f6752-6d3a-4fca-93c5-70ad7529617f@foss.st.com>
Date: Tue, 1 Jul 2025 09:09:32 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: stm32: delete stray tabs in
 stm32h7_spi_data_idleness()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Alain Volmat <alain.volmat@foss.st.com>, Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <2033b9fa-7b0f-4617-b94e-7b0a51c5c4b1@sabinyo.mountain>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <2033b9fa-7b0f-4617-b94e-7b0a51c5c4b1@sabinyo.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01

Hi Dan,

Thank you.


On 6/30/25 21:35, Dan Carpenter wrote:
> These lines were indented one tab more than they should be.  Delete
> the stray tabs.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/spi/spi-stm32.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index 3d20f09f1ae7..afb54198bde7 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -1895,8 +1895,8 @@ static void stm32h7_spi_data_idleness(struct stm32_spi *spi, struct spi_transfer
>   		if (spi_delay_ns) {
>   			dev_warn(spi->dev, "Overriding st,spi-midi-ns with word_delay_ns %d\n",
>   				 spi_delay_ns);
> -				spi->cur_midi = spi_delay_ns;
> -			}
> +			spi->cur_midi = spi_delay_ns;
> +		}
>   	} else {
>   		spi->cur_midi = spi_delay_ns;
>   	}

Reviewed-by: Clément Le Goffic <clement.legoffic@foss.st.com>

Best regards,
Clément

