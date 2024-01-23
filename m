Return-Path: <linux-spi+bounces-631-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB62838FBB
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 14:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C061C256E8
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 13:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DE85EE8D;
	Tue, 23 Jan 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RExK9hLa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EF35EE93
	for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015606; cv=none; b=T7x2L2pO7FzpVdPGqnMaGHwxXmTAUba6XoxYiP/KXy43S4a6MpVRhGsIlV78b8AKhclJjskfJrkYaZV6XLtANBQde6E5yaEkK48iipnI9UnfYhvgWOV+5AiGHRH5iSM6dlapCQyCJKxmE8AcF1/G5Yip50VJj8qlABlWlEN7vJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015606; c=relaxed/simple;
	bh=puZbuaWvqA5tTOwsx7uQIFWRoH/pWdzKWfTbVzBNOjo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=lEs2/Xek2bWk9sQK5eRoSOYQlCWUWXe1GYcIFw6ITziOZbPOYMMZzepEl2FSS554qPfjYLqK83/e3pGe/Sg/MAn6IUqiK3/F7RmNvrFGD2ChdwJNdhh1fe3RNsf7UvA0Xn2mkwdZG1ZTp+TQeIHDVQqtzzLqrKQBp8c6hC8N4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RExK9hLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A29E0C43390;
	Tue, 23 Jan 2024 13:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706015605;
	bh=puZbuaWvqA5tTOwsx7uQIFWRoH/pWdzKWfTbVzBNOjo=;
	h=Subject:From:Date:To:From;
	b=RExK9hLaCIgG9kD7RWkdh/UCNKw6orpSf3aICFtLqUKehKXSiUxznXnQLTsK+O51+
	 zJhbAWuZVevcgqWia1d0xUEEA9M3EI/z2QOsXt3rPUgDyqUQB6WXftUk5rxnPmh3Mj
	 GlydV5946Ntd7z1vshdsHPT++41HdVnj3wh4YK1/5eknORz7B7X21UGuHiuLpS50ID
	 Rc4M4mK7FPRpzMgXXHsTuNtdiDe0hj4Zfac18vn7RxrWJqBU2YoJmHFUK9mj4QDZl7
	 oaz4QmdFhNKD4D8+8UWTGrF4vYzY8wyYzE+gkpqk28QN/aHdR+LVWdDCW32YKcZt8n
	 7QTiSSzCECUOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84EA5D8C97F;
	Tue, 23 Jan 2024 13:13:25 +0000 (UTC)
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
 <170601560547.30882.9243253664531847876.git-patchwork-summary@kernel.org>
Date: Tue, 23 Jan 2024 13:13:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/2] dt-bindings: spi: fsl-lpspi: support i.MX95 LPSPI
  Submitter: Peng Fan (OSS) <peng.fan@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=818506
  Lore link: https://lore.kernel.org/r/20240122091510.2077498-1-peng.fan@oss.nxp.com
    Patches: [1/2] dt-bindings: spi: fsl-lpspi: support i.MX95 LPSPI
             [2/2] dt-bindings: spi: nxp-fspi: support i.MX93 and i.MX95

Patch: spi: spi-cadence: Reverse the order of interleaved write and read operations
  Submitter: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=810962
  Lore link: https://lore.kernel.org/r/20231218090652.18403-1-amit.kumar-mahapatra@amd.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



