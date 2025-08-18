Return-Path: <linux-spi+bounces-9498-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF1FB2A4B6
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 15:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C892C4E31A5
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 13:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B8F326D79;
	Mon, 18 Aug 2025 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tlJjuuPx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCCF326D44
	for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523081; cv=none; b=C6WIkGu884jp6jVNqkON3wnxjpgmFYdt/xgxMUiFjndnx+c4cepRlTV9AcT5/B/RlkeoZi7ijl/oOikgAGr6QOAz1/X6dYaoykWG7AU9FVm6wIGOzAVwrICkXQCXfNDdbQHHZSfLNP8fL2vk0VcWnrWaAlxxvCBjru1cbUY7V9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523081; c=relaxed/simple;
	bh=cN2Dr1U3N+epcvzyenIo+98wH45Absd+P6IxmKwk8T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUgvD9Wse+8ccEJvbzGw+5VPn+EEpSnmp2pskYpkU9tO6VsTb0gO9pzzRH+xXy7Hkmev7bdD90WD7zjy0cEMZ9kHkSZWkWV7RYUBAIPQIIr4GZGtTPzuzEcm5mGM0WFCSEMI+7W+htinBfC29kYUATtbYpvUog6oF2pcD3Bba3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tlJjuuPx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9df0bffc3so2861230f8f.1
        for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755523078; x=1756127878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WD8JY7wGfENB2vQCzVFhM+JL0GSgqtbytlovzqiUGn8=;
        b=tlJjuuPxNwepZfdmjXoNY4VnN/v1dTsY5AM8fn47PXalgMEcIAE7hhRxeBRe2ir7u2
         i/IZzVPRRG5GKgGpuvvYIWn6PK5iHT+u0p67MU5uZDXjYMntz4+pavUZ+x38iS1mFmv/
         aj0Ra0HlF+9HliokS3z2g+roDkocQ4CkW+fEQYWjNuw8ka3OQUBGWMn88BPYrIbHDsR5
         7iwk1ADbrcK/FCEZnsflDyO4rIITBf/ULudCgaXrN4cpCdJypT/P1rXNm1tUI1XhRI1i
         VMrk7qvNqFIoS5JCrnNlz48hsZW4NEd4SHt2T6JXqaWiZ3/AQgMqVV7lEsDUfliy5KKz
         /kBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755523078; x=1756127878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WD8JY7wGfENB2vQCzVFhM+JL0GSgqtbytlovzqiUGn8=;
        b=bJlBOz3yiyJ0JtCI6490gJ3vaWZlwDmI24TqtH5QqtqtFspNBuxzHVVZXGOY6aZQqW
         aRuaZ9+anfKTf03yMfKpUf3z6mYFIuEQFHQJFVO+A/zLEj9J6j1gKtSq/v3EE3sq+30T
         I4wlM70B0oBciHQ2b/ug6aEfdB/0G1qTjLgUqh/qvUHtRJNJdwjVsMIvDr1PUwufrf5a
         r7nLEfh3dfY7pJGb8h5j3B4/wINasDpuAr8zrGFmomDsw/LEqwlrkm+dwYQrkW73Lo1O
         NIB3ck4B5R2y+SW7wKRqxUCjs9aV7XBVbPsnSJWqKjLOnpLl4+p6C+GPbpFDCbRAJB+h
         Zw+g==
X-Forwarded-Encrypted: i=1; AJvYcCUJmP+nGQa1cunxwn6dUdEHqBiPYD5SEGIqRq5sxzi4uriUBZTRUgDaRdhAXxPPYTqdI9m4quCamqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhACqfVfNDV+xZ/OY1cmacknw6yqwuDHepUboPTCkp/EphPjaZ
	Z94hhSBkE2Fb+n24xH42iNrvNNhIvPBWENpBPHIOB0Lsh8wOZs0Aa89WEvTH+vH6nGI=
X-Gm-Gg: ASbGnct/4c+OOV/7Ukw0OeW6HSD+JO9UdS9ofkAAFWUaap1h1JsbDgIaoaeEfPtlGph
	AeINN/0GyDYaIpMk+/ZKnKiSP90uGDBMcc+BFydnw8KKSa79plPfI5fkRg4YQnkJZqbObOvYXQk
	HJUfhpr8W8lBH6B0u9DP1kQwKqxNi6puvI7YoPoGQU6hUEclBRM3lNl5A3PIasOlGCxaDRfk/zp
	kAegXMzROOVXWDoQ3s/DsAmk8DTRJKV69AvkbPTfhFrwr+H8CLCz/GbIFp9JL+jzFI2RI77kV21
	jUecZ17tE2I6m9/tUyzelzWeC07x6z25iZ3wV8g4ZgurdPQ0pqaJ+9kLnzuIhJBPtdr8JNmhl2y
	AAfCFjM73PWPPIaPVZbzws9w4eWs=
X-Google-Smtp-Source: AGHT+IFJio5fCS2fBNF+0hXuSZxnS4K+PQVhd5zP27O8GnG2aQ92KmNgjsK/8qAhqnk6lalVTMRMDQ==
X-Received: by 2002:a05:6000:1a89:b0:3b9:717:4bcd with SMTP id ffacd0b85a97d-3bb68b0d589mr9121216f8f.40.1755523077542;
        Mon, 18 Aug 2025 06:17:57 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22321985sm131021375e9.17.2025.08.18.06.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:17:57 -0700 (PDT)
Message-ID: <7bd5e0aa-c7fc-4c3f-9e5c-998a1d4f5703@linaro.org>
Date: Mon, 18 Aug 2025 14:17:55 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] spi: spi-fsl-lpspi: Reset FIFO and disable module
 on transfer abort
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
 <20250814-james-nxp-lpspi-v1-3-9586d7815d14@linaro.org>
 <aJ4UH8fSWGODwnmO@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aJ4UH8fSWGODwnmO@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 5:51 pm, Frank Li wrote:
> On Thu, Aug 14, 2025 at 05:06:43PM +0100, James Clark wrote:
>> From: Larisa Grigore <larisa.grigore@nxp.com>
>>
>> In DMA mode fsl_lpspi_reset() is always called at the end, even when the
>> transfer is aborted. When not using DMA, aborts skip the reset leaving
> 
> Nit: s/"When not using DMA"/In PIO mode

Ack

> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
>> the FIFO filled and the module enabled.
>>
>> Fix it by always calling fsl_lpspi_reset().
>>
>> Fixes: a15dc3d657fa ("spi: lpspi: Fix CLK pin becomes low before one transfer")
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-lpspi.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
>> index c65eb6d31ee7..aab92ee7eb94 100644
>> --- a/drivers/spi/spi-fsl-lpspi.c
>> +++ b/drivers/spi/spi-fsl-lpspi.c
>> @@ -734,12 +734,10 @@ static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
>>   	fsl_lpspi_write_tx_fifo(fsl_lpspi);
>>
>>   	ret = fsl_lpspi_wait_for_completion(controller);
>> -	if (ret)
>> -		return ret;
>>
>>   	fsl_lpspi_reset(fsl_lpspi);
>>
>> -	return 0;
>> +	return ret;
>>   }
>>
>>   static int fsl_lpspi_transfer_one(struct spi_controller *controller,
>>
>> --
>> 2.34.1
>>


