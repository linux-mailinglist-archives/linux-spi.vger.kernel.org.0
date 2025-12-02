Return-Path: <linux-spi+bounces-11730-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFF4C9CF12
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 21:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAC43A8756
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 20:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438E62E175F;
	Tue,  2 Dec 2025 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOZiRomG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0D11D5160
	for <linux-spi@vger.kernel.org>; Tue,  2 Dec 2025 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708188; cv=none; b=Rd3sZjPjaEdraz0ljP0brkFdcvHixjYzwDdw5AmFF0ymgGxvvnupfL47axy7SqDLq7s7LoYpM2qVMBTL5AMoRX7xuZ0sQrupFE5vAIzfKkMOV/10v7l2tjhsaA4hEzwdG3yVIFtPUDS7lKDQNqbIyFMfmuLu0DE4EDVeK+kjoc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708188; c=relaxed/simple;
	bh=p64gb3YmeKsQr/y5aGBSvjHWXIXIJOiY0jg5qdMEAoo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KQ8yZZzB90X3T0oUmcojXfzuG8Dh4hLHg1T/OwOfZBbItx9PIZmcSYvsnYB15Y1KabZs18lBfprd0hsy95+q+a90H/ChBHKxqY/4pu1OUtyk/uLAp3KXjyn5xi+pyQJrK7UyXncjcaCcTYhL6xJq8hKv5kQZPz+w5F099E6h9b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOZiRomG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD90C4CEF1;
	Tue,  2 Dec 2025 20:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764708185;
	bh=p64gb3YmeKsQr/y5aGBSvjHWXIXIJOiY0jg5qdMEAoo=;
	h=Subject:From:Date:To:From;
	b=jOZiRomGX0p0uRA6/fAyHdmrYjCEiMivJ7gf2/t4WK+yE8OqLp7UN6M4Xf3PnwRhP
	 yzFImMWHDL2BX2cZbeb1X0OlSWnNm0KqCQZfRisMTWlLFLJqsxLiqRciACt5jnsN1Q
	 ZhzbdlCCSOtnD9DVEnATXb7VVJgxvb3WPVg9HeW/kRhoMBf9DN8VYmKq//QUbR9qyP
	 36IEJtRNNtdJ6hplGNdXICV3PMLyVGS7TdxuCYllDlvob2CWs8RLKJUy9gL+0Tm+Ws
	 2OcsRbeojYeOcLG2lCF27Z5ATeT6/Ae0ZaIfS94nPpfz5ItiHRhSPhjbUHok5gbjND
	 xEO3b2FFCHldA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 038FC3A54A3D;
	Tue,  2 Dec 2025 20:40:06 +0000 (UTC)
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
 <176470800450.3382228.462416297158407153.git-patchwork-summary@kernel.org>
Date: Tue, 02 Dec 2025 20:40:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: cadence-qspi: Fix runtime PM imbalance in probe
  Submitter: Ali Tariq <alitariq45892@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1028970
  Lore link: https://lore.kernel.org/r/20251130091251.12120-1-alitariq45892@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



