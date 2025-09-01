Return-Path: <linux-spi+bounces-9832-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE925B3DDA2
	for <lists+linux-spi@lfdr.de>; Mon,  1 Sep 2025 11:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6227A01D2
	for <lists+linux-spi@lfdr.de>; Mon,  1 Sep 2025 09:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6255630147F;
	Mon,  1 Sep 2025 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ne7f7yqD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE143043AF
	for <linux-spi@vger.kernel.org>; Mon,  1 Sep 2025 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717755; cv=none; b=uQJn2BDfHbp6S2GOeSqCus4tKgdw3sRBf1mwJqFFGONlXX/eZNfEsR8QdeMOo8idKfPiBHF9jcqNeFfwskfB3FEW2wE76ne2k2fMlZKFFnajZLofA2dsQucGn8wmcLPvh0rWeEHdToX6YjloakTzFWVa31MSh0XjF4++K4kxFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717755; c=relaxed/simple;
	bh=PHiUvICP0aYOlnmmgLUBKOKa0p96Stm0kjepB/azcGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8iDLeYPYBVMsr3TTvhwhTiSlbXgUpyMF6AkVXdsF2bMQMF6Q/Uj4vR2Re6pdbbyUY2ZT15yEzeqgbykILpDflgemYaiGO4ZrZdqhoGNjdMTQ/5pWWXxaZjprGlgAM5mnPNzu10mBEi+GsRM1X6ukVyE87hqHNSujTkahAqUiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ne7f7yqD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b7d485173so24647785e9.0
        for <linux-spi@vger.kernel.org>; Mon, 01 Sep 2025 02:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756717752; x=1757322552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v+Xo4tkbFhwj2dkE+zxlT5qS+Qcu77hpuQM/6Wfp1/E=;
        b=ne7f7yqDpf1iX5VpqbqMCjmJ18NrJwPJq8MibfKyMhdjdtynmvsyVKEb/YpNPqbDBE
         jFJfMaHP4zETrTygboZu2nTeaT7PaLd363uWE1M90OZCrvfZVUCYVb/udXmpjQ4TcTxf
         tcni66ehXbo5B3mCl3rtCQjiFnTgDQk4QRr8QEJ9oVKHlCELqB1MqWAbVLWWKQlwBlIf
         YvWEvKHL+T4IB4Xj2VNsagIVQ/U4jz/k/5EWcZzz9pGLlidXVy2oIMsMNQLVApyK9cEs
         ouxTYPt7XalW0iNWZuoNmMwOmfqDZT0fmewIibTtaydTX3bALtjmIUTzomVLzIKtCGiQ
         71vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756717752; x=1757322552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+Xo4tkbFhwj2dkE+zxlT5qS+Qcu77hpuQM/6Wfp1/E=;
        b=ZbfmJKRil0KauBRAWOEr0eEnkSz9UXFMREGZ3Uhc8FxecLLi7Aoe5rqHswNsJfAu4M
         80inQr6VxfTGKkexTw1goJ/oHJ1/l5uU1Fw9CVaMruSLj9T+QIdFDXg85Nyx0i5cu90M
         Lt3cFJygysRisFewKOL71832lWOrgNk33VZaUXXlTZyldN6ZI25IurdUUC0mXHy2E3Xg
         tvCLxtpxTsizrvOH/d0XtTaevi/SCDbQPXq2ObeQ1cOul9inh5l4tnGF8IpF+g3wmEHs
         DRSYaQxrVQ/3LpKGzzZ/7oNWwJFFBJUMhf/Q4iEkYOpCIBeRXbprB46s+JNy9yUELWGX
         niSw==
X-Forwarded-Encrypted: i=1; AJvYcCVcp2dMeOXPR9lMIS/eFUHuI7zi6WrCTzRQPhPCLMhEbwcrYkd49oyojvclUVE4mfiaF1sXUDDb4Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA0uFj0m8VEM9vSqnkipu5Aq154zYdOHVt2P8Hcy5iCSSvM5dk
	2Egi3BOafL8XABbA+6wRwbMjg6AgNXrfxWT+qYYqhllKcoQPxoVWTQdxm9SSWAMxHbw=
X-Gm-Gg: ASbGncs4WlNOuclpAoH3Hyi1yIg6Z+M4hvQiJpaQdgcL36yVfUPwajZLkm5cJlU2eJM
	aY2txScQiIoI6C2qq99aFbd4ppqE5zMJZytOSS7oCIgxODNPBnrnWmACTcfOaMw2GV7McMHv7Nt
	ra73frdvcIC5TrESk20kLaVygD5iYehW9zK30ugDkhFZ2DXWkK14WvoFLKaijnDVMCRglUOdwGv
	+lgA2JplEEZ7G33XkXA5cpmRyew3tZMjMKGC94L2Rk4q1QlDW1QAecRKm0Hgt26EEh/p/JqfgOK
	HJjV5OymqDU6WyA7Frq38ByTCHeJngG+VczdUvLof3chQjYezUz/VxHaACfc/oFraq5RcyQ+SjO
	r9ylB9BI/Zpa9oE6u5TXnegSx56KurAuDYsW85A==
X-Google-Smtp-Source: AGHT+IGQBSkz2khdRsQAv7vacSGMiUv3G+dZ9L9wmpydMb3GXDxwfB16QPW8+IRZec1HkLE7lP8j4g==
X-Received: by 2002:a05:600c:1e8f:b0:45b:8067:d8ac with SMTP id 5b1f17b1804b1-45b8553362bmr52083795e9.13.1756717751775;
        Mon, 01 Sep 2025 02:09:11 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8f6cd502sm6940335e9.1.2025.09.01.02.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:09:11 -0700 (PDT)
Message-ID: <ce55ed06-7326-473b-a2f9-40b0bc61c396@linaro.org>
Date: Mon, 1 Sep 2025 10:09:10 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] spi: spi-fsl-dspi: Stub out DMA functions
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Larisa Grigore <larisa.grigore@nxp.com>,
 Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
 <20250829-james-nxp-spi-dma-v5-3-3246957a6ea9@linaro.org>
 <20250829142636.7nv3ylyck5yda3fd@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250829142636.7nv3ylyck5yda3fd@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/08/2025 3:26 pm, Vladimir Oltean wrote:
> Hi James,
> 
> On Fri, Aug 29, 2025 at 12:46:45PM +0100, James Clark wrote:
>> This will allow the build to succeed with !CONFIG_DMA_ENGINE, either due
>> to a randconfig build test or when the target only uses one of the
>> non-DMA transfer modes which this driver supports.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
> 
> Sorry for not paying attention to this previously. I didn't pick up from
> previous conversations what problem this is addressing. I built an arm64
> kernel with CONFIG_DMA_ENGINE disabled (by unsetting CONFIG_DMADEVICES)
> and it got built successfully. The .config is attached.

Did you test with or without these patches applied? It's only needed to 
make the commit "spi: spi-fsl-dspi: Use non-coherent memory for DMA" 
build because that's a newer function that isn't stubbed out like the 
old ones.

I originally tried to fix it in the DMA code so it got spun out into a 
new thread, which is probably why you missed it. And the commit message 
is missing the reported-by and closes tags which I'll add.

> 
> Please post the specific build error if you haven't done so already, and
> give a reasonable hint at the technical motivation in the commit message.

The reason we saw the issue was a randconfig build. But it's possible 
that someone is building the driver without DMA as well, hence: "or when 
the target only uses one of the non-DMA transfer modes which this driver 
supports".

The new commit message can be:

   spi: spi-fsl-dspi: Stub out DMA functions

   In a later commit we'll use dma_alloc_noncoherent() which isn't
   stubbed out for builds without CONFIG_DMA_ENGINE and results in the
   following build error:

     spi-fsl-dspi.c:(.text+0x644): undefined reference to
        `dma_free_pages'
     m68k-linux-ld: spi-fsl-dspi.c:(.text+0x67a): undefined reference to
        `dma_free_pages'

   To continue to support devices that only need XSPI mode and so that
   randconfig builds work, stub out DMA functionality in the DSPI driver.

   Reported-by: kernel test robot <lkp@intel.com>
   Closes: 
https://lore.kernel.org/oe-kbuild-all/202506160036.t9VDxF6p-lkp@intel.com/
   Signed-off-by: James Clark <james.clark@linaro.org>




