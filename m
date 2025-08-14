Return-Path: <linux-spi+bounces-9411-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7C3B26415
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 13:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B8B188BE64
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 11:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DD0287241;
	Thu, 14 Aug 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1tY5e7A"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952D2286D5D
	for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170394; cv=none; b=BaNxzwEt9wXahYY++OhxssUftTNXKTv/m6bzNVFRhFt2iy1IZ8iOX+otrlwULcrq2kLqixe977E5XsPf590EKjUGOevWJq45Pb5YFynAUB5oGNQI6Fp2wdOwwFOmlwU3Fn34Sg8yeIqHWABlG8WWaIr0cFI6NhQ7JM6D6y91d/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170394; c=relaxed/simple;
	bh=N5xfCxksFjMUv5/9xlrxfoAXvY81lanRFm/c2lFODTg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=CzXvnYu+qg7fIh//LvGE1x9sJnXjKfjCOY1ENfcvZ39k/u0vdxdkMtyTOBphBB7J/cz5S/p6j8rmRvjgdwoX95AedrliU6Ea0g2FCebLglrCcQnsXpiLVxT/O6gJMp9lyB3EO6D9Tg7AIi2i8uBqUHQN63unjXIwA+a4A/d+zn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1tY5e7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27055C4CEED;
	Thu, 14 Aug 2025 11:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755170394;
	bh=N5xfCxksFjMUv5/9xlrxfoAXvY81lanRFm/c2lFODTg=;
	h=Subject:From:Date:To:From;
	b=p1tY5e7Aeekq/vtRV8VHPEfBEMxCRsKv9e34MAYr8zBmvzR68wY1E3ezGQOZFxadZ
	 ASfAcw8UAhSKyvpBB/Vimx9KFzfDCMRLwLcvRd/z/HCT/SPirSLAIKm845woFFJDdo
	 yng/SnmNO26gWcCUydR5bUhr0KhkJY5srWpBlQwIXFBIy2fByqRy4wtLwEfRF+TtQl
	 SDmoF6dkfSQEkEfabceefz0jUVdBCc0+sl2fmmCg36LEc5kyKifuKH7UwpKQLdzaDt
	 NbvOpCiP4HQgiHDixzEjzDpUJVl2QxLx/EMyter2E9BKG28c7zAZr4hLDsbf0ebB7k
	 6Wyce9YpIUb4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B16BE39D0C3B;
	Thu, 14 Aug 2025 11:20:06 +0000 (UTC)
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
 <175517040534.249339.265759175208433066.git-patchwork-summary@kernel.org>
Date: Thu, 14 Aug 2025 11:20:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: treewide: remove unneeded 'fast_io' parameter in regmap_config
  Submitter: Wolfram Sang <wsa+renesas@sang-engineering.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=991125
  Lore link: https://lore.kernel.org/r/20250813161517.4746-1-wsa+renesas@sang-engineering.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



