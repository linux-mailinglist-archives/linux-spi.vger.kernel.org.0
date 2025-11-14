Return-Path: <linux-spi+bounces-11220-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 778A7C5EA53
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 18:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE81E3C4C1B
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506C0332EA2;
	Fri, 14 Nov 2025 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNd5hjYq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990830F545
	for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140346; cv=none; b=YSSiTGW/dOXS2/oUgIHTCmwcG+6BidZfctkalVpkiwSRdeuo2pAQ1+967j0DbhSV2QquHbqu1Dg++3xq6jhMeazhd8EElPIxYZ0CiUIVSXRFvl0DSBTfxvzAxIJOCMGavi16XziNgqM7Y1a9WBwaM8K1r87q5OD0m0oGdKmvmHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140346; c=relaxed/simple;
	bh=/EOW2fSED4RuqwrG2wHsaZgXylt/GL9kI5hXhf31sb4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uiPt95skvRFwhFWqe6o3GOBhMgYNf2cfSEJIJmX1Q+RhZb/lgXwnaYJTwhEApcOwTsJ1oEMG1ZibCG+pWDCc1bNqut/Fq92ps5gEAGSUSNWXbmHmViqU71/MHKDepXNfnae0OtGEkCteCpvsfz1mosGVt5GsVr6L7C0ukjgZd94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNd5hjYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C497AC4CEF1;
	Fri, 14 Nov 2025 17:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763140345;
	bh=/EOW2fSED4RuqwrG2wHsaZgXylt/GL9kI5hXhf31sb4=;
	h=Subject:From:Date:To:From;
	b=kNd5hjYqtlx1uooC2WByZh1z5J7wtEmcFbhZynIZGAl6+wTX78JWVqozzj0z8QnNr
	 lngd+q5bC6vnwd1Q5trRXo74bLkyYliHRS7kMSckI1QIDnTt+wuSp66EBKKMM0DMiJ
	 ghqkNJRF3YQJvEsLTmxVBRGntWftoNTo3SUpICkZRCEVTr1v8FOhRNqbg82ZN0DxUD
	 CEd1TWnjey1QjAtPmAd+wgmbqjc/ROKXCm3ecu+HhdEGlnzdylNr3ezzSF758Rh+13
	 ottz3QYaal6a410Vjm5faGz2hIoTbFXm2Ktd0z3VNlQY87dQAp0bRefk3Jd7rCVQlo
	 IieD7c9XJq0Wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74BC63A7859C;
	Fri, 14 Nov 2025 17:11:55 +0000 (UTC)
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
 <176314031406.1740925.13429356557671840351.git-patchwork-summary@kernel.org>
Date: Fri, 14 Nov 2025 17:11:54 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add support for Microchip CoreSPI Controller
  Submitter: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1023466
  Lore link: https://lore.kernel.org/r/20251114104545.284765-1-prajna.rajendrakumar@microchip.com
    Patches: [v4,1/3] spi: microchip: rename driver file and internal identifiers
             [v4,2/3] spi: dt-binding: document Microchip CoreSPI
             [v4,3/3] spi: add support for microchip "soft" spi controller

Series: spi-cadence: support transmission with bits_per_word of 16 and 32
  Submitter: Jun Guo <jun.guo@cixtech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1018037
  Lore link: https://lore.kernel.org/r/20251031073003.3289573-1-jun.guo@cixtech.com
    Patches: [v3,1/3] dt-bindings: spi: spi-cadence: update DT binding docs to support cix sky1 SoC
             [v3,2/3] spi: spi-cadence: supports transmission with bits_per_word of 16 and 32

Series: OSPI pm_runtime fixes
  Submitter: Anurag Dutta <a-dutta@ti.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1019989
  Lore link: https://lore.kernel.org/r/20251105161146.2019090-1-a-dutta@ti.com
    Patches: [1/2] spi: spi-cadence-quadspi: Enable pm runtime earlier to avoid imbalance
             [2/2] spi: spi-cadence-quadspi: Remove duplicate pm_runtime_put_autosuspend() call


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



