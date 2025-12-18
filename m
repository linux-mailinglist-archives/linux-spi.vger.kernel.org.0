Return-Path: <linux-spi+bounces-12009-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6CBCCB308
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 10:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D24313040783
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 09:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9873321B2;
	Thu, 18 Dec 2025 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVGeJRLB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E242F069E
	for <linux-spi@vger.kernel.org>; Thu, 18 Dec 2025 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050397; cv=none; b=VwLo5ltljw5vfSAzQ656GBdA/T2CWZMfTuqbA0/Gqtp6wd3DY4YuXWGvh2MCR5IZhQplhZpSBb76ofahKTjP8GnTWCTcZ2zuFIXdm7MHcarNocJpyo60/MUrjVuyVeXOoiCR2k6h4AulQrSUHoTtAKSMQBq1kJNvT9U0CEO4F3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050397; c=relaxed/simple;
	bh=UW97uI8gqRiktaDhVmYXSp3ZEn8rop1ldsCeM00+dIw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=IgSQfUGnOWoQtS4MwJzYp36dPiYZF7PVGTvgI2IKpr0uz6zIDuyfJNx4Qra4Algt5ZU55Uc1xapnX+43nxkiDTWiaOyTiRkDsF22i07ARdxKUTeVaY3dycB9+zt9HJnlKZefVIexx3Or2pyv/rB/IQlb5R0+gja9y1DqtWI7wLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVGeJRLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4A6C4CEFB;
	Thu, 18 Dec 2025 09:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766050396;
	bh=UW97uI8gqRiktaDhVmYXSp3ZEn8rop1ldsCeM00+dIw=;
	h=Subject:From:Date:To:From;
	b=SVGeJRLBEql/E/jSfp9dap4fCYgET2Kf1aOr2XMS3aOxxqx8cNmU64vJjzZiKRGQV
	 9w1WD9OnKbwT4VmU5AhYsvYjcx6pgfrpBi7VNt/wZit9VrsasmlmmYLB1J7yG9zLII
	 Zqk/aDjD98+ugkisH5tnrDeyt+tS5cGtJv4c6EzKN2t5LN+TadgCq9XQR8so+SG4p7
	 EUMtnKXTEscMdLhibPRkwQpkb9FFuoHAan4v7DoyELSnH0ecgiB7y6KEMTRthmq57G
	 5G0S4SMWwcggGvDLycXZtIkGtZekw9aU0ZOKeY3VPjUg9cDTFnxuLDQ8FV/wpFOeje
	 z0bXQO+ElF3qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 416463809A98;
	Thu, 18 Dec 2025 09:30:07 +0000 (UTC)
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
 <176605020568.2471287.16229013289558644351.git-patchwork-summary@kernel.org>
Date: Thu, 18 Dec 2025 09:30:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: cadence-quadspi: Fix probe error path and logging
  Submitter: Dutta, Anurag <a-dutta@ti.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1032546
  Lore link: https://lore.kernel.org/r/20251212072312.2711806-1-a-dutta@ti.com
    Patches: [1/2] spi: cadence-quadspi: Add error logging for DMA request failure
             [2/2] spi: cadence-quadspi: Fix clock disable on probe failure path

Series: Add support for NXP XSPI
  Submitter: Haibo Chen <haibo.chen@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1033581
  Lore link: https://lore.kernel.org/r/20251216-xspi-v7-0-282525220979@nxp.com
    Patches: [v7,1/2] spi: dt-bindings: nxp,imx94-xspi: Document imx94 xspi
             [v7,2/2] spi: add driver for NXP XSPI controller


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



