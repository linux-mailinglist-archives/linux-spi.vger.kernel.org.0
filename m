Return-Path: <linux-spi+bounces-9502-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E431FB2A7FD
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 15:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAA3627927
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA59335BCB;
	Mon, 18 Aug 2025 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aH7Emne3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2533335BAF
	for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525040; cv=none; b=EP98R0ZclmwTcz/uXWGnaCHS9kaqQ4NMp9Hrv6le9WN9oMGDEZxnbu4kD9u80dL5WlhbzrLAiED7vHyX6P2nEXo+DBM3CSHsfxf86DLArfIcZF21OsCog/2MPMTWfMKl4OZV1UD5pvohmtnl9yM5HBTgaVvD2aF57p6h+kB2af0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525040; c=relaxed/simple;
	bh=7yHgSWeRbcyIHbjLHLnRwx4d4C71Zhhg/Zdke7nbkOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXeb5g88b5aX6IdYdeHQd1w/veyYIv3Zds9lEDDIYXzkdkJaW/D3QFhoWegSaAvPNLcxstYXCbA8HIG0FMKlv6nLlpoyznBW8x47+vGngHxPaashnwi+jGE1n1dsvvxCnmukTaSc8e+/SDG+BvLeizNie6isbzY80vmMmEinTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aH7Emne3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9d41bfa35so3655265f8f.0
        for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 06:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755525037; x=1756129837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DVVUnvtZO4/Z08Z1SdfbMyHejdi9PdhiDncUyyHKx0=;
        b=aH7Emne3U+UkgKJDzVJS7F6bcfdWp/nQxhcWitu9crpnm1ipo8o4CqXyUqL4aWNWXv
         Zp/xALcU11IRJLUdRKMynxrmQfpmc5snOYkiqz0gCKmnu9wIdzga7fZPMuwR6cxKmFT1
         1L/NQHQLur5ltp6HPU3H+zXmpauLVEuCGq/6IkD/4o+53XoQDJ6P8IXuzgd/EJa9u5r8
         6MWQ8Rs2VYPgPcCTP8D6NJOwmjaOneF0tY/11Fj/V976tAZYS+cLIlpw0RXgFz5X8TSF
         GTz5hNOoNG7Zmu4Lef4lWio1AN0T4AwubR3DGWoEGZ70D7ZkCke17vxvUeJ7QgmZ4NVm
         w1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755525037; x=1756129837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DVVUnvtZO4/Z08Z1SdfbMyHejdi9PdhiDncUyyHKx0=;
        b=JxbZ28d6Ri9h48/kjxPTpD7/9tGN6A5AxdDc/dvz2FXOKcEzHph5RlL+hoNooY63HK
         ECh2goTAlpAISpdbsp9Swj6175un4/z4gxXUGftFQGV/QhaGLz52gxJqpgM6sYiN2UPz
         HgpVqZCQLeMB51fSmVdDcc1trEhN9Pb4RdJhAjMuq5jLA6tQshUnLQUCW8xh+4k7dTMw
         OeL1Vfs4l+tT06oEkrj5UyMmX3W88e0yGgLZnRNyecZJfjfY8znMlqaQCxxYER87m+aL
         eOolRfsVJ9aWpVap6E5IJnmXME0pDfokqadrPT51mymN4FtVIItCpEJx0aTkOAfq3s34
         AHrg==
X-Forwarded-Encrypted: i=1; AJvYcCVwIhmcjvi//KGG8IkhN9+bxdHfcOmSexzUMW95svJZBUxfdugJbf/kKyX83zQPwcVlWUxLHdQKw/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZuRJ7We3dpPehXW0/hYtPOGoHZgkFPjutlmPKtBbfLLG5egNn
	IZ8wRL5i+5FGX1jKPnbc6XwxKRp8GBdGFssUIEdkBEUyanRoB78TdTYe3xuU0jgTVjI=
X-Gm-Gg: ASbGncvAWuhVEeUAZfCvPwFFoSI4LbXSILxtYrQY4FLjfqiqVrknPxrzY2IYuqIup/x
	RRaoxoHS6NPeqvQaLdKOPMjijWVK0/DCHYdmDhLUihGPoUDOZBMEy+F21c9MpzRRGrZDOFjhG7T
	ZhVnmLkmo0RKaaf53iDKjJz0cPflIQpRuWaPCQNd2n5ujaSG9tRcc4Lyvn1F5m0WeTYLeMIg3hs
	YqnyRL9Gf7DQwOuUHAXM65w+nTzilE204Ro+IWn5Zwgr2cxgGTjjzqLBDszMK62MzZ4Ot9PBaFU
	MZahWrGU12lwROUegWQKFDsvANmwi1rvColdNY715RLTN71bKOaPAKiEbfDSKzn2lfbVC2d9wKO
	XZvilgGKTbjGHdmvCXIJADSLbSrA=
X-Google-Smtp-Source: AGHT+IFYGhlIbmElePo7wESeoOURpi8z/foNFggrXzWJl9Ckz2bQUv6UqjNpy4xJdPri66mHTNKaFw==
X-Received: by 2002:a05:6000:2886:b0:3b7:8d70:dac5 with SMTP id ffacd0b85a97d-3bb665647dcmr9959991f8f.2.1755525037164;
        Mon, 18 Aug 2025 06:50:37 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6816ef48sm12603170f8f.58.2025.08.18.06.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:50:36 -0700 (PDT)
Message-ID: <a1e7f857-79ec-4cc3-ac64-0f1f43efb7f2@linaro.org>
Date: Mon, 18 Aug 2025 14:50:35 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] spi: spi-fsl-lpspi: Constify devtype datas
To: Frank Li <Frank.li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
 Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
 Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Larisa Grigore <larisa.grigore@oss.nxp.com>,
 Larisa Grigore <larisa.grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-7-9586d7815d14@linaro.org>
 <aJ4tITKLkfto1ltJ@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aJ4tITKLkfto1ltJ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 7:38 pm, Frank Li wrote:
> On Thu, Aug 14, 2025 at 05:06:47PM +0100, James Clark wrote:
>> struct fsl_lpspi_data->devtype_data and fsl_lpspi_dt_ids that point here
>> are already const, so these can be too.
> 
> Add const for all devtype_data.
> 
> Frank

Ack

>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-lpspi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
>> index 98da6a5d7013..332a852b746f 100644
>> --- a/drivers/spi/spi-fsl-lpspi.c
>> +++ b/drivers/spi/spi-fsl-lpspi.c
>> @@ -145,11 +145,11 @@ struct fsl_lpspi_data {
>>    * ERR051608 fixed or not:
>>    * https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
>>    */
>> -static struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
>> +static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
>>   	.prescale_max = 1,
>>   };
>>
>> -static struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
>> +static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
>>   	.prescale_max = 7,
>>   };
>>
>>
>> --
>> 2.34.1
>>


