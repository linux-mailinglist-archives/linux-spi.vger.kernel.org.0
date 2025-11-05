Return-Path: <linux-spi+bounces-11045-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A11C36996
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D91643FAB
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 15:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ACB328B79;
	Wed,  5 Nov 2025 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGJdaz1Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28005221269
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357442; cv=none; b=Zf5vDtVkwQUaD6znKXJod/WLKiW38hJiW6uYMlhF6dd44gQ9PuH2d9eqZWg2c3WEaMHdcLpWNqn6foerCpq6f0ymfWB12fV0XKwTLKSvOCWr1IfNIUkzo8ZUI2JwoXGxFCCDFtIluj8zhCGrlKpwV50WzvShMy4gnbcjOgOJku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357442; c=relaxed/simple;
	bh=sCTIQJdNjjajAv8x/JfOJ97BJ2l4jqRvj4Dollk9KWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeIBlFpjbuu/cpY1EvCywCO+6iWGfpuDswaqlgbtTSji94y5OVNKYv66WqD2y8zd3UD7A1SWL6JcGe4k5tufW0HkJq7oqp0kvv1VIK5Rc31KSf6JfiYX/pZ48dcoF6xI7FHGV7kBSeCkoBYyNPqwu1wV+bnAE5xXLmMd6Ynjroc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zGJdaz1Z; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b719ca8cb8dso446991566b.0
        for <linux-spi@vger.kernel.org>; Wed, 05 Nov 2025 07:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762357439; x=1762962239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSVtmYaRorpLg3ihHdyCGNJLkC8P7NNl8FUvIMwjsNY=;
        b=zGJdaz1Zg9tc+ro2vdqsNCQWmgo/lkindTPd4ZPGMQDcBqCS2VyQik98ntMyGQMaEl
         jIRpBZZjib9N1IQKHb3f0dtBidc8eYQoMzcKFPOGpvQujsFdOgCExQqk5aGQe6cP5BvO
         L4jLDVmrbdg1LpG2zAlhvHBirXCNUMK1vWOyZLtCGSy7EyBhePFvu2JyBLCT9kFYFkfp
         v0XZ1lCLBfDPxttB9jLevnwrn9Qr4b63RQixJEt6GWU69IEyT5nPrP440GFXhKO7tiHJ
         1vQTC+3O/SfCwqeBIYVUeSFc+men3Z7Kvuqm9qAAH9aymChbLsnGVwrbo4G2Xg6GcKnH
         oWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357439; x=1762962239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSVtmYaRorpLg3ihHdyCGNJLkC8P7NNl8FUvIMwjsNY=;
        b=Cp3sgw43Ox4QTI17+uL9ieNms11YaKH2A2cCUlzdsYm0zN2coC3xJd83uFcWsZmDKB
         vEfX/Qqfii6NgdImf6H/zGNjAcLO39FBEBhV5grKlx5jVgjLnPv7im63Ncn1rghBCVX2
         4i5QH7vKDc5EgNmrfuI2DOoudUGdOh/QuSIkIMGtWi6XwWaq+83agqPWTQz96gB5nMdv
         TjpFLSAMPb/l1CQq2iMKzvA1avoGL7aivOoOr/PRbVMwTjnPZnyIVWJDGPM/JAK1rXd+
         sOgOlpZnTs6OEhQLsBDQjziK9BLiJ8mYK0XWr0ou863UwL9JEyMhPxXU9c9jWwKV9trJ
         z1kA==
X-Forwarded-Encrypted: i=1; AJvYcCUY8qKUK+7M4lXNXM6opBsPZ1CT5YjiY+fhpbMg9zu93jKfSRyIYmg/nxV+FULlIqhk8tKL3J5XT7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgqBXe2x/MsbYUwcrsWqZB8o8W0/cWg4RhzCZ/z++XOGVA7zP4
	vGwPnhnXMBECip0airc35uogGwIcPWHAHa28zCorky25iDMSxElzGhmFfhJIadV+ayw=
X-Gm-Gg: ASbGnctUnTnk1bzpPhbRBs38e3yBPwts6iJ5V8nMuQ8mNWS8VbGoClB3VUPeIacTNgU
	qFfa0IG2N3LrnzyEQ2XWOjvpyOuBFu3WmBDEdIrfHNHrDoRqC2QunvusL/oryFtWOTdWKq/g0UJ
	ELe5KJxmy7ro1grmqq1j45Ur6Uh2xd+OJuAvis1wOdn8n79zCYwzvLa8cZk1TOS94ykZmJ8zOUV
	1Y/dxt0dY9cnDJql9yzZH28YcojYSTQCdyMScyki/p4/8c2U/VCBBBCSIwS0kbno7ROpNKVnDB6
	wC1cWWoydsye4q3RmORVaQu2WepgxXVnes41LCGTqffyUGmCYclZFDt1CH8SvRDXwzsrou+xiNo
	gITi5aEjqe6Ttp/CjzDx6I+NYxlULF+uu642TzSiE1nritENMFZ/IFAIPWzbL0eCceAFpcHObC9
	6E5Ky3lH81fXPt0DCqYyXSw9c=
X-Google-Smtp-Source: AGHT+IFa7/X97763xpJ1l9X3Sq82I4dFTfY6YWJOkY+3Eh/I0wcCHNCHX/dwcVa4BdzknLf2omKPmA==
X-Received: by 2002:a17:907:2da5:b0:b42:f820:b7c with SMTP id a640c23a62f3a-b7265586f9cmr328010166b.41.1762357439537;
        Wed, 05 Nov 2025 07:43:59 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f8c5bsm514160166b.20.2025.11.05.07.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:43:59 -0800 (PST)
Message-ID: <0be97b27-4f8b-4d22-a653-154e87ecbc78@linaro.org>
Date: Wed, 5 Nov 2025 16:43:58 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/28] spi: spi-mem: Create a repeated address operation
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-2-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-2-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/25 6:26 PM, Miquel Raynal wrote:
> In octal DTR mode, while the command opcode is *always* repeated,

this info is wrong: opcode can be repeated, inverted or a dedicated 16bit,
so please fix this to not mislead readers

> addresses may either be long enough to cover at least two bytes (in
> which case the existing macro works), or otherwise for single byte
> addresses, the byte must also be duplicated and sent twice: on each
> front of the clock. Create a macro for this common case.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/linux/spi/spi-mem.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 81c9c7e793b6ab894675e0198d412d84b8525c2e..e4db0924898ce5b17d2b6d4269495bb968db2871 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -43,6 +43,14 @@
>  		.dtr = true,					\
>  	}
>  
> +#define SPI_MEM_DTR_OP_RPT_ADDR(__val, __buswidth)		\

I find the name too generic. This is an macro for 1 byte addresses, right?

> +	{							\
> +		.nbytes = 2,					\
> +		.val = __val | __val << 8,			\
> +		.buswidth = __buswidth,				\
> +		.dtr = true,					\
> +	}
> +
>  #define SPI_MEM_OP_NO_ADDR	{ }
>  
>  #define SPI_MEM_OP_DUMMY(__nbytes, __buswidth)			\
> 

