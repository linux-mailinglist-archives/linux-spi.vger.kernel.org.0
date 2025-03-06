Return-Path: <linux-spi+bounces-7069-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CB8A55631
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 20:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9AA41747D7
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 19:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF531263F5F;
	Thu,  6 Mar 2025 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5KIu1om"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A10325A652;
	Thu,  6 Mar 2025 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288185; cv=none; b=ZcQvll6FVDA2Whi2PrE/vV00nHBuHnWBRygGyFIfg8A1wBwo1v1U02rnwq9u23Ji8EjX6hwuC2h1wSiH8ZcK3dHaNIL+nxrqKaJ4J7Sm2DEO8TU/xK3Tn2fG6++qI2P4d9g0i91c4jVBPnhrGoX13eLHcXby+jmCcPNvDWqNY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288185; c=relaxed/simple;
	bh=4gUFR0sw4nvaIHYvLbMR5g7jzOxVgrFF7Jlbd+HjFT0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BsaLk/QgyvR0Pfg28H8uFDFDOymVcGPX+d6Ecxge16lvrxuKQ3bfzWP2UnjH3DJPEhIMScqAaRq1wZmJFQ+K5+BqJpgKMAYe8cl02RzEMHATi/ymQKQnYI1qhoZ8aDe9P0HNL9e5zEnlGNA9DGe6mlt3iL9n0HCRO7mOtzzA0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5KIu1om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F50BC4CEE0;
	Thu,  6 Mar 2025 19:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288185;
	bh=4gUFR0sw4nvaIHYvLbMR5g7jzOxVgrFF7Jlbd+HjFT0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o5KIu1omqX47y3cQX8KbvJ5UFo1R84Uh3XRliXwF6CU9WGGUI7Qw5M/XTzsFqYebY
	 OkNV/ONwZe+58SepWv9QhN33zIB78e9ZMa1PFtKepcj3aO43hB4rav939frg2/rjFa
	 BVrLGbQ1LQ/cICb69LZfWlCVRg8z1KnjkZOkrchRdlg50WGnM/+2Bh/CwQ1poaw7on
	 breaoY/R8U2sb8b7Dz8tVwlOi/XCYb5rfegBsVUQNfbv1zG/9Tj9ixXEVO/Q59+BWX
	 RP3eVpOEo0/pL8cAgaXwDmMwIDNd8aOVm77sycsB84A6/fhxwIymQj4wiV1PkzuGCT
	 HgU1x4cZQnQsA==
From: Mark Brown <broonie@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
 linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20250306024716.27856-1-jiapeng.chong@linux.alibaba.com>
References: <20250306024716.27856-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH -next] spi: stm32: Remove unnecessary print function
 dev_err()
Message-Id: <174128818323.185591.2600414701558020572.b4-ty@kernel.org>
Date: Thu, 06 Mar 2025 19:09:43 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 06 Mar 2025 10:47:16 +0800, Jiapeng Chong wrote:
> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
> 
> ./drivers/spi/spi-stm32-ospi.c:798:2-9: line 798 is redundant because platform_get_irq() already prints an error.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: Remove unnecessary print function dev_err()
      commit: 3707fd9c383fc7ae19733a3ad2e5a82bf86370a0

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


