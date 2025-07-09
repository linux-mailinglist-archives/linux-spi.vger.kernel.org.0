Return-Path: <linux-spi+bounces-9080-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33E0AFEDEA
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 17:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11CC4E0670
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FD9287246;
	Wed,  9 Jul 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9/2il6p"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C092C294A1C
	for <linux-spi@vger.kernel.org>; Wed,  9 Jul 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075592; cv=none; b=OuwiuygiHgl1onNd184KRMO8uTHE1oNnLW4a2r79t7Vd4HvDDepWADC/tWYN3MKv24d84gF/OkOEYOCzGE5nE2MujGWRlsM654ivn2c6qR5kqxPhXVw3zo9YvYJb3cyF2dGR2UUwmafRHp77kQdJWm0YfYreP4sdjQMRqs+28Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075592; c=relaxed/simple;
	bh=IguMMEkFpV4JHVO5/qZVHWr0wMYHoCd3sPtLJgjSDuI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=LRTHRC3Ob6jcpZD5lEroUgr6RHitzFJg/KnbRZF1Jeh/xdygK3iEAB5I5Xb1VdJjmIuuKoTfke6/DyhsQlgFj3vKz4jcO65Repm9hUfxE5mTEefkn8wZiLalbqnSHyQ1pUUfUtp9j4ql3iQIPceUraQjOTUuNv2/MF9eVlwveI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9/2il6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56085C4CEEF;
	Wed,  9 Jul 2025 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752075592;
	bh=IguMMEkFpV4JHVO5/qZVHWr0wMYHoCd3sPtLJgjSDuI=;
	h=Subject:From:Date:To:From;
	b=S9/2il6pl5QQnCiNyYxy5USMj/g5b9hfoLV2yZJ5kz47IkoxzZqPgGo9xEW5rzh/k
	 LjM2p+U1XkDuzswGPsBPCiCjGp7GsFPuts65Na0tC7ILlijI2cRLogg1Ibeoz9ptDs
	 22WanM6l9fquH690RQlv17F2HMw9xa2oAOCiuynLqaoa019NBHci1BpXDi/2lXkeSh
	 0oyMTBrvOY455ZQGLbNYCn57rKrBwMAmdepxNsaov9IzJtiZTuZ7n/J0zO0diE4Wuv
	 zJIIjtzwx1yds5e0J/lBIM7WvBzbW43vKCrIV/oNXzBmBqqJz9beFos4ghYbNm21yl
	 PHTvoNK2XNQSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF290380DBEE;
	Wed,  9 Jul 2025 15:40:15 +0000 (UTC)
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
 <175207561449.766901.7735081880616912142.git-patchwork-summary@kernel.org>
Date: Wed, 09 Jul 2025 15:40:14 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: stm32-ospi: Use of_reserved_mem_region_to_resource() for "memory-region"
  Submitter: Rob Herring (Arm) <robh@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=980293
  Lore link: https://lore.kernel.org/r/20250709021638.2047365-1-robh@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



