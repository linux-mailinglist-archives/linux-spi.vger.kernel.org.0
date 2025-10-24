Return-Path: <linux-spi+bounces-10817-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C67C058F5
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 12:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CA41AA8091
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 10:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C6530F92A;
	Fri, 24 Oct 2025 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgA34tBo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23592F7AD3;
	Fri, 24 Oct 2025 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301445; cv=none; b=IoSaf2Z6HNP51HwlxsP5XNQYksFGLPYrChtLjoeWZc2rFY+CK4ik290zf2ZWpc1GJi9VAbsfUtLOcccJD2+2Em+Il1fJA4QwGHBCQ3zKiB4mRz1W5ZCn16ZDtiiAWCpT16DRMskWLF+XfHSsSDwQPEljhGTp0PBXP+tSn/UMLyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301445; c=relaxed/simple;
	bh=021tNjgZwRg1FHQidg9CY7VhVF/eBoFNQ/r/yc6VFFs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JUpJ23cS47/SGyiwpd9/aj5NRDSVBuw8hGl/WXhhXS3AXAPco6nH9UaEFNpxq25aUFzVHwBJ2e9Zflp770l2a5rEI3c+qBtgIyXdUuP0Q9EsbxDlkOMR4EGGwS/bXh/JydszgW/ntoH5Ql5B+S7+8GaiiK20bDsvT3hcoUmyJa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgA34tBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD986C4CEF1;
	Fri, 24 Oct 2025 10:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761301444;
	bh=021tNjgZwRg1FHQidg9CY7VhVF/eBoFNQ/r/yc6VFFs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qgA34tBox9/WwVBLVlX+DFE2GNwIbnFduLgFxHpCZtjnWMy4PhdFCR4erWPdpmBbJ
	 Lvgh6Pv9PSeflOGLzEunZmiVzFNCJtAMaRIADcCFxIanI5zVJy18ty+irfa9t5O6Gl
	 YXQgwJYwHhUvNvt4+3D4mHklr1wPXRCeNiFyLAPwqvAVp2VrFFeQRxxcudIMYbU9Jd
	 6CzjNSgeOK6dIr7dxeUrHu8kU1HJH/6QJT3pkMhUDx5j7Ekj+o2xweAXuOsNAxrwiT
	 O0bvxuf0SXg0QorS54RnmvjIQJEchugye68++VJcDsByytAffFJliB8Amry/Fvuk8g
	 V3gx0m0lWKnzQ==
From: Mark Brown <broonie@kernel.org>
To: Can Peng <pengcan@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251023024250.3181084-1-pengcan@kylinos.cn>
References: <20251023024250.3181084-1-pengcan@kylinos.cn>
Subject: Re: [PATCH 1/1] spi: spi-qpic-snand: make
 qcom_spi_ecc_engine_ops_pipelined const
Message-Id: <176130144314.10577.9953872880836297632.b4-ty@kernel.org>
Date: Fri, 24 Oct 2025 11:24:03 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Thu, 23 Oct 2025 10:42:50 +0800, Can Peng wrote:
> Marking the qcom_spi_ecc_engine_ops_pipelined as const provides
> memory protection by preventing accidental modification of critical
> function pointers at runtime. It also enables memory optimization
> by placing the structure in read-only sections and improves code safety
> by explicitly documenting the design intent that these operations
> should not change after initialization.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: make qcom_spi_ecc_engine_ops_pipelined const
      commit: fd5ef3d69f8975bad16c437a337b5cb04c8217a2

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


