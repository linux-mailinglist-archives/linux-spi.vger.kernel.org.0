Return-Path: <linux-spi+bounces-804-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E93A83CB0A
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 19:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2AC28B7A0
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 18:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2D71339A3;
	Thu, 25 Jan 2024 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qS1J1evv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68479C7
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207133; cv=none; b=VX04lBhtxH89zIb+mcXFvKuFXrUtMvmAY0atwlu3MVhbMYPsPEIPcnJi7/FHCp25anNfzMVx4rHUVUcu/d7MXW5osoUb4C8giUlZUcR0B/+WvAFr5OjJu0vPi79z7z3wz6etkIPId8Ibg8tOHncuneL9TbrHeDh90w+U2B1Rlj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207133; c=relaxed/simple;
	bh=LQmmZH9xsc0bc53gYmM1AJR6B4NXTv+yCBZTDxaB0Ks=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hawMck8V+iU2LqCS+OdNh7AyKXawktE0943J8GJFN/9at+jD6W/x4fYtBBnmb3kF5YiX5hpZ+7MYyih0nmKIAlEqHQEhd7Q07sAdsDMmnVYtyROHrsGw5JoegPTojDx4DvprOxBBx+QGvhooEPrnRw92gedlkEYi6xxVcVhFR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qS1J1evv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3FBC433C7;
	Thu, 25 Jan 2024 18:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706207132;
	bh=LQmmZH9xsc0bc53gYmM1AJR6B4NXTv+yCBZTDxaB0Ks=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qS1J1evvfyL+kMuGZLMlf0VVnIw4pGAbHAUMIb/bVT4Zs8kXwuzo28kNCVM4l6cgV
	 LgCCdoAEiwyrdfy4AY2RIMa5aF+H0T1iKd3aOIJywBsIvY6IB5yLJkpeg23iCA8VPp
	 jOBqN/eEJSAwWuNqK+ttEld+JejprEEmuLqJuxUeJ5dTfncXgSxXIDDnuFjEJwx5+/
	 +8LFWl5d7kUEgCc+nheBlQ/5UitUomi1kQWlPt1oF4VH9b9asBiyXVeV9PWm9OmmAF
	 Wyq5UVbai2kCW/SHA7UMakJoY3I1/ZJqgZMMvRxr91TI+ZQoN5/z4s4lsXa7ZCa70j
	 jQQ1I7ETcN7Nw==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: andy.shevchenko@gmail.com, patches@opensource.cirrus.com, 
 linux-spi@vger.kernel.org
In-Reply-To: <20240124174101.2270249-1-ckeepax@opensource.cirrus.com>
References: <20240124174101.2270249-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] spi: cs42l43: Handle error from devm_pm_runtime_enable
Message-Id: <170620713122.74091.11789056983185408744.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 18:25:31 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 24 Jan 2024 17:41:01 +0000, Charles Keepax wrote:
> As it devm_pm_runtime_enable can fail due to memory allocations, it is
> best to handle the error.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cs42l43: Handle error from devm_pm_runtime_enable
      commit: f9f4b0c6425eb9ffd9bf62b8b8143e786b6ba695

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


