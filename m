Return-Path: <linux-spi+bounces-5730-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537939D2943
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 16:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F4F280F13
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 15:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DA21D07B9;
	Tue, 19 Nov 2024 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7nPWsS9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2451D0947
	for <linux-spi@vger.kernel.org>; Tue, 19 Nov 2024 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029016; cv=none; b=OcoDP6hB90QZkfdwvfGUSVaRuCEJdMfRMKpZTkItnuXfgQP9prdhrwGJIAauwZXCpsYylkF0SqKoRE5CPttYela61IhSTYbNE3GtsO/PqXWlbqEvodtbuUC+w5yeP1WNb/TROuLWp/7M5ZunO/+UqRZPeFM0uEidgFR1DFAODkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029016; c=relaxed/simple;
	bh=JMg8WS7Hpb+eG/c9rctFN6PYAXy6sJM4ZgmrGhpNDo0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=i+oPTBGq73IdcNGO5q8yAlcH2IUNSp15S2fUYClB+v3LWWoKyfD11mbWcNBE0qJWYx79MHXOfT0xRM087/6A44fBuV+33ZcWMKv6Yst7VT60avna3cQYumHWupgSxbciKvBRo5kEbaE29u0c0KeuwWHjWK7p4iRnf/0SBsnTW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7nPWsS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A443FC4CECF;
	Tue, 19 Nov 2024 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732029015;
	bh=JMg8WS7Hpb+eG/c9rctFN6PYAXy6sJM4ZgmrGhpNDo0=;
	h=Subject:From:Date:To:From;
	b=p7nPWsS9WeCvdp8pB2KOpTcnJ8vv+rbdbuyDVAADBqUYfPitKUghRJALirNc5YK76
	 ZhXe7AVdGG2R1ub/9RPtRgjh8bIyh4mDDwd0cINgbue6qcCsRGs89S4JFySQ+AJtp4
	 Lo7Iuye8jV9HGcpbCXdv4Fzq4+kiQHUun1DBnn++ukqmFriUCEASQCRopnWFmkJGBC
	 xyJZuhjkxUd1TTAw0eYZFD1F/AtJN0rscKs4QkkNs6J1p4+/dJu11DQH28pFnRsIsk
	 ZW4ldiBGaG5Uiuf8dpe6YjpBPh9oXmsLyG7/1prn6ax6+TtyxSCVKmQm4TR3njF71T
	 ERr8TVjwdj59Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 387503809A80;
	Tue, 19 Nov 2024 15:10:28 +0000 (UTC)
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
 <173202902683.574837.8874392671058217646.git-patchwork-summary@kernel.org>
Date: Tue, 19 Nov 2024 15:10:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: rockchip-sfc: Embedded DMA only support 4B aligned address
  Submitter: Jon Lin <jon.lin@rock-chips.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=910704
  Lore link: https://lore.kernel.org/r/20241118145646.2609039-1-jon.lin@rock-chips.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



