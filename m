Return-Path: <linux-spi+bounces-5096-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851BF98F064
	for <lists+linux-spi@lfdr.de>; Thu,  3 Oct 2024 15:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8901C20CB1
	for <lists+linux-spi@lfdr.de>; Thu,  3 Oct 2024 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD2E15E5D3;
	Thu,  3 Oct 2024 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwplVRN+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07014C70;
	Thu,  3 Oct 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962233; cv=none; b=FJGDpJeSN3pBcWt7bbbT0CzxN1TxvI+yokhJsC2gAeMtCtrBScQAAod/sVVItiQTbP1zqIl0D5pBHlcyoPsY6jA5EpGFZFg4+ecGPOcpFEkraGA5htNbHWpj2RBNvnhrmbT5zlXTPHEu3+eYzhtq9402Y3X+gpp2wYA7Qs+0w6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962233; c=relaxed/simple;
	bh=pHRbWBDHREJSqzpsVJJd5IeG+i5fBE9YBM90wmPmc4A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GhlO5ZnvIMY/Zl0OBKH7yDdnd4yIJxgMPO4WGyt9+3mBAuNcNkwDjz+I1tL4Ds9g7GPNI+8BSexirMJ/yamDpBSGk7BaQ7AldrfnKVcbGfwFoqxQDdr5vXZZGFiy9G8PGJqvJ/TpbCSbrDmeqeS/ceoEhvwIdkINIJJZBif5nQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwplVRN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976F6C4CEC5;
	Thu,  3 Oct 2024 13:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727962232;
	bh=pHRbWBDHREJSqzpsVJJd5IeG+i5fBE9YBM90wmPmc4A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OwplVRN+XUYOc7Tp8PpUZHUlGo6cELNfDMSRLvx3iiNqOuLZl/As43+NWGpdagvXB
	 wxN4J3MNLX1E5Eq5swrREAp7Cgz6mu9p7hUgKTuxnylfWzeGFGtiL1A+hGfUFWzuHd
	 4dWvBDWg5GVIKn189en+MjTnJFSmjtE1z0EzegUXL4wbS8pOnDmxepNM4MUTQOCYEA
	 VLO4zXhgj6VKq/lsCJaVS9gCOWACqi8mVw9EFRd91WTHtRWcc465+MxGS07psWfkoS
	 Uts3P1RhnAKN4roa9su4T28eC0/OPUY2Aqp8Xpa8GF3Jl4Ir3K55DEVbjBNpbWr0so
	 eoNj/MnQ5haCA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241002162652.957102-1-colin.i.king@gmail.com>
References: <20241002162652.957102-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] spi: spi-ti-qspi: remove redundant assignment to
 variable ret
Message-Id: <172796223030.102453.17964438247890503921.b4-ty@kernel.org>
Date: Thu, 03 Oct 2024 14:30:30 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dedf8

On Wed, 02 Oct 2024 17:26:52 +0100, Colin Ian King wrote:
> Variable ret is being assigned a value but it is never read, instead
> the variable is being reassigned later in the exit path via label
> no_dma. Remove the redundant assignment.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-ti-qspi: remove redundant assignment to variable ret
      commit: 46854574fd76c711c890423f8ac60df4fb726559

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


