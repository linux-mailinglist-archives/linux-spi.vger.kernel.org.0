Return-Path: <linux-spi+bounces-7576-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96955A88662
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 17:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D133B02A1
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 14:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1268E29A3D2;
	Mon, 14 Apr 2025 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6nqmboM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB40729A3CE
	for <linux-spi@vger.kernel.org>; Mon, 14 Apr 2025 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640994; cv=none; b=AQLTiCAXdxztvYqHcgWFLcQr9SwNaG0Trhj/sFxmTqVLyh5wJaTb1ykUy3zmYlonJJvA22NYqrSFyx6cANDPcgYCg1VIiv2RBwHi2mTPNGMlUSkqtc0ffbPD/w5EUbtB7gO6CXDCwu+iMT/P4ueyCje22dj0Oxfj4VmEGlWFxhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640994; c=relaxed/simple;
	bh=Lqxl19hAz8yuW3OqPJyhN+0GCHfchXHv9+84kHkotk0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YapODE1MA/aBQq/o5b0+6elprI+QVCH48Ghw/931GVK5LEGbWmmfIlS1oKrMIaCMG8ce7pvCHBQbxHUsyW4uuPfEfsX6OO2YAR0OrPn62lwcenf2oXSFOx6aQyMyUcY/IR1L3qtKtIDVnrzfUF71Di2AINxmBdzwoDHcz9FhG6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6nqmboM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B99AC4CEE2;
	Mon, 14 Apr 2025 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744640994;
	bh=Lqxl19hAz8yuW3OqPJyhN+0GCHfchXHv9+84kHkotk0=;
	h=Subject:From:Date:To:From;
	b=k6nqmboM5/y3fnEykOfxK5ejkqCQQZoZQhHq5iX+wKMIsGlLP9+ZHIX67Uv+d5M8T
	 zw+WWn1naW/s1XLdNXFxKd2HjkmBSk/HhpqdPLzQ+3t9l6A//d5RqMSzap8A6dJK5M
	 YwgRX46hbuUKAVU/SGGVXM9a/P6kq1wOW6+wpq7JqAWlqxW9GF2guP2Ip3ZGHQG+vL
	 taFlHKQE9SL6uFghkTI56pjeQNyArUjdtWee8IyEoCU7Z2zvbM1Ll2gvhC/f26AZff
	 DxpBdX2Rr9wXkqgyXrJ3Ci9O121lNd8wugfda4yjZwTipUGGvE5EAkB0PyMoPjnzRq
	 jeOsuXtrJt7cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3964D3822D1A;
	Mon, 14 Apr 2025 14:30:33 +0000 (UTC)
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
 <174464103170.1921794.15087325206089482540.git-patchwork-summary@kernel.org>
Date: Mon, 14 Apr 2025 14:30:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: sun4i: add support for GPIO chip select lines
  Submitter: Mans Rullgard <mans@mansr.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=952018
  Lore link: https://lore.kernel.org/r/20250410115303.5150-1-mans@mansr.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



