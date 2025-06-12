Return-Path: <linux-spi+bounces-8483-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953DBAD76BC
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 17:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD79189008C
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8CA29AAEE;
	Thu, 12 Jun 2025 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RIWSgNLx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073B429AB07
	for <linux-spi@vger.kernel.org>; Thu, 12 Jun 2025 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742663; cv=none; b=GqaWp4y0fp0lX+docMrkuA+iwg9kdwc28UnJdZhpovTYO8GsjjUIG0udSL4GpAI3MUyffz/pShVuOXrVYf1MtFRZvOVNFNT82fiILw/5/7Mps0c3exgelC5llqLCxP52AjIzlTCEA1WjHTN9PIzo9JSYT0cytLNWCfu9VVh6I4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742663; c=relaxed/simple;
	bh=z2zBLVhAg3p3R67jfYWg7Qs+bluv2nCq11ZiAgcv6A0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=re7C4fQK3Vs4FEmo1Ws3vTLjb7MzZ+lyr2dDIQ0ybsjmmtgeb4hBRQ8LQFtyCUCpP5O2qwGs4Ay/6e3dYJVetldDA+di6r6/U6d9FYxZA452BS8t6b4sZ9qS9asEXkAbYX/Op1Nl2e3ifTVC8TQnGKwraop6An4FyA4A4jEkC84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RIWSgNLx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so13589925e9.1
        for <linux-spi@vger.kernel.org>; Thu, 12 Jun 2025 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749742660; x=1750347460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lUktKHSDBv8YyZ3T2JIpTkEKDY+CUAzzGXJTRlK4hLM=;
        b=RIWSgNLxAcdhYVcY+zmtvnVfrfnlTnaixL1+x+EEjRsznbJpE15TDPXbFIvmBXrqiF
         iHO/IkCvX2sVxlfCA0minG6DFzIhco8N7S6ps0FHrB7bX6rtToNjzkhiv2ToMtss5tUB
         H3q9NoXNAPcqvnTIG9Gr9SD5dsdZWkR3co/F8a2qKMQiPloF2IdeKIAwoxi7/5Uj2LOY
         veO06yIPZpSiRJbEhMC0RDFSFEtfiSt7CM+satUZ7iFrj+kx07veHsm59QTBKcEFdaq6
         gaNfkiIzszE9DDNM0npvrBX/d7pq8pWne40GDhiIEmsx6AtHJ7Web61if2LQTd42YjgF
         5PQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749742660; x=1750347460;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUktKHSDBv8YyZ3T2JIpTkEKDY+CUAzzGXJTRlK4hLM=;
        b=hqTznCbjmX/Snc0pldQYiMmQGmdCSU4TFCiNM4ptCZXekKnH6DKrUD/JCxRxpi+X8v
         5qYW1UnPHGAIOWnyE3QNDaYiUYC0jeP5PEeLSMVBa3e3Ye4hdgGA+AmPplLIykG1Wg4Y
         l+0ScD1zf0AV/TsDj9HswdIITg1BE1A45ExPh0Tpc9K95g3cyWPtX//2f+0V7422cy9Z
         DOM2eJg4+6NKvqhQMwcAetqoJPkpvGFwXGJU9JIUtLa9+DThe9rb5qIoknm1rKJ9OpqE
         HSIBfyG+sUv7a9rm/5rfj8geRs5eLfP13BNFucCXHrUpMnZqJdkjiT/brziTST/S3ckw
         v/bg==
X-Forwarded-Encrypted: i=1; AJvYcCXg1aqHVH22jM5HilSCq3EODv4wUIXFsGJXcvtqnyZKYbihC6h/ScHkD26N+kEg3Ttl9AyN0bF+EIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9mCfjPsgwCTE0eHdod+bUy5VkFme+OnSALvdpywDo83VFxz6Z
	aYWOKlt2uP4nB4xGxtA89h9G+pXG2+ufABbxW9StzncPh7eR1UJiWE60iGgQ7TK/7xs=
X-Gm-Gg: ASbGnctXh9VdSeAc2tUKeHqPrG/DVzxpPMm7BIRSf+8AVV053Cqr0jEs2NGW0ZjtfLI
	F7+rDiXuaI2HJlISUFzaYKpQRtSBxzlfRliUu9TBMFBMv58zHJhuEn6lC+45Uw1bo4xkYr+Nx+w
	XnooMsuslaM9m/8RQ+TxweZRalhdBWk31cRUeNdxi4pxfQ22JnFn39OPzJqiO81fV4dIfX8ruoa
	SYHMEm7fS6LQRYcOnfmYqcZaydWyvYtatLnDOTnOcFsYPLv3uLf7IZCRcOLbTS/nU6DHehwd/5U
	SWr3jFqJnuLo/AY9lsT3B8N0SfI3Uu5lCPc3/SPP9I/n2ZhnrPcTu7RIXpb1vItibhA=
X-Google-Smtp-Source: AGHT+IFW8ovzvaCmO1YWcta4MdeADZMqjWi7FwUuaTUhmWbYq1MdUXaxsJ0b8e/O7yTwG63YiU9oPw==
X-Received: by 2002:a05:600d:104:b0:450:d611:eb95 with SMTP id 5b1f17b1804b1-453343c068fmr616725e9.17.1749742660256;
        Thu, 12 Jun 2025 08:37:40 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a561a3c756sm2314615f8f.52.2025.06.12.08.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 08:37:39 -0700 (PDT)
Message-ID: <e9f0cb03-06c3-4cea-ba2b-1ca1571a8f31@linaro.org>
Date: Thu, 12 Jun 2025 16:37:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
From: James Clark <james.clark@linaro.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Frank Li <Frank.li@nxp.com>,
 Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
 <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
 <aEhVsrEk0qv+38r3@lizhi-Precision-Tower-5810>
 <20250611090107.t35zatn47vetnvse@skbuf>
 <c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org>
 <20250612111514.rfb3gpmlilznrfxs@skbuf>
 <ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org>
 <20250612143644.cmw6d4iiootipafp@skbuf>
 <7e4bcfe4-cf79-4b21-865d-a1248e09ffee@linaro.org>
Content-Language: en-US
In-Reply-To: <7e4bcfe4-cf79-4b21-865d-a1248e09ffee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/06/2025 4:36 pm, James Clark wrote:
> 
> 
> On 12/06/2025 3:36 pm, Vladimir Oltean wrote:
>> On Thu, Jun 12, 2025 at 03:14:32PM +0100, James Clark wrote:
>>>> FWIW, the XSPI FIFO performance should be higher.
>>>
>>> This leads me to realise a mistake in my original figures. My head 
>>> was stuck
>>> in target mode where we use DMA so I forgot to force DMA in host mode 
>>> to run
>>> the performance tests. The previous figures were all XSPI mode and 
>>> the small
>>> difference in performance could have been just down to the layout of the
>>> code changing?
>>>
>>> Changing it to DMA mode gives figures that make much more sense:
>>>
>>> Coherent (4096 byte transfers): 6534 kbps
>>> Non-coherent:                   7347 kbps
>>>
>>> Coherent (16 byte transfers):    447 kbps
>>> Non-coherent:                    448 kbps
>>>
>>>
>>> Just for comparison running the same test in XSPI mode:
>>>
>>> 4096 byte transfers:            2143 kbps
>>> 16 byte transfers:               637 kbps
>>
>> So to be clear, the 'non-coherent' test was done just with patch 2
>> applied, or also with 3?
> 
> The whole set, and then the non-coherent patch reverted.
> 

And with DMA forced in host mode as a hack.

