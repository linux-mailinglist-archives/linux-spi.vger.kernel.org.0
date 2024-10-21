Return-Path: <linux-spi+bounces-5286-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 841629A72A7
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 20:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FB81C22915
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 18:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6DE1F9420;
	Mon, 21 Oct 2024 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsVcaczx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9661CF5C8;
	Mon, 21 Oct 2024 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729536852; cv=none; b=I4p2RJo7PvDzc7Y5yY8gK4FSpqTfIobkYDeCJW+zx9i34Wb4JP9euUlI5hNJJeMv4lK60mw4xnzMSTS5/OdxXTL4DiiMFbDexioVl6KTUf22UK119JrZnOKL+dq1x5Yxs9K9TF1U4yLhsaFo+PGg3gLr2P4m8UM9aE7mOOMfWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729536852; c=relaxed/simple;
	bh=OWlqbW+2Dn/AzRWzu0cQ1Bnyezpt2t6ppecw+i011ME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g7Y5WDDu37ceg2+Nvi+eVzny3OH+zXAYjxJHgNKFEatFH5xz14Dy2u9sgODbIwo1LHd+wk3Fwt1lK3Hc4LeYSTzL2k3FKld+kd0UUd0ryWZSgnePrOqekrGHtn07DIrDC1fvefjsQEuOLId1R1Aba2tZFbdEQ995cTsLWmlNO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsVcaczx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD036C4CEC3;
	Mon, 21 Oct 2024 18:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729536852;
	bh=OWlqbW+2Dn/AzRWzu0cQ1Bnyezpt2t6ppecw+i011ME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BsVcaczxj2gAoU8O7KbCqkx2gXKsCSXxRi63ZnDlnwNkPTiOt45hy8OgbR+8ZQabl
	 4M/m2Yt/qz4D/jptZciOZy3MzC1e/UJDGyq3k4mTnbZetjJxwiJ3iNtBFkssqDH2fQ
	 bNhkh55hRTjVNFZgRL3Hb7URom8fMh+wFAdkOdom5Szw0hnt4pM/hKssOlxRz/mZID
	 utgayqR3j33DBJG3Mb+4T/ehCMNZGUxU2aZ4z69RpKbsEbJtEfZ/pLk3XAMdzR6/RT
	 ePIXJ/0s9VJ1ABdV9VEKeTdUjkwlh6ZJc9uvemjnx9/G957DoTxzVb/LlXBAoRtHbV
	 QU5Nc/8lm6ihA==
From: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20241021142113.71081-1-brgl@bgdev.pl>
References: <20241021142113.71081-1-brgl@bgdev.pl>
Subject: Re: [PATCH] spi: mtk-snfi: fix kerneldoc for
 mtk_snand_is_page_ops()
Message-Id: <172953684947.122063.5239058776799131206.b4-ty@kernel.org>
Date: Mon, 21 Oct 2024 19:54:09 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 21 Oct 2024 16:21:13 +0200, Bartosz Golaszewski wrote:
> The op argument is missing the colon and is not picked up by the
> kerneldoc generator. Fix it to address the following build warning:
> 
> drivers/spi/spi-mtk-snfi.c:1201: warning: Function parameter or struct member 'op' not described in 'mtk_snand_is_page_ops'
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mtk-snfi: fix kerneldoc for mtk_snand_is_page_ops()
      commit: f2b5b8201b1545ef92e050735e9c768010d497aa

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


