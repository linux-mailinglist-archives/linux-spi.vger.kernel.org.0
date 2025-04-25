Return-Path: <linux-spi+bounces-7768-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32292A9D280
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 21:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1D61BA7B96
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 19:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489C521ABB0;
	Fri, 25 Apr 2025 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFS2F7Eu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229621A5B92
	for <linux-spi@vger.kernel.org>; Fri, 25 Apr 2025 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745611015; cv=none; b=jMuLuTwUzoCyTkJ5tYCUwMicgubgkDdcX+Wjw5Kv9Ao4PefKJjASn9pqel/2urcrHQjzfuiDRPifjUKvoe3QT2aEb/6kEuxUub22JYCs+0L4Zk59v2TpxpthkWISXZnQjcfx/E1LZPn1qyaJ3QpzjvJiGBTzbDVkiP+7hm4val8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745611015; c=relaxed/simple;
	bh=RDJ3039cLI6f5MMuJ/UcNm6Y9sdKgEsoMZZEpSi8k8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Jh3JOsKMU1unRDd1J/k/Ehdax5L96JaAv4fvh58n7cVR2IOyOZ9svEWyO9PF1vlBtMZzqbHUaay7bTveJzdH3ZaNb+jTrc9ioPw9oPeQv7wfNRpP2fjRK71TBwlOdkEzDppY8IUXcrm//LBgr7uqx5BBZ2aV/gFa5ECsis+qAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFS2F7Eu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E10C4CEE4;
	Fri, 25 Apr 2025 19:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745611014;
	bh=RDJ3039cLI6f5MMuJ/UcNm6Y9sdKgEsoMZZEpSi8k8E=;
	h=Subject:From:Date:To:From;
	b=PFS2F7EuPCANfHFrqdFVJljyNXyffDwjVCoDYSBkkklnxBLYXAhWLoy1/w5SaBZ3l
	 Mv2FaSxqDuCzTIYGVmF8/USGisrlIIdU3FSK4bYoV2cY+MR89h6omH/sh/GBWAoiuj
	 iA4sYZ39ztAULCgoqr8BgcIzebh5Xu4lI7VV/EZ/oeu8CjnL9r3WS2WBgZGsR7Mvmo
	 1GOjnEwwNPOLvni0X4D5THuNlvUjXW0Elrh+H/Tgucoz5pY4mIIoelpmWAfM+NM9wT
	 /fM/psb3NMGnjemaU8VoUMAmq84DY4J1/htM1SVJDn5x4E3uk9ae3GPfDdwqskJ7ho
	 SbFiNZL2iWzdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E94380CFD7;
	Fri, 25 Apr 2025 19:57:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <174561105289.3822955.11679705215629483894.git-patchwork-housekeeping@kernel.org>
Date: Fri, 25 Apr 2025 19:57:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] Add basic SPI support for SOPHGO SG2042 SoC (2025-04-25T02:28:11)
  Superseding: [v5] Add basic SPI support for SOPHGO SG2042 SoC (2025-04-22T02:27:07):
    [v5,1/3] spi: dt-bindings: snps,dw-apb-ssi: Merge duplicate compatible entry
    [v5,2/3] spi: dt-bindings: snps,dw-apb-ssi: Add compatible for SOPHGO SG2042 SoC
    [v5,3/3] riscv: sophgo: dts: Add spi controller for SG2042


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


