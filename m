Return-Path: <linux-spi+bounces-8468-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED31AD6BE2
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 11:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673EA1886E07
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF4D224244;
	Thu, 12 Jun 2025 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ovwOcZGv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809142248A4;
	Thu, 12 Jun 2025 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719571; cv=none; b=b9Jp3JDOm68z282PbUMPRMU/Gcaqx4YAi2F4ye3MQ2+aGVa1J7WRIxIdklU+l26JbAz90NSysMiE5pazZeGxa5TwMZG8q9uvyGatryx6bgLwI/cStlh9Tbp2z1H/tQ2zkT8/qLuXUd96QUGXgqxiTGh1+5jbFozetZyLspfKPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719571; c=relaxed/simple;
	bh=42E6E2A4Ymy9vC+ni9OnFExuqN/KM0INPI6sbvhyP/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hR6BOSsfV6+FzscjSmrklw67jel6x8k4DprWW8xp3YvuHct1coRQ4nqkgnY2LwGmw4aTT99BZnGqKnTg/riGYHaEHC3d2raaX1Mm6zJxL13utMNq+ScABfdHeuk1AAEmu+jYMVILqBmPVbPIwQxH4yTkLNn3kgV4NDHunL1Y8qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ovwOcZGv; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C93cWv004497;
	Thu, 12 Jun 2025 11:12:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	k4gTnAusbtfL5G0grnWGEElF552MerFrkX+8ouuadF0=; b=ovwOcZGvVZO+1lK8
	pwGai2+7sgumZ9z7lixxIQdKouskKxZyNisYGGKx2ibHkV7KU+T2BW5ewjpdZ4PG
	g92OxE9AH0lbYtHM4Di29+naHxN0/2LQuJzzItlndQCP4P6R1jnqjBUHg8j9rnSI
	E8aUzlcKiyAeyEXg0pXGC8Gdav+n93DLCf9u9zcp/GWScF94I60S4wJjbSc/deuZ
	5A8zGO6f4kn14VLnpel7Mwu9Kkp5zI3UJNgH6yUwcU6g5w21zWJ4Tn+JRyQbQ8O1
	iaUc/K6zYN4xgRUCnghOdKXp+Irc6WizD32L7lR+YF+RE2x11hnDqvYyjzj70xvv
	QC9IgA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474ajaegp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 11:12:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 51E7840044;
	Thu, 12 Jun 2025 11:11:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B23985C820E;
	Thu, 12 Jun 2025 11:10:44 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Jun
 2025 11:10:44 +0200
Message-ID: <11dcec73-8e29-4139-bddf-4b63de3f9aed@foss.st.com>
Date: Thu, 12 Jun 2025 11:10:43 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] spi: stm32-ospi: clean up on error in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <aEmAGTUzzKZlLe3K@stanley.mountain>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <aEmAGTUzzKZlLe3K@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_06,2025-06-10_01,2025-03-28_01



On 6/11/25 15:09, Dan Carpenter wrote:
> If reset_control_acquire() fails, then we can't return directly.
> We need to do a little clean up first.
> 
> Fixes: cf2c3eceb757 ("spi: stm32-ospi: Make usage of reset_control_acquire/release() API")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/spi/spi-stm32-ospi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
> index db6b1cfc970f..4ab7e86f4bd5 100644
> --- a/drivers/spi/spi-stm32-ospi.c
> +++ b/drivers/spi/spi-stm32-ospi.c
> @@ -937,8 +937,10 @@ static int stm32_ospi_probe(struct platform_device *pdev)
>  		goto err_pm_enable;
>  
>  	ret = reset_control_acquire(ospi->rstc);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Can not acquire reset %d\n", ret);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Can not acquire reset %d\n", ret);
> +		goto err_pm_resume;
> +	}
>  
>  	reset_control_assert(ospi->rstc);
>  	udelay(2);


Hi Dan

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

