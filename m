Return-Path: <linux-spi+bounces-8475-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFB0AD7353
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 16:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCEEA7A9A68
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 14:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1447124678F;
	Thu, 12 Jun 2025 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWc7a+aQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0172418A6AD
	for <linux-spi@vger.kernel.org>; Thu, 12 Jun 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737680; cv=none; b=CJ3BvLXuI1zxvPpq51MAD6ahA/6JiUMpxMu0ZcOWKiB0h89RHcjw50GwcLtsU8k5odqtMxWSXNGrljp8Rz82u3PffmfY6e3FlzGgy0yYgTUx6pEmxpJnfcsO/3h1t4NxtdWkgkqRvJfpfEDggipZG1j+N2W21+q30Q6aR+oZA64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737680; c=relaxed/simple;
	bh=60WDQiWn4ERcM4sXmxu8hCFJPSCd2H/JsWpNpGO9EBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFCsMWL3OKDFjjM7CveeMi+Cajl14pAfjOSqyU3vfIo8V34jw7jLn8wJnjkIAdLcgiaip4fh/KSS+Z6EhC7UnhfWWf/9IMLmovXQspLocTZZSoP0gywW/IWE+A0xrJlDro5dwB+Nx1LtpqsP3td4Y98hERfq67ErWtz/BwAnyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZWc7a+aQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a528243636so679851f8f.3
        for <linux-spi@vger.kernel.org>; Thu, 12 Jun 2025 07:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749737674; x=1750342474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J19QzIs1SpN2V+Z84587yjfC+A6S3Z0DqJUi8/rsIps=;
        b=ZWc7a+aQHcTTvXzje3+dB4qw/TBms4ehHn53nXBEU3WJGPqi7w60eTsKpF8fcQxGIZ
         Iox5Be8J+2c/nDpwqfmJ+ii2k0tiuD7IaQ1YFlMlvu9o0Ux9h1wNNt1NQ4QOfxpX85gc
         YZrYkdqaPKbVA/sTC0QUHandbm024ofuExH0tBPBV32J6PeETfrirOm7OApkodq7jQr3
         Nb3WF3Qfikwf2p/ZR6NQPTulQ99Am6j+dey+adTYJwDHne4VG+9HngY3WFc/Cl1ZLn+h
         UVjbXNBYurr0/ahOKwndgA4Tc9wwwkcnqYKDQR/KKt9vqHBf4AaEgsZM3RREthzjiNoH
         BGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749737674; x=1750342474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J19QzIs1SpN2V+Z84587yjfC+A6S3Z0DqJUi8/rsIps=;
        b=FjI3h64Hf78Ofh5RGQMsEyELkmhyr44WlYnFxMIRlSCg3uVIgQLCgkoJjt2ucfMODC
         bUg5jtKjMaSHNfZ7tbYVIGj4Auc+ejppgO/6uIOVSdJ5mEat+QNCqSoMo/pkrUvBMFXV
         5tyHUDFKugXyHCGWmf72jC6/DhecPalJ+ZA8S/AkB/GGyA/1LjSwCBuw53OIQNeIQn7K
         ev09WoRayH7RW9fRG53Aog5pt5DFcgYFxjaHepyOm07N97TCPxJ7o8DvVOrDJDYpHOZ6
         f4UZKl6Hy/iaMLDR8+KJ2OrrzeufVPQ18xOCAPqP2D7oKN6j7N/lNYiDDg0rfBjXWn1R
         cJ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcSOCb8+QkoXMmEbpht1tE71tWQzBzSTgp0ZQ08y8CBsi6uCPwDzELzMXEfLNI4IDW3AgUb/0hNSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1u+DKiY2kRhWKeC/gbWspiK6arXXWEFqnvoQ3NGpjpouXJLoI
	c6sWQWnnr17QhCWIjZJKPZr5RWmy8URQyIvhNg3g+GaboU4u1CtuTiT2Qe+HBb8hVf8=
X-Gm-Gg: ASbGncs8fvW6CgfvFfJjU8ut0Jh9S6iM3VClS5YddRJ7zeuy2poAgG94RGmRqbS2bUW
	w3ScXpr0HZMQZutMHC4P0/JKmLfOCKWTDzBj2bn3ckLCW9ymb4N0v+nmWQpyLra/ogNRzAy9mkW
	QPtq4EPh9pFcN7a6RXMRymxTxWMtDRmKf/jjT6o4vtObLB0wKjfWdzwEHUBVITiElzBuZL5lDBO
	5RfZ/ZfEGtC64taE0FbLREdA8wpS1MRj9xDBLQz2I6symuMHldNujFXoXRnq2JwtgX0b6w9UlFh
	VsGt5fFD1KbddRKSTPTQAOl+a7St0hyq4nvKE+mSgotmECyizYO8tdQ3Ud3Optte0PAW5CeGZoK
	k3w==
X-Google-Smtp-Source: AGHT+IGMvfoiQPigVo7iO2Dw6iilpFxrDO4WGsQDGLouqfPnH55vE1SO0OF49/vNlZbAzHfxJoNlPQ==
X-Received: by 2002:a5d:64c5:0:b0:3a4:d700:f773 with SMTP id ffacd0b85a97d-3a5606a2f5amr2978490f8f.11.1749737674171;
        Thu, 12 Jun 2025 07:14:34 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a56198f827sm2077031f8f.29.2025.06.12.07.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 07:14:33 -0700 (PDT)
Message-ID: <ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org>
Date: Thu, 12 Jun 2025 15:14:32 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Frank Li <Frank.li@nxp.com>, Vladimir Oltean <olteanv@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
 <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
 <aEhVsrEk0qv+38r3@lizhi-Precision-Tower-5810>
 <20250611090107.t35zatn47vetnvse@skbuf>
 <c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org>
 <20250612111514.rfb3gpmlilznrfxs@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250612111514.rfb3gpmlilznrfxs@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/06/2025 12:15 pm, Vladimir Oltean wrote:
> On Thu, Jun 12, 2025 at 12:05:26PM +0100, James Clark wrote:
>> (No idea why it goes faster when it's under load, but I hope that can be
>> ignored for this test)
> 
> Might be because of dynamic CPU frequency scaling as done by the governor.
> If the CPU utilization of spidev_test isn't high enough, the governor
> will prefer lower CPU frequencies. You can try to repeat the test with
> the "performance" governor and/or setting the min frequency equal to the
> max one.
> 

That doesn't seem to make a difference, I get the same results with 
this. Even for the "fixed" DMA test results below there is a similar 
small performance increase when stressing the system:

   # cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq
   1300000
   ...

   # cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
   1300000
   ...

   # cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
   performance
   ...

> That's why I don't like the DMA mode in DSPI, it's still CPU-bound,
> because the DMA buffers are very small (you can only provide one TX FIFO
> worth of data per DMA transfer, rather than the whole buffer).

Is that right? The FIFO size isn't used in any of the DMA codepaths, it 
looks like the whole DMA buffer is filled before initiating the 
transfer. And we increase the buffer to 4k in this patchset to fully use 
the existing allocation.

> 
> FWIW, the XSPI FIFO performance should be higher.

This leads me to realise a mistake in my original figures. My head was 
stuck in target mode where we use DMA so I forgot to force DMA in host 
mode to run the performance tests. The previous figures were all XSPI 
mode and the small difference in performance could have been just down 
to the layout of the code changing?

Changing it to DMA mode gives figures that make much more sense:

Coherent (4096 byte transfers): 6534 kbps
Non-coherent:                   7347 kbps

Coherent (16 byte transfers):    447 kbps
Non-coherent:                    448 kbps


Just for comparison running the same test in XSPI mode:

4096 byte transfers:            2143 kbps
16 byte transfers:               637 kbps


So for small transfers XSPI is slightly better but for large ones DMA is 
much better, with non-coherent memory giving another 800kbps gain. 
Perhaps we could find the midpoint and then auto select the mode 
depending on the size, but maybe there is latency to consider too which 
could be important.


