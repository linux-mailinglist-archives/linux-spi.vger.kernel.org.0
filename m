Return-Path: <linux-spi+bounces-4750-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBD097213E
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 19:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774D61C236DC
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 17:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A4916DECB;
	Mon,  9 Sep 2024 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9gBvpOP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C758720B04;
	Mon,  9 Sep 2024 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903800; cv=none; b=gjAdoXr0xZXXraESINt1/jOcnFpFFvBvlfTriUlKPM0hK/CGUubE0PYQo9TJJ8SamUlbIpajHpY02rQyWOJFFz6bC1yFhHKwljh23ZzCkuipXdPC+r+4ibyil8hsJdcW69zO5bS+KKkWtd2jGsww0TIZ94V0XJt4A2Ri0KfVjjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903800; c=relaxed/simple;
	bh=cS0uFZhcKMGP6x8N/zvxqnv9L/C9WqrH7mGUzGeHIqU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PbNkgok01iZgJ9esH8ktqvA+F/ZvuHT3l6cshMcpSdiGZFc7U8qz7ArFb5D4HCC/6ghPQxyCuT+Mj9FU8fBf8piBwOJHLmyf+5d8yTeV9fKwC0VcXIlJglx2d49xtxgzrtj/zvw05zkzg56+c9e0sqiAw0r4Rb0cEJw67qZ5Gag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9gBvpOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242C8C4CEC5;
	Mon,  9 Sep 2024 17:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725903800;
	bh=cS0uFZhcKMGP6x8N/zvxqnv9L/C9WqrH7mGUzGeHIqU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=V9gBvpOPC54BiWYa06gnm4cPvKsxV+ZpJMxEbX1woW198bYCl1zZBRNbbaJLchrgC
	 od0Qquw4jv1zBjHzcV0wRUje0YRjOTEtqFvmXf30LmY4wzZXkfeVEzKvcmu1DFnZgZ
	 j5A2B+J51breLCc4MYdqzqYO1R6kUHKqLHils+6M0y0+Rv8MLI77z2Di83HHnBYfZy
	 6VZpeqBNye+2Ax9wtDnKTC2ngKHpx7DEyjyJoGeiKPgjTteJgirSKaG7hbgPmbtcX7
	 AZOgLXnLclQ8Qp91DbHQUG6Z5+EVaksO1ASE272Dc8oWTmgvjdPRlOMyrl+MeXwc3d
	 LFZSP4/PyE3gA==
From: Mark Brown <broonie@kernel.org>
To: dianders@chromium.org, vkoul@kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240909073141.951494-1-ruanjinjie@huawei.com>
References: <20240909073141.951494-1-ruanjinjie@huawei.com>
Subject: Re: (subset) [PATCH v3 0/3] spi: geni-qcom: Undo runtime PM
 changes at driver exit time
Message-Id: <172590379886.101587.7270716934939509618.b4-ty@kernel.org>
Date: Mon, 09 Sep 2024 18:43:18 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 09 Sep 2024 15:31:38 +0800, Jinjie Ruan wrote:
> Fix two bugs for geni-qcom and use dev managed function
> to simplify code.
> 
> Changes in v3:
> - Adjust the runtime PM patch to be the first.
> - Use devm_pm_runtime_enable() to undo runtime PM changes.
> - Land the rest of the cleanups afterwards.
> - Update the commit message.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: geni-qcom: Undo runtime PM changes at driver exit time
      commit: 89e362c883c65ff94b76b9862285f63545fb5274
[2/3] spi: geni-qcom: Fix incorrect free_irq() sequence
      commit: b787a33864121a565aeb0e88561bf6062a19f99c

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


