Return-Path: <linux-spi+bounces-8981-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521ADAF0690
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 00:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B44417A003
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 22:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7D22737FE;
	Tue,  1 Jul 2025 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYgZafzo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE0271A7C
	for <linux-spi@vger.kernel.org>; Tue,  1 Jul 2025 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408984; cv=none; b=MGJ3gAzZPEcvcFsS/ssXWps9uvVhUO7ZbBUoxGKl/0gWdbp+x47fEz/I2opm8ixsnWPhTykNuNOdlOL660I00yhubUSFPq6Ry2Z3qLkwj//6D0LgCzH9gn84NnbEHvCA5wIE0XIyHUciuyTpvcY5Et69RKlvbmKRSlnNy68tZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408984; c=relaxed/simple;
	bh=6gZtK7NX/uYHWzk94SrfK1KY32F6H1oJ8ZGoyZJXDXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=DD7zy8vpYVBaK8iGjsVJBO9fUbutyhp5lr5dmiFFf2SzK0uQzBMEZ/wYQ05i4m+4mghxN7Vtkow3AcRJNE8aE+gAYgshsjt0LMNmuUrxJIVtl0b8gsn0kyPFoKlhbvtrrIIVWGBLJuis49zHY/sW6ZZkQgsAcsew5xk2STnzxKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYgZafzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF19BC4CEEB;
	Tue,  1 Jul 2025 22:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751408983;
	bh=6gZtK7NX/uYHWzk94SrfK1KY32F6H1oJ8ZGoyZJXDXk=;
	h=Subject:From:Date:To:From;
	b=CYgZafzo+yaOICrV8fSO5Gjb9Q3WzW5SXy4RY8buP1z0U9w+kp0WglguSRItpGw+a
	 bAGiDH73sFJ2U3cXPS0ms8e39Wq1BYAbfoSP75v2gg0Jwb7ynupUt7UW6HDXptfp4R
	 gNK3FN2LhI3AXG/CYCjfPANMqDDLjyZIahPOe4B6RZMgSB/Z09QjQ8ltTSdvEDrM4f
	 7qDwGvztsNTtCOHBCbMf0J/ofJ9bl1nLEaYin52VgBPCPbWhstqJwgUAZ8h1OSTZyJ
	 2O7+Iswk6bcad6SyEjveoPkmQtKOE6GLZydqWES4pvDQwlr2dZyn761Aw3Jpbl+HCR
	 ZoLQczErKJDpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A18FB383B273;
	Tue,  1 Jul 2025 22:30:09 +0000 (UTC)
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
 <175140900822.135877.4527054382417926449.git-patchwork-summary@kernel.org>
Date: Tue, 01 Jul 2025 22:30:08 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: stm32: fix pointer-to-pointer variables usage
  Submitter: Antonio Quartulli <antonio@mandelbit.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=977212
  Lore link: https://lore.kernel.org/r/20250630081253.17294-1-antonio@mandelbit.com

Patch: spi: stm32: delete stray tabs in stm32h7_spi_data_idleness()
  Submitter: Dan Carpenter <dan.carpenter@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=977463
  Lore link: https://lore.kernel.org/r/2033b9fa-7b0f-4617-b94e-7b0a51c5c4b1@sabinyo.mountain

Patch: [v2,1/1] spi: cadence-quadspi: fix cleanup of rx_chan on failure paths
  Submitter: Romli, Khairul Anuar <khairul.anuar.romli@altera.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=977278
  Lore link: https://lore.kernel.org/r/55fd5496924ef8a9046bd2758d0111be6bc8ff8a.1751280932.git.khairul.anuar.romli@altera.com

Patch: [v2] spi: stm32: fix sram pool free in probe error path
  Submitter: Clement LE GOFFIC <clement.legoffic@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=977317
  Lore link: https://lore.kernel.org/r/20250630-spi-fix-v2-1-4680939e2a3e@foss.st.com


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



