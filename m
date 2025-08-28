Return-Path: <linux-spi+bounces-9758-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8072B3AC69
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 23:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA8E1888325
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 21:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E032D8DD4;
	Thu, 28 Aug 2025 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsCzelU7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B797299A94;
	Thu, 28 Aug 2025 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414860; cv=none; b=aVAzMvZwP3MRLHP0LLS0XS/dhdbsSjPMZbUnftb0PusWF0gf9eFqqsbeUTAqK65mqcZbNib6/r4kIMdPgcDpgvc/SI/TijeKPUicFTxlzMlg9nRROUGLubGDR5qc9JOUrlVfLRwm06He222MO5o+fcCSUrH+lHn9/o7LB7U1M5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414860; c=relaxed/simple;
	bh=5irYHIaOSLtfrL3dC6NTgTbspmjfB5YRutxHPAIurJY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qTkSc8SpQB3Xhrkc5NK9Qx91RixcUmFZOsTLrIiJDQWHHLsa0IwFSm0AfLfw46IpEEHDrcq8wCBIy+0TZLYro537kFHHBFP1MuJli2v63Uo6e+nNbmz0NQIpP6LJ6WaAZFjYJu6C7HQWol8HYRyAiedAp8sh+azIaVw7DyTeOBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsCzelU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E61C4CEF5;
	Thu, 28 Aug 2025 21:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756414860;
	bh=5irYHIaOSLtfrL3dC6NTgTbspmjfB5YRutxHPAIurJY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AsCzelU71JSWT71qkQ/6atyY3DOFW72fuxUcKIFJcrV2yr23brhHn9ejfNiOUSCdy
	 cnRcFAeF34fkbPlfprs+eimAGBTSo9C3HUUz92QWcGMArM7XmUpIRT8UI8anwSkOOy
	 mDiy5m5onfBbPV9Em6EUAlBdMtLOKHO7D+WUcaJwEP52pKkivVQqDBMPz+X3TJyRhR
	 NyQPXsvJZvMfxRCDFkjPk8W4FzKHaouvnH+iYnCYCOFMU//MN4UaOFqnCCFR170gWB
	 drcGVWf6A8OfPb7BusnRiyg0axfIMMWKiIUXMMPcQ/rZq8r+8nXFUxmlYzJRMHrB/J
	 SWPny1TWZ2VkA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: j4g8y7@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20250826212413.15065-1-rosenp@gmail.com>
References: <20250826212413.15065-1-rosenp@gmail.com>
Subject: Re: [PATCHv2 0/3] add COMPILE_TEST support
Message-Id: <175641485903.364382.15277195547103842587.b4-ty@kernel.org>
Date: Thu, 28 Aug 2025 23:00:59 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Tue, 26 Aug 2025 14:24:10 -0700, Rosen Penev wrote:
> Allows the buildbots to test compilation. The driver has nothing
> architecture specific.
> 
> v2: change to patch series and add extra patches
> 
> Rosen Penev (3):
>   spi: rb4xx: depend on OF
>   spi: rb4xx: add COMPILE_TEST support
>   spi: rb4xx: use devm for clk_prepare_enable
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: rb4xx: depend on OF
      commit: c73c378dc05ba8060558b9b50e37f3afa4763ea1
[2/3] spi: rb4xx: add COMPILE_TEST support
      commit: f18f0ac5331f8f13737e87cc1416837fb5b27b0a
[3/3] spi: rb4xx: use devm for clk_prepare_enable
      commit: ff9a7857b7848227788f113d6dc6a72e989084e0

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


