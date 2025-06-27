Return-Path: <linux-spi+bounces-8807-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E16EAEB5AF
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 13:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE274A46BA
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAF42D2391;
	Fri, 27 Jun 2025 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vuim5axm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E134029CB3C;
	Fri, 27 Jun 2025 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022107; cv=none; b=tp/7GkMdS6DQzYqXylnqE1Jo23SS8xc9zBZpPLVNXwz9m/ws0sLdLw2p8U3+48syp9urLSDk1Tj9ZtEfyJDgrt9v7+JMVFPxmnrSTP1SCIbVeDe1ATBYUCHgOm5xp9nGVWUojm3Hkj3BLCZ7BWGMhtSCX/USIiBnBq0WZdep9zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022107; c=relaxed/simple;
	bh=A1bxFNSWz35yFvhEfWY+CykpQc2zGdJBAlx9+90e2dY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BbyE+JDoiV8JDf2VHJQge6VIiS6I+viCr67VZ7rXvF/gU37J+2jZ8ceQSWXMKktK9/ZhP1nGCqMVEmRK4ng4R5BXG/qCnuJf9P0fUkbYl2vCuleSmUFPuXiPBNivqQtcFERGbORUXA2eRSQ08vDN+qpepdGtw8EpuyYumP59tTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vuim5axm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B3FC4CEEB;
	Fri, 27 Jun 2025 11:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751022106;
	bh=A1bxFNSWz35yFvhEfWY+CykpQc2zGdJBAlx9+90e2dY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Vuim5axmcv1budcLMxptutxipo6ZXvXL5obJaxzRyYtPfv94hXtUQ50S0joXsI5o3
	 9kZN1cwE8jTBmE2kvjaQ9swQ5QN15VrgHV1Zu8UPHTSJE5cbn4KCZswpmABjlYHyQC
	 Fx1fErSFiH43/LDVA7C8QrVBo/5V9REKDIMxsXNsOT3KF3J+raB9qbpnUV3YIt3BYC
	 Hu9pjITmoTEsHzLTi09CCXiEtuPPEPwJ9JhJXoSNvXtw9oL46iotjuwmYmZmyc64Hg
	 oAJ4v/eYtXsLLnPpjdwaUKZ4dpYaxQqaXBM5UeKOw7kw0BA7mQdFx0f73RivtvOwdk
	 1iC2N58+q8Tog==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20250625215255.2640538-1-Frank.Li@nxp.com>
References: <20250625215255.2640538-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] spi: dt-bindings: add nxp,lpc3220-spi.yaml
Message-Id: <175102209646.386964.15013271820664016381.b4-ty@kernel.org>
Date: Fri, 27 Jun 2025 12:01:36 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-07fe9

On Wed, 25 Jun 2025 17:52:54 -0400, Frank Li wrote:
> Add lpc3220 spi controller binding doc to fix below CHECK_DTBS warning:
>   arch/arm/boot/dts/nxp/lpc/lpc3250-ea3250.dtb: /ahb/apb/spi@20088000: failed to match any schema with compatible: ['nxp,lpc3220-spi']
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: add nxp,lpc3220-spi.yaml
      commit: ac4c064f67d3cdf9118b9b09c1e3b28b6c10a7ea

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


