Return-Path: <linux-spi+bounces-1775-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA83879985
	for <lists+linux-spi@lfdr.de>; Tue, 12 Mar 2024 18:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403771F22BA7
	for <lists+linux-spi@lfdr.de>; Tue, 12 Mar 2024 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F519137C28;
	Tue, 12 Mar 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke7BWUXe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396BB137937
	for <linux-spi@vger.kernel.org>; Tue, 12 Mar 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262833; cv=none; b=jb/upAzw3VPsXN/84fHmWMyk8YsqUHBZoN2YF+gzOwCc9pMsJMya2W9fYr+15AHj3LoFxV27ikmLnGjwWiLrP3Izd4Bb8a5PuThPPSeIH17zCJX+foqpSavT8sUGq/XsA8NGsESuu+nTb5lK3r+nzEChEiAb2YxuVb+eywTFof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262833; c=relaxed/simple;
	bh=n1htj8yOakxCs3r5du7l88o2te4v8FhmoR1hcz+YeZI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=aXWoOpu48Dwnia6gq0g1aOisRq/JoVfZh3+WHkDVGKqO6NJ77C7zNsrZ3lTD5xs+0LMNdK83yU51L/evV31nidG/zqd+83KsWs85WuC/jLk5eKEp8H0dvSeG8sUgh5oQKdiaRQEbZoxZteDAuunvg2Gki6LIp4dkaCn3lyGucbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke7BWUXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9B98C433F1;
	Tue, 12 Mar 2024 17:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710262832;
	bh=n1htj8yOakxCs3r5du7l88o2te4v8FhmoR1hcz+YeZI=;
	h=Subject:From:Date:To:From;
	b=ke7BWUXe8+HsDcjBa4Mmz/kOSanXuCFHnAYekn93Dl1q5Jlsc4V7wyVicTBmwBUP+
	 5qVm6VMWI9MsVj3SzJe/A6omEnMxtDlu2kXW2HyPDTtSIhzA1O1lh1E4b2XmUuiFWc
	 WQ3LLkjINJRQQbADWX683uZ/N+Mof6WIJgCQ+Bzwvi1GALFCUU1TlAZoX8E0lOTsc7
	 ZPnGg5YH/EWb7oJxlvzJDOYrHp6cNbDQc+wTLhBRRSk/UHYroOMq5NA2IA5MQOQQpU
	 zJucXtElzQgS90eKmPpMSjv0F+a0QQPUups8n94TTf1eveZiwSnWYBUv9CTFnofkZE
	 miDlOPNfzOlpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 918D3D95053;
	Tue, 12 Mar 2024 17:00:32 +0000 (UTC)
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
 <171026283250.31737.10029348188067733561.git-patchwork-summary@kernel.org>
Date: Tue, 12 Mar 2024 17:00:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: lpspi: Avoid potential use-after-free in probe()
  Submitter: A. Sverdlin <alexander.sverdlin@siemens.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=834606
  Lore link: https://lore.kernel.org/r/20240312112050.2503643-1-alexander.sverdlin@siemens.com

Patch: spi: Restore delays for non-GPIO chip select
  Submitter: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=834469
  Lore link: https://lore.kernel.org/r/20240311-spi-cs-delays-regression-v1-1-0075020a90b2@jannau.net


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



