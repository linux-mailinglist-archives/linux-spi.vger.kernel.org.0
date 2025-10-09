Return-Path: <linux-spi+bounces-10487-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D2771BC7BC3
	for <lists+linux-spi@lfdr.de>; Thu, 09 Oct 2025 09:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EA2D3516E5
	for <lists+linux-spi@lfdr.de>; Thu,  9 Oct 2025 07:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E971F4606;
	Thu,  9 Oct 2025 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mDe9u+UK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F3C1DED52
	for <linux-spi@vger.kernel.org>; Thu,  9 Oct 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995466; cv=none; b=GaWibywJ1uvDk9GJfJQ0T2rP+OIoTcAVFqVNLIuiP2Ss4h/w3JUg/8m3L20hxbfHSPcvx1N+GiqXfPafOUgIH0O0CAtoLwsIGd2APtChLZlst2uSDATO6/Vf3W+NPSXeXL5JpJ5WSnR+ZjmyZkSTpObiBEWr/8CjiM/zPvn7BtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995466; c=relaxed/simple;
	bh=dGju8AeWqVChK/btSkkXXitucm6kni2Hg7FXCU+eGHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nt0DvISEnozaA4EMvyBff/pwxuEGKS9JezHnuy8rHWDxqlj2of/te4qDDLk8L4KsQX/JgW/VUY23t5z+yFruvgjqjC5X++AKROVIm3h2D/Ayw48VEZvHMYUZaFYi6nra1cTwwyouhz0UGa+wn7xDQ5XHnLgWloZo3ep0t73qnDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mDe9u+UK; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso869306a12.1
        for <linux-spi@vger.kernel.org>; Thu, 09 Oct 2025 00:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759995463; x=1760600263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QkBo4+o98aA49wUvu+G1xef2+IziwVoenRLYEe5BuKY=;
        b=mDe9u+UK4Mwu6M18fO0TRloIRr1AIoR0KlO4CS6yjeyJsGvfj1CWv7qlTBQZWKEnHK
         jM0FUy8uKYEeZIOIpavbq3oPWGMmXz9t+rDeqnvDaTyqSf0Fywgm8ykKtbSt4oG5Emf8
         T9XTTjyinFnO4Br/iwGz1PSwwz+ICZ7yRT1leZzyjYGEzsidBkeKCCZx69MxVBfi2T0V
         HJNvVfoLLJlz8H6ZC8wC1OByp6x8D0k98kL8le2fDn+ipcg7MqFU7tKspJs2HvMm4WDz
         OjWO+BtwfQJCSChuXNn9N+uc+MPhV0z6KgLYeNTRA+VLbOPwtE25RoJQCc+6es4VcNKH
         u5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759995463; x=1760600263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkBo4+o98aA49wUvu+G1xef2+IziwVoenRLYEe5BuKY=;
        b=OBKap1HE11z8Y52OC/1k7BP/y7KHNFZWsVoe89Ac3Ntzb7qIYHa7Uip0u9KfDNbncf
         SYxLU19WgqH4raWgKC9pFDSwUmwgLv/JxX7i2StLfTOp5DIQtZA7lJ/ESwZJxFkv7xlu
         uD5xKe7XRqNRW/9tr8cetZI4w4YQdjrguSwnH/UU7exrtmLVj4BYtbiWueNkdJeUaxVb
         jFNijfhVA67CGgnXY5LFo/Zt3DxqAUkhCTVEb54oT15X87i7sklrPzcf0xT1yd08llbT
         OIpLF7zSjokblWzUxRPfEJ5tnaZC2t3Uuf3SpjB+vZJ+lpQca3r3jb4A8DXBNlJQKDa5
         L5Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWBFkHu4DO37mZ2XG9JudOOjpJJ6Bu9bL4A4BB6Shqs7F8/ScH67nXDJit1KT3F/9vx9ger8w5iNqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK7teBnuXxSkQ8tjjC5C7e06+662Ih9bgbUNYLNv1oNnHvgzV6
	YFE2m/zqc86phi7GfD5fNcp0KuABl4v85d/VzoLBQ3TwmJnuk98e6IVRRFysv+s6tqA=
X-Gm-Gg: ASbGncsgjDetL262QZz5POx8lEj5KKSb41wniwFAdCs5ONfrKngiIaNfk9ujRlo6iAp
	bc/qbpFOJVJOIZlSFxN3iL6ZNgrmK6WQ/eLbv2LbV9qUagNeXn3QIqOBIar6pzPYvK5DmWG/icb
	ttRlfhs3M86pUR87dIpf1MzKQzNgpNXKTN8lLEyGHPOpXz2wtgIHLrFR5il+ccrjXFuweW7fl3r
	hiWFesTRKcOOE+EXX7XWPQfEQC6wpKAvPsZg5jYKP2XSQ4nYyZiuSIz3ICdZt5t56aaswOJ0Ckz
	GEbR6FkWL8XBr5wN0xxg5rJikd8HLRzuhwHX6rsOadagto8s7eXA9UrGpuHyAgDHYxTtfQWzOdn
	KXpT8abT0iz4pPp+lNEb0gJUbJ/HFdkfjp8xc+zTNQV1xryo63tgceB82tuQSFo5kUOU=
X-Google-Smtp-Source: AGHT+IFHi/yZs/pGR4qTm0LoEk0mx1AMmvxnoL+zqu9ZIvbq6rDqz2obSOnUoPzAuZGAuoj0ELKvaQ==
X-Received: by 2002:a05:6402:2708:b0:639:c56d:2407 with SMTP id 4fb4d7f45d1cf-639d5c3f43fmr6045687a12.22.1759995462468;
        Thu, 09 Oct 2025 00:37:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-639f30d9963sm1766971a12.15.2025.10.09.00.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:37:41 -0700 (PDT)
Date: Thu, 9 Oct 2025 10:37:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: cadence-quadspi: Fix pm_runtime unbalance on dma
 EPROBE_DEFER
Message-ID: <aOdmQhGW27I6rGTB@stanley.mountain>
References: <20251009-cadence-quadspi-fix-pm-runtime-v2-1-8bdfefc43902@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-cadence-quadspi-fix-pm-runtime-v2-1-8bdfefc43902@kernel.org>

On Thu, Oct 09, 2025 at 09:10:38AM +0200, Mattijs Korpershoek wrote:
> In csqspi_probe(), when cqspi_request_mmap_dma() returns -EPROBE_DEFER,
> we handle the error by jumping to probe_setup_failed.
> In that label, we call pm_runtime_disable(), even if we never called
> pm_runtime_enable() before.
> 
> Because of this, the driver cannot probe:
> 
> [    2.690018] cadence-qspi 47040000.spi: No Rx DMA available
> [    2.699735] spi-nor spi0.0: resume failed with -13
> [    2.699741] spi-nor: probe of spi0.0 failed with error -13
> 
> Only call pm_runtime_disable() if it was enabled by adding a new
> label to handle cqspi_request_mmap_dma() failures.
> 
> Fixes: b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
> This has been tested on a AM69 SK board.
> ---
> Changes in v2:
> - Updated message to use correct Fixes tag (Dan)
> - Link to v1: https://lore.kernel.org/r/20251008-cadence-quadspi-fix-pm-runtime-v1-1-33bcb4b83a2e@kernel.org

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


