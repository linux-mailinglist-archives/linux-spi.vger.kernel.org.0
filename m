Return-Path: <linux-spi+bounces-9882-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E246B42621
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 18:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C30162F45
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E5329A9FE;
	Wed,  3 Sep 2025 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPvp5DkQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8971DE4EF;
	Wed,  3 Sep 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915282; cv=none; b=PRSDBUq+DgjTJr3Vtfg3hvDxkJ+Ytpt0jipMIPMdaAvD8FnCOoTQO9arZtFwKBeyve5+hDJLsJFat2EoyIppQAfsGCxdt6lWUSw7oaWtzyz4iwwNzW6oMvp/envBUHsSiwBg0Q6Lga2nV7JDXpWZFCfj3qtfbxsG+MwMSgV9EUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915282; c=relaxed/simple;
	bh=i64CAWts2YZ6ybHu6F+iqKIBJLQf3nzp1WavcnOp510=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TOJQk/Gx41JyhQ/4hOXqrQP3S9j2IXvYpm2WC2cSj9iAO+gZRYJzGatLLfEP7Wbf2ODBfNumJAhgZKnyp7FRFi8gEUYqcXM2b07eza1C/0HztXeQludupJumPlNlUAau2OI7fu6Htjh3i2M4eNyUz+Sfh77vWfXl+ZiMcWtPQxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPvp5DkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D926C4CEE7;
	Wed,  3 Sep 2025 16:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756915281;
	bh=i64CAWts2YZ6ybHu6F+iqKIBJLQf3nzp1WavcnOp510=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YPvp5DkQIUoxNhjrv6C+TlILkp0bg1VKng2cJr6TvcYFaOw/1qIBc3dyPlHQnWT4s
	 S6+F2IgOXfSyNHiOvfkPLKwNs4+YBpe+2VpUqFl8Lq2ZedQP869JIOBlEEuLvzYv7G
	 K0HSjk6o9xww+RjH8g1g0anFE9RbwdFXYMuaqYD0CfhUbpega38mWU4yp9DMx6axwC
	 WI8+F4BmH0OFhR2M3S8WGGKnOg2UnM9gMLfadym4d7YRemT737lzZpnV2rUhf9j+Hi
	 BD5cxpCHHrNQmOIPjXS5V1yk/+DBD/mzHuc6GKL6tF+WgILed8Viu0qfs07YncM4YC
	 clhJTR8FANcaw==
From: Mark Brown <broonie@kernel.org>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, 
 Xichao Zhao <zhao.xichao@vivo.com>
Cc: kernel@pengutronix.de, festevam@gmail.com, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20250903020347.563003-1-zhao.xichao@vivo.com>
References: <20250903020347.563003-1-zhao.xichao@vivo.com>
Subject: Re: [PATCH] spi: mxs: fix "transfered"->"transferred"
Message-Id: <175691527998.217160.2520958272233581688.b4-ty@kernel.org>
Date: Wed, 03 Sep 2025 17:01:19 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 03 Sep 2025 10:03:47 +0800, Xichao Zhao wrote:
> Trivial fix to spelling mistake in comment text.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mxs: fix "transfered"->"transferred"
      commit: 94b39cb3ad6db935b585988b36378884199cd5fc

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


