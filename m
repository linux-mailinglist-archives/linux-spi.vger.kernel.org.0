Return-Path: <linux-spi+bounces-4885-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F74B97CA89
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 15:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3EC8B2390A
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DEF1DFF0;
	Thu, 19 Sep 2024 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJamlWko"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B1A1CA9E
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754113; cv=none; b=gchvscjT4Wmva2pnt3Iz4IWFZuy0D2WmyFFxF7fVDE1r1UBxbxE+svnnZF3amlYL3i0aPnKAXbWzqjtLrMccuqdZEfNOYuxUzwEl0qaivIafd3JdVfdoPeEujp6GYcLHHLnUZMb6H/WOaDIA3i5bmznmAD7bVLvIr9KXz2WBO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754113; c=relaxed/simple;
	bh=f1Pw3U2Q4kr9f2+PlSUNdRRlxkUWuANPSNA7LW8Oghw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dhYFK474ljBM+bXvbbCmcr82G2aHcjJmK9bGxIeIKu96IEdBFtdLSzJq1Z3ejXRDwAPpM3cpQTEhRUJoorNpea8yCehJXxv5Bn0HZclXoFYc1FRR/n50wm/wFH6FpPObO17l48pCPo3z/xVnKKp6rRm4+H6ewEnEfiWz50PS7uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJamlWko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407BBC4CEC4;
	Thu, 19 Sep 2024 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726754112;
	bh=f1Pw3U2Q4kr9f2+PlSUNdRRlxkUWuANPSNA7LW8Oghw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=FJamlWkoIlwijUtEm8YkKScD0pEa83xcTs7CI1Erxq6RP3au0PRowrVlCWoMm/F+J
	 1+hLFo0Nc8u3KW2ldq4w0GXVfLGKqhjUPs3vPjcP3ox/cBLDjeTBpzvrSzOyr68Vrl
	 ldfu4HH2WRs9o6eq1q1KBPaBp3K2a1ZpB6A/uKeUH1/Ce9Hf15EvRUOd+jGeUCt+3v
	 BRg8Kv8/lAZnaw145F4FHQNsxu4GGSFL73bn4d/yFbJfoGeNmE/ySXff8GcjW0P7fS
	 4GjHrClV0vQg+sxct4TK6oyk6YgS06nzA2UFHC3xSK+9P1XkmvePVkRH2rzeeCq0sf
	 QdBJYGbzEdKnQ==
From: Mark Brown <broonie@kernel.org>
To: xiaoning.wang@nxp.com, frank.li@nxp.com, han.xu@nxp.com, 
 linux-spi@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240906021251.610462-1-ruanjinjie@huawei.com>
References: <20240906021251.610462-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: Undo runtime PM changes at driver
 exit time
Message-Id: <172675411054.1834907.1811992365060406660.b4-ty@kernel.org>
Date: Thu, 19 Sep 2024 15:55:10 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 06 Sep 2024 10:12:51 +0800, Jinjie Ruan wrote:
> It's important to undo pm_runtime_use_autosuspend() with
> pm_runtime_dont_use_autosuspend() at driver exit time unless driver
> initially enabled pm_runtime with devm_pm_runtime_enable()
> (which handles it for you).
> 
> Hence, call pm_runtime_dont_use_autosuspend() at driver exit time
> to fix it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-lpspi: Undo runtime PM changes at driver exit time
      commit: 3b577de206d52dbde9428664b6d823d35a803d75

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


