Return-Path: <linux-spi+bounces-2766-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80908BF4A8
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 04:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0595E1C212EB
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 02:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BA6107B6;
	Wed,  8 May 2024 02:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY2rH4y5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E358715E85;
	Wed,  8 May 2024 02:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135946; cv=none; b=mPmNjpxqwEuN/jkkehato22V7ALUSqXc7cU9LR5+gVKa6ZRPp7mDW3WoK8/mI+NuqWGE9wDzwnU2F3UGcS3zKDr7a4NBCUBrCHklBZfioF+/5MkMr7tTVpbAojmuayc2v9UIJN1ZYr0ahqyc21c15f4HNrv/5HatwPUFey67Y58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135946; c=relaxed/simple;
	bh=WHbkXeHPne7pZYmCpb8C4jJqEdLJmDFm2qxEFJuckhw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dUV5h71/DTcOYU2ug79/+uyipFkQMyJVY3Rlo/IPgxqrhHrWn7m7vn1qiNE7cHOeAvlTxxGZcXiGDLERR9V85ZSt5wnfkoQFn/5hnBjdPDlbwodvSRZbXfedmJWhQBXSYpxu/HB0B710ZRXGZtMIOmZ9w5cUgK3j2UrIKP9EQIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY2rH4y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7271C3277B;
	Wed,  8 May 2024 02:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715135945;
	bh=WHbkXeHPne7pZYmCpb8C4jJqEdLJmDFm2qxEFJuckhw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LY2rH4y5UWktchIat98KPe61Lo9H2YkB2g5afuXP7bhIiW+W1s+Lp62/JWEAeQl06
	 iZuvsJ6cX/CVuNukqa8n+GutC4r7eAUnGgVIYBPl2j4mfO3MvgJoWMJyJcQBaMLvkg
	 IPseagVk7w0s3PpdDZNED1t2JbjbCLF3JUO+9gpn66tpPfRH/pdCs4ymdfByu5A4Sv
	 27575xD2k/KS6YiF9RoLJHXD26I6kZ1sZlramyxZAOB3tQvIdfdcJBXDQvIfcuJkv0
	 02d0a2hkl237weAjc2N+DNUEyN5pu/jWyFr8nKMiuZrPk7nG/eXKuKQwYov2uWQG9u
	 LcttfWEBrhEDw==
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 Lukas Bulwahn <lbulwahn@redhat.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
In-Reply-To: <20240507141449.177538-1-lukas.bulwahn@redhat.com>
References: <20240507141449.177538-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: repair file entry in AIROHA SPI SNFI
 DRIVER
Message-Id: <171513594308.1998064.12450268139510361452.b4-ty@kernel.org>
Date: Wed, 08 May 2024 11:39:03 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 07 May 2024 16:14:49 +0200, Lukas Bulwahn wrote:
> Commit a403997c1201 ("spi: airoha: add SPI-NAND Flash controller driver")
> adds a new section AIROHA SPI SNFI DRIVER referring to the file
> spi-airoha.c. The commit however adds the file spi-airoha-snfi.c.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: repair file entry in AIROHA SPI SNFI DRIVER
      commit: eab80a2ee46bb362e2c4434cf0da96d3a6bda544

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


