Return-Path: <linux-spi+bounces-7071-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BD4A5588B
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 22:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228F57AAA20
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 21:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D5F207DED;
	Thu,  6 Mar 2025 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5sPRdEz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08E41FF1AA;
	Thu,  6 Mar 2025 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295736; cv=none; b=r5egLM3J6Iz+zsiYmwfqYi7ySwdLGp6o0fmBvog6CAtbp+RozazOzMjNhzSMOZ2nj0hnXpeLc0xnFKPGe+DV07OJErtOMwHRrZ/fdqLe1vdrqX0a8hQYCeCcflu7UcMOZFlprRZy1Hj3U0djVBEV0N0E86+YKJ/ZJmDcQxhJ0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295736; c=relaxed/simple;
	bh=sYQMd9jtAcMXQq31WqrbCsoeBlpEOogNZ42LeKgZRLE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M9Ivm6Amz7zmCRkoaj9wzYYmEeT2or6/I89MxbCUTgfeWZPPZWOnJC57Ys5FiQfjxB8orRV0XYQlQdFaCBwE6Gueh2rSJyW/zektgjjvdyP+BJACkMkNI0YMzNG2wOihNRhfzIG9GT/8eT/gF/i8OA9DFP4mUIu3MGQYJL3RzQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5sPRdEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C27C4CEE0;
	Thu,  6 Mar 2025 21:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741295735;
	bh=sYQMd9jtAcMXQq31WqrbCsoeBlpEOogNZ42LeKgZRLE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=P5sPRdEzBxLsvmJQ4ev5ME8sxk0V0l/CWholldIGCQ9ojT1YjN9XAYmBia0q+cr+Z
	 7pFhmUyV5qdIzp1rF8Yxyvpvz7ITIs6wMcxzgScGlryhcFRWKONh6Cdt2lSzxPhUTd
	 7h8NmPoHxk/SZQGbTq/mDGoVh8dBaVUCoSkXEWgWCaQVuXXAEbAwoAsBad249CDYGM
	 BCRvYBSOFV1FsY70Y3RFgu3r+XZMLzHHmPw75xX1NjZErpHQX0P8LL4B6r8G3CQhWg
	 SIlGyXkbmjn/2e0lDtmJHTUG7Ab0HtkpFzgIHPq2Ab9CUOO7RZ8X4jbOxNtmPXmody
	 8CNrI96VmvZog==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20250306170954.242707-1-Frank.Li@nxp.com>
References: <20250306170954.242707-1-Frank.Li@nxp.com>
Subject: Re: [PATCH] dt-bindings: spi: fsl-lpspi: Add i.MX94 support
Message-Id: <174129573262.723955.4642185166611701005.b4-ty@kernel.org>
Date: Thu, 06 Mar 2025 21:15:32 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 06 Mar 2025 12:09:53 -0500, Frank Li wrote:
> Add compatible string "fsl,imx94-spi" for the i.MX94 chip, which is
> backward compatible with i.MX7ULP. Set it to fall back to
> "fsl,imx7ulp-spi".
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: fsl-lpspi: Add i.MX94 support
      commit: 02a838b01b8e7c00e2efe78db06fff356a112dec

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


