Return-Path: <linux-spi+bounces-7260-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EA3A6AD3E
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 19:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67BD884FCB
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 18:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9FB227E88;
	Thu, 20 Mar 2025 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQtYjLdr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33C1226D14;
	Thu, 20 Mar 2025 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496364; cv=none; b=jTMakT+LuSIGTYGLSdfuFBb7e4ktnovZJ7iG7zAW5Phhj8kFDm8lPfeMCJsVRMywYTFHtDhPo6357R8Qx/+62+GTPo4eO3UEOG1rH+bfgyEX9gFAJH2IeK8yZovgrbe3uH+QsOlo2WSvUvqClN7Kgd8VHj0Jod1kj9cj/s1B8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496364; c=relaxed/simple;
	bh=a8YCP8jcej9A/OFDhRdTo8bPx3igikMkPK0x2FPo3s0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SK0ph72VXo99MHMisXjcCDCWPTh7A96LMkBNH0CRkqziPptyMed8xykGzmY8mGp7lsWtQ45WsuENB6zkPW+42v5fdI1lYT4jslg/JAQ3aoroOx5ZlYPsy3M/bRGspEOP4FThHLLBlATauh3O1Wq5WFKx0MdQ8ov5k8zM1MGckxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQtYjLdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FD3C4CEDD;
	Thu, 20 Mar 2025 18:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742496364;
	bh=a8YCP8jcej9A/OFDhRdTo8bPx3igikMkPK0x2FPo3s0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZQtYjLdrX0AVoR1g5SBXptHBT6Vgbz62wh7ktKgQ3CqAFOr2rVZxNUShxZr/VDlXs
	 WSWt4+UWItkoN6g89NcXCSR7YtLu6Yg6McysSYxmGaSm+FFOv1BAkQz7bRGfIi614Q
	 4+TnRdQ3dZmVQiwKCzldWNB2UtzavEZ858ch4wZGJNcwBfwrQLMarY3VxG+3P2uWkk
	 Jt2GDzeEO4TsxKdHqcbDwIsPMMFAWalo/f72W9qrBxTUIYKudnEpk7YBS5iY+amu7H
	 LYN/MBiOzhokw+ZdE10SPDNInN5nCJ0SoHE46Zu2IwoSbTBOkGlAdEqteSkOTbQBQS
	 UrDoyND40cqYA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20250319094651.1290509-1-miquel.raynal@bootlin.com>
References: <20250319094651.1290509-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 0/3] spi: dt-bindings: cdns,qspi-nor: Improve
 description
Message-Id: <174249636229.174561.3014141569675675466.b4-ty@kernel.org>
Date: Thu, 20 Mar 2025 18:46:02 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 19 Mar 2025 10:46:48 +0100, Miquel Raynal wrote:
> While working with this controller I figured out a couple of small
> issues which I propose to fix. They are not super impacting, but I
> believe this goes into the right direction.
> 
> Changes in v2:
> - Collect R-by.
> - Use a non deprecated compatible in the example.
> - Instead of suggesting that some of the properties are required by
>   improving the example, make them really required.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dt-bindings: cdns,qspi-nor: Be more descriptive regarding what this controller is
      commit: 77289a8a8b33defd8e5d9f4046c27ff0655b024c
[2/3] spi: dt-bindings: cdns,qspi-nor: Deprecate the Cadence compatible alone
      commit: 8b35d653878fb98f36df8b4968159499258fddf1
[3/3] spi: dt-bindings: cdns,qspi-nor: Require some peripheral properties
      commit: 50605d2eefed51946c010b76464b2d7419af8310

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


