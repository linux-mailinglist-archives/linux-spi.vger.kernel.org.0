Return-Path: <linux-spi+bounces-10485-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5EFBC79CE
	for <lists+linux-spi@lfdr.de>; Thu, 09 Oct 2025 09:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9ACF4E5019
	for <lists+linux-spi@lfdr.de>; Thu,  9 Oct 2025 07:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B6B22173F;
	Thu,  9 Oct 2025 07:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOLH3ABH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0621E492A;
	Thu,  9 Oct 2025 07:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993750; cv=none; b=LMSNtm0/0LB6kYGWg8dklN9WNPAGttmymT3mhDuKO+/II2503ew3nSU0icnN/msdTU1/98Wy+WzwwJuMUdIAgVsGtQGIpgUY3BmmeUzYdAXJu0K3FC8g7OXgdMy33MPWTCuPzUYjZcTqck8gBb54L8fA213yyhU27MSJ+w0HjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993750; c=relaxed/simple;
	bh=fohZD945hyOr6EgcwYHCW/ohIox43n/sBOa8Gkw4Pk0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ag+7LNE9XOeLSV9b5RACytHELPmkXuYYlgXp4gdEx199kQu/WKMb1ssyNmiizc03vfLgX0FVKP5BPgopSaE9tQGWBmuMPICswQTGCbG2BcaE908L6vxWvzGuFwvCLNCDMNljhPE4KtekkyKeQGANmIiSAcZKa2MiihZQjppsx48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOLH3ABH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A1EC4CEE7;
	Thu,  9 Oct 2025 07:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759993750;
	bh=fohZD945hyOr6EgcwYHCW/ohIox43n/sBOa8Gkw4Pk0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UOLH3ABHH9Nfi4yu62b97nE1usiiZxYrrY5tlp3bOvnc354apw+kdyjXctsAxrbSk
	 wwqeGoYFBmk3Q1B7qM2qYC5MZVyt/WLMme8aQEfBchVb4U6+LedF3tZEF2cO06vfvG
	 9603cck+DTsaSsp3v7gNSWbqgnsZ9KZvGULE2G/NWDYidKylGJwQAHD9uoxwghzqnC
	 3oaUGDuOh/yQjpR/e94Iq5ehOj8QcM+C6O9imsDVRASTtk2J/QYKTgviy/Aejg3JQk
	 sd4aYCqJb0WkBGr38Q/Vg99C43bxqWkmKJhEkIrovXvCZciVF9/kKRJasgBflBOKYe
	 ySvAqUvOKnHng==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Khairul Anuar Romli
 <khairul.anuar.romli@altera.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: cadence-quadspi: Fix pm_runtime unbalance on dma
 EPROBE_DEFER
In-Reply-To: <aOaEZmrWgy_g0u7c@stanley.mountain>
References: <20251008-cadence-quadspi-fix-pm-runtime-v1-1-33bcb4b83a2e@kernel.org>
 <aOaEZmrWgy_g0u7c@stanley.mountain>
Date: Thu, 09 Oct 2025 09:09:07 +0200
Message-ID: <87frbswnzg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Dan,

Thank you for the review.

On Wed, Oct 08, 2025 at 18:33, Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Wed, Oct 08, 2025 at 03:38:39PM +0200, Mattijs Korpershoek wrote:
>> In csqspi_probe(), when cqspi_request_mmap_dma() returns -EPROBE_DEFER,
>> we handle the error by jumping to probe_setup_failed.
>> In that label, we call pm_runtime_disable(), even if we never called
>> pm_runtime_enable() before.
>> 
>> Because of this, the driver cannot probe:
>> 
>> [    2.690018] cadence-qspi 47040000.spi: No Rx DMA available
>> [    2.699735] spi-nor spi0.0: resume failed with -13
>> [    2.699741] spi-nor: probe of spi0.0 failed with error -13
>> 
>> Only call pm_runtime_disable() if it was enabled by adding a new
>> label to handle cqspi_request_mmap_dma() failures.
>> 
>> Fixes: 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths")
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> ---
>> This has been tested on a AM69 SK board.
>
> The patch seems correct, but the correct Fixes tag is:
> Fixes: b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")

Right, I hesitated between the 04a8ff1bc351 and b07f349d1864. I will
send a v2 with an updated Fixes tag.

>
> regards,
> dan carpenter

