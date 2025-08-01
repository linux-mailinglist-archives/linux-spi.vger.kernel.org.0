Return-Path: <linux-spi+bounces-9263-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D564FB18739
	for <lists+linux-spi@lfdr.de>; Fri,  1 Aug 2025 20:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BFDAA09EA
	for <lists+linux-spi@lfdr.de>; Fri,  1 Aug 2025 18:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB10287511;
	Fri,  1 Aug 2025 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vF7ndXBb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7013441C62;
	Fri,  1 Aug 2025 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072040; cv=none; b=i9lOy0vZh6W4oeK954vPpc4GbuRX3taTeUNl4ct5SWrNRXcbVOO2mSP9hMehIrIybVRfxvWa7dw0p6kuPJt0eqaUJB9REykH+lkksZZD1xK695GplHjh3SObxLmaH56wr4ARxO819LA6TSMfWsDegDPmEUZmNvDdeXO5fM7aTv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072040; c=relaxed/simple;
	bh=6Z7i5YajHNTIkkMs+weIqxL2dvnDzhrWWIA+qiSFCgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LDmavNgBAtqCwMGIfkZSBH+TGHgsjbj1wauzNDpRrH9dozkgdcjUAMpGbmcy7zzQdn4wMxE+qXdFmeXdzNTx7tZM6Vj7ma2fETOt4xyQ8U+2ZLEEnTHI88sTGih6D/c1LoMZC5EdZhHp3ZE5HWPfAWaR2J9mNfs3nb7IHMklGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vF7ndXBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F033AC4CEE7;
	Fri,  1 Aug 2025 18:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754072040;
	bh=6Z7i5YajHNTIkkMs+weIqxL2dvnDzhrWWIA+qiSFCgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vF7ndXBbrJEWlueEh/oFS5irY7lyj2JePvxLctiKBLKgivFTbQ3ArdL6o7dXHcl9v
	 dxcfcl5OwykClkWeyEMZGad7KiU+k2x4WGa9NxTwN2hgyVPtE4zG/khiOsyrb7pWng
	 XubgHS/7+K0eVCiC64fuzar3vOxdIT3TlTneEDi1xchT4ezG03z2aM8OFYvBA9ee7d
	 4yI3eLzxhPUXCOyw7SD4ScHaKT+/kBVnrL+iW1fkCSgMbTwLra5jydS1RtcGvCprin
	 gtD+0G1waVwcv0AytYE2mKd+dBSrUV6o7j7fhxCPpKN1XJx9an08cIR/DqrQL7Ojgl
	 WUjMK1/hVwx9A==
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20250731160109.1547131-1-simont@opensource.cirrus.com>
References: <20250731160109.1547131-1-simont@opensource.cirrus.com>
Subject: Re: [PATCH] spi: cs42l43: Property entry should be a
 null-terminated array
Message-Id: <175407203870.139709.8000597693697838500.b4-ty@kernel.org>
Date: Fri, 01 Aug 2025 19:13:58 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 31 Jul 2025 16:01:09 +0000, Simon Trimmer wrote:
> The software node does not specify a count of property entries, so the
> array must be null-terminated.
> 
> When unterminated, this can lead to a fault in the downstream cs35l56
> amplifier driver, because the node parse walks off the end of the
> array into unknown memory.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] spi: cs42l43: Property entry should be a null-terminated array
      commit: a735ee58c0d673d630a10ac2939dccb54df0622a

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


