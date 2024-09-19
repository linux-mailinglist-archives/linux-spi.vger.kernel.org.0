Return-Path: <linux-spi+bounces-4863-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CD997C5D7
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 10:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7226AB20E4B
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 08:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936091990A8;
	Thu, 19 Sep 2024 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWWTebar"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A7198E6C
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734602; cv=none; b=XLbLrJ/UWA5j84pt6bJn0IlkFtq/td8/+nbW33Ul3LavD7BnZKnBp2PgpSLpPmGQNxZOhVdMl6tmv0Ot5j2lAmX41rPf2Vo4nNndqLurMxAVFjDocC6tH/UCrF9i53A6Dwpvw4duky50yTv+tYtk2lp7Ti6Wt+TVVYd2yEbTQ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734602; c=relaxed/simple;
	bh=/V6ckSt9rlF2Ghd/La3jfYZGsugwDECJeVQPyNJg88k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D8gCXXd/YIhtkKdpGgV1+iI7z5Rk/ocsk63ntF/FG1AaFYGhn+I+ldcT6kKNcaR6Cv0IKeOixTG/iMBNbkmXc5Sm+9mhEcyg3+py0q32I7c9qKpzqg3NwfTgT+nDgr9otLFsQa4B8yVJgaWajHMaqxSM8pCKZ07GrXDcTythvxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWWTebar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06620C4CEC4;
	Thu, 19 Sep 2024 08:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726734601;
	bh=/V6ckSt9rlF2Ghd/La3jfYZGsugwDECJeVQPyNJg88k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rWWTebargj9GDQaolP61DoYMRsuCcz4VezSrH5ZMTJyqHYng7fm1mShYYKao5Xdmr
	 BuT9AVIQIjJQrFgNh5pDlJZx0awyWdMBGm3RPkC+Tt0jAddar8qGFKY7qAzpz6ntdK
	 po+yFQpsYQCW7rqIl/kNAO3mjUsjJlD5FimTv4IrsRNL0qLKupXnVcNgtapT1vGx1c
	 1663qKEN1rIWyI2za3fIswF0Mp7fMFVTt5YKb5brcfk6U+KtOf/9nE5lE4xXt22fFr
	 myIOsE5+pcQC4bX+4RlnasP3W0/b8Pw2mqkPYUzFF0ADNHlVCXnI9TiZgJ6i81n5ss
	 8iJvxwv2eIfbw==
From: Mark Brown <broonie@kernel.org>
To: Ray Liu <ray.liu@airoha.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andy@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 upstream@airoha.com
In-Reply-To: <20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org>
References: <20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org>
Subject: Re: (subset) [PATCH 0/4] spi: airoha: Fix errors reported by
 mtd_test kernel modules
Message-Id: <172673459965.1807523.13398242599346549903.b4-ty@kernel.org>
Date: Thu, 19 Sep 2024 10:29:59 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 13 Sep 2024 23:07:12 +0200, Lorenzo Bianconi wrote:
> Fix errors detected running mtd_test kernel test modules.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: airoha: fix dirmap_{read,write} operations
      commit: 2e6bbfe7b0c0607001b784082c2685b134174fac
[2/4] spi: airoha: fix airoha_snand_{write,read}_data data_len estimation
      commit: 0e58637eb968c636725dcd6c7055249b4e5326fb

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


