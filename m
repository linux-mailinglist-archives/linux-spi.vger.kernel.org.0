Return-Path: <linux-spi+bounces-5608-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 320DE9BB72A
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 15:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6431F2235D
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 14:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1D61B3945;
	Mon,  4 Nov 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wuyirciy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225E71B3939;
	Mon,  4 Nov 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729223; cv=none; b=HwoevHOj8wc8uqv2IcP7PWjGyfKzg/9obwwPTilftk+nxh1Sn/x/flIyauZ7pmYqJhZ2gay1v8t3TBhAate20bDuA6Vw3PUB4Rhiln0EmUWcJl0Cc6KUtsvMiA8Q38iQ+4qWWcBpNDfjau3vx5cXsBT8dwPW0uRsb4X5q0BzpXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729223; c=relaxed/simple;
	bh=8zkMh7Y7RhrNZANlbaXQ/bvchiQiKX45qJfKlH1uPX4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=agAUBbqnTBYztdSEQjNJ+ZgjLfNCMhsW0DNpxlc/u4xbbshwk64C8eQF6gaU6n3LoBQKUEPbIV/5FwCF+TFzoL8Dwd0esXLUHpmN9oZbcJWcfTop3duVzffMRGPks+s1LsAUJ/MrT5hWCKBnIzuyfPvZ05+ELHRJgTDEW2qxGv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wuyirciy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA86C4CECE;
	Mon,  4 Nov 2024 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730729223;
	bh=8zkMh7Y7RhrNZANlbaXQ/bvchiQiKX45qJfKlH1uPX4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=WuyirciyR/Y/qm16X8Ejd4C+wT3YaHJCScA0VKtRArg+EJjVBclg49wVJGBJy62R4
	 DGzDWWlnjZm6a+ZW02+pGV5ZQPjNkQnXDhGvlcKi5QDYA0KyWn5+yAlyQNGvE32gG9
	 hAwdruziUxlAH+yxfedRftu+/1pPKCA8m4OgiNeMoJ+jE4lLxmKjur/l5xApFsCncm
	 FUiyPzunfNTilR4x1P2arrM7fZFSAaaG+7cPv4D3rrrtJdbxd46ek4ytC0aCQ8BaoR
	 hUu/wl27zEpNGh0vx27d3Iq2xoB1pkpe9r/TMufi6uSr+jRMJxXzx7kLEAF01c7D60
	 /o8QKIPx3ofeQ==
From: Mark Brown <broonie@kernel.org>
To: michal.simek@amd.com, naga.sureshkumar.relli@xilinx.com, 
 shubhrajyoti.datta@xilinx.com, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240920091135.2741574-1-ruanjinjie@huawei.com>
References: <20240920091135.2741574-1-ruanjinjie@huawei.com>
Subject: =?utf-8?q?Re=3A_=5BPATCH=5D_spi=3A_zynqmp-gqspi=3A_Undo_runtime_?=
 =?utf-8?q?PM_changes_at_driver_exit_time=E2=80=8B?=
Message-Id: <173072922129.32316.16371123096263241252.b4-ty@kernel.org>
Date: Mon, 04 Nov 2024 14:07:01 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 20 Sep 2024 17:11:35 +0800, Jinjie Ruan wrote:
> It's important to undo pm_runtime_use_autosuspend() with
> pm_runtime_dont_use_autosuspend() at driver exit time.
> 
> So, call pm_runtime_dont_use_autosuspend() at driver exit time
> to fix it.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: zynqmp-gqspi: Undo runtime PM changes at driver exit time​
      commit: 2219576883e709737f3100aa9ded84976be49bd7

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


