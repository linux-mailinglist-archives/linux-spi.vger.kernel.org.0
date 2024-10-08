Return-Path: <linux-spi+bounces-5159-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD74995759
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 21:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DEC2828B5
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 19:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14480213EF4;
	Tue,  8 Oct 2024 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="p3My5eQ1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8692A213ED8;
	Tue,  8 Oct 2024 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414167; cv=none; b=nfCvq497GEMEFXbhRl8cCIkTM2s8taiP1GakT+KQLKk8VWZtzKPTgt6WkiYW0R/Cuh3z8OcXVOpaQodshfrg8GqfyK0i09kBmNCGrO6s+KT50x+CZlM728S7MUUVd4AW1YfyDv1J4+4xJ5jpk00rX+4/2IJ2NavVq0x1kD4kcYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414167; c=relaxed/simple;
	bh=RzLX1r/HzJb4MV5AXwCJ6oB+wq9qt7eEfvDIe5ZoSKY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=epsSwjEh1YK88WrIY7TZB/THh7xDWg3QWXJdLaOGbop5wRzzC3ZBlfgY93fo7v6sgf27Kw9e+rgL9N2xYCk/GYbma8An1OcI3E5yhwZi/jd//oyFctgcBMIYknhbeIDkF6IwJBmypavFvhsdVraP2gIfdJnpGm6e0VcRcprfDlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=p3My5eQ1; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728414158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ou+RnMev9fN370/zTQH8oJcFFqCmNNELD7WUwEdv1mY=;
	b=p3My5eQ1j27ncSbGLhoBnsPkCGfACnKQRxJAKnhVb8JcUkqiI8P+meWMQi/bEhWJljx80G
	5+xmPzljXDkj367vggIGDavAuVjO1wOEswiSU2g66qeFHRUDcdPtOh/8wvfJqeGhsjGN+r
	gHiH1UQp9qwpQjbYyeVAJALKxPI4D44SIAHq7Al2+JbaZnIGnUIKCXBkRHt6Cz02zyU+x0
	XuJhGQroYIpmVHMpdC7ExyXEuQgVDWqqgQwv6frVM8HRffX6NwlM6R84nhfH6l2RRSoKIJ
	ie17E4YRlUIHhgL3QuPtWUtG6IVg+Ciweq6wwAt0/Tsij2miLb9GMhfsQkzbkA==
Date: Tue, 08 Oct 2024 21:02:38 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org, heiko@sntech.de, gregkh@linuxfoundation.org,
 rafael@kernel.org, oss@helene.moe, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Fix a typo in __dev_probe_failed() comments
In-Reply-To: <cec37f5568afaef8fca2d35bb01c90556ccbb4f4.1728408464.git.dsimic@manjaro.org>
References: <cec37f5568afaef8fca2d35bb01c90556ccbb4f4.1728408464.git.dsimic@manjaro.org>
Message-ID: <76254295771cb4ea5644f2ce4a30f0d7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-10-08 19:29, Dragan Simic wrote:
> Fix a small typo in one of the variable names found in the comment 
> block
> inside the __dev_probe_failed() function.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
> 
> Notes:
>     This is an incremental patch for the patch series [1] that's been 
> already
>     merged, so it should be applied on top of the series.
> 
>     [1] 
> https://lore.kernel.org/linux-rockchip/cover.1727601608.git.dsimic@manjaro.org/T/#u

Please disregard this patch, Mark will have both spotted typos [2]
fixed by hand. [3]  Sorry for the noise.

[2] 
https://lore.kernel.org/linux-spi/e8cbbf877cc0e6838afd2d6de3b7bfa1@manjaro.org/
[3] 
https://lore.kernel.org/linux-spi/ZwVt9e44jc3CQaV1@finisterre.sirena.org.uk/

>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5f156a9a10a4..a84a7b952cfd 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4989,7 +4989,7 @@ static void __dev_probe_failed(const struct
> device *dev, int err, bool fatal,
>  	/*
>  	 * On x86_64 and possibly on other architectures, va_list is actually 
> a
>  	 * size-1 array containing a structure.  As a result, function 
> parameter
> -	 * vargps decays from T[1] to T*, and &vargsp has type T** rather 
> than
> +	 * vargsp decays from T[1] to T*, and &vargsp has type T** rather 
> than
>  	 * T(*)[1], which is expected by its assignment to vaf.va below.
>  	 *
>  	 * One standard way to solve this mess is by creating a copy in a 
> local

