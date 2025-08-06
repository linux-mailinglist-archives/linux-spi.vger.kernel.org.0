Return-Path: <linux-spi+bounces-9301-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D85B1C5DF
	for <lists+linux-spi@lfdr.de>; Wed,  6 Aug 2025 14:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A5BB4E2FA5
	for <lists+linux-spi@lfdr.de>; Wed,  6 Aug 2025 12:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19CB288CA4;
	Wed,  6 Aug 2025 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT+TFjL0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7CB221F1A
	for <linux-spi@vger.kernel.org>; Wed,  6 Aug 2025 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483488; cv=none; b=dbC0pSwG/deCRU68TeZChjWuQRIAuMYL9bo9jBnY47bAiJIdrxxgpLWMTEhEEFJUBbIdLBPpKOzdo61l8AzS98EmIGkEx/fN6i8yrmFDOwYXsyeacpauT51mzrSCGAar71uS3BL5hCzqzY/GwRXurzWJrFfIV7bVLaGwXHYpldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483488; c=relaxed/simple;
	bh=FFC9pRgQhsqnQb1w7Nn6I7yMkG5BPeWxZRIeBBGZbss=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XDMgD2lYolqAPHOheupMqcwMMk1ZPBfeWbyR1a7wVVxR3vIly58TY5l6syRBRZrnHnysXdprauI2steanJaypT0v3E7jRA7Cnnp1wPhDUjwA/eTaNhoau+tA5fXDavZtvTcTK7pwPo+1NIJnS0F/vASgSsGXle41fdC4jx4G7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT+TFjL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A37C4CEE7;
	Wed,  6 Aug 2025 12:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754483488;
	bh=FFC9pRgQhsqnQb1w7Nn6I7yMkG5BPeWxZRIeBBGZbss=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nT+TFjL0imbvqw8ZDDn6B7dvw7VmO4QUrzSzIARhcfN4tMuP1d4WM6Yc/yw1intKj
	 i3QKujIPfHnPiEYGeTO5wZueb4smIW3fWMKEOQ3pfkxbfcC7KRUEECwnuNYz5sMNpC
	 B7RcrcOX7A0PJJahUg/HhX2WcW7Cgr+9YDtWHy8tBQHiWFQT8O2+15QMxQY1+/F9Uo
	 2E/GuKZtIbO+Y7zOUtuvzV3z3UifAC7N+diOJsxrypVX7dN20IkQmQL5gtcTcuPJOT
	 KtAr4+ig2XvyGGjoVQgZGLpL34V/8n0MoLtLI4LS/pbSqn+7XHpwFIT/Hbx9q0KsYu
	 XnyL8CXFz+aCw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>, 
 linux-mtd@lists.infradead.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20250804095013.409700-1-miquel.raynal@bootlin.com>
References: <20250804095013.409700-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH] spi: spi-mem: Add missing kdoc argument
Message-Id: <175448348502.51843.4178346530523985516.b4-ty@kernel.org>
Date: Wed, 06 Aug 2025 13:31:25 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 04 Aug 2025 11:50:13 +0200, Miquel Raynal wrote:
> The "*mem" pointer has been added without description, describe it in
> the kdoc comment in order to fix the following W=1 warning:
> 
> Warning: drivers/spi/spi-mem.c:594 function parameter 'mem' not
> described in 'spi_mem_calc_op_duration'
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mem: Add missing kdoc argument
      commit: 72332439e6b0a39e763d4604e71774ab83423275

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


