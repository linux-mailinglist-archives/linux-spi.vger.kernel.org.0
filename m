Return-Path: <linux-spi+bounces-6627-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01CAA28AA3
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 13:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22111881FE5
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 12:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D9522D4FB;
	Wed,  5 Feb 2025 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAf8SzSl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3506222D4C7
	for <linux-spi@vger.kernel.org>; Wed,  5 Feb 2025 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759486; cv=none; b=rJv/ebOabYaKLorGnVtCZcS/aGoi0F+LLX1c+NE+G3SATqYNspUcQhKzfPlJToVl3FBin+LuLLaVV6z70+7EkJ1zX1a0MTW9hIy1jVKnjbhY/UV1dZc54bTPeSgZOzlSBL0D5keIGjrPAAMz+HaI+XEdFwR+pD92DMe3HgtdUjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759486; c=relaxed/simple;
	bh=2f0SRPSfX2QhNqAmWH+2bCMTXgE9boWLauLHqpp8ooY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LmXm2IQCr9aCi0USsviumLqzeZh33v+dE62atJ9rMlIqeyURQE+jJGS/6Y/ISc6nS3lvHBGJJA02BjqiPklcbQnU7HA8fZKVcrEXPhqb2fflyQK/P5NXXOkh/4eUJPtYWhct438pix0xT6LJDxtYZHjKhL/X5KiLvvUXEJd5pOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAf8SzSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3B4C4CED1;
	Wed,  5 Feb 2025 12:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738759485;
	bh=2f0SRPSfX2QhNqAmWH+2bCMTXgE9boWLauLHqpp8ooY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=PAf8SzSltBC0tye5CqGYiBwaoKYqXIAhTlRpJwQ1clzpfN0y1Br7l0vxmfxJVAT71
	 i2oBWi3ycrZzh2rYxFPOOru2/UNJkZFvKLTvnXrYwd1m3r4ML+ISwKl39xyEzsSgXP
	 3xl+Hm2G9kk6jZFR8HQbS/zpTM5ttsln5KU4soM7u1LG43Qh5WF+7gp0kjeJnEprpL
	 rL+VWLY4YQ92jcgb1DOyH4ntli1D3gdw+f0ccz5GX/N5ssnjAyZf5l7udmeUrJ1obE
	 aa+v4YyRa5t/7c0+gAf6Mh09wMvf8fbIW3QifRIjrHgAP14v+e2g7DGWI+xdFj7Ehz
	 r9Y/W7gdssFog==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250131200158.732898-1-eajames@linux.ibm.com>
References: <20250131200158.732898-1-eajames@linux.ibm.com>
Subject: Re: [PATCH] spi: fsi: Batch TX operations
Message-Id: <173875948491.32625.17979483810877439376.b4-ty@kernel.org>
Date: Wed, 05 Feb 2025 12:44:44 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 31 Jan 2025 14:01:58 -0600, Eddie James wrote:
> Batch sequential write transfers up to the max TX size (40 bytes).
> This controller must specify a max transfer size of only 8 bytes for
> RX operations.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsi: Batch TX operations
      commit: 652ffad172d089acb1a20e5fde1b66e687832b06

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


