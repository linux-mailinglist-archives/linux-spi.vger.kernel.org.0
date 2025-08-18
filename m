Return-Path: <linux-spi+bounces-9503-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7998B2A8D3
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 16:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFE362694A
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 13:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B126E199EAD;
	Mon, 18 Aug 2025 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArxOw4lS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84F1E8836
	for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525281; cv=none; b=fEj3eTTnZ7dIdywvY92FgnnyYaYWK07kQOPnRiunnyLw0Y13bsUf4wYrB0NkCBM16v8BbK4K/1Z2gploZUE8mtVhFQaigIuTYvnFRC48Xh11nUr2L2qPIiePT1RjXAzlpRVPxHLwDjbz5T9H4/aCGw4IQmAAoBgmwo3Gm6+A3t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525281; c=relaxed/simple;
	bh=0hUvDxAeE7pM0L/uSr+rO+vIOw8U3fLyKq+FUQ9aY4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrVpIHLfW1nyoeeYDirAhvlvgXrEbvjopAdHA3t0G8nyKpUK/Y211NVfLIoKjD3JnpgHoakpzesi+Kzt0DEobMTxxNI4ZsMRi+pdpv98UfSjINrd6xUQJt3chMjcpfwiR/WgDQLxQlyaCkXnwUmN4LmTS+iy1LnTjcodx2C5SU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ArxOw4lS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9d41bea3cso4540760f8f.0
        for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755525278; x=1756130078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ajbb6uzJgO4JgEqQefnygZnHUM70xCyJcHToGkwu0DU=;
        b=ArxOw4lScpctX7HElRKvj1EpvQNImZ3Nt5qF/gOdk0mmImRfv2fpcCW9RXHiZVG+Fh
         aSmelL9KEdbP1FbZYUUmcKWWZf2RIG66G9X+Rp7v8RqyC6GHw4FrnkNSnBtsXh9KCPcY
         vSUHy/7Lgk9auIv8+W4ff8sZ1ZMXTyZBXqNbhpLUSP+CHobSY260V8XnAArE9yC4Qkmj
         iffTxpY8KheV39qYcSUizUga87a2H0Ga6prjXyTc0TdxkIzwsUNf6MW2obUzU2ROvExS
         0xLg4JQ6KKQvHDhed+eybxZM3FkGBqYR6h+FVzAmIID3NFrWisP90eb8lfgi4BQIV7Ar
         JMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755525278; x=1756130078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ajbb6uzJgO4JgEqQefnygZnHUM70xCyJcHToGkwu0DU=;
        b=H85UreOxJZLKqEqn8BJo5F/1poEUT0gj40LEVNGB3/2+lCffQgFvfPCr1hDpy9L7Eb
         1WgfeDn6uHRMGnfX8YXuvsDUXKXINzd0NBfeRwU2XI5hS0TZD09LiAPVxBoZ0xUgAp5N
         S5pcGAc+tfC21onTslSoCox9ysG1HeQ+5zjkDb2bdQIweBH9bzCSuX0r17YRVThc3O+U
         zVUGGJBUWiVR0RmmUFgbPgTz0uv/VDTsfLx/B/YZVIpjK+YhKyatwCWbqA/bbRqbFNIM
         Vgh2tZdO4jD+V9CgdsUxrV3fma2ovX6eosvOHyQUu4pf+zJcw7bDJJ03wvuFFPrIG4tj
         GfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnNEHSEmFV6RJ/otUrCvZOILEAu8KZwQ4/V4On04uD1Cawr6uZWZXhtHT7jN1z8BeGsJfQR6I0uw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLjcs3P42I3+oewncAp7zIUU59eCODRunIirUvt9/KqWH1esST
	1v/Rijuqq/mQ4+SzfGCxkr5R9IgvoJmG3GTc2hselZh2qN5oPiI+2+sKFXsls6CCv9w=
X-Gm-Gg: ASbGncv+y4BMG5rLEudppacbq4hSjtSd4JL6cQ+n65dHE2KruJnGsLaacUR+GKNX/bE
	keD5+e6JPzNyqRytLNQnmjK1kcdssM3XpevoKRIQmyqt6z7lUrZY/4jeBbyILYFdBwAeSujzJ/A
	izyJ4Cxuj9zO1bDltnU2MkAGEWQE8R90213L1DsvcEQ2OADbVDEFErBphxCMn3zlRXFnV8Ii5oQ
	6zhPoooLsxcs1KQkd/DSLPGJJtcZed6FI+E1FUYNk3sWlvZ0QnwJB8LoNFXFQ0p1UFrxLBGWYxg
	e/cd81XzuCvs2kIa8WYGSrSBqCdxN/+mWddvMa+O1A7gPykmITKhjSfIIdSYxEp+Azkh9LJ1fG/
	SzNrgVmuqw4Oz+W++e+qsGic5hdg=
X-Google-Smtp-Source: AGHT+IFsqQPe2NKcX8XP+TiqznD4ogEZ/CDbCC23S0D8qqY54BvYFiH5p+gzA/UnoS6QDPc9lUMMiQ==
X-Received: by 2002:a05:6000:2408:b0:3b8:f864:2fec with SMTP id ffacd0b85a97d-3bb66943367mr9469963f8f.2.1755525277815;
        Mon, 18 Aug 2025 06:54:37 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bc5e232534sm10596525f8f.24.2025.08.18.06.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:54:37 -0700 (PDT)
Message-ID: <7c4cb21a-e1ea-4931-9b51-91cfc8217155@linaro.org>
Date: Mon, 18 Aug 2025 14:54:36 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] spi: spi-fsl-lpspi: Make prescale erratum a bool
To: Frank Li <Frank.li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Larisa Grigore <larisa.grigore@oss.nxp.com>,
 Larisa Grigore <larisa.grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-8-9586d7815d14@linaro.org>
 <aJ4sktG1NoMPu5wZ@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aJ4sktG1NoMPu5wZ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 7:36 pm, Frank Li wrote:
> On Thu, Aug 14, 2025 at 05:06:48PM +0100, James Clark wrote:
>> This erratum only ever results in a max value of 1, otherwise the full 3
>> bits are available. To avoid repeating the same prescale values for
>> every new device's devdata, make it a bool.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-lpspi.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
>> index 332a852b746f..1013d5c994e9 100644
>> --- a/drivers/spi/spi-fsl-lpspi.c
>> +++ b/drivers/spi/spi-fsl-lpspi.c
>> @@ -96,7 +96,7 @@ static const char * const pincfgs[] = {
>>   };
>>
>>   struct fsl_lpspi_devtype_data {
>> -	u8 prescale_max;
>> +	bool prescale_err : 1;
>>   };
>>
>>   struct lpspi_config {
>> @@ -144,13 +144,16 @@ struct fsl_lpspi_data {
>>   /*
>>    * ERR051608 fixed or not:
>>    * https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
>> + *
>> + * Devices with ERR051608 have a max TCR_PRESCALE value of 1, otherwise the full
>> + * 3 bits are available (0-7).
>>    */
>>   static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
>> -	.prescale_max = 1,
>> +	.prescale_err = true,
> 
> I think prescale_max is good and clear enough, you can treat 0 as no
> limit for prescale.
> 
> Frank

Ack

>>   };
>>
>>   static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
>> -	.prescale_max = 7,
>> +	.prescale_err = false,
>>   };
>>
>>   static const struct of_device_id fsl_lpspi_dt_ids[] = {
>> @@ -329,12 +332,11 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
>>   {
>>   	struct lpspi_config config = fsl_lpspi->config;
>>   	unsigned int perclk_rate, div;
>> -	u8 prescale_max;
>> +	u8 prescale_max = fsl_lpspi->devtype_data->prescale_err ? 1 : 7;
>>   	u8 prescale;
>>   	int scldiv;
>>
>>   	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
>> -	prescale_max = fsl_lpspi->devtype_data->prescale_max;
>>
>>   	if (!config.speed_hz) {
>>   		dev_err(fsl_lpspi->dev,
>>
>> --
>> 2.34.1
>>


