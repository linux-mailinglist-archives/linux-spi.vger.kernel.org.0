Return-Path: <linux-spi+bounces-4428-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB0E9647BD
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 16:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F744B22385
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C20F1AD40E;
	Thu, 29 Aug 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5Y8smki"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F718E36D;
	Thu, 29 Aug 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940590; cv=none; b=nmnZ4FlH2OXI5bRUwoJrl7dhyQf1cUlTcs5m1LeVFxQkW+jS9yAXDvAjwIbZN8N0CLwiE8bxqFWyC6sjG6o7kLjy5FRdhp/xyKAMWo6HnMCaM8SmZe2F7ffhgVwbFfBgbZG4HmHO2XsIw097PclGWW0Nzf1plwnXbnLuPM0MaKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940590; c=relaxed/simple;
	bh=FpQQ/uMy+PNEKD3Nj/2L1tmHC+W7Oe5wDR9Ehc6CsN8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BgBW58qjivF4xXWwh1cTgux84cKa4ClPAQ9vysohHC+qqAbdZVEm0leZ11bWMaLhn6Byrvm1Uy1i9i7YKkZiW+13QbAzDCaqVV8/8y0WySkesf9eKLVDnF7iFbqsMmrFIjlyopIV9fhObE0TtljlrhAaVjXmEyS73AUmmu/O6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5Y8smki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10949C4CEC8;
	Thu, 29 Aug 2024 14:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724940590;
	bh=FpQQ/uMy+PNEKD3Nj/2L1tmHC+W7Oe5wDR9Ehc6CsN8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=J5Y8smkiEo1lkup2f9eYa2RokLMAO4TDrKHnV7dE+bFLSdQhMq23PW+xgL9crBBa+
	 ii15hOaCIYcDquixZ1jV6YlUZngh9EAaipzZbkDZ08Ov91/AGWcZ7THZnRa2sUYSYi
	 2zX8LwLq512nq3HC0bmuJFJuvKZ/D8dbb0ZzoGFy5f0vyWUk2xHBAAme5wqFdN1iSz
	 4PSKHNLzdeJLxqGDz1+tquDM23MV8b8AlU1s/I+yIOjbhrlr9xIsAtpDjaCxdO7i6I
	 Vc/CNf4X58qtlMoDuH5v8f+PJKZR9ZV9gY54X1UaXfTRKCBFxQBUD9DJRnQ6fAvWuf
	 3EW13UvGCX/Ug==
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, otavio.salvador@ossystems.com.br, 
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20240829113158.3324928-1-festevam@gmail.com>
References: <20240829113158.3324928-1-festevam@gmail.com>
Subject: Re: (subset) [PATCH v4 1/3] dt-bindings: trivial-devices: Document
 elgin,jg10309-01
Message-Id: <172494058780.260290.2099482677435543580.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 15:09:47 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 29 Aug 2024 08:31:56 -0300, Fabio Estevam wrote:
> The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
> The marking on the LCD is JG10309-01.
> 
> Add an entry for the "elgin,jg10309-01" compatible string.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
      (no commit info)
[2/3] spi: spidev: Add an entry for elgin,jg10309-01
      commit: 5f3eee1eef5d0edd23d8ac0974f56283649a1512

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


