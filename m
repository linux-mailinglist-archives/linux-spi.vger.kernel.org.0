Return-Path: <linux-spi+bounces-11309-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C21BEC6E452
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 12:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 5F9FB2E40A
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 11:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41809355024;
	Wed, 19 Nov 2025 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS17QJo+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F1354AD7
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763552440; cv=none; b=lnQD4DrtmKv3NMDaThogo+MUk935fB1bRKwIMkJFqIqa0g/Fb1DW8B28J+GscazTETvr7cFytM/BGTOIRQeyoH984UJFaByMRWtL9hWmsig7EGk6xfczuZ7SdFjy2rQcrQjPSO8jpccL4mwGb5nF/gjFy6ELifs/fMEkuf/OdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763552440; c=relaxed/simple;
	bh=CDHNpQxa44dLrxG1dMA7W6bhjrv1bBFrjY/GTLXUKEU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=UghatsYmPp3UcsAaA75euOqB/uSATiTbh8wXBFU0b7eTgwyaWgIIMvnrJFBvcxMHJj/BSSu1bwr0XivkUycNi0JlvZkyG+jLmV3JR02UE2pU4xn5nef4sUNza5uGXZBkbgWhT3qUi/4dJ++h3YwNcAh/QHEz30KBwo/FVJd4wAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS17QJo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ACFC2BCB0;
	Wed, 19 Nov 2025 11:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763552439;
	bh=CDHNpQxa44dLrxG1dMA7W6bhjrv1bBFrjY/GTLXUKEU=;
	h=Subject:From:Date:To:From;
	b=IS17QJo++eFvNz+xlZuHZhrByq4UIkMQfusWqY4+Mpy/oTFFJq8r953/XztwDbYgE
	 SzIb283jFFOpXdIWDmdvzlBB6/yMElMh9PDAJb2twvZTv5EdOxl496hu2uXJLCDJYL
	 3cYhkdTy/ngYhsSAWtkK2DPI97T3zotcuPxbxHoNmVRwB8LNZHnDXt9MyJJVjeThox
	 A4/4NpMAyVSvxGzWUnxKy3mF0wSsa8LoMHq11kh22RpDUFbv1tPQ9Z3O7t5zBmeKP6
	 KPG6Nr1JDhHC3oQK7E1zoXKJ3/4j2rkRBiX8Yn/W7jmRLK3Wtmr9m2bB1i29tmPf6T
	 3WT29DHJ3wOYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1371380A97C;
	Wed, 19 Nov 2025 11:40:05 +0000 (UTC)
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
 <176355240432.742193.13399678986762766039.git-patchwork-summary@kernel.org>
Date: Wed, 19 Nov 2025 11:40:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: sophgo: Fix incorrect use of bus width value macros
  Submitter: Longbin Li <looong.bin@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1024153
  Lore link: https://lore.kernel.org/r/20251117090559.78288-1-looong.bin@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



