Return-Path: <linux-spi+bounces-12000-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21984CCADB7
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 09:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B77F730111AC
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 08:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A6F2E22BA;
	Thu, 18 Dec 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFSSX/HS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ACE2BCF7F;
	Thu, 18 Dec 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046099; cv=none; b=fcu9vO/9UnJz0WnhX0W0fmRd6vsSEx7mpRQ7bppiMmjkJoWixZiSaM9mtcaS2gEhcKcSAnYAGD18Osw8c0LEMPDJtJ2+tUNz/HNccWpbIcCwvjkrX6jCzmLzxmwC/a7EKHXjgcgfo1a8YfKXDdgGU65kK0VmMvsGnt+ingLHvus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046099; c=relaxed/simple;
	bh=lwZky4Sy93K9y11fSHxmJSRldxUDXgP06dp7jqDCMlI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RI7NNWo38VyRD2K2YOBtJIqvNF4UCwqIn/+s0c0Zi6Oa5bEhpOrdIVkKfZpIh3/8O5X/ez26zelZNkxWGU5JBYNQ4xdDd78fGURy07BguMnUrlXqf4gbjNHZOYA7O7fPb0P44W/B3Q3e8BGjftvGbIk9z/aMvZQEGHWP0F9ZYjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFSSX/HS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5581C4CEFB;
	Thu, 18 Dec 2025 08:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766046099;
	bh=lwZky4Sy93K9y11fSHxmJSRldxUDXgP06dp7jqDCMlI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cFSSX/HSJ7LZ6qlKgCo2crWokvtu3I43Toqfg195RazIZYiSnNKRTALn5hHHmDl64
	 L+KgQbUDDi761XJ034i1NN+Q8JpzjSmZl/RJIZNTDcU/aH/Iwd+NpT3nZVh/GbCSnF
	 1G7q/N81N5+whcxTysGOM0CphtEi9GFLqD5DvFK+bFF8TszGFNrGIVD0TNsXs3h74V
	 Pg/gwwWhaLXK3NhiJSPGrm8CnosSoUyPeMLaiKbbhSfHqWygj730lm/iU/tciIUkGA
	 /xbYtni/ICrsDfuG+fvgpo6Ygbm5e7sqnk4jVOjCu6giKSonfjVwltKPR2YjjbETB/
	 b7IrGpzjtJYCQ==
From: Mark Brown <broonie@kernel.org>
To: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
 Chen Ni <nichen@iscas.ac.cn>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251217023721.1684244-1-nichen@iscas.ac.cn>
References: <20251217023721.1684244-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] spi: stm32-qspi: Remove unneeded semicolon
Message-Id: <176604609753.49312.11376425894198542181.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 08:21:37 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Wed, 17 Dec 2025 10:37:21 +0800, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-qspi: Remove unneeded semicolon
      commit: 7f7b350e4a65446f5d52ea8ae99e12eac8a972db

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


