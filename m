Return-Path: <linux-spi+bounces-2746-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA628BC19D
	for <lists+linux-spi@lfdr.de>; Sun,  5 May 2024 17:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39DB61C2084B
	for <lists+linux-spi@lfdr.de>; Sun,  5 May 2024 15:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9EC1EEF8;
	Sun,  5 May 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYdLa0/V"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F741CD38
	for <linux-spi@vger.kernel.org>; Sun,  5 May 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714921828; cv=none; b=RP6XqI1vOq816VZ1dHsxetOBHolx9c4eGxmCtOXwkTy7pGVTHXcGW9ia9EDNPZ5xwrU528yqgH8Hc1CPtMZLjqY7wCLvpOuF0UHf8lF61no/fkpglhbN2FV3Tay9Ep/tBvvjlh+pgxgwMU6SR8Opu47ePgucy9pS65FJ6yTTJss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714921828; c=relaxed/simple;
	bh=cM0yMocaeFMrzSUV7xjtTSk45wLrgKrSNKkfCWlMyP0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=M4KXdwoflAzuO4DDojxEVluRUhp65cPtGH8ING1aWIzAhYDYxS6FNTOM831UidWfv/YsBVqfT/cCXXKfi50DVPLCA+sqkzjrSPMKh8lmVmCC5s2lrKXQBPYuk0gDvk52B3jEpwwZtErmGECwwUhw3ivkPCsvffTL6o11iA7OdEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYdLa0/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BB5AC113CC;
	Sun,  5 May 2024 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714921828;
	bh=cM0yMocaeFMrzSUV7xjtTSk45wLrgKrSNKkfCWlMyP0=;
	h=Subject:From:Date:To:From;
	b=rYdLa0/VARQBhwKJecx2EOMdz8gU8Mr9kWpCYa3E4wfrv+So59w9Dtj0DhmrjK5id
	 wgRe6yA15DuRKsdfN1YQQe3+2JjZwTT6kzyJteLXsLliGWSQ4TYUTYxrBGjVhzjTSL
	 7NI3BYoQcKOdgDaY84AyfHoCBYiIFv3udlyvmTKDaox1tTsCEPme3QvCWiikNdaDCL
	 aPPoo2wsZsBd3Lmv+SKVg4Nk08JQ4INQftkVW9JNcFFboP+VAaLHlkZLm4e4XsXPgW
	 I36Iu3BSTS6/cxLDDnWkla3o2Wb158+jO3GWardpuXqs0hyJS0oTnVsccxxDoRXTUF
	 XJA+tmdOC4bIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2162FC4339F;
	Sun,  5 May 2024 15:10:28 +0000 (UTC)
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
 <171492182808.1188.15897397056318442952.git-patchwork-summary@kernel.org>
Date: Sun, 05 May 2024 15:10:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: stm32: enable controller before asserting CS
  Submitter: Ben Wolsieffer <ben.wolsieffer@hefring.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=847479
  Lore link: https://lore.kernel.org/r/20240424135237.1329001-2-ben.wolsieffer@hefring.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



