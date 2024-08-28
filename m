Return-Path: <linux-spi+bounces-4359-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F992962DAD
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 18:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A02B2151A
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 16:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E1E1A3BDD;
	Wed, 28 Aug 2024 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JF4obSZc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F8C45028;
	Wed, 28 Aug 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862631; cv=none; b=GL7n26timzVaD7NlaFp1QVuhW78BsgnRhn/GjBWdf2sl24eY0m/o0j7aa6XTDVV9Q36L3wnhUoGRO5cODP5qCY6Jh1IXjLIiYXFCvNbNLEPifYtURXAdpg2vFsmXbyVaUWlt6nvR9kRuY4sIpJNQw/inoLWNqjRmZAP4uDbFA5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862631; c=relaxed/simple;
	bh=+2M9DfbXL36bIZ5qZ0Kp00d3aasP/QYCZHxSEDtTneM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KlPC+ZiS31/OmkWfPNmEZm3tQsbH24uAa4NS4GrP/dY7R46j8DpJUvXEC0xetMKmidyLoC+P1/19bpA8vCftCLLsMcGvwQRm0eK9BDFMXKRWPvyQ/TKZAlg8v8mwz6eY03YZQtxNm2TWJHC2r4B3E1wn2jNOqWf+3JuLCSkiGy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JF4obSZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B60BC4FF56;
	Wed, 28 Aug 2024 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724862630;
	bh=+2M9DfbXL36bIZ5qZ0Kp00d3aasP/QYCZHxSEDtTneM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JF4obSZc0yhW2k3zHttgrUz3D3DHL81z5ulyDpbsgBiqIYOCkreHUennu1mOVFEoy
	 FXeDEwVgctH1tpKNDwolAMkyJPAUTYA2jq+yLjNeYwx87D1EMGadEdL/bpBRvyrA0/
	 MvqnLlnN+laIPrlkYtFyE3epAmzM5A3ICllTfOCXHmG58/CeZEbppGR738I/Xu9g/d
	 rg25ggXIcqgpra18lfAR1C0j5anVGxhkSxc0sU7n7h4txzB169aii8oYBnM7FMUibi
	 KImkSTHy82VPPFcI2ynxn0hdlPFwrGb/SMISF3Nd6KrufVbsbXJuY8H9phchLYJFC/
	 OrvEOyzFeJU3Q==
From: Mark Brown <broonie@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Christopher Cordahi <christophercordahi@nanometrics.ca>
In-Reply-To: <20240828063131.10507-1-bastien.curutchet@bootlin.com>
References: <20240828063131.10507-1-bastien.curutchet@bootlin.com>
Subject: Re: [PATCH] spi: davinci: Adapt transfer's timeout to transfer's
 length
Message-Id: <172486262889.93098.17891332820401670505.b4-ty@kernel.org>
Date: Wed, 28 Aug 2024 17:30:28 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 28 Aug 2024 08:31:31 +0200, Bastien Curutchet wrote:
> The timeout used when waiting for transfer's completion is always set to
> HZ. This isn't enough if a transfer is too large or if the bus speed is
> too low.
> 
> Use the bus speed and the transfer length to calculate an appropriate
> timeout
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: davinci: Adapt transfer's timeout to transfer's length
      commit: 2fe6102bf01a5f4f48f211c2e5c8a274342fccb1

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


