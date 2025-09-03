Return-Path: <linux-spi+bounces-9883-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5CFB42640
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 18:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FFB77B22B3
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669832BD01E;
	Wed,  3 Sep 2025 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+04AX90"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427A42BD015
	for <linux-spi@vger.kernel.org>; Wed,  3 Sep 2025 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915800; cv=none; b=GR74uLTS6Mf1jCqmpnlJKOuWzE/04azEOxmzFMeU0n2qpuEot8quXU73lbYbzem1A2qK6ZXGvKrHseUwLRStY+g9UZFbUDESG4SCO1Svyl1g14BMh44BWNa5/kqLnICaep5rWk4auYjhmHEAbNuoAssrgxBPIKsTore2bAEUuQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915800; c=relaxed/simple;
	bh=yIV1DlVi8V+1Ru/GARk9mM0PouAQDUZQvEeU0WdoqQo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=I3J+Ul/bHlSKbN6WVPzlRCiPw3HnkH7tGulX48BUV0la7x+oA4+LhRpDWDm9zEbHgdAVTsYxZQSFWE1mpeKhGk6GZNfnxL4GXdfhIoSBnILw+KVRNgS4G41yRtnh0p7e7DF6pLOZBUDWYQgkj+u5+u5LcVjd3VtVp3WQNkRzewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+04AX90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C552FC4CEE7;
	Wed,  3 Sep 2025 16:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756915799;
	bh=yIV1DlVi8V+1Ru/GARk9mM0PouAQDUZQvEeU0WdoqQo=;
	h=Subject:From:Date:To:From;
	b=f+04AX90khKHMnl6Wi7VL3AKhapd7WcDogW8OYXCd0u4IK3Sb9s0gmaawkIrY6nNV
	 eIw6j5DWYAn2VN85MbxQ0QLB7oLHxbdcfe9ecMuOC4/77t2msM9P1KW9o1YEVC1WdF
	 yP9FReadFPKUvJnNGsaYZRBav1AcR+LiLcHMRGvIsKL013roXKTR1YlXkbT/aFvkTe
	 9WYci4jSw7k4E34o63GLqJXmqgrh0wC0obS2pgddxIzUYSqoiT511lfee3JUH87Z7J
	 E+2ym/xNZGeWEAvjY8luRND4r7aFjcaNC4V7Kk5UY9Ul5OsW4ZaTjQbwkHX1FZfOTS
	 O8exsZruO0D3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EFA5E383C259;
	Wed,  3 Sep 2025 16:10:05 +0000 (UTC)
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
 <175691580447.1123812.6650229275995054325.git-patchwork-summary@kernel.org>
Date: Wed, 03 Sep 2025 16:10:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: mxs: fix "transfered"->"transferred"
  Submitter: Xichao Zhao <zhao.xichao@vivo.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=998212
  Lore link: https://lore.kernel.org/r/20250903020347.563003-1-zhao.xichao@vivo.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



