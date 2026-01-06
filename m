Return-Path: <linux-spi+bounces-12197-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB90CFA565
	for <lists+linux-spi@lfdr.de>; Tue, 06 Jan 2026 19:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 312443063DAB
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jan 2026 18:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DFA2FCC06;
	Tue,  6 Jan 2026 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nm64cbVc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203682F8BDF
	for <linux-spi@vger.kernel.org>; Tue,  6 Jan 2026 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767724409; cv=none; b=RJZPBiQ2jCOXlzc3tfIHFeUXdV6K68nfPyRl6kHexIcfBYePatwTPVlCaOLR8e7mVMxQxgg9M7BEsJ/VR6B+4khdZW56iLCvzcrodyY4m1DYaYQXXVw9NKfs4hclskEcWxO/SFMx3Dv5mJqOg0si1dIdKiw3F/b1vqPuGyFQ6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767724409; c=relaxed/simple;
	bh=So0TTgZjZkCpE1mymMTXXYxcGGuGGoM2wsWXxjXUy24=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FC+uCaS+7vuSMavsfZAmITvjsbKNawxCF11GG46FXO3LxxiPMVMhk5DQP4lFBTUy0nCfxuSrJWFIO2H16L95Gr70bhY1as4zAaGk81WEnHhrb8y/yDpibFmxoVxtS7Kbomh334f0k6c875EkHOh6LfAZj+JVUgkqueuAhP2bgog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nm64cbVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF002C116C6;
	Tue,  6 Jan 2026 18:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767724408;
	bh=So0TTgZjZkCpE1mymMTXXYxcGGuGGoM2wsWXxjXUy24=;
	h=Subject:From:Date:To:From;
	b=nm64cbVcFfys2d9ueD8+t13oBwP7H7SbqYzo4Yc4317qmrVJe3HFYX/wRZYeWajvo
	 o2tvDf3eRwvZW2pFQ3T+58kMhQs+4kOdyHA8jUTt+6aBjZnb2FgZ8pgr2FdMy5h57a
	 JbHiVSRl0jxEwg3Ku12yEhTcCTcR/0ZjQ/VLHhM+5NW1x9dO75/nD1oHIutqNObJTK
	 VoTGyzcrHDViBnHH+mWThzCoKaDEkaPnjhHr/KbZWaka6yFBOPPlqOZAsGya1hm1aI
	 gzq1urHfPGWr2QNPSvZRrmYiNx4rHhVvmrbHO9ZRjVN0RGcCTA8zuWF2DdSIoDSDHD
	 IzHSKaFFy8iZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEDD380CEEC;
	Tue,  6 Jan 2026 18:30:07 +0000 (UTC)
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
 <176772420600.2094857.8436386779083459985.git-patchwork-summary@kernel.org>
Date: Tue, 06 Jan 2026 18:30:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: drivers: spi: st: use pm_ptr and remove __maybe_unused
  Submitter: Alain Volmat <alain.volmat@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1038948
  Lore link: https://lore.kernel.org/r/20260106-spi_st_maybe_unused_removal-v1-0-8f5ca7136e96@foss.st.com
    Patches: [1/4] drivers: spi: st: remove __maybe_unused for suspend/resume
             [2/4] drivers: spi: stm32-ospi: avoid __maybe_unused and use pm_ptr
             [3/4] drivers: spi: stm32-qspi: avoid __maybe_unused and use pm_ptr
             [4/4] drivers: spi: stm32: avoid __maybe_unused and use pm_ptr


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



