Return-Path: <linux-spi+bounces-3446-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A215B90DD14
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 22:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B077B20AA0
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 20:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEB716EB71;
	Tue, 18 Jun 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQylxuay"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C494116EB6F
	for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2024 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741431; cv=none; b=ZwXCQ7FU6kaloYlYH3UDKjPMjUVRJo/68y5VJ+jJX0m3drY8rsRh0nJcdeERRmnYuI66OfNdtSpb7K8yust9vFHjcfatCgK1Ado92U8PANBb7ve5hmJVSMeZc/9YhEJssv4ZCG94fnEQmyjszSGtM4yRk3R6AFp/eQNOvq1mfkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741431; c=relaxed/simple;
	bh=EKveK1l2jhoZoXvOGNiFpKMmAP6KAeM0+ziWzCgtr04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=DUYQHZXOA92LLA4TEhA2YAc1mzMPJzHFe3aJGnQCuZqF5BlqdyJxnzI0xOLCgeDAvBVqlxm8gXJ0mwa80Wl8RQLcKHj5r6Usg5t+ge8vHzJR8eKSDBAC9skTjy446FvA2+y/nM57eGcb3dsulCdgG+bJq2vbF1SmmO22PVPsPMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQylxuay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7307FC3277B;
	Tue, 18 Jun 2024 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718741430;
	bh=EKveK1l2jhoZoXvOGNiFpKMmAP6KAeM0+ziWzCgtr04=;
	h=Subject:From:Date:To:From;
	b=BQylxuayMTq8AMkD9A271SAbrrfBnLtsYrMdHbWwyT3nQEuY7M0wV4OP5SGOt2y/P
	 ELjjslaGQcmH5fYXuo2PYvA7CV/aaBYpFQ6d+l5aM3J5uZMq9kk02JIvao7SME8EFf
	 y+2NXfRrL5eF1CPlHtOFj3GO6MfP/BFg8T34svJVaLCJdIHa/DOUUOVnlyp5N0/MlX
	 YLEHmqE1ppgCxQNCF3Mcx3ewK88npk1xvU8Pi4U19viqQxtznmuOjMZFiBZUrC8fyw
	 WpT9DMPUPCngXm4Au4+Jy+JDvaOFK+OcpGCWru3HKvziIzEX5toHehi2tK2t7jva6L
	 WgcZICwFQIogw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B802C4332D;
	Tue, 18 Jun 2024 20:10:30 +0000 (UTC)
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
 <171874143030.13665.8799100218151431710.git-patchwork-summary@kernel.org>
Date: Tue, 18 Jun 2024 20:10:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: OCTAL mode fixes
  Submitter: Patrice CHOTARD <patrice.chotard@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=863035
  Lore link: https://lore.kernel.org/r/20240618132951.2743935-1-patrice.chotard@foss.st.com
    Patches: [1/3] spi: stm32: qspi: Fix dual flash mode sanity test in stm32_qspi_setup()
             [2/3] spi: stm32: qspi: Clamp stm32_qspi_get_mode() output to CCR_BUSWIDTH_4
             [3/3] spi: add OCTAL mode support


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



