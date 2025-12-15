Return-Path: <linux-spi+bounces-11895-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E59CBE958
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9099307FFDE
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057F133122C;
	Mon, 15 Dec 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmS5oqYB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07C7331226;
	Mon, 15 Dec 2025 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807169; cv=none; b=VvH5YaKCcmo5/UGBkuZcXkf+5XMixXeWjUJwB7TcHVTEQF80tSX0HBMeS6UXSKbnk9pfPjP3Xf/W9Uy7TRapok6rOYT0D5C2om30oy469tDtPUjrJ4XigOa04+l+xWj2GTEsTCSDd/jKOBM3OYIjUeyNyAJVWayhabbR9hpGUFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807169; c=relaxed/simple;
	bh=I90uO8DlabRsTe50gJeM0hZJ71d+H7R9d3RLmfZ0EuM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g31AzqsPqjOIV8NtObJJK3lBjUKylE8Ct1urziralAt3nw4NyAo+plL96LpG4t2p1fUKqV6hIHN0e237r6IeeZv9ZaF3l89SJeZHGc1oy+bjL8MEZYhRA6kz8siI6r75HBBkcLaKI5MkIbdiS4iki/kGhxqRkOZ9dz1sVNy6zlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmS5oqYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E9EC16AAE;
	Mon, 15 Dec 2025 13:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807169;
	bh=I90uO8DlabRsTe50gJeM0hZJ71d+H7R9d3RLmfZ0EuM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JmS5oqYBQOFERCFbS1mCwgmPpB4RKQt5k3x4hcoNcV5lvrfV/ag9fO5SebVSNAZJ0
	 +KfjW1i/iyp5V31jpHLuQUhFuTh58OA7ckdEUXamkrm2MpCv/Fly9r7cTyVabOVzW+
	 +cD+RbTWVSDTz0AmaYMK+2ftUcSxX7S3i8TFtVdISMyzfIvdueMuZKPHiJK9TlrWTP
	 GnAqlXuhdkm0/NH8CFJAcXc9W8kg/eS5TbG95i5lYWbTn/P5D/iF419YQDHV47Ri0x
	 GhRAVohuKSJRGqYpv9NoBXqakNqw72XbY+TWlkYZWfpgLxl2cC6s4+zW5uRfFp/Qob
	 1pRuUe0BOGVZQ==
From: Mark Brown <broonie@kernel.org>
To: Akif Ejaz <akifejaz40@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alitariq45892@gmail.com
In-Reply-To: <20251203181921.97171-1-akifejaz40@gmail.com>
References: <20251203181921.97171-1-akifejaz40@gmail.com>
Subject: Re: [PATCH] spi: cadence-qspi: Remove redundant
 pm_runtime_mark_last_busy call
Message-Id: <176580716842.161463.10027388090640755995.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:28 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Wed, 03 Dec 2025 23:19:21 +0500, Akif Ejaz wrote:
> The pm_runtime_mark_last_busy() call is redundant in probe function
> as pm_runtime_put_autosuspend() already calls pm_runtime_mark_last_busy()
> internally to update the last access time of the device before queuing
> autosuspend.
> 
> Remove the pm_runtime_mark_last_busy() call from the probe function.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-qspi: Remove redundant pm_runtime_mark_last_busy call
      commit: 28d21dfcea0121afec04451733a6c553fd319c8e

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


