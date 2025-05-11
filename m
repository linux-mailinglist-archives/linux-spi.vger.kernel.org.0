Return-Path: <linux-spi+bounces-8061-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D828AB2610
	for <lists+linux-spi@lfdr.de>; Sun, 11 May 2025 03:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21A7861FC5
	for <lists+linux-spi@lfdr.de>; Sun, 11 May 2025 01:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D80140E34;
	Sun, 11 May 2025 01:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7dVw8nG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E52DEEA8;
	Sun, 11 May 2025 01:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746928502; cv=none; b=JWhNEOsUaPTUUngqIi9jWY2qzvgFoX7tmxs0ANJifrtnL7hffy90nzFwfMQZepYuR/DyD1qMLEM9UmPU/yHEVJEn//ASQfpCP7SHiw5vPBdHV7onMhp9Yj/5yOiM4uFbsiCvkpR8OvTmGsTvsmbB576HY65uxhDLsjuN24axTMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746928502; c=relaxed/simple;
	bh=ig4DYJ3RXrVpEeq3aerEl+Ap4/cbUODtqNdrvm1zJko=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tr0Ry1l4NcN3w+QjC1nAQr7XCgRFZhw/5SlKo5PLMrTVA6voAM34Kt1yEBQQoQngI4qdQeRKKSWhAMSHA1BuRD9y2IbFFtcnjdfAdYbpkz66Q8Mpqttd+ZUGqF1dctKTfMy/OZmUY3DCGRgU7387e0YSSAdIzT/bw/1EqmKnYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7dVw8nG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B011C4CEE2;
	Sun, 11 May 2025 01:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746928501;
	bh=ig4DYJ3RXrVpEeq3aerEl+Ap4/cbUODtqNdrvm1zJko=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=O7dVw8nGOAjKUBvvPSiCXB25ADmuwKNiprixu+5FFh04GZ2ucVCvxN8jFlQtEHjeY
	 ImxJlGApNuSuCtgpPcorxA+7CoZbJo6J8RF9JzivuA2wstZQ9u/gngjZH0/JR9OQni
	 NuIbGRShNPb/deGAzgu8zTrvA06yHiAAZVwOCwmQ8/4wL3Ui2RFpJEXanFKDkQ6nK/
	 XP1e12gz8+AdtJghb/wfFNlryapmHqAQbBA8DRyscCRk7coru9UYkZ0GTLlfpLAsd5
	 iX2LV4Vf/e9o4wyclhxLzZ+c93b5lWOALqlCUcfAlxmJymj60l6ewr87wcT8kXrma+
	 yNbTpHKoV8yEA==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Frank Li <Frank.Li@nxp.com>, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250509112130.123462-3-krzysztof.kozlowski@linaro.org>
References: <20250509112130.123462-3-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] spi: dt-bindings: fsl,dspi: Fix example
 indentation
Message-Id: <174692849876.61256.337596049686049621.b4-ty@kernel.org>
Date: Sun, 11 May 2025 10:54:58 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 09 May 2025 13:21:31 +0200, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces, so
> correct a mixture of different styles to keep consistent 4-spaces.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dt-bindings: fsl,dspi: Fix example indentation
      commit: 846656f278e803cb60161f0cba4ee90a058440cc
[2/2] spi: dt-bindings: nuvoton,wpcm450-fiu: Drop unrelated nodes from DTS example
      commit: a4ca02454821cbc411e0bf16e527d392f188c218

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


