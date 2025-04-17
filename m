Return-Path: <linux-spi+bounces-7649-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 499B4A92B7F
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 21:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9870E16D9A1
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 19:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1424189902;
	Thu, 17 Apr 2025 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxEftnz2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BFC1D6AA;
	Thu, 17 Apr 2025 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916927; cv=none; b=tWR+WKcuXQ46WYjcUHB4zrgi/N0xO2LVQVtFZQNm0PZ/2VissV9wTTgMwLiyBsq89t1676ip/4CnaN55VuZYGCWJanG7yAkIKzZ1Ky65GwfM/9Jmigc3e3NLlWEdeAfDSIiyjp2MQgoU94kaMXhygyT9sc+Cx3OOWHxhrvLKEfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916927; c=relaxed/simple;
	bh=pTz0A13GV9IAZv13xMwTkwVBhBOD1CeNPXi3q//p8FI=;
	h=Message-ID:From:To:Cc:Subject:Date; b=doMaMypxc36w2MtJEK2B8GiNl8EPkFq13qsLPqKqb8zV8jeCTeMU8M2ltq9SvID1MAN3F3iM+09ORHAaG9r7JFVXqE82IhOXOoguYye0LOxaF/OBBvRJJF/Mh8hPGACWuAiUHm/QiVse6oN7cvnxF68OD0LiwFN+sEOOVs+bNSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxEftnz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE34C4CEE4;
	Thu, 17 Apr 2025 19:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744916926;
	bh=pTz0A13GV9IAZv13xMwTkwVBhBOD1CeNPXi3q//p8FI=;
	h=From:To:Cc:Subject:Date:From;
	b=bxEftnz2rOJUGONa/XfGdESKQpt5Z3ZJvnyjxjtU2Mx7nYyt/jEgzaZQG3Qvdheps
	 aaf5uNGAhsvMK8unz/WVD972iTDLZ6bK5eeDBXwkA9S70ECcQiAJpCjesNnXldJkcN
	 x9plOlrs+ly/pCa6fxd5Ya/d3FwInVatmHId/Nxw8G+sseka6Rt+wphDalIizIsL3g
	 ApoAf/m0x9DYKETbT2E4xyPPoovRy7LLjJ3CXxSSU63YLVpl9wZ2kHWOHec7NpaUye
	 hgDzFWdp25iIClvtbuNjT4a8wOWlPzMXXdKRzR+el0MGI89EPXXJKE8Qerc1ZSj7vL
	 7EKbNopQeWliw==
Message-ID: <2391fa16200e50aa1a9379b791d0b7a3.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.15-rc2
Date: Thu, 17 Apr 2025 20:08:34 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 8ffd015db85fea3e15a77027fda6c02ced4d2444:

  Linux 6.15-rc2 (2025-04-13 11:54:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-rc2

for you to fetch changes up to 951a04ab3a2db4029debfa48d380ef834b93207e:

  spi: spi-imx: Add check for spi_imx_setupxfer() (2025-04-17 12:25:12 +0100)

----------------------------------------------------------------
spi: Fixes for v6.15

A few more device specific fixes plus one trivial quirk.  There's a
couple of patches for Tegra which avoid some fairly spectacular log spam
if the hardware breaks in ways which were actually seen in production,
plus a fix for the i.MX driver to propagate errors properly when setting
up the hardware.  We also have a trivial patch marking the sun4i driver
as being compatible with GPIO chip selects.

----------------------------------------------------------------
Breno Leitao (2):
      spi: tegra210-quad: use WARN_ON_ONCE instead of WARN_ON for timeouts
      spi: tegra210-quad: add rate limiting and simplify timeout error message

Mans Rullgard (1):
      spi: sun4i: add support for GPIO chip select lines

Tamura Dai (1):
      spi: spi-imx: Add check for spi_imx_setupxfer()

 drivers/spi/spi-imx.c           | 5 ++++-
 drivers/spi/spi-sun4i.c         | 1 +
 drivers/spi/spi-tegra210-quad.c | 6 +++---
 3 files changed, 8 insertions(+), 4 deletions(-)

