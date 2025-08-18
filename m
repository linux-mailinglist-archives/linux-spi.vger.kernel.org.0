Return-Path: <linux-spi+bounces-9499-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36B8B2A58E
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 15:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D91581F68
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68339340DB2;
	Mon, 18 Aug 2025 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHJOmxQo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7F340DA2
	for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523292; cv=none; b=mR1r9kOWJMp6/iXfIu1bcnqtrW4LRlqguyUaQDxYlkAzHQeCr1QADquSaf9MTeyUpTStKQfP7uffxKCNsbcLOsiVm65BuDK90P6WBEq0mQNG0VOalc5nGPuK2Z1u637F7Bv83JyTCw4B1m0/gjjk1xyDM7zxmAPOL2FPsPnKhkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523292; c=relaxed/simple;
	bh=+cKh+v4Cm+T1peei9b5ebp+8tJt6yVUSf7x8iARtLHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0Oi96oNDREeMddlZ76N5jcr8BJsCrO+V6QbwKltdR1kewDcRdG7lmhC366YJAyFmCQ36iut0B1Shacf8UH9M0qhCgkbxOgg+SCo+Jz2JpDl8NQ+imf7ZGrszUW71ZheZqOjRL+/agZAkhlgKjKnPijXDG07hbFSJ0TBgC0k4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YHJOmxQo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so21325535e9.2
        for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 06:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755523289; x=1756128089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHosbQ56I8nDu/Jz/4UBzucrPmhDO2H2KjGIBtWOyX8=;
        b=YHJOmxQo8LX3DQ6QZRMnXdmET2P1eqxPpqY5zoTtkzboIfm2XFXgWJcOkliK37ylib
         2qATDs7I5RWTciAELc323nPk3HJ1VNYvnyDHFtFhoIzADZcqJtidKPJSmENuRm0qL2Wz
         5X8MTXp3AuYg0xRGF0KydoEaLLCN5GEMm11mo1gLbxF0Y4romjlaWi9oBgCBTkmFUe2r
         8Ex7vvChkJFUcEwBBaOY9lUKwxjd5ZhudC2QH3fPfQLLzRYzbhCJ9jfV/bTGI+FlSmIf
         krmh7nAdxizJD+xcuIYlu6Fi9aL/aMqgmS2/E4Ye/fpIquSULJcWlYmQ5H6V5EKaCf/l
         KOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755523289; x=1756128089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHosbQ56I8nDu/Jz/4UBzucrPmhDO2H2KjGIBtWOyX8=;
        b=JDSGOCCSXuuC0+nKQUEPl5IEfhZE1JibaohZ9IKS+ZlnH/F4cnUdukeoZuBkRlNVxz
         KvHhjCAI1nPypepU7IYQB50ypcqkc4BwAexXd3tbEhn4KN1KqqUAp0XmX2O5nCgInMB+
         vKsAB1+WSDAXWgS+risc1sioR0Hi8SMWwnyXj4V3Nf35P9tFY9v1BlXR85HL1ojIb9Hr
         NHu4eP0nRhVlSZyTxQ/rGh4HoQH/i2NOY7hgGGv9IN1L7uRKesFDW84/xPiq5aHDE+UR
         gyyUCcLPEAvh/s8U0atjF/27aGZlA3mZOUPP0gVGcdSsKNBmseggDnElnc02N/si0LP4
         veZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/DMkjEMVnZD7XnS6ele/IVDmnB3N4kChc8ETDako6HO/XMGMu25g0aTMLbJUEo0C9SYMgA3JW4Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5LZBkco0IyUSY5slJbi+3HmJwobi+WTazvqH8IsVWjU1aYUiT
	djmY8AUFh6nTunk/Sk5Ud/WX0JiNVbDaQLmlmvM3HSTCJofDpjg/e5r31vsY8Zx5esY=
X-Gm-Gg: ASbGnctg8Th8++ovz6QKTYKoWXfaiORgeBcFtUpuaUcPOEOcZ2lkxh1I8ljkCNpxrqV
	KBnzvPpHJ5RN1aKSEJvfdW+LtG9vKAZVSb2GFkV1v3e0YCtecWCWeOPhXUO2xwGjwkgs0JOmXWZ
	NemZwZlMh/sLOjv4Id4myUSBtudR9tY0CJZDOnu/xIBftJ8Ql92zYJc8IikyDN/G84QAuVRhJSi
	EMy+m+Cq93SPHRwGpX4rL1iZeSZbV/UPxvJ06/xQ+HIY/PbK7Mg+CoeMB6AH+OgrQfG/hJR6nRu
	QlionjPFLxzaHk2+wYQgT9WT9phLp7Qq7lM6LwlmL27/aXyK3nklT4xqYjokuIJjZwAjQbmJay+
	0eTdYLnUTYxmHiGs6AIBil4UaiOk=
X-Google-Smtp-Source: AGHT+IHmQYSiITA4A2f3X+nYYnR5TguRUDLdC1f6m0CIICjfTIGcLFHLP+kZ1Fsg3j7tteqznpBIhw==
X-Received: by 2002:a05:600c:a43:b0:459:db69:56bd with SMTP id 5b1f17b1804b1-45a21839e02mr89031265e9.20.1755523288609;
        Mon, 18 Aug 2025 06:21:28 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b1db885sm108362605e9.0.2025.08.18.06.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:21:28 -0700 (PDT)
Message-ID: <40b29323-66db-492c-be00-71ff87f48d77@linaro.org>
Date: Mon, 18 Aug 2025 14:21:26 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] spi: spi-fsl-lpspi: Clear status register after
 disabling the module
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
 <20250814-james-nxp-lpspi-v1-4-9586d7815d14@linaro.org>
 <aJ4VpLhI+hZU+cpj@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aJ4VpLhI+hZU+cpj@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 5:58 pm, Frank Li wrote:
> On Thu, Aug 14, 2025 at 05:06:44PM +0100, James Clark wrote:
>> From: Larisa Grigore <larisa.grigore@nxp.com>
>>
>> Clear the error flags after disabling the module to avoid the case when
>> a flag is set between when the flags were just cleared, and when the
>> module is disabled.
> 
> between flags clear and module disable
> 
> And use SR_CLEAR_MASK to replace hardcoded value for improved readability
> 

Ack

> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
>>
>> Although fsl_lpspi_reset() was only introduced in commit a15dc3d657fa
>> ("spi: lpspi: Fix CLK pin becomes low before one transfer"), the
>> original driver only reset SR in the interrupt handler, making it
>> vulnerable to the same issue. Therefore the fixes commit is set at the
>> introduction of the driver.
>>
>> Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-lpspi.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
>> index aab92ee7eb94..79b170426bee 100644
>> --- a/drivers/spi/spi-fsl-lpspi.c
>> +++ b/drivers/spi/spi-fsl-lpspi.c
>> @@ -82,6 +82,8 @@
>>   #define TCR_RXMSK	BIT(19)
>>   #define TCR_TXMSK	BIT(18)
>>
>> +#define SR_CLEAR_MASK	GENMASK(13, 8)
>> +
>>   struct fsl_lpspi_devtype_data {
>>   	u8 prescale_max;
>>   };
>> @@ -536,14 +538,13 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_lpspi)
>>   		fsl_lpspi_intctrl(fsl_lpspi, 0);
>>   	}
>>
>> -	/* W1C for all flags in SR */
>> -	temp = 0x3F << 8;
>> -	writel(temp, fsl_lpspi->base + IMX7ULP_SR);
>> -
>>   	/* Clear FIFO and disable module */
>>   	temp = CR_RRF | CR_RTF;
>>   	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
>>
>> +	/* W1C for all flags in SR */
>> +	writel(SR_CLEAR_MASK, fsl_lpspi->base + IMX7ULP_SR);
>> +
>>   	return 0;
>>   }
>>
>>
>> --
>> 2.34.1
>>


