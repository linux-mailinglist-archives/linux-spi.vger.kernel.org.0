Return-Path: <linux-spi+bounces-9853-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7600CB3FB98
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 12:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A461A80C88
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829682F3602;
	Tue,  2 Sep 2025 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQ2hQyF5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0AF2F291D
	for <linux-spi@vger.kernel.org>; Tue,  2 Sep 2025 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807237; cv=none; b=PS9Mk5NBwxu8GEK9t/ZstXszgZZGyPj7mjBWKGG3coiykPJl8wtELeUWnxsEES7jkCnuex7Sr0H1V8+9sXPkoj7oiBFGooqCXox+bKJ8o6sVwXb+KnR5+xoB9AoVc2dMkMI4H32v7PXfdkWbIOACx/5eyuuwIhyru3qy7OWhRbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807237; c=relaxed/simple;
	bh=6oV18Uq9PBMnrsN897GLuDtL+Mkv+z/60YLGP/4gNnE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=DkXws3JG808RYgW/ZDAa+Lk3j/9XZfx2WPkb9o90cOg0Fc86uxoTSYwYxVEqoCXQCygicEy/pLAhEpVCyhmvJ0GIjrIMUTe5k88gFsued7EP2y5JKvg+eBj4WTOAxUTkf9VlHPgTMaLpSMJnkE2UUQfnJpMkVcumWFHIKrUgsRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQ2hQyF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDCAC4CEED;
	Tue,  2 Sep 2025 10:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756807236;
	bh=6oV18Uq9PBMnrsN897GLuDtL+Mkv+z/60YLGP/4gNnE=;
	h=Subject:From:Date:To:From;
	b=vQ2hQyF5H9HrfYjFBfMcddgc5k/ATzCdpuOtB1OVHjVix/aJSUuJwcJvBiieu07oR
	 IAD8fixiCU4fMmM7K3LQUTA8vNavDs1uZf6bIRdQ9REjV1wr+8K1r04I/cSb+Ity6E
	 a5W+QwviWnyYozRWmuDXLm43zTVJ1K5i0dgHe+BRBR5u1/A89yM7sxbKrNf6CXor98
	 ycR5TwYRGdCvAUfevJY75qvRqDnrsqRx8/fwrxq9satfEHTFWEWQ8aSNjqa1IXgn3X
	 T2oxn9+IrQEKKl63b/9qzXUzZASelM+qxJMtcUT1LN3wwMfoQdQaqmuaHhhZ2VofTa
	 uytVj0IF78MzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37805383BF75;
	Tue,  2 Sep 2025 10:00:43 +0000 (UTC)
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
 <175680724173.223363.2463065029565291577.git-patchwork-summary@kernel.org>
Date: Tue, 02 Sep 2025 10:00:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-fsl-lpspi: Generic fixes and support for S32G devices
  Submitter: James Clark <james.clark@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=996424
  Lore link: https://lore.kernel.org/r/20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org
    Patches: [v2,1/9] spi: spi-fsl-lpspi: Fix transmissions when using CONT
             [v2,2/9] spi: spi-fsl-lpspi: Set correct chip-select polarity bit
             [v2,3/9] spi: spi-fsl-lpspi: Reset FIFO and disable module on transfer abort
             [v2,4/9] spi: spi-fsl-lpspi: Clear status register after disabling the module
             [v2,5/9] dt-bindings: lpspi: Document support for S32G
             [v2,6/9] spi: spi-fsl-lpspi: Constify devtype datas
             [v2,7/9] spi: spi-fsl-lpspi: Treat prescale_max == 0 as no erratum
             [v2,8/9] spi: spi-fsl-lpspi: Parameterize reading num-cs from hardware
             [v2,9/9] spi: spi-fsl-lpspi: Add compatible for S32G


Total patches: 9

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



