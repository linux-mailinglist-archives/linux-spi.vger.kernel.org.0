Return-Path: <linux-spi+bounces-8547-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA84AD92F3
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 18:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9BB18875E1
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB5D1F37D4;
	Fri, 13 Jun 2025 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8g0Swpt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A82E11B5
	for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749832798; cv=none; b=fqs/6sg7rFtAgE8NqJ6WsjqEBA/48UcIkUgr0A/PYfYDYE3zi0yfqz73qG4VxMHFJhPs0JH5fWgh+C4193xIfwScH0ebuO1soz55r1GwOnDxTHTdPxXNthZRAHu2gaBMb06ifvZgyur54RZQMWhOVgSNGFwfYJVfYns2PO/oRAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749832798; c=relaxed/simple;
	bh=OtFZ/GUDaElMnUlbsycVqns5ixsmzVh8H/NQL16l0hM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=PMdCK/LEtq6tnMFYcwTEmp1ot5SXHRiBHA0OTzJ7E5dob1jDeYPf/Wy4w06i6rlrAXw0BcFKevGO2Pb0gVoDRNm4mIxyk/1QuNlbn2dZwhZfLjErdITI6hcI4XkoJSG3uBkDf0M0/0GKbjgdag/cAqVzz7GyHR2bUIz3KuYn1Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8g0Swpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A25C4CEE3;
	Fri, 13 Jun 2025 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749832798;
	bh=OtFZ/GUDaElMnUlbsycVqns5ixsmzVh8H/NQL16l0hM=;
	h=Subject:From:Date:To:From;
	b=e8g0Swpt0hy7AS0/8zgMZdMNYB2bACR/lh3BmboZyTeN14er1uHfeCY7tESX87fa6
	 y5bqiNvrYV3JuaYWH0KaRpZCh0Z03mD2PrnkUL8MuhvXqrNMliqLAyDlrug3QzxV6i
	 tuMdX6kUfMt6w1t6TNX65QGYhcE7bt3lx5dlvmtElf6UYaA32uUZNb4NvOamOHPTHW
	 yeZfeObNsDW6FNShpPqBhJZppJlrHfTzQLD6KKPaQn9w4wxDDLYpif5p8AXPpyGHew
	 zw/M5pyL18C4RhCyaOq0I9w/F1OulmlxD6zkdSLhuOIjG7o6M69Saap1e5PU10velA
	 iVIBG77GnvAFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3758D380AAD0;
	Fri, 13 Jun 2025 16:40:29 +0000 (UTC)
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
 <174983282777.807921.12796924511826577929.git-patchwork-summary@kernel.org>
Date: Fri, 13 Jun 2025 16:40:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,for-next] spi: spi-pci1xxxx: Drop MSI-X usage as unsupported by DMA engine
  Submitter: Thangaraj Samynathan <thangaraj.s@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=971128
  Lore link: https://lore.kernel.org/r/20250612023059.71726-1-thangaraj.s@microchip.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



