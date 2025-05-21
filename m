Return-Path: <linux-spi+bounces-8228-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC55ABFC94
	for <lists+linux-spi@lfdr.de>; Wed, 21 May 2025 19:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FCB8C6028
	for <lists+linux-spi@lfdr.de>; Wed, 21 May 2025 17:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D3D28937B;
	Wed, 21 May 2025 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsj0xwXr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313EB12E5D
	for <linux-spi@vger.kernel.org>; Wed, 21 May 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747850393; cv=none; b=HXfAL1mjIEcuwjopc1g4vxpMz5lEJy266thzGO+iCjBG6Sg4X3VLbTBPLB016mN8oOl7agdXH7OTjRo3ekyyPTD5HPPfegMcgHDycSlou2PuEgQORqZmTwd+vvg3ClltSGUX0obEYOU34H01AcXCyoMTDOYB/MiJhbHm1DJZWts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747850393; c=relaxed/simple;
	bh=W9nr428hcDJP/+fm7AdRHNNp1W7avbUgs7fA7GjeJMM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WNfl/piuREedqWRmX56iSPNXEWBDlAZs/XVrGDT7YOJR5nl9hwA1LFUo9tDxwNetyxpMb++FxMUa2xgGzIuPreZ2eZyIpf/IbqPgS0jFbOBpcWFMywawkkLXatk3m/ZtG1OjTyrEDgWyt6HIV1KgYYodUUiAGMkVmN3rh4RUiyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsj0xwXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BE4C4CEE4;
	Wed, 21 May 2025 17:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747850392;
	bh=W9nr428hcDJP/+fm7AdRHNNp1W7avbUgs7fA7GjeJMM=;
	h=Subject:From:Date:To:From;
	b=dsj0xwXrQOtwARu+x4LuxqqEFcxKTLd9zD8JaC1nqnwv7QqcQ03Rt193H8YOpHP6I
	 lpw6TSU80oaoi0Bs25+7aDqTzl+X4Jdw4pLeBT4dFdlsiWU4zMt11mTEvZUHwPxXet
	 IzjHz9y1bYjEbYSMQGLUZYcMAkiGpfv019ejFNRBLm1FM4KMhoGHbmlDIiJpNuJfWo
	 6mdTBddUHqrJ1Pn58nfqFGk3At5mRmARa1Wp3k5m0xvkQij5/g6wqFDYzEs9Td/MOc
	 bxSD6xfsU6ahs7G74TOzMEvMxAogf04UH0nNsnKFCqD8gWTPqGiEm9DsPG/roXm4gj
	 uZHjtT94esm3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77F81380CEEF;
	Wed, 21 May 2025 18:00:29 +0000 (UTC)
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
 <174785042801.2174125.5208120940852348728.git-patchwork-summary@kernel.org>
Date: Wed, 21 May 2025 18:00:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: arm64: dts: rockchip: Add spi nodes for RK3528
  Submitter: Chukun Pan <amadeus@jmu.edu.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=964517
  Lore link: https://lore.kernel.org/r/20250520100102.1226725-1-amadeus@jmu.edu.cn
    Patches: [1/2] spi: dt-bindings: Add rk3528-spi compatible


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



