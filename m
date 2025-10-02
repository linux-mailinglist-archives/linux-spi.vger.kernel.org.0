Return-Path: <linux-spi+bounces-10431-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A8BB462D
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 17:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0207D3216B5
	for <lists+linux-spi@lfdr.de>; Thu,  2 Oct 2025 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131EC2264A0;
	Thu,  2 Oct 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Itwu3wci"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85472253EC;
	Thu,  2 Oct 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419866; cv=none; b=tyO6iEzvgoiowGJ/A1bsEtNw5cXzPIatW7MKVJ1t/ndRfkEXvVTWOIJTOTgdHzphryNMm4zErByP7JhUwj4IL2uYau8zcl7UQA3zirgFYyN23lR0G3biaY29v6uaNSzfb4qDC6T/dvF0Yx6K26+pweUU+c5DCCj4p9gZW+hakdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419866; c=relaxed/simple;
	bh=gwC5BhJBwYKgsnNt4fN26IJ79zFAZbre4VusA+f9pes=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pP9Xc5uP2pfUtpUllowr6SvUEJsjHB0mRCtZgcDtoHi+Lb4Zi2IWQ7L4thjRmGJCSn56r0KHahqdhPVk5iz9VhzXIHw6lmg2i0xAFFWfWcwYpeDWIyH8v83XJJp6IXc+SfRNKMH1EaDsYJYxrN3vXgqf/cvqLXkPDz75xR0OVm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Itwu3wci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEDDC4CEF4;
	Thu,  2 Oct 2025 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759419865;
	bh=gwC5BhJBwYKgsnNt4fN26IJ79zFAZbre4VusA+f9pes=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Itwu3wciA297/eNzH7IsKflMpXmHgbzbByzzUeWY++7lJqzQG0//z8vEeua0uNuGi
	 wCUHifUd3ejiiE5D7rPb6mJcNvPXe6wgeslW0kVP31U0pjh94O4jfPJwY2kBFlefhM
	 SAtSZT0/ONJmBewr0/tjHlkQ8zgP/8MaH7XK/B80jSDT5t8e/dHc8kZeLSNH6sD3ct
	 /iSGvoBU1ikZfyhYnUdrpl3jhqgBTX14a42i1DQ3hk/vuReiwRdLhfx4PP3eJSCdBD
	 Deas6xrGBPbyqDSAEAIOWixKRAtXdRtZoEdXzfRhE84fZPMmIsWgDRN4dXPPy0Cx/Z
	 4LwZX6SXCtr9w==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Jun Guo <Jun.Guo@cixtech.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20251001-basics-grafting-a1a214ef65ac@spud>
References: <20251001-basics-grafting-a1a214ef65ac@spud>
Subject: Re: (subset) [PATCH v1 1/2] spi: dt-bindings: cadence: add
 soc-specific compatible strings for zynqmp and versal-net
Message-Id: <175941986332.90691.14872518520812537985.b4-ty@kernel.org>
Date: Thu, 02 Oct 2025 16:44:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Wed, 01 Oct 2025 19:31:12 +0100, Conor Dooley wrote:
> When the binding for the Cadence spi controller was written, a dedicated
> compatible was added for the zynq device. Later when zynqmp and
> versal-net, which also use this spi controller IP, were added they did
> not receive soc-specific compatibles. Add them now, with a fallback to
> the existing compatible for the r1p6 version of the IP so that there
> will be no functional change. Retain the r1p6 in the string, to match
> what was done for zynq.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dt-bindings: cadence: add soc-specific compatible strings for zynqmp and versal-net
      commit: 4092fc5f35cecb01d59b2cdf7740b203eac6948a

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


