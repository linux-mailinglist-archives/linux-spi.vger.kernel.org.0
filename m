Return-Path: <linux-spi+bounces-7861-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 960BFAA7D69
	for <lists+linux-spi@lfdr.de>; Sat,  3 May 2025 01:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780F64E2458
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 23:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D822367DF;
	Fri,  2 May 2025 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDCoIIhx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16BE223DD6
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746229192; cv=none; b=XUbzovTFWZqJ4gpjCOMDxvk8P92Ya8EZtfEYKVUR8phnXcpvU5LF6c5toA5I/wjkCx6gObOuAVtqgWutKALp1/WowqnBUmduvpQHVJgNI3/UHkVEYD6q4HDDOal8B+kopkDPt332GGfW8KbS5jL9dLvZuyEudBrm4g6Vqks746A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746229192; c=relaxed/simple;
	bh=mI6z4/QF8du898mizLTspqGXXCeNTjcwPzrEhjXInB4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=olrhnrlBR7FbT6zRg1nwTxfEK3LCocVYJPr3BvMWl6e8c0EHF9nBMT7nf0F3kmIRX+u/sOvDaT+mPpZEJxALGraNydUREqwoHkpz/1yZ3qVdIxUYpw/bZwVp90d926U3x46clo+U7tfQV/XxYRJDvtgn1t6vZxpeRYht8U7+PbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDCoIIhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32254C4CEE4;
	Fri,  2 May 2025 23:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746229192;
	bh=mI6z4/QF8du898mizLTspqGXXCeNTjcwPzrEhjXInB4=;
	h=Subject:From:Date:To:From;
	b=ZDCoIIhxutRwc7SSm1tuNDMktSTr12vK8vnEoaJgqQBE/3GShrs29ZK0R0mocHfKU
	 qgPOdaewmTuh15eZSVVQnVmKDVB5XfQtYeCtWkmJKRkPmmz2L5nYljC0uK+eZGRsQa
	 AghR48iaPDHogmSbpX7X4gCZbQEefDbRpYoNZVRZqaUN1/NgZgOegsFGl36Jaf6W74
	 CGAy2Cv2lfHKQJob64WtJ4F+gRIlFcVCwhdYDCCPRBLZhQekMYxGfC0+zAFbLsihxm
	 vZ4TrGnXd7xSg4inWn0iBw4RKd2ejoR8jga2Hiiyvnbk7mJo8m26PrTboFsWaaXDVR
	 yqQBdfPyiTMbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74AF1380DBE9;
	Fri,  2 May 2025 23:40:32 +0000 (UTC)
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
 <174622923101.3758756.9693792243558251462.git-patchwork-summary@kernel.org>
Date: Fri, 02 May 2025 23:40:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: tegra114: Don't fail set_cs_timing when delays are zero
  Submitter: Aaron Kling <webgeek1234@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=956407
  Lore link: https://lore.kernel.org/r/20250423-spi-tegra114-v1-1-2d608bcc12f9@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



