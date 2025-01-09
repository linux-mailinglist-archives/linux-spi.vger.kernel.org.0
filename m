Return-Path: <linux-spi+bounces-6270-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2DFA07829
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2025 14:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0353E1887EAB
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2025 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA89213E8F;
	Thu,  9 Jan 2025 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4RAbtp5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175132AE97
	for <linux-spi@vger.kernel.org>; Thu,  9 Jan 2025 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430675; cv=none; b=dQwrzvEvrgaToRcJKGmYmsdTb6SvwJxLBJEAkeuHA43erEQndNeOrQMUbkASRGQ8qjrsYcQ7hSy5/e74oURdy9+CvguuFmVSML2hwvNsJVFXpxlPL962WYLFkAafwKWtgJ88+2jWSzOUXsRqJM5nUTVHCl+2JXAfuURERGBwSJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430675; c=relaxed/simple;
	bh=pPAoTFzY9DqHCLbZQ9hisqJK1XaWicWHE6IkEqxgB5M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nEz3z4YmfB53/IeRNKNAY/iPQzNS4g9iIp6wRpejjD3Pt4uJfVbBgECQ48FvE/yzdGQ+GClH5su7tUt/IyQxBqixGjYF///OjoFmkhs6UnuDaqFCUvy7w8EZTZjDlgm3sMioGnjFSYYxC91fhB7SyUN7MKXbtpl5Ro2iG73A3ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4RAbtp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991F2C4CED2;
	Thu,  9 Jan 2025 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736430673;
	bh=pPAoTFzY9DqHCLbZQ9hisqJK1XaWicWHE6IkEqxgB5M=;
	h=Subject:From:Date:To:From;
	b=P4RAbtp53He9I9rznzMSSJpUsC6HiJ7x705HFQNvc2KHdTfYZhuwROhhaIMINEcM1
	 UnfnZmaJqJMmKGXQO7diKZJzMe/xmWiMSn7aRVxKO8XthLfu7EL86+D6KiZY7F0TsY
	 PsuXFf2JEibKbNUgEhqOzywF/5OhNY3gOiUkKQh3ElHvtXMws+AOWo+3u7tX/hE6eN
	 GAlPeDPOf0chEo/mHDeHHZhdJEqOZ6sLgsveHpWYBlU8QLagzXp43KfoWvsU1345te
	 Ugpb4KfhjSMyQOA6VsfmaglaL4HwKyYZz/5IZwj5cPrW0YUeCQkQZbOR/zd2HsoDxN
	 2yJ6+od0tgEiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4057B380A963;
	Thu,  9 Jan 2025 13:51:36 +0000 (UTC)
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
 <173643069471.1334189.16555288468156998613.git-patchwork-summary@kernel.org>
Date: Thu, 09 Jan 2025 13:51:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: atmel-quadspi: Update to current device naming terminology
  Submitter: Alexander Dahl <ada@thorsis.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=923675
  Lore link: https://lore.kernel.org/r/20250109094843.36014-1-ada@thorsis.com

Patch: spi: fsl-spi: Remove display of virtual address
  Submitter: Christophe Leroy <christophe.leroy@csgroup.eu>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=923640
  Lore link: https://lore.kernel.org/r/8a37a960ff084dfdb9233849c00714e9317ae6a5.1736405336.git.christophe.leroy@csgroup.eu


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



