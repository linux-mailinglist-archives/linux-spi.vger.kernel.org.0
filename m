Return-Path: <linux-spi+bounces-9176-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 898A0B11324
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 23:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680D7AE48D7
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 21:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80160280308;
	Thu, 24 Jul 2025 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPI9HadF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8F81B4F0A
	for <linux-spi@vger.kernel.org>; Thu, 24 Jul 2025 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392588; cv=none; b=HOWU3BmZnIv0tf6z1mruR6CTBKcqc1NCc//JJlGF21BxL0H0MihUmww54EXQql5phW+RG2yJtJiJvRBI6upGnnlIG2596WdwM1fe6juCz2zFhoqz6nvkAQIAVRNcYFoW+BKkue55QZ39dCKdy3CbkgV1jIGih0DROEToPde4HaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392588; c=relaxed/simple;
	bh=OQPS8AAqfpTsd97WTDGkeISmkgUYNAfE+ye0llUxc78=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VeBk1F0PGFoLgdsYxyNho2sW+/lo2fkYTfYe+67F4+JiRBhk3JlX9Bc2koU/z/k6sAKuaVLZCcf9rxqvFhGbSPivisaQl3b3Vk9OZ2HX27qR4qoswuW0HzVCcDK1YpG4qr4asmUo6NTuHSa1n7KaL4C7UATLHh3n2cF9KkO/1SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPI9HadF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDB1C4CEF4;
	Thu, 24 Jul 2025 21:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753392587;
	bh=OQPS8AAqfpTsd97WTDGkeISmkgUYNAfE+ye0llUxc78=;
	h=Subject:From:Date:To:From;
	b=nPI9HadFzlwi8sWxIUf8rmQmSgks6cXFo627tEuAT9oGQ+WjJz5Hpf/XODi7bYFT1
	 GggZ1R4qV7Xz1O0MrDYKocOTyGuGvAG+Z8Op3a4fcg8ndcZYuVqi7idbXePUClr5h5
	 g1YiyP3AJ2EZ6pzF82on9yV6STV/w/Zj0ylLnBlrSJFK+Ds22BQmdv0YtK0AgQ91P1
	 DqJQkHmtrCGRzeVZTVT5j5u2bEDK0apIGWLnK8cC3+jYqbXOBBFTEMdJy+SlkFXqnd
	 rYDsQ6+/0lJuGIpWsbTUb9nxJXC5jeHFyUnM7Jd0ALcMYODHxl26o44a1rGMygdcEv
	 2pjHL8sFkeMzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1E73383BF4E;
	Thu, 24 Jul 2025 21:30:06 +0000 (UTC)
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
 <175339260528.2535775.17632049219535085630.git-patchwork-summary@kernel.org>
Date: Thu, 24 Jul 2025 21:30:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: support for amlogic the new SPI IP
  Submitter: Xianwei Zhao <xianwei.zhao@amlogic.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=983569
  Lore link: https://lore.kernel.org/r/20250718-spisg-v5-0-b8f0f1eb93a2@amlogic.com
    Patches: [v5,1/3] spi: dt-bindings: Add binding document of Amlogic SPISG controller
             [v5,2/3] spi: Add Amlogic SPISG driver
             [v5,3/3] MAINTAINERS: Add an entry for Amlogic spi driver


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



