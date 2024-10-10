Return-Path: <linux-spi+bounces-5200-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88813998CDE
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 18:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DE4281691
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3C41CCED2;
	Thu, 10 Oct 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LylwUHvU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA41CC15B
	for <linux-spi@vger.kernel.org>; Thu, 10 Oct 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576627; cv=none; b=Ouk1VkgRq73YKaiHl08oijs+H0NkvJA6ELVFMqS/3ScUBKMvjWqBn5bJnw7Qrv92NwH28JgHg1SJtQm95SgNksUHiZsSR6cQUxVWqG+OzOc4iGiAorZarzfdxb59rRLzyoGF3qvznxO0Lxfto5Y8JPUdRVU6Eu7m6MndBnzb4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576627; c=relaxed/simple;
	bh=bANLhduIjuUPetMO0FZJ5en7ElaxkHceXm2+4kXt+gM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=btmet96YyyUNQeErX77O+kmKdAAbbkagB5ogLm94pA5moGIrq5MbTHKKntObM6ACkJHeTz0v8O7xPznAAQGgfuu11Q2+8uuTQrW9SqGO/XZDmrtCrCV+fkqzItNXGyR2Z4IkEs9zT1nVf//gCkSWiIzvNdgeuHFlzT1b6eQj1Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LylwUHvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5EDC4CEC5;
	Thu, 10 Oct 2024 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728576626;
	bh=bANLhduIjuUPetMO0FZJ5en7ElaxkHceXm2+4kXt+gM=;
	h=Subject:From:Date:To:From;
	b=LylwUHvU/3Z42Qsa/Jf+0ZakClCu8cWE1nkFKcWrSU96LdN/Jg7EEbh6SJ2b31jKK
	 n1uwKCpFX/uPNnqOdhngGcfqptd4WELNB7Ibt0FcPGjXpuc+7CmdhMRxKrBVYNkCPT
	 T2AZRogSFgTALTnH7ItuQPbS7epQ9GaVAKNC247mKDkZ+M68zf7jtHzoiGgUrfn0yi
	 CD5jxX4hDnHHLoo164ZdoAGhjfiknPux/Dkx8crrgLlaQDj8+bKxT89QF/LLk6wm7R
	 Jbxt9n2KCyawWV6IsnBh1Mc7euk2RRemDPcsYn1m7QJhcZviAtO5pixfXl91ln41mg
	 n1HBBCnXmykxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 39A2E3803263;
	Thu, 10 Oct 2024 16:10:32 +0000 (UTC)
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
 <172857663087.2081951.1209358925114789236.git-patchwork-summary@kernel.org>
Date: Thu, 10 Oct 2024 16:10:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: stm32: fix missing device mode capability in stm32mp25
  Submitter: Alain Volmat <alain.volmat@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=897649
  Lore link: https://lore.kernel.org/r/20241010-spi-mp25-device-fix-v2-1-d13920de473d@foss.st.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



