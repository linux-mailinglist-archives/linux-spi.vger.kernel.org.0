Return-Path: <linux-spi+bounces-6769-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A953CA314E2
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2025 20:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3181418858FA
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2025 19:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1FE24FC03;
	Tue, 11 Feb 2025 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="es46vdYI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669271E7640
	for <linux-spi@vger.kernel.org>; Tue, 11 Feb 2025 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301603; cv=none; b=quAMfCj5f7cmmgvAXKqDYkihj6BNfxxRyR9Mt+OPXH6k29ZtIVpcHUTBSYIsHfcfbsixN8WFzHP3t4kywFNQj+wWvDU5787ji890YHRCU6wUOr3n5qPQQBBoLKk2FJYO2/ebn8HEZItzm6Zx+/rprWDjEPSSyrq3K+8Ft+PmOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301603; c=relaxed/simple;
	bh=C8yi2FSTOkFDf+KCakk5znJhrom10L1s0rMGXZ7C9I8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Yf0m3rPNN/9od42BbY5dwMLAdwdMW9h3L9kORWUm24lpKu2b+uoNTRc8e2JrvhaIwZ6V4osGRULkvsE+i8SxWwBldQn8PKZMdeO1cOw4rH3Hy2xI+Aj9epGQP/tReITRr88lUPIGC6G0bO0bUNH/0HeIX2dqZ0oanWNBEFinXWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=es46vdYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D233FC4CEDD;
	Tue, 11 Feb 2025 19:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739301602;
	bh=C8yi2FSTOkFDf+KCakk5znJhrom10L1s0rMGXZ7C9I8=;
	h=Subject:From:Date:To:From;
	b=es46vdYIdugWVn4cdVVgcAXU4xG11eySobpRg0YKGGaReNxXgdmhii65f6ZLon0ei
	 5/jIEMgqwyKDfaWvksPjVg98kt1+eO9jGxEE2paix6B4OuN7TO/naXdfLsygMw+BYv
	 2Z9fcCUZ9z7ZCm5TRP3tdT1aRF8NtAManDZp6KW8F3/qcb0TZx9+2q3ju0GRjZJrWt
	 Zmik5apPan8cbgoGRWnV0ji64IzNn9lxckrEyCRMLCwU+aTYz3JzQE+bSh8aW2H360
	 dm66T0SVw9lityP+gjsGJUrDlTfh9wjg4TsX4l5R1qD+rg1UQx0muF+io4ogSjRDxH
	 ASul3J4lA3hxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B3B49380AA7A;
	Tue, 11 Feb 2025 19:20:32 +0000 (UTC)
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
 <173930163111.4158981.14338067556601154663.git-patchwork-summary@kernel.org>
Date: Tue, 11 Feb 2025 19:20:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: offload: extra headers
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=932606
  Lore link: https://lore.kernel.org/r/20250210-spi-offload-extra-headers-v1-0-0f3356362254@baylibre.com
    Patches: [1/2] spi: offload: types: include linux/bits.h
             [2/2] spi: spi-offload-trigger-pwm: add extra headers


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



