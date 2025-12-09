Return-Path: <linux-spi+bounces-11830-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D9ECAFA16
	for <lists+linux-spi@lfdr.de>; Tue, 09 Dec 2025 11:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86FDB307B4D0
	for <lists+linux-spi@lfdr.de>; Tue,  9 Dec 2025 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB042E173D;
	Tue,  9 Dec 2025 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhwX96F7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6BB2BE7A7
	for <linux-spi@vger.kernel.org>; Tue,  9 Dec 2025 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765275790; cv=none; b=XIoU1ZQQ+jc3lZZ7YGsEUpubSk+75hODXFjCSxGmgFvxDkm+dhp3o7bCRugbwMTgh5bXX41dKp3YjqeFSmmzDLzlOcbesilLZpKwviz10XXDlr1NVWr7el+B1VlCWx1ShsxcOV5c0+nE54csN695y29j4pQicd0XBwH8nqc4J3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765275790; c=relaxed/simple;
	bh=/i0SNXgntT6JcCEauoPoD7Woz/g3mDzopu6mZJQKXwk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=jmZZSiHVEjkgdVEUjCmVIfveWMrgG+TsrdxjV/XUXOx8y2UQOQUBsLjPkuczhmPA5fvg3hDyf+fpF9IyRE1C2MKfr3WeVAxKNJb2hWxxJYSRR77a4QeH7oQcS32OkESAH/RW+8EX8TNjaNVBNR/DccYvDWWJXabj6q0MEoBY98I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhwX96F7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CEEC4CEF5;
	Tue,  9 Dec 2025 10:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765275790;
	bh=/i0SNXgntT6JcCEauoPoD7Woz/g3mDzopu6mZJQKXwk=;
	h=Subject:From:Date:To:From;
	b=UhwX96F7f7ZaDg6ZwAuMKxIrY0rODDOt2/yZG1z3iojbv51sG9f6p2f8pyp+Nhcwc
	 qrjLSpv2Vbt4W4K91zVXcJyHuPOR418npgSBDOTrsaeNG8YWdEEc8R4kJIeSY9rZty
	 81NNMBYcDb0qNUGGfK5j0y8zJmx6kI/kCyg8n3YNaFFN326MRhi3cm3h7sCfzf+Csc
	 g1YL8IrvJkW1TcyrgLMkhzhiPsVFilIL2smxTSCvkC8QbSkkg+aN3i6qS3+nafuYOv
	 Gatai52m/YplrblyeP8kBHi0BNOBNdCbSBIbgXJwhUVsCT3C4q0HaYLtxQt7pSYDDc
	 RqKwAiI/jMK0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA5F03808200;
	Tue,  9 Dec 2025 10:20:06 +0000 (UTC)
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
 <176527560527.3892005.10174408861534045421.git-patchwork-summary@kernel.org>
Date: Tue, 09 Dec 2025 10:20:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: microchip-core: Fix an error handling path in mchp_corespi_probe()
  Submitter: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1030984
  Lore link: https://lore.kernel.org/r/a7aaff1f28a83303a288de2914724a874fe1a11e.1764969247.git.christophe.jaillet@wanadoo.fr


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



