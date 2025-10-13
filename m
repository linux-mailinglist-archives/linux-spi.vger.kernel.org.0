Return-Path: <linux-spi+bounces-10602-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E58BD2C1C
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 13:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D3B3A6209
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B4C222587;
	Mon, 13 Oct 2025 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKc/Sc1t"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C02AEE4;
	Mon, 13 Oct 2025 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760354441; cv=none; b=mMxbkDHDZBXNKmVzgTRYDc9gOJicfRi+PLOP9uYBoxFL7BLq6Eh92+kSnnCFsm405C/RaYk4xGABC4C07nSdF8cJkGzeYkbiiJgo7JF3JJVCFw25sXgBU6RgPEA774u74t/tetCAsBs7oGln1etrcjkelzR42tCQXUrUp0/0u+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760354441; c=relaxed/simple;
	bh=1/CWxoK/iS9tXWPUHkCA6Taf6bKU2DpwDhdiJOpKZGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vk8i+TWv3z1LHn/ApcUyJyY+CURNTDp8BVWSoc2V0QHsgX4csKabLhk9kZraKzYPM/WvmIMnmOjHs6AYOhy3HwAAVm4JjjKfarWA5cZd6mMpeYn3aVIeT+5Noif0kpL0AWNTHOHUovrv08dAY0XCrTaROc3E5a5J6n/VS2fLxKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKc/Sc1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4719C4CEE7;
	Mon, 13 Oct 2025 11:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760354441;
	bh=1/CWxoK/iS9tXWPUHkCA6Taf6bKU2DpwDhdiJOpKZGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SKc/Sc1tUs9d6snRvFlXvlbyhS0+1asKbkvmhGUcwAwTSVgxg6xCaCwJz/KZ3eGSK
	 vUZCQaFgZSMgWahF4Vu1aKkMvycyQ/Y59IV016qvg67+KqgR0E8ApJuVVrClmRrHJh
	 cLW4qjTcnrCSeYv2rKd4APNGW0Zw++xnXPYIUIrK+IeTy6oaTLgE0TC20SkiCQUJkY
	 v9RKWuMWJ9Id2p0Ut7CxuMENJcDmlHWltHeJc8ArHtxN5yqpOn8cbaAhUbK+Xaue3U
	 OYg4MOfURjE1LlLhtSwsg8iQUx3RkSGU45+sqbFG7qopGj21i5Hou9+kQWVES9oZ7j
	 gLqt+s2tGMouw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Mark Brown <broonie@kernel.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: Khairul Anuar Romli <khairul.anuar.romli@altera.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: cadence-quadspi: Fix pm_runtime unbalance on
 dma EPROBE_DEFER
In-Reply-To: <eb66bb86-328f-4d43-96db-e0a31eb73ee8@sirena.org.uk>
References: <20251009-cadence-quadspi-fix-pm-runtime-v2-1-8bdfefc43902@kernel.org>
 <eb66bb86-328f-4d43-96db-e0a31eb73ee8@sirena.org.uk>
Date: Mon, 13 Oct 2025 13:20:38 +0200
Message-ID: <87o6qbujy1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 13, 2025 at 11:22, Mark Brown <broonie@kernel.org> wrote:

> On Thu, Oct 09, 2025 at 09:10:38AM +0200, Mattijs Korpershoek wrote:
>> In csqspi_probe(), when cqspi_request_mmap_dma() returns -EPROBE_DEFER,
>> we handle the error by jumping to probe_setup_failed.
>> In that label, we call pm_runtime_disable(), even if we never called
>> pm_runtime_enable() before.
>
> This doesn't apply against current code, please check and resend.

Ah, sorry about that. I based this on master. I confirm it does not
apply on for-6.18.

Will resend shortly.

