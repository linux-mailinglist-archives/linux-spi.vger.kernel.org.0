Return-Path: <linux-spi+bounces-5059-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA7E98AF4B
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 23:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5C1282AF2
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 21:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CCC185B77;
	Mon, 30 Sep 2024 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmN7ZvY3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44BB17BED0;
	Mon, 30 Sep 2024 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732521; cv=none; b=u9d5SHf145pwh7nPzlOOargYQsyduKBXMfLrKvgg2wihte6YlNhKGk7gcVjtdsv4MbqFtn2Zp0afP/HZWUvfS16TPx+d9Jx+u5k0/IGU1UKcBJn/oHqm8pG8BrmOZ8G7v97iqDrT8P0sUeSG35o3VRIm8ri0yWDBC3TIifZPuLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732521; c=relaxed/simple;
	bh=8H/vCVexZKk3SDms5mmWuT89Z7hKTzNWvCultJ7VfuA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=suMmcfGOW9NGlk4kCh7JVdS18le741eu5IYZXJvKijUefvOCdyheMbKsfr/YFbgK2TApK6muTNwKZYYp3tL49OSgnPK111MgdclGGwR49dkKJuVdEgWFGvA3qZeNgz3T902pElG1Ap4zcCAl1SNhVZC01we6HvxMzoUEHpkaZd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmN7ZvY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D321AC4CECD;
	Mon, 30 Sep 2024 21:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727732521;
	bh=8H/vCVexZKk3SDms5mmWuT89Z7hKTzNWvCultJ7VfuA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LmN7ZvY3QGebpDNWHs/jPuBNs1YYYRJzvHWp9Y88/V82P8WuG7bvWr/xVPbw6ys26
	 iC8ec8ANXkSJsE0JPlVZNjAe+nrR8XzivK7Aeb9L5lfFLgIIZZ7zRsps7m0F97L4/D
	 OkziEhDeY8Sj/ApgIDB9ZwXOqtm1ogEAozyM8yvE0NpEkHZdjc4YybCVLXlbnSYaLQ
	 fZviz3ZmLSuxuALffXzIbj3Arjk8ngjN9L4F8HtJ+vVmhpHdz1Lb4klVRHWoo52bCE
	 X1PgrijvxG+eabKz6KOrg4zNkZxnH9TNSfbUxmN09bdhFLqnc0Y/9OmOp2DfkoMYAp
	 IdUwZlznrRicA==
From: Mark Brown <broonie@kernel.org>
To: f.fangjian@huawei.com, linus.walleij@linaro.org, heiko@sntech.de, 
 andi.shyti@kernel.org, krzk@kernel.org, orsonzhai@gmail.com, 
 baolin.wang@linux.alibaba.com, ldewangan@nvidia.com, 
 thierry.reding@gmail.com, jonathanh@nvidia.com, Yan Zhen <yanzhen@vivo.com>
Cc: alim.akhtar@samsung.com, zhang.lyra@gmail.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, 
 opensourec.kernel@vivo.com
In-Reply-To: <20240914095213.298256-1-yanzhen@vivo.com>
References: <20240914095213.298256-1-yanzhen@vivo.com>
Subject: Re: [PATCH v1] spi: fix typo in the comment
Message-Id: <172773251765.2210210.17538340798969212217.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 22:41:57 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Sat, 14 Sep 2024 17:52:13 +0800, Yan Zhen wrote:
> Correctly spelled comments make it easier for the reader to understand
> the code.
> 
> Replace 'progrom' with 'program' in the comment &
> replace 'Recevie' with 'Receive' in the comment &
> replace 'receieved' with 'received' in the comment &
> replace 'ajacent' with 'adjacent' in the comment &
> replace 'trasaction' with 'transaction' in the comment &
> replace 'pecularity' with 'peculiarity' in the comment &
> replace 'resiter' with 'register' in the comment &
> replace 'tansmition' with 'transmission' in the comment &
> replace 'Deufult' with 'Default' in the comment &
> replace 'tansfer' with 'transfer' in the comment &
> replace 'settign' with 'setting' in the comment.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fix typo in the comment
      commit: 89980d3a34655d99c599f6acf877fd48775a29ad

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


