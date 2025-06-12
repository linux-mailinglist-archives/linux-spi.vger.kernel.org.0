Return-Path: <linux-spi+bounces-8485-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17177AD770A
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 17:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E60E3B148A
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 15:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007AD299A9C;
	Thu, 12 Jun 2025 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HgHjtsPN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1335E299A83
	for <linux-spi@vger.kernel.org>; Thu, 12 Jun 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743250; cv=none; b=PsYfxYDlMXLTj4ADEycPf2H5fZ9VKFcfgpA/iuycwGsSk/vhX4E1UHN0F201ltQOsFXTYLvMdh0ZOGJJ98wPsPp5nlrZ2C6UQ1KLMAqA6FXq/6L2bqyNLMdgZrWZHenXFJnFHDSamctRR//meiI8Xr5GS9xyUBywr5c5Fio/zeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743250; c=relaxed/simple;
	bh=6EJWAXUizv4x6TeLRRJdm1zI0l44XmREmXJzX+1ANS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4jcEjhstBKSilB9g5C9Mvcn5jUIBcczuprWT1AsW6qbrCHCzGq14oOYoquiLmLhGsyGF+sWTBo2YHJWYg0dLqCF8OBeKr+SuiannrxZEXaPdClg11VioqEa0EnPuIhOGgIL+zIsrMdXaiMZuH45z0Zd+K3vB+CQ/MWC3CyaBVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HgHjtsPN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-442fda876a6so9891795e9.0
        for <linux-spi@vger.kernel.org>; Thu, 12 Jun 2025 08:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749743247; x=1750348047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zh7m5aFTZexY03nsf1b1OGgOvOMdgi7k2RJzccpdmoQ=;
        b=HgHjtsPNh7XU9GHYO+Qs1sc18DJW4arxxmLkJB0bnQNv4ZxH5fJOmA6I/2avoNElDJ
         ezG8OI+AIFHFziJxMglbUI7AQtWdsEvAEu/+ko6XfDJJHIrmQ5yytyTEYT7zfVmBSsDg
         oCs7CHMkYsDagsB7FpLKsGB1Y7cPHtLOFFHTC2aX6AinACJZnctisFStEaWCRuB8ydaT
         H1xw/O8EXh+bMuTao3vy6/U2YugHOcvRNTTQlFrAJSLLu9JhM+KbU+HDT4oTpCqERSlv
         e3j/w+QcvCHSLV1lRMbq+AkfGbRVk7L6xbda5zUXlfV80Es1gFVhCjs1GbLs4kYccgHb
         zKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749743247; x=1750348047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zh7m5aFTZexY03nsf1b1OGgOvOMdgi7k2RJzccpdmoQ=;
        b=OS2tS2v+32ODm24ZfkjoGle6aLy3b4TQj9p7Rs4TQsdd87Cro3frzreG9U6ZlrIqBJ
         6VX1w1qStgjJPfwenSgiA3u3XTctXyGCAwMwAiag+H9Y2ToIUByhG3vLUeeRBwXpobRl
         EVlpY4DH8kxFqzW/fON4OJ2iENclQI/HlrDNV4V+k+Q5NDyEd3gwYhCNKdNzBIsvZlHd
         yupY4g1zNhXbhIVp0iV49vuRVzfuj5AUFIULK+wdNlKHerJJZg0qXJIbF5z2cBYJxWKL
         3FmkgUJdijLEp/hzgvgZmX0B4TERzmJD2dSsRhEX3mv849uyTZUe2rEIXb32s6yigk7Q
         V+qg==
X-Forwarded-Encrypted: i=1; AJvYcCWZls6eY9wZ715XgFRCOs86L07Ch+oL6ybetmaOIhfU1bhLeAmfkB278c83L78AF90XWq3J/SQ6OYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgXorTWk8Cuxlb8EXb9PfZJ+y4MSVHetq/fHE/V5/CbthV87mi
	uGKhnazjVbJ8XGeGjjiBEJdzRNN2HqEKB713tHBFEv4FKktU34f4MfWgCgDY9qyH1yDGVA7tb2C
	rcx9+
X-Gm-Gg: ASbGncvomtgyYs5JvdJUqjSGx84Ow+q5PRbg8DLJuYeRpnbgMTRCPuI7+hKUtV2yO1y
	rae24nSIFrgro5ofiCynszOGHg/vHzygfy0sdn+fD0E8xsRWaOcD1O8NwG8A7EQ8E+H2j1avaRH
	Wtm3u4L46HdWCaTVWeHY4nm3zVFCsZCFG0rOlONZz5O0OBjAYtwva9HiJcjQSw3dBoWWaHfvhCT
	XM62RcGZyAf9/XUxk1SeoBivY42McbHm0XAvDwzar/igp7HxGprU1PggKRe75sokRh/vFJDqbLJ
	s1TTzfTFYjXaBbBQaV4NvWWo0N6VsHhuoebGhtU7RNPw1yAI8r3yIbMnyt8WlTr7PGaUyiiwVbJ
	ocA==
X-Google-Smtp-Source: AGHT+IHczznv5LyNR2hJXOddUvykY6/Q7P2zOffstHCE9b07Vxo76rhyxFFsgAzhcmc0JU11Yz5PdA==
X-Received: by 2002:a05:600c:8b08:b0:450:cea0:1781 with SMTP id 5b1f17b1804b1-4533436e50fmr1615195e9.16.1749743247314;
        Thu, 12 Jun 2025 08:47:27 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4531febf905sm69898505e9.0.2025.06.12.08.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 08:47:26 -0700 (PDT)
Message-ID: <78d77dd0-2ddb-4074-8f2a-debc7bc41fe1@linaro.org>
Date: Thu, 12 Jun 2025 16:47:26 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Frank Li <Frank.li@nxp.com>, Vladimir Oltean <olteanv@gmail.com>,
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
 <56b158fa-5fd6-4582-8ca1-296863d6d2a8@sirena.org.uk>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <56b158fa-5fd6-4582-8ca1-296863d6d2a8@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/06/2025 3:43 pm, Mark Brown wrote:
> On Thu, Jun 12, 2025 at 03:14:32PM +0100, James Clark wrote:
>> On 12/06/2025 12:15 pm, Vladimir Oltean wrote:
> 
>>> FWIW, the XSPI FIFO performance should be higher.
> 
>> This leads me to realise a mistake in my original figures. My head was stuck
>> in target mode where we use DMA so I forgot to force DMA in host mode to run
>> the performance tests. The previous figures were all XSPI mode and the small
>> difference in performance could have been just down to the layout of the
>> code changing?
> 
>> Changing it to DMA mode gives figures that make much more sense:
> 
> If not having DMA mode is making this much of a difference shouldn't the
> driver just do that?  I'm not seeing runtime configuration in the driver
> so I guess this is local hacking...
> 

Yes just changed locally.

>> So for small transfers XSPI is slightly better but for large ones DMA is
>> much better, with non-coherent memory giving another 800kbps gain. Perhaps
>> we could find the midpoint and then auto select the mode depending on the
>> size, but maybe there is latency to consider too which could be important.
> 
> This is a fairly normal pattern, it's a big part of why the can_dma()
> callback is per transfer - so you can do a copybreak and use PIO for
> smaller transfers where the overhead of setting up DMA is often more
> than the overhead of just doing PIO.

Makes sense. Although for some reason two devices already use DMA for 
host mode and it's not that clear to me what the reason is.


