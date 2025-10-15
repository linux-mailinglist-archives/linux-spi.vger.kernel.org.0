Return-Path: <linux-spi+bounces-10684-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB454BE06FF
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 21:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7DAC502C0C
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 19:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ACA30E0CC;
	Wed, 15 Oct 2025 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJycL5iL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD330C628;
	Wed, 15 Oct 2025 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556639; cv=none; b=txhTNHjdRBAGuweZRZ5/JimphHIKGXlfL7SyIGRs7AaPmFQfW1NxaIr45PSsMv7aTxAm450nq5BhGUWUTPSDXhxzppHci0xSd3gyPha0UrChDT6Qx5RONx1vLQAXabIPQrHARnCJEx1SmDmieo8jXwb+c9JIkEeZuTEIb69fY4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556639; c=relaxed/simple;
	bh=VIYuQwv6H4T/fe1LQzyXmYaZQ+UKzKXazKHLQNglFbU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s7stgnYgyjkmhhp5pTOmvlAPAEtl76QS8va9OUCD88Bv9cKIoaKov9v/a6eQJiThl3lHrL9OcGA4qBKGUIC952t0JeX62chywksUguAXq4VmkmKW4zxwEaak8k/dPupNnOELEoevrf9hvJSC19Ztwp1mGOAv8eYmMYJO05c1MYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJycL5iL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9234EC4CEF8;
	Wed, 15 Oct 2025 19:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760556638;
	bh=VIYuQwv6H4T/fe1LQzyXmYaZQ+UKzKXazKHLQNglFbU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QJycL5iLb5ohZi+4x0ZCCoYoICEgk6J5g3FvZa2FLGiw4XenJDVR80wUFPGykgJxd
	 X+f4/OnBejt5FAFkqMTYkIU6t/F0iiCnIwSDVNHcj8ChSxz75yKhqvN+T9hzSjftk4
	 9YHDrze3tomYPEWZQmAh5+mcZ5Qjx2wdHKQhhElJYhILkzfrLK4ZBvr+KMxty1mSvT
	 RX/dH9nv7t0/x9Agub69aNqrQalfDfszQpJ5FetLYtDtqyjDOsGsx6M1DvVy/vplrn
	 7zadH90TjnBpDPyt25lCyjy/TJSWHAsIZtI7+zT7gg9pmtWdN9uys24c2G8s0amWnG
	 dRM2Nuaik+jcg==
From: Mark Brown <broonie@kernel.org>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Frank Li <Frank.Li@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250922-fspi-fix-v1-0-ff4315359d31@nxp.com>
References: <20250922-fspi-fix-v1-0-ff4315359d31@nxp.com>
Subject: Re: [PATCH 0/3] spi: spi-nxp-fspi: few fix for flexspi
Message-Id: <176055663624.243729.1614334756010588411.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 20:30:36 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Mon, 22 Sep 2025 16:47:12 +0800, Haibo Chen wrote:
> PATCH 1: different operations maybe require different max frequency, so
>          add flexspi to handle such case, re-config the clock rate when
> 	 new coming operation require new clock frequency.
> Patch 2: add workaround for erratum ERR050272. Since only add 4us dealy
> 	 in nxp_fspi_dll_calibration(), so do not distinguish different
> 	 platforms.
> Patch 3: add max frequency limitation for different sample clock source
>          selection. Datasheet give max 66MHz for mode 0 and 166MHz for
> 	 mode 3. And IC suggest to add this limitation on all SoCs for
> 	 safety and stability.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi-nxp-fspi: re-config the clock rate when operation require new clock rate
      commit: a89103f67112453fa36c9513e951c19eed9d2d92
[2/3] spi: spi-nxp-fspi: add extra delay after dll locked
      commit: b93b4269791fdebbac2a9ad26f324dc2abb9e60f
[3/3] spi: spi-nxp-fspi: limit the clock rate for different sample clock source selection
      commit: f43579ef3500527649b1c233be7cf633806353aa

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


