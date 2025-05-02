Return-Path: <linux-spi+bounces-7860-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 471A1AA7CAF
	for <lists+linux-spi@lfdr.de>; Sat,  3 May 2025 01:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153A11C03821
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 23:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BA4223DD6;
	Fri,  2 May 2025 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi+hot0o"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEEA2222D4;
	Fri,  2 May 2025 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228609; cv=none; b=PSBOAMcPgIrvPka4ljKDus+SLkG/pJ/IlXT1QdJSIexJ4OYrW/J62eVP1aedjTyF7jy+ryjJhV0Bu13ZX+SrtNuvtqgH7nhI8zA03DRiNfyRJXjBkFU1+Vgo4MxH54eQ4EdGGjq3uCCX0bbsIwkC07jNjyzE3zRmtQUVaNCn/qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228609; c=relaxed/simple;
	bh=1AGj47Z6CFUGr1ZKftxRaGHbVy7hunbrlknVuuKnBjY=;
	h=Message-ID:From:To:Cc:Subject:Date; b=QJtIG8Lhqe2vyj41oyWvj27MaTbF9dRV8lt3Km/D0r7dADr8H0FOe42jYSZegeYglw1pYHUWNd1TxI+/p+nYQqyDmWPt2ACnz+vJcExRRwSZZNyuKN7OGujk04JJRR/oQHl786Qrexu2tx8NMno/jVo680B2iEWE5e3LmiW+FCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hi+hot0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D61C4CEE4;
	Fri,  2 May 2025 23:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746228609;
	bh=1AGj47Z6CFUGr1ZKftxRaGHbVy7hunbrlknVuuKnBjY=;
	h=From:To:Cc:Subject:Date:From;
	b=Hi+hot0oEzvOqZrJPfOGk7a0qTDY2eB1Kd3TDILAwFEUC07EeGHzjSgc7IPuBoZ5W
	 /hROR3J8DsKq7P3oqrRfnJoz1E34AzXjM8kJSK3NiEm2VzLvYhcOrD/MaeN/eauiMn
	 6TwJf5Aql+V/x0nponViuOqAUUH4UdeaYmk7XR10KMvDxYjCfRpylbA2/nTy6QVwu5
	 4pPmuD1vQ7e7LIiNxyTrd3DNWJr3oHdlE9wYfpDiyC+5QPDDwifmbzfNwtTYFti42M
	 3q9MHPLl7GRvSPLJMli7mITJlJvYee8XFbF+Q2ETiAiGhcmaQMoVa8ExM4rwFusoso
	 shVrhc2ZtsYAQ==
Message-ID: <9751094822c3f97d71b3f100baf655a3.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.15-rc4
Date: Sat, 03 May 2025 08:29:59 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 8ffd015db85fea3e15a77027fda6c02ced4d2444:

  Linux 6.15-rc2 (2025-04-13 11:54:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-rc4

for you to fetch changes up to 4426e6b4ecf632bb75d973051e1179b8bfac2320:

  spi: tegra114: Don't fail set_cs_timing when delays are zero (2025-05-02 05:38:27 +0900)

----------------------------------------------------------------
spi: Fixes for v6.15

A fairly small pile of fixes, plus one new compatible string addition to
the Synopsis driver for a new platform.  The most notable thing is the
fix for divide by zeros in spi-mem if an operation has no dummy bytes.

----------------------------------------------------------------
Aaron Kling (1):
      spi: tegra114: Don't fail set_cs_timing when delays are zero

Christophe JAILLET (1):
      spi: stm32-ospi: Fix an error handling path in stm32_ospi_probe()

Gabor Juhos (2):
      spi: spi-qpic-snand: propagate errors from qcom_spi_block_erase()
      spi: spi-qpic-snand: fix NAND_READ_LOCATION_2 register handling

Mark Brown (1):
      Add basic SPI support for SOPHGO SG2042 SoC

Raju Rangoju (1):
      spi: spi-mem: Add fix to avoid divide error

Zixian Zeng (2):
      spi: dt-bindings: snps,dw-apb-ssi: Merge duplicate compatible entry
      spi: dt-bindings: snps,dw-apb-ssi: Add compatible for SOPHGO SG2042 SoC

 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml      | 19 +++++++------------
 drivers/spi/spi-mem.c                                 |  6 +++++-
 drivers/spi/spi-qpic-snand.c                          |  5 ++---
 drivers/spi/spi-stm32-ospi.c                          |  4 ++++
 drivers/spi/spi-tegra114.c                            |  6 +++---
 5 files changed, 21 insertions(+), 19 deletions(-)

