Return-Path: <linux-spi+bounces-6330-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B4DA0BDDC
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 17:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659891888F95
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0739920F096;
	Mon, 13 Jan 2025 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTEaETqr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9D820AF8C;
	Mon, 13 Jan 2025 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786711; cv=none; b=dHaybyitTmSm7UASNUyOOPHsmCXFHgqsuGmYPnLgYCcdzePFIlkqF3STu+jX2g348lQmnKw3NDKYIXo3XbgpR3mAKit3BNqeUVMUj+3ARiNSagrpyTo9As8AbU0iLH1vtbA7jIaRzDk3wwdy+Wi+k7TT5WFPMLrsj/jcK5PF//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786711; c=relaxed/simple;
	bh=r2aPD4W4PoU8dkdVZrPxegFIk2Ob9+DmuOGvyINAld8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iIx0HoxFNe1ccqPyx0WDOjL6VU5Qh0B3UlUE1KIuhL3fnril1EOA8A9tvbtN+vMbBLfM9HZ0AXvq6hcKFmSbp7nqI9gETCcuO5Dn0PWbuoswVx4rpSDcFuY2HurK3bv2d502vcfTPmAezMdXvdTH3vkfVThqfPg+47rrfiMsQTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTEaETqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2C7C4CEE2;
	Mon, 13 Jan 2025 16:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736786711;
	bh=r2aPD4W4PoU8dkdVZrPxegFIk2Ob9+DmuOGvyINAld8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bTEaETqrfUt4Gw6iV7vKqW/cTaFjTXKj27EbIoHE5MEb6zGrLyfnT2TFf42yZxbEM
	 ACSVlmJrxWygHMuTOYAXU5yc00KT80Opc3JhY060qgkEjcfNFRu08uxqytf3v9qC9i
	 Na1mG07MYaYEsAnNr0ZBTqTxw/t/+v/k0AlxwFhMW3dj8T6ClmdjBafETKjrSpGiOf
	 DgsSTZ5TFxzVwT6eNpT5W9mYebSMAi4hkUxaZa4xuIii0Xb1Wk4LFYpy0FGCYIdR9P
	 IizLxKGWh1YP821/obgYBkSh9US1gG/wXxrqm2X2c/XFeRwRjYfUCBzLMkdP3fjgZL
	 RYx/63pBD6dfg==
From: Mark Brown <broonie@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Nathan Chancellor <nathan@kernel.org>
Cc: linux-spi@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, kernel test robot <lkp@intel.com>
In-Reply-To: <20250111-spi-amd-fix-uninitialized-ret-v1-1-c66ab9f6a23d@kernel.org>
References: <20250111-spi-amd-fix-uninitialized-ret-v1-1-c66ab9f6a23d@kernel.org>
Subject: Re: [PATCH] spi: amd: Fix -Wuninitialized in amd_spi_exec_mem_op()
Message-Id: <173678670956.71125.2320310623665812760.b4-ty@kernel.org>
Date: Mon, 13 Jan 2025 16:45:09 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Sat, 11 Jan 2025 12:08:38 -0700, Nathan Chancellor wrote:
> After commit e6204f39fe3a ("spi: amd: Drop redundant check"), clang warns (or
> errors with CONFIG_WERROR=y):
> 
>   drivers/spi/spi-amd.c:695:9: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
>     695 |         return ret;
>         |                ^~~
>   drivers/spi/spi-amd.c:673:9: note: initialize the variable 'ret' to silence this warning
>     673 |         int ret;
>         |                ^
>         |                 = 0
>   1 error generated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: amd: Fix -Wuninitialized in amd_spi_exec_mem_op()
      commit: ea2680e9cc96b957927ea3ea36b2b4ecb5da3d03

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


