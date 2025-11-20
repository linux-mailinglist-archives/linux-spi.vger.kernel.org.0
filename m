Return-Path: <linux-spi+bounces-11383-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A381CC73504
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 10:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 763504EE15F
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 09:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BD630E846;
	Thu, 20 Nov 2025 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QALSPEUl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0D30E839
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632245; cv=none; b=JuSIR0JzHkgSRxhIsY7HTruXZ2mFL+cwrbYf2/kA2vbIO05dkktaY59/C0ROn7kHUR7SN05+2un8ehyN+F209MuJg0WgoMT6o2DF+APAMtLuFztgWQ7In95YJSjjNqTf3jsXfzcA7UxdBOYWNBmFrRbyznp3UoZPgFK4U7vxMH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632245; c=relaxed/simple;
	bh=Dljoid9YOEr/fl9u5wwb/RZ22ubbcxV8dQ+MNvVh4fs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Z8U4tg7Ks3jV538vGmWXUFQPi0M5qoyDFfWp42tofZ7fTYQRYCALBlpRFF9kqKSzVY5I4rdfA9RJDxJYBViKDk2eys4Hxs+M2RNgWvtks+2SrHr3/nLzxm5ADaaJfmwRyq6lODK9Pehh9i080MCBpuqAGBuaDvcq9b7bwqUAAEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QALSPEUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE4DC4CEF1;
	Thu, 20 Nov 2025 09:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763632244;
	bh=Dljoid9YOEr/fl9u5wwb/RZ22ubbcxV8dQ+MNvVh4fs=;
	h=Subject:From:Date:To:From;
	b=QALSPEUlWtcp9R64aYGUw0n1SF/KZ60dPf735XEjfYI3jwwrEecai0bOuW2uFuCsm
	 PGucDiD003tGhVsLZ2ATe9fqHriD05bP07f8she4eJP1odYGH8ut1PZwu76M4Sffdm
	 K7sn+M/rxtJ8LOANndKIc+XaVBwtXewsaeHWH7ssftMaCaxYoXWYTlILsLQqCoiuaU
	 hXSGUA8nORVOjJpqWUZ+HpshHfMlA5MZO2gIM1nogLGfpVTtXasSTW0jjOWzbM5g3+
	 2xN3zlH73PY3Tma6P+65kZfoDyhs1eulb7Ww7zWE5r4oLkQ55nkBn4AUN1gqKlYgrt
	 ycw+c1BNxRifA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3733739EFA65;
	Thu, 20 Nov 2025 09:50:11 +0000 (UTC)
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
 <176363220982.1552940.17124487842064660914.git-patchwork-summary@kernel.org>
Date: Thu, 20 Nov 2025 09:50:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: cadence-quadspi: Fix cqspi_probe() error handling for runtime pm
  Submitter: Siddharth Vadapalli <s-vadapalli@ti.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1025391
  Lore link: https://lore.kernel.org/r/20251119152545.2591651-1-s-vadapalli@ti.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



