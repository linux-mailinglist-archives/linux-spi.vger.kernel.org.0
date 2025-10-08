Return-Path: <linux-spi+bounces-10481-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D276EBC5DD6
	for <lists+linux-spi@lfdr.de>; Wed, 08 Oct 2025 17:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D87427448
	for <lists+linux-spi@lfdr.de>; Wed,  8 Oct 2025 15:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F003002CF;
	Wed,  8 Oct 2025 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYBMgz54"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576432F5A1E
	for <linux-spi@vger.kernel.org>; Wed,  8 Oct 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937646; cv=none; b=RYm6Z/o+RFIEB0Xwld7QvK9m03afnILHiu3a3RHqQT1lvu8QYqVP379R2JgbrllFaUfedGwRXCdRe5b3IpzXCR0pVYJGKjDbT2aX+GS87jeWSb8WFFGg6tdL3xERPo7CateFbLmLUcj4knrL+UTZHx2BGhvqgt7pTYpNDT+EJNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937646; c=relaxed/simple;
	bh=42RqGuehjRDSpY2gsrVZJlk6zt2QYdS+W6t8m/VoWXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0ros2Kcw9lLzhlbrwWLIA6790We3XaxWuQXavJXE+rYQxZPNXuNLYqWlLlPxqB4jEhO/c2QPQ6MWFglSq83CHZFS6dBQi4kwJGYU+Rykdlxyta/ZbyF/BphPOItP/uxYR8G/KVgt6P5yXjS7iG1hksSZUUx7Kw/5Znt3brbUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wYBMgz54; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so58957735e9.1
        for <linux-spi@vger.kernel.org>; Wed, 08 Oct 2025 08:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759937643; x=1760542443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3nT10c9+RtbCyZpgzKMKOftV2ncNLF5WtmF89g9eodc=;
        b=wYBMgz54rI2qanBpnS/yUaLctWQRbskcCwiHIiuLdt00vfamaLNmUQSdpKDXfbxn1I
         a6z2V2dDEKYb5QdKAlP/2HwY0M30bMBaCQlHIKgKbcmRoKYsTSUshurlpuQRGrrBtwai
         DPXNyMaqyAuFXTj5wvvUaorLOUd6o/VidvrMHSnVvujIDpSk1qXZ1TU1xdizwyJLXGll
         dHV5rA+ei/8m/wzGYxZ2nDP8DK5gPeeJkIgmX50SCl9kZJL+7BlhAWtbKG3VwMgBjWie
         EnpQcDsSnf5FcIOKcOknRetHXcNauTRl1AFhlwYeoMxVlmthrDor60HNiTQooud8UVg2
         1JzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759937643; x=1760542443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nT10c9+RtbCyZpgzKMKOftV2ncNLF5WtmF89g9eodc=;
        b=MXkfTtbkwmcp4vWU0gWt7bumlM+5dZUFGuA/4qcRfe1z0xuHb86wRWi3zEieh+NuiQ
         Cq9DZitPRzP6FRqRA8b9AaWOrPigTBu8X7DzK9KnkjKjzGveMVcSFNDt+e0Z83sjgb1t
         otR0xh4V+xwvsMWU227f9k3wqmhs68a5XBOJ6K04D6pjC2pUsxOITHKAo85jeQsucoML
         bZKUCeeILp4dexo4fvugfrVvOYAxlMac1eDS0ucNUJRTKzLmgwnJ3A+wlfLeZJghP8nl
         5ZfLW+DXXhuyIscWLMiklwQeL0ShK8zsJ67evaSmdXoKxKElndblUN2ncHLS8r3DvwvL
         6IyA==
X-Forwarded-Encrypted: i=1; AJvYcCU4E8GpRbdgV0HDkbRuG7BQePOEc+Jwp3+2AybnPXnY1nPgjixOdzQ0J7E1udKqTzCzQn3TslUGBJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFjnCx71CQf7uRepC+FwDc3Kxz9A3Ctp4GsQNY3Oosgvz5Qkic
	CTKOqdzD+2UI2QctCNAy5NeqfleYKpyKug4Nz7bLy+BoP4kADl0M2hsdaUmrhYfI8h4=
X-Gm-Gg: ASbGnctERmurzVNOMk5L9pu3q+JaLu9PxROBWfy0B3w/yiEMydMSDhL4d/PyOOf7Yvd
	GRPI45q/hCdsTIle+E2RUih3rqo2glSh1S2nV1sy4Q6hVZyxWmgB9KgiuShwdkMwqO4XnRH5eGg
	didUcIlA2DZPC2CdJKMsyUAvlmiMLo3AWihEbMg4amYWNmVpgbfHLVaKugECo2TeJo8rikbIzTZ
	uTpbPP8+YzrRree7FAj/wUlvGKUPufJI6lCs2fcAz3+qIDZB1HEBpa+rg1DR2ZNNfihh187BJZK
	I+oZ1LDATm8wcoRbdX9UWFCQWKUUA2ULY02S0yDvx5o40Lm3u4nWhXgftmpQJC7OZSkHMB6mh8k
	UX2WPWi4YcZIIatqbLI/YPymK4GPtBrhwe3FPX+VgbHZR8pB54mtWi3EUaWjdZeg0pFQ=
X-Google-Smtp-Source: AGHT+IHWKpjkgnJ6mZ4SxdFrASKIm3+agiqKwM+jn1niikJVBh/tK845v90Y+pp2KpRiWUEcs/aoDQ==
X-Received: by 2002:a05:600c:1f93:b0:46e:376c:b1f0 with SMTP id 5b1f17b1804b1-46fa9a8ca9fmr25983455e9.7.1759937642542;
        Wed, 08 Oct 2025 08:34:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fab3d7df4sm17562785e9.1.2025.10.08.08.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 08:34:02 -0700 (PDT)
Date: Wed, 8 Oct 2025 18:33:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: cadence-quadspi: Fix pm_runtime unbalance on dma
 EPROBE_DEFER
Message-ID: <aOaEZmrWgy_g0u7c@stanley.mountain>
References: <20251008-cadence-quadspi-fix-pm-runtime-v1-1-33bcb4b83a2e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-cadence-quadspi-fix-pm-runtime-v1-1-33bcb4b83a2e@kernel.org>

On Wed, Oct 08, 2025 at 03:38:39PM +0200, Mattijs Korpershoek wrote:
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
> Fixes: 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths")
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
> This has been tested on a AM69 SK board.

The patch seems correct, but the correct Fixes tag is:
Fixes: b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")

regards,
dan carpenter


