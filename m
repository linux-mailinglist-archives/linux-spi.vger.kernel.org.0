Return-Path: <linux-spi+bounces-725-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ABB83B0BD
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jan 2024 19:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B836D1F2228F
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jan 2024 18:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6F812AAD1;
	Wed, 24 Jan 2024 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivA/deTp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E6612AACB
	for <linux-spi@vger.kernel.org>; Wed, 24 Jan 2024 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119900; cv=none; b=ik+YKAVjwdQucp5tlGgjryALEuACC/z25s0SR6Uz2gqUmcMgPZepGx7SOXxP0D5MUFsSHVCHqrjvTVDNXVR7LP85A8SGDQG4D/Y27hk4EfKn3IQ983n5Kx+ozo6uar9jYwuMvBvkc9w18pw3U/JKoE3qZuvsMVhSFTv8lSRPda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119900; c=relaxed/simple;
	bh=4ENjmJ8LtN7u+lth485gOdi71Dc/7RbY+mtPXDQteKI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZSKT3BT9JcCOI3IpdXDNfmbVsvrvngnJuPPhrxXnJ37bhsIvNX8efPmqWALsTMBEAX66C4peaDRkpvqhSo7woIhPQ0vYXXw+yZjy0NoIsJMd7SYwvdeJraxSH95xzOZYMPkOWGgConm/DhhOSnOQhuTHbIdMQuAQuvQGUDgbGIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivA/deTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5254C433F1;
	Wed, 24 Jan 2024 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706119899;
	bh=4ENjmJ8LtN7u+lth485gOdi71Dc/7RbY+mtPXDQteKI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ivA/deTpGAuKl7LQpL2n5/fvdG/UO3XkjRe9DascHECSmveoZU4NsUvEzJJ4COLxN
	 7U81bBZcwu2Jt8s+/W/bycPFFoSS3JjydulNmESBxMOb1KmX4jdkrA4Ze4JgDRrmlG
	 BWR9WmCamlpabdnRKc960UXr5rHeEio4k3N6mLaVB/e8aIa7ZbNIH70xP0AMBQLRoU
	 9w1nRnq/AmeqB+/P6gl95JhfmNJBtInB1jIj6swzVYBG5kbEEyqHQEKemR+/s28IBh
	 e1fQMpC1PTbwSZ6lpJ9hkZEb1I+nejDS/qbLH3GJp4QPwRxUr+i4EyKzOFXWFqqOuo
	 2jsBzrd7DlN0g==
From: Mark Brown <broonie@kernel.org>
To: Devyn Liu <liudingyuan@huawei.com>
Cc: f.fangjian@huawei.com, jonathan.cameron@huawei.com, 
 linux-spi@vger.kernel.org
In-Reply-To: <20240123071149.917678-1-liudingyuan@huawei.com>
References: <20240123071149.917678-1-liudingyuan@huawei.com>
Subject: Re: [PATCH] spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts
 were detected
Message-Id: <170611989846.57421.1409832807563728076.b4-ty@kernel.org>
Date: Wed, 24 Jan 2024 18:11:38 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 23 Jan 2024 15:11:49 +0800, Devyn Liu wrote:
> Return IRQ_NONE from the interrupt handler when no interrupt was
> detected. Because an empty interrupt will cause a null pointer error:
> 
>     Unable to handle kernel NULL pointer dereference at virtual
>   address 0000000000000008
>     Call trace:
>         complete+0x54/0x100
>         hisi_sfc_v3xx_isr+0x2c/0x40 [spi_hisi_sfc_v3xx]
>         __handle_irq_event_percpu+0x64/0x1e0
>         handle_irq_event+0x7c/0x1cc
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected
      commit: de8b6e1c231a95abf95ad097b993d34b31458ec9

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


