Return-Path: <linux-spi+bounces-10674-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246E3BDEA9A
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 15:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6013A4795
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F8132A3E5;
	Wed, 15 Oct 2025 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILZbSwmc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF4032A3D8;
	Wed, 15 Oct 2025 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533795; cv=none; b=JgGA5JqbXn664nHg7tdDCgSm65xB5hRXRvUo2NtIb60zPYgEOvMaltQmGr/Zk1a38S0fK9b9ZSkF16W5grgIZpQTjuJz5himVCHnOxNqtk4gV9JQa4UVxok07g7ohXNUbVoMiQPHv2q5fZE4QC87lssJCFxjkP1+IB6cCJ7WOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533795; c=relaxed/simple;
	bh=phCD21A/z4XBzH7RONTQqek/Jju3wLrTO4NKwJS7sk4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VlO0us8W2ASW/pJG3l8nmAfIeTn4ETiN0yoyj8bN8qp+0YLSDGXoEjS8MAiUn5vAMLRgXi7Pj+T28UwUaDwOF5ihRg9NORM7uO9uVmok/j9Roq9+V38YKZAxZRA/k9QJWnmmbl0Q3dJ0nI9ZrLKcsG0zzX+hrSzps/s3HZY/GDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILZbSwmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F368C116C6;
	Wed, 15 Oct 2025 13:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760533795;
	bh=phCD21A/z4XBzH7RONTQqek/Jju3wLrTO4NKwJS7sk4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ILZbSwmc3PWM18xqEktYR9h8Xu1kTMwkW3ffrpLuNWxvQYbI/22KHnb0RVwbppS0M
	 F74tb3W4b+6y9WxXAB7jSRkOyrYe1BHt/1cLiVpwFypdauLxBAb6dgKHusKA6vQN7e
	 9nPJDAi5kEGrACJxvW0WFx/X7eD2ZmWuviZKu9w/pVcTfjQ1gDFI5Pw7v/j0B/0gME
	 sax/Pm/A6DjfCEx2Fs+v+c5SU53NPXeChmd3Ad1BZrECVaUOGFVkOaZWn6E3Tta+lO
	 Njtl6v3/Bpud4RAOqOSRVYegVZqpPmANznoe8/OPrfK1FtlJs71SHvpqsTI3IkNwEC
	 j4q3QxiffFYnQ==
From: Mark Brown <broonie@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251009-cadence-quadspi-fix-pm-runtime-v2-1-8bdfefc43902@kernel.org>
References: <20251009-cadence-quadspi-fix-pm-runtime-v2-1-8bdfefc43902@kernel.org>
Subject: Re: [PATCH v2] spi: cadence-quadspi: Fix pm_runtime unbalance on
 dma EPROBE_DEFER
Message-Id: <176053379406.136664.18129460150090147128.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 14:09:54 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-96507

On Thu, 09 Oct 2025 09:10:38 +0200, Mattijs Korpershoek wrote:
> In csqspi_probe(), when cqspi_request_mmap_dma() returns -EPROBE_DEFER,
> we handle the error by jumping to probe_setup_failed.
> In that label, we call pm_runtime_disable(), even if we never called
> pm_runtime_enable() before.
> 
> Because of this, the driver cannot probe:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: Fix pm_runtime unbalance on dma EPROBE_DEFER
      commit: 8735696acea24ac1f9d4490992418c71941ca68c

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


