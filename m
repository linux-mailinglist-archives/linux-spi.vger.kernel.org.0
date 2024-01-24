Return-Path: <linux-spi+bounces-692-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498A283A581
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jan 2024 10:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D231F22CC7
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jan 2024 09:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28B317C79;
	Wed, 24 Jan 2024 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAOGt6cj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486F817C67
	for <linux-spi@vger.kernel.org>; Wed, 24 Jan 2024 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088752; cv=none; b=JKSi9xiTIU9135MGUIHDPBispbjqwm74Kjbp+I3yO0HXxcLpdIA0HhEV0GtJLZEaGnhkK7CCWUz9F+nVnKHiibXeuKTiXKLAiQRGQLhp13tKv6JgIMsjlVi4OsE2JS4iTFPV1nJwkKw2F0uacha+F513/F13GmkAjNDT97gsneA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088752; c=relaxed/simple;
	bh=tQZcL4ECH37EQ+/arRmR7zsnjElJNaWdgCWP0n4ZebY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3cpC4Lbcy2dSXJxDhzq5OfE9tk6MbnjaqoCLpHG9ON8F2SboVBPMGp2Lm76tdNvs7KCe1osCFBeeUkrLPDotWSY+8cnBC+H4bXS8liak+KU33tDZ983jboDXowNdy4/QDtO1oWXIzFneSNyO5FI/spIV2xZLlRon1CF1s9VDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kAOGt6cj; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3394446205dso1341373f8f.1
        for <linux-spi@vger.kernel.org>; Wed, 24 Jan 2024 01:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706088749; x=1706693549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tL5YthdDbTwVS72RyvMOT0Z4mTu9jQloyjam4JQYcjg=;
        b=kAOGt6cjAkP2bGS9oXFtiOjMvWLrhUvqeRDfvVVYQBH4YMVHEk77aPfySYLn8vqoJJ
         aD09xDgl/tWHzefceGuHeWZQVLJpGa/rulOzi+Xa8PHI8U2zk9hT6hAxpLb3Jw/l0CrC
         3X1bnm+aaWn5VOUnLokINr0sobrM0fYrjI/C/rqnAtue2sGlokJll7W6h6FJ7DbPq/yu
         SGid9pZOOMFtKk/F+mFGubYpdN474BeQ2ILZbeJ4hu3z2osyA8og9YeXkocr9wbOKvQ6
         iAgLAhEfXiPi4aMGsZm9YOiuhabTOK0cEcEeeBp7Z6V9kwiq6mFq6dS4pzo25UfPWGHk
         zXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706088749; x=1706693549;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tL5YthdDbTwVS72RyvMOT0Z4mTu9jQloyjam4JQYcjg=;
        b=VMaWE8wQVsGPRIkIbz+weeD6kxEKABcT/3F6pbB2b5Vm+bxPhhSE3AuwiZ/q6WOszb
         7XWBsQnm8LXrE2oQ2LK/H9outQ3VuQj/iBRHjbGbDve3LKro74gOKyhcSQeRxDUxXR/w
         7fGF8/ZENn3m6epO3JNR3hny6xIEN7tkjTlWZJpaup398B4OKSzZi6nE6VSRDWA4hxar
         bS1raOBb8FMvIH15SvJTAj6u3fwjmIWvkMk72Q+CZ+ZGUwXcCOy1HxtNo5Q0JL2tj3cT
         tp83JHZb3m7TBZjQnmkC7V9/R9o8e4sowjXjFAxHOG8NKiQrbEmB1m9YDZN5LV/soB+W
         w71Q==
X-Gm-Message-State: AOJu0YynTkK3gSP0vEXSJP21HZmnaWTq0MkHeHXLK8/ekE8f9ZAm55+R
	kerpWo7VksEAWhOH2bQ6PuPd9p6K4yVMn1YvTZ+Dm+oPOYm73NzQLuv35exQK20=
X-Google-Smtp-Source: AGHT+IEqvRy7K3CShIUckMyawpSPAkF298SYtjKe6/q+h7oDCvciREplxoVcHybuTBb0Nb3hbWYHYw==
X-Received: by 2002:adf:f8c6:0:b0:337:c4c2:8141 with SMTP id f6-20020adff8c6000000b00337c4c28141mr307062wrq.35.1706088748867;
        Wed, 24 Jan 2024 01:32:28 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id d10-20020adfa40a000000b0033953f87085sm217636wra.35.2024.01.24.01.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 01:32:28 -0800 (PST)
Message-ID: <8de1c6c5-e86f-40cc-9650-efc2c581b221@linaro.org>
Date: Wed, 24 Jan 2024 09:32:25 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/21] spi: s3c64xx: move error check up to avoid
 rechecking
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, peter.griffin@linaro.org,
 semen.protsenko@linaro.org, kernel-team@android.com, willmcvicker@google.com
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
 <20240123153421.715951-9-tudor.ambarus@linaro.org>
 <4b8bc0bf2f1fd87183276816522e92f7b0c3b1fd.camel@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <4b8bc0bf2f1fd87183276816522e92f7b0c3b1fd.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/24/24 09:21, André Draszik wrote:
> Hi Tudor,
> 

Hi!

> On Tue, 2024-01-23 at 15:34 +0000, Tudor Ambarus wrote:
>> @@ -538,13 +538,8 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
>>  			cpu_relax();
>>  			status = readl(regs + S3C64XX_SPI_STATUS);
>>  		}
>> -
>>  	}
>>  
>> -	/* If timed out while checking rx/tx status return error */
>> -	if (!val)
>> -		return -EIO;
>> -
> 
> This change behaviour of this function. The loop just above adjusts val and it is used to
> determine if there was a timeout or not:
> 
> 	if (val && !xfer->rx_buf) {
> 		val = msecs_to_loops(10);
> 		status = readl(regs + S3C64XX_SPI_STATUS);
> 		while ((TX_FIFO_LVL(status, sdd)
> 			|| !S3C64XX_SPI_ST_TX_DONE(status, sdd))
> 		       && --val) {
> 			cpu_relax();
> 			status = readl(regs + S3C64XX_SPI_STATUS);
> 		}
>
Oh, yes, the timeout in this block. You're right, I'll drop the patch.
Thanks!

ta

