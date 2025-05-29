Return-Path: <linux-spi+bounces-8330-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F65AC7FF8
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 17:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C614E56C7
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6540922ACCE;
	Thu, 29 May 2025 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOQS2LLM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4001D6DC5;
	Thu, 29 May 2025 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748531239; cv=none; b=XSlt1zsdRuByudzeF05UY7gLbljWC+za52oWF5BR4TqaMr/J/sO0io2x7rtPiFx+GaspgSJ2QYbyPEBCZIq50c/IHllnvxaeDcLXjLLZFSp6lV2/w1IuxrbalrECTSps9HW0dMjmD9dO5xBbbjGmVWUwkhrqL9YfHn1YbddLyJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748531239; c=relaxed/simple;
	bh=7Uuer2ZMLk3n/otquF9YSCMQXFD4ZRTJB33B7pmdhyE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HSGAMtLtSlySQHDUjmzaO62CHpi353Rg8LEYT3BtGRdu/uiE8KCV9wnZDFvBVxURaZ43KGpdR/mwoAfGn4KPGfiPupbd/eVrZUDwGb56Hr0NahgZHFeclBt0E/Y+KzDZdscOjNJyIZjllDyrGaqSHKyQ5x/8uAOpdeuQjPoW8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOQS2LLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A089CC4CEE7;
	Thu, 29 May 2025 15:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748531238;
	bh=7Uuer2ZMLk3n/otquF9YSCMQXFD4ZRTJB33B7pmdhyE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BOQS2LLMsIB/LXRcGH2mvdym55pwQ2s1SGKjy6t7HhjIh7v0bh0xsB2G0pYCheYvF
	 Rq/28ZPNJPWrOvBLC6+wMsmLLn4YHrRcFQ+qj3UTLwMwQL0PpYV31Q3XmpmnTVaGio
	 49/imMN9oV3gXI2McxBdqK/KOYoYjWfKtSpAN75+txfUj21HJ9X58PcM9rg/+mphZS
	 4s08H8PdyI45QRKQkkPoKD/ntGt2QMKUke/xSVnr9kikUHJwSqytsWHpjsDg6uVPzi
	 2V1voYIeVwVFvOOCvPCAoDxEECDAP9vDYiQmS57uQXFrtmSz9+v0weK1ALg9Rzmp0u
	 /TplQizW+dxyA==
From: Mark Brown <broonie@kernel.org>
To: prime.zeng@hisilicon.com, fanghao11@huawei.com, f.fangjian@huawei.com, 
 Yang Shen <shenyang39@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20250529061406.183992-1-shenyang39@huawei.com>
References: <20250529061406.183992-1-shenyang39@huawei.com>
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon SPI Controller driver
 maintainer
Message-Id: <174853123734.49583.13550481147232391697.b4-ty@kernel.org>
Date: Thu, 29 May 2025 16:07:17 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 29 May 2025 14:14:06 +0800, Yang Shen wrote:
> Add Yang Shen as the maintainer of the HiSilicon SPI Controller driver,
> replacing Jay Fang.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: Update HiSilicon SPI Controller driver maintainer
      commit: 3b5d1efc878adee4835165663297a75193343d37

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


