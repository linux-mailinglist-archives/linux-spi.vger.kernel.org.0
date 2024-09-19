Return-Path: <linux-spi+bounces-4887-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8966597CA98
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 16:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCB61C2182A
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 14:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2314F19F473;
	Thu, 19 Sep 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIruNTAU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FFB19F434
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754428; cv=none; b=Zp1GEnFrYDZSBO+VB/9lGwZRiwiEnnJdVvFvXUtg5iiikjOGcVyT5pI/OTTPiwpD85l5/oWYc3NchMgj5oMfQSsneVVvgk/1RUaJNlX9KiiZcHrqLtuBQmdbPw8i0gOFD4TiSRBJYDyUVLFMUqaboiAGLb4SHDP4XvNcMx77gms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754428; c=relaxed/simple;
	bh=Q+o8ZpD+4cU1yoEoEGfomHiCROg12mxxBcpsGjc3smM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qeMVJSwTzISkpxrJ0S5Jox2Yp/lFm9OR8GoPj3o4Jgx1JFBYB3hkagF4MayTsZLy5FLeZPypVwX8C4gM9jgH8jQWQn0+rVO1LGzOCC4V8Q8YiP14UH4DFwFAaToE/MmWQhUkS2RPZ6ntKeA0SBmDVpFrSWtjY8CHL2VgXWt6gHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIruNTAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9005BC4CEC4;
	Thu, 19 Sep 2024 14:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726754427;
	bh=Q+o8ZpD+4cU1yoEoEGfomHiCROg12mxxBcpsGjc3smM=;
	h=Subject:From:Date:To:From;
	b=HIruNTAUD14q+aWrIhe15TSYO8S3eIajgtFDr30XGz8Y8jGM7xnOFlU9PEo4BmFKU
	 fj3HOVmDVMqRmFnprG5l7qnTXvJMBZe8IbSlvqi5HvggzAl5GVZXVdjvROZFwzrd+a
	 Sjg+lAjrUkgZ4oFCj90nif7JQDokYCbCaqydKjgf5xhd5tl1/J64xI0llH9TcEMCqg
	 Gf8itl0yc+BjHwP/ccvSH3BvCDZqcbIvNPhH63171kX0kPiWKmkBcFnDo4Pcjzbt9I
	 zvKypiTEyHv9z6OlBnchyi2Wz6Lw2wjpn/0O7iwgPGd+I5kaoshPqSvmUP76af8heW
	 bCKhRriusGBVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 771B73809A80;
	Thu, 19 Sep 2024 14:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <172675442902.1557757.13094339321206765765.git-patchwork-summary@kernel.org>
Date: Thu, 19 Sep 2024 14:00:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-fsl-lpspi: Undo runtime PM changes at driver exit time
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=887477
  Lore link: https://lore.kernel.org/r/20240906021251.610462-1-ruanjinjie@huawei.com

Patch: spi: atmel-quadspi: Undo runtime PM changes at driver exit time
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=887491
  Lore link: https://lore.kernel.org/r/20240906023956.1004440-1-ruanjinjie@huawei.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



