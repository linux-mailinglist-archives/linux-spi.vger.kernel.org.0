Return-Path: <linux-spi+bounces-6080-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5309F4C5B
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 14:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74161892F1D
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E156B1F4288;
	Tue, 17 Dec 2024 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzzba+p5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98721F4285;
	Tue, 17 Dec 2024 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442056; cv=none; b=S8GWvaOflPtxSllxnB5WXVbXc9SwagmanJqxQbh5PGpO6JqqJTzzgEKE3fmi9WjIeI0de25Nu/nCQUhp8yrPjqFa7HdQrGt6XiMDtJFznSOHb0VT8w2e08qpw+Ij63SXiqU+v53pZnNsntEbD/HD5xbyR/Lmra6mZF8jRvkfK/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442056; c=relaxed/simple;
	bh=pvcne/S7h5GxuzsVAtKGGhSARJDAW+nt0TG3iuNsj+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gTKcjuaenHZ+fLqHhbUs+ne2iwdcDgQolBKbxpw5KMrTJ3MUrrSy/7vzXVheUkSurpogByhOPj9kZSfvL3m83+GJ/hlIUiailTdr0D7amsyvUHI6La3saopZ02MXai9NotbScc6k+oKa6TNvuotrI02ngAaQ/sLdmeL2m+nxhr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzzba+p5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B085C4CED3;
	Tue, 17 Dec 2024 13:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734442056;
	bh=pvcne/S7h5GxuzsVAtKGGhSARJDAW+nt0TG3iuNsj+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dzzba+p5x2f9pOP97NAyWQKMZ3yTMna2Ad+pX58avKeU2yFyyQdarWEghTmw8+66h
	 abU6dXZkGNvlWdBV0iS1sr982UgTK55tTr6Ttf1j/cjJJ6cVaP0uoy7Mrm7W4BE88E
	 zwyajdVFB0FYkIjC1Bg9CasIMc/+HhA3r2S1VyV8kFb00lN5Ok12faVXxzJxIIuW8i
	 Ph3Fdc7X+yRLKW0Hx4joeiDV3oHTEf9XGLOhx3VEW8eZeLC2HbwXWLpL4BJQs8ywnC
	 Ex5oFJedrH5e2Z+y2d595wZlrFJQ/n1uuaPagbTrxpkzEDUeovaIu1Un09AaxuRBVt
	 PF7q5s6+ezhNQ==
From: Mark Brown <broonie@kernel.org>
To: Jon Lin <jon.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 heiko@sntech.de, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org
In-Reply-To: <20241208130311.1324024-1-jon.lin@rock-chips.com>
References: <20241208130311.1324024-1-jon.lin@rock-chips.com>
Subject: Re: [PATCH] spi: rockchip-sfc: Support pm ops
Message-Id: <173444205510.31817.16108705113990702119.b4-ty@kernel.org>
Date: Tue, 17 Dec 2024 13:27:35 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Sun, 08 Dec 2024 21:03:11 +0800, Jon Lin wrote:
> Support system_sleep and runtime_pm ops.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip-sfc: Support pm ops
      commit: 8011709906d0d6ff1ba9589de5a906bf6e430782

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


