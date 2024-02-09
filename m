Return-Path: <linux-spi+bounces-1256-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0712C84FDE9
	for <lists+linux-spi@lfdr.de>; Fri,  9 Feb 2024 21:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8471F21EB9
	for <lists+linux-spi@lfdr.de>; Fri,  9 Feb 2024 20:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DB163B3;
	Fri,  9 Feb 2024 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX354ORZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F75CCA66
	for <linux-spi@vger.kernel.org>; Fri,  9 Feb 2024 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511739; cv=none; b=IgNiiwToypssSlmxVqbSlnKkiqPwLKtX+UQX5P8ZJ9VNMRd2wQ6WZ5rKey5yqMacmOi5BFrNxFQ+BjCE25HxdDe7Z5K79ywV+s2fvBv9WfXgMe7ofjwugEfNKLfAo14NEdE437kgktIlF6GC4xO20Uupv5t/ACF4oi14/EFwewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511739; c=relaxed/simple;
	bh=QRg2R8un/qUCSLzzdjxaC2y88MIa1qgY+xSCzkKqNxU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bd2bI7JxdwSZot8IBer7hYhM2Ao7NijMBGdbl+NuTaNMRSjn9BDxPVnKp0wI8r/YlSRya7t8GJnmcCRiKbcsLnkYa37APxenLU+uYsyZPasHOJ2JeHTvKgaRKc1ebKrd2f0CBAnlsWsIpCNS65OfVv5SrkcwXfH6eeuenP9R5cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX354ORZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3336FC433F1;
	Fri,  9 Feb 2024 20:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707511738;
	bh=QRg2R8un/qUCSLzzdjxaC2y88MIa1qgY+xSCzkKqNxU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=BX354ORZXNorzTr+fiNY8SCAHQ5MVe3ULcYfV3WEcBnOL/bHnWsauNaLkbhi6x5fF
	 E+0dwGajd9PNUNprT/ciIcRWjCzox7Hk4ysDxeIorTKJ0yyiDGPJiTfvv8BNQZWXUM
	 UQ6zZdWfMzoRObYadIlEoScQ22uXUphl4UNLP96FoNeHy25Sol/QmeIa+l7orN/4ia
	 xBYwA55Iuhh2VPrmFVc40FHZtIFXhkqZgmD2fRJKcJB1GxmJA+C+5qTc0LKE1XeB3k
	 29YF2sGQ4S3aqsFDoN/YpWqhkbLMxhi9ZTe4lqSqE+dzsLsYYkeN9+jFzAeRX50InZ
	 KN7/Xh6+KKkLA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <3eb3f9c4407ba99d1cd275662081e46b9e839173.1707490664.git.chunkeey@gmail.com>
References: <3eb3f9c4407ba99d1cd275662081e46b9e839173.1707490664.git.chunkeey@gmail.com>
Subject: Re: [PATCH v1] spi: spi-ppc4xx: include missing platform_device.h
Message-Id: <170751173690.2414604.16858513850600028471.b4-ty@kernel.org>
Date: Fri, 09 Feb 2024 20:48:56 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 09 Feb 2024 15:59:07 +0100, Christian Lamparter wrote:
> the driver currently fails to compile on 6.8-rc3 due to:
> | spi-ppc4xx.c: In function ‘spi_ppc4xx_of_probe’:
> | @346:36: error: invalid use of undefined type ‘struct platform_device’
> | 346 |         struct device_node *np = op->dev.of_node;
> |     |                                    ^~
> | ... (more similar errors)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-ppc4xx: include missing platform_device.h
      commit: 9f208e097801f9c2088eb339a1162fff81c08b4e

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


