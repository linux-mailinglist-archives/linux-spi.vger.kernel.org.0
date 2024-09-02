Return-Path: <linux-spi+bounces-4513-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20528968AC4
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 17:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02A2B20DB8
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 15:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A23183CD4;
	Mon,  2 Sep 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FixFN8UR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313F1CB50B;
	Mon,  2 Sep 2024 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725290325; cv=none; b=aQdujZI3UhAWCH7Hjo+8Jzd6LhQ1rW6Bfqn0e2NVFHhvOrZbbTcfSrY9dhmrU9o8L3+4NeGg4LxbxW3HP2qj9CrV7buvPAaIiMqhuwjSg0ln2DqAA0dc4+8TnLKnostCKLaSEFaNY75T7Y0Q9q+qiX9D5BYCVOP/qIfXcPzz5Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725290325; c=relaxed/simple;
	bh=ClaXFzaPRSXmVrmJrt3ZOQE1vOA1eEQUJUITG0v52V8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S9M3lLQCACzkLIu86kMPiS0aeoVr9AFlz7Tk/KpYExcbN8jjpBicTyETH6W9aOmQuJs4KJhdEitPRlKxGvn9pZX2tRrCmWBmnpfzO/c4h8LdTuGw7rVsnMCjdOOt37LkKlQjbS7rsabuhYEJT1/UNYV1R3gGLZ928zzoNWqk62Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FixFN8UR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A9BC4CEC4;
	Mon,  2 Sep 2024 15:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725290324;
	bh=ClaXFzaPRSXmVrmJrt3ZOQE1vOA1eEQUJUITG0v52V8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FixFN8URxHzkZ3pzpoTWyeWzNzVajjEIL4jx9cdMSxQG6H5PTYG5rdC4yMAkWsoAa
	 r1INi96CViIBJ+uepPJyDZD04M8X6YTFo+8kfB3TI7ObRNufQ383iQXf9gA6RKi9LC
	 vlbhQmPbhPdca0MLYAOLKOlsVRZ1UsRgZJcs3XdOEzKWrAIjW0bYixBsDYOcx/0IEj
	 NrLPUlv7mDoJ7NZH+QZj1gHxWgYdgCL4zIuYzKdFzvedObI3JY7BgopUHJa49KNdmU
	 XI428bS+mNxJzlSN06IP3ayVFA1cMu2yB59LOT65T/mNtjajKH/XNOglabC10KQYvy
	 /1j6guzk1ERhQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Liao Chen <liaochen4@huawei.com>
Cc: jonas.gorski@gmail.com
In-Reply-To: <20240831094231.795024-1-liaochen4@huawei.com>
References: <20240831094231.795024-1-liaochen4@huawei.com>
Subject: Re: [PATCH -next] spi: bcm63xx: Enable module autoloading
Message-Id: <172529032321.103244.3746881658811312741.b4-ty@kernel.org>
Date: Mon, 02 Sep 2024 16:18:43 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Sat, 31 Aug 2024 09:42:31 +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
> on the alias from of_device_id table.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm63xx: Enable module autoloading
      commit: 709df70a20e990d262c473ad9899314039e8ec82

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


