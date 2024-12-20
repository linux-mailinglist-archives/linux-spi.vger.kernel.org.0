Return-Path: <linux-spi+bounces-6128-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA059F928E
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 13:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090551893FEB
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 12:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC60215199;
	Fri, 20 Dec 2024 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwL7Vudg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5733D1BB6A0;
	Fri, 20 Dec 2024 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734699081; cv=none; b=PzMMfSbcoW5ay/nidrI3Kvfs0Mke0sbZFkUA7EgkzCIj+Xy4p2hJQJO1NUBDkK+MiGCrocPkcTFTQ6DsBhJz6OZImmsrJZpMNDs2Ucp/xgvsgFAiqbysdSETumjo4gFJg54pBDhqde8FYZeSXfwZWqZ0vu7eM5as9d56+FQ049s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734699081; c=relaxed/simple;
	bh=iNUieLeVqPIfattAHE6MY3dLDltvoFy2LAyrDyY0bG8=;
	h=Message-ID:From:To:Cc:Subject:Date; b=Wb43SLHNyGp4phVWMjh9eaFXnsjbHDcCccJBSdBYGoS5QwYKDaXtBxNseJq8m7CPFvg0py1RelVff92BExHehIxb9euVLhTCV1+48cBvkpv4UYQhrFsa8S1aPjhiaLXlRFxMGqj3NOZ4r3ssZm4bFB5f2u8NnCYM4PW2COv86yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwL7Vudg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EA6C4CECD;
	Fri, 20 Dec 2024 12:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734699080;
	bh=iNUieLeVqPIfattAHE6MY3dLDltvoFy2LAyrDyY0bG8=;
	h=From:To:Cc:Subject:Date:From;
	b=pwL7VudgfDvTdZ2s71B7wxk6aVXZEBB1L7gHIt42UccmlmqWMnR/PpMiy18EB17ZS
	 xI571q+RVwxwcsVtNPx2NzFqa3JHLdEOEcpHDuI8ay9b61QIaMs0yKkPvSlo1naZ07
	 tZ4jHtVnZpCc0sF0ANNzOaDv5i9b9eRhSNnT4pPcm1ps+gwFB2MapD5UzUezgN62Fm
	 yCgy9SU1WQ+YhJ603BXtaWPwWzhIYhvjeFkSqshYItaVhfovBJMuLB6fPw5tt0E2d2
	 hpJRnAFsCIcosHiGAf0X0BWzROopUWpa43WvUGZJf3OS3/sSTaj1luqliRcpnnFRZN
	 rrOLq4vqZvZGg==
Message-ID: <aa309cfa0ae84b6e6495dfb1ac91b953.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.13-rc3
Date: Fri, 20 Dec 2024 12:51:11 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8:

  Linux 6.13-rc3 (2024-12-15 15:58:23 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.13-rc3

for you to fetch changes up to 7f9a1eed1ad8b274ed9163a02cef891a90427237:

  spi: rockchip-sfc: Fix error in remove progress (2024-12-18 16:02:08 +0000)

----------------------------------------------------------------
spi: Fix for v6.13

A fix for the remove path of the Rockchip driver, the code was just
clearly and obviously wrong.

----------------------------------------------------------------
Jon Lin (1):
      spi: rockchip-sfc: Fix error in remove progress

 drivers/spi/spi-rockchip-sfc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

