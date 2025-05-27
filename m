Return-Path: <linux-spi+bounces-8316-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792EDAC53B0
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 18:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1448A1CE6
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 16:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E6927FD53;
	Tue, 27 May 2025 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSDq7LRi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A7F27FB3D
	for <linux-spi@vger.kernel.org>; Tue, 27 May 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364600; cv=none; b=SMDiobqBm037BXYl5Gx4WcWnnduZQZgem0eCeGvcwSjo4RFsVohC0veQRE3l0k8Dccf91o0Z6H+YoDyTBNNML8XemM/O8NW68s8nUrPZxG6sJYi3MimipGbyzvJEYQWrNL/pPXAcOpue7pmHPX9oR4T7Mayt9robYilVMY+I8PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364600; c=relaxed/simple;
	bh=fCY+wIWXUdXN5mb71U4f4XKiGUo9QnhTzpHEI0H2nxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Kp3onQSREnZLOWoY6VldUel2mHj3NJe0ybbkZg7ezz0nE4FZohG6Ps76HolfWd/blpGE90PfdD/tedAQVWUdjoruSeKjx6KSfyqLdmY8Euz1CSKYbYXNyRhcpRns5ZY0NYLcwlBRp/Sx4ANwgnO3PI62zMMHbFlNu9jI9xPCEUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSDq7LRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7187CC4CEEB;
	Tue, 27 May 2025 16:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748364598;
	bh=fCY+wIWXUdXN5mb71U4f4XKiGUo9QnhTzpHEI0H2nxM=;
	h=Subject:From:Date:To:From;
	b=VSDq7LRi6fi3uEuyPQKX+qrl/QZvlbYaBH/f9BPFJIEYyAT7zm70ZHkb+sZVRk4Ra
	 tn7ExE9Vqc+g4jNEoxLPQcwjl1ZvQetildMDLAEsTqXcZfH9qOqRTR0qo8wMelkId5
	 W6aEQh94b/dlG3LvxSNBCgzfESl0PoglI28DBWsaAXPLUi5Cl66CnBevNxOR5BOAW3
	 OozMA3hMWcXbdrXvXVbEyATRs7EDCcNQMcDo1cu73Mv4GNKR6MnOdF0bkb9eKi3Gtm
	 vrYHknh16I64vKofnDSM94ulNt/rWrxQqP9KrLN+t9hmHbvS1qaUc9lTVFgc5JRG7g
	 oG2ct15x3uVqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB230380AAE2;
	Tue, 27 May 2025 16:50:33 +0000 (UTC)
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
 <174836463247.1707309.3955010571178215718.git-patchwork-summary@kernel.org>
Date: Tue, 27 May 2025 16:50:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: sophgo: Add SPI NOR controller for SG2042
  Submitter: Zixian Zeng <sycamoremoon376@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=966237
  Lore link: https://lore.kernel.org/r/20250525-sfg-spifmc-v2-0-a3732b6f5ab4@gmail.com
    Patches: [v2,1/3] spi: dt-bindings: spi-sg2044-nor: Add SOPHGO SG2042


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



