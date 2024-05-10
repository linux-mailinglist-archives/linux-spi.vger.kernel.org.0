Return-Path: <linux-spi+bounces-2805-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C098C1E1D
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2024 08:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590BD1C213C8
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2024 06:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5761DA21;
	Fri, 10 May 2024 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcPzgyj3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D661A2C0E
	for <linux-spi@vger.kernel.org>; Fri, 10 May 2024 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322629; cv=none; b=o1wqVhZHoOhm00GkbDg9FMVUQxJGqXeBATpnZcXhlvin6va6OjelEqmgc+Fd4YHjs/8GniGPIxIzUcixz4mc8rZAcvlcxxhHgV85DLon2twCUU7sYRzMzXTfVRwZQLxxpUkCGublBhT2FsjT+Q4es7il7K46x3x412PWIl3Dm0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322629; c=relaxed/simple;
	bh=obUT/T8BX+5ZJOSzMFzL4Wv8aXiGQUGLzjy1j4v/JGY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fKnz0KQdOJSSZKbI8Wa6R+qedGbrgfGaT7ZjoJpb0zEvY0pG8em40K4mydHqSwm2qDdLehWuSsHdUhWRfS11tijxiOuUgI7DDa9kPg85PJdUhUfnciHIyQ9gbD7bk47fXaZbHoLpVHDPdHLB5KaGJeitRcTQiITFEXQUIX/3fH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcPzgyj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27F0AC113CC;
	Fri, 10 May 2024 06:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715322629;
	bh=obUT/T8BX+5ZJOSzMFzL4Wv8aXiGQUGLzjy1j4v/JGY=;
	h=Subject:From:Date:To:From;
	b=hcPzgyj3vdh0Y+ikepn6kM3bUFSO2cO4WVaZobnF65BgXnMyRzaFMvr/ipJQ5BfIP
	 NRJH/nBgxcq8JzkleiW7Oref8QzRT0ibnsJ7z6z9fJC29+XpgarJHc6l1C/WiYP4ER
	 ekNVuAXW9fAs3By459rQVmRxHH8a1zbjS60HmJ/gzzBPy/EXBgPG4E9djftcbICip5
	 0TW5LLtGVT5xVY4zZtyQPtKlFyxfNrFzRLRBErHZu5esT4195frigJOf5UfAp9mSeH
	 TZOpaOwZCeH7bffhrLiU9omhny9KK5T51NhOwpJwbd1iP7m22wwDtkfqZ1wMcwCmcu
	 p3h/KInjvNVGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B6B7C43330;
	Fri, 10 May 2024 06:30:29 +0000 (UTC)
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
 <171532262899.10962.9934565243403713065.git-patchwork-summary@kernel.org>
Date: Fri, 10 May 2024 06:30:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: dw: Bail out early on unsupported target mode
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=851514
  Lore link: https://lore.kernel.org/r/7ae28d83bff7351f34782658ae1bb69cc731693e.1715163113.git.geert+renesas@glider.be


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



