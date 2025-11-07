Return-Path: <linux-spi+bounces-11109-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0828EC3F5D1
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 11:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A9F188DEAC
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 10:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0749127E04C;
	Fri,  7 Nov 2025 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJMvVnBg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93632AD22;
	Fri,  7 Nov 2025 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510562; cv=none; b=p9WfzJkCTQ5XBX8HVwr4nXMM5kENR7MUZDccXYqV44NXjgm2rutEVUMdW2pXjOSAjvD9+K8q+sA0tgXa9WWmm/vaY3paXHy5NjSIVAsRdKdXMieukFDIZNkpEwiCXn6W6+vPE+bIV4TSGhvNqZYeYpqYS1OKmV4vX4HQd0Pcay4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510562; c=relaxed/simple;
	bh=qviGVDBTi1qrAbuFnDyLf1pcDfPGvS8U5aiSjvqCc4k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bkxr15a4OGaQso2/EFPCds2Ljo0iE66drCZ3ivmlc8h95zlKyFPcSzarmAzWDS4o9Y8ac/oAx24MeUvJZuzGKLKS2nIuj+b2mdpFjJVtySDmXu0V7F0pcnJfhEzu1SgvjMKw/CVExbpoaAFJ56PczGpbvHMqNHw4mHApW84uJyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJMvVnBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FA2C19425;
	Fri,  7 Nov 2025 10:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762510560;
	bh=qviGVDBTi1qrAbuFnDyLf1pcDfPGvS8U5aiSjvqCc4k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fJMvVnBgY9P2M/E2U68QDNumtskhL7X39tpAM1FOV7uOwn2plb6s6Z6ramQhQiAGK
	 PxgjFOMBNsLXOzryveuR9aZFUZb4WoYpjLXzEyNKdyeTuU60IUEqXm0hX+8TYaUWYh
	 TgHfqO8mKuf/9BiCJGcX1t4j9aCwwkYoSqZ4adc1deFXrbtc298cTrVJkEd4QmzW2w
	 WCcbi4DY+VweCjvqvqp/18otSfyqozwhdfEuQFLuSVrscNYEjMniCuyqy286yS9QMU
	 00Nh5J9UbwmXI/UrgpwGZ54c8Dse4aF7X94pVtt0XgNX7kwakkF3CVx+2XKDQyhPk6
	 t5zevqH9KYuPg==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 han.xu@nxp.com, dlan@gentoo.org, pjw@kernel.org, 
 Alex Elder <elder@riscstar.com>
Cc: Frank.li@nxp.com, p.zabel@pengutronix.de, guodong@riscstar.com, 
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
 apatel@ventanamicro.com, joel@jms.id.au, geert+renesas@glider.be, 
 cyy@cyyself.name, heylenay@4d2.org, conor.dooley@microchip.com, 
 fustini@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, spacemit@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251027133008.360237-1-elder@riscstar.com>
References: <20251027133008.360237-1-elder@riscstar.com>
Subject: Re: (subset) [PATCH v4 0/9] spi: enable the SpacemiT K1 SoC QSPI
Message-Id: <176251055452.2492712.5964458337079179341.b4-ty@kernel.org>
Date: Fri, 07 Nov 2025 10:15:54 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Mon, 27 Oct 2025 08:29:58 -0500, Alex Elder wrote:
> This series adds support for the SpacemiT K1 SoC QSPI.  This IP is
> generally compatible with the Freescale QSPI driver, requiring three
> minor changes to enable it to be supported.  The changes are:
>   - Adding support for optional resets
>   - Having the clock *not* be disabled when changing its rate
>   - Allowing the size of storage blocks written to flash chips
>     to be set to something different from the AHB buffer size
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/9] dt-bindings: spi: fsl-qspi: support SpacemiT K1
      commit: bd352547df647be8a1e6c9d4ca2b54b459f3abc1
[2/9] dt-bindings: spi: fsl-qspi: add optional resets
      commit: 873a46141460d209bb62eaa0dc9e7b67bff924a6
[3/9] spi: fsl-qspi: add optional reset support
      commit: 106d7641e55a472e7523c1f525c77fb6d420064d
[4/9] spi: fsl-qspi: switch predicates to bool
      commit: 6b398c1d3da7a673b13b1857f9fff4c15ee20cef
[5/9] spi: fsl-qspi: add a clock disable quirk
      commit: 1797d254f5c4b46b295527a635af7321a3fe1318
[6/9] spi: fsl-qspi: introduce sfa_size devtype data
      commit: 56931105074fe7e5fc9d54e3163df3b95075643c
[7/9] spi: fsl-qspi: support the SpacemiT K1 SoC
      commit: abc9a349b87ac0fd3ba8787ca00971b59c2e1257

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


