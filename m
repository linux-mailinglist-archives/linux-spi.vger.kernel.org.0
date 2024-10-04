Return-Path: <linux-spi+bounces-5107-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E549911EE
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2024 23:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B380A1F23E6C
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2024 21:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECAF1474B9;
	Fri,  4 Oct 2024 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sollMiRt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F44231CA7;
	Fri,  4 Oct 2024 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079119; cv=none; b=GbnBP5QGb2U+cKyLUcD54QzclrL+bJ5qt6an+Q9y4OA7u1c6I5getmy9bGeN/CLv74XPbNfK6MFPk272T1bstQP4tjamH78Z6vSjVb05sCC+5HP974S8cw/e9twwy30q2O15t1ZGaoRVTzR7oTGjc8qQrp/+wXZM4YhDyEO7Tcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079119; c=relaxed/simple;
	bh=NWJ2ejRwVxbuD9Q92StrJcn2VdD1Fw1ly1MZiLiQyf4=;
	h=Message-ID:From:To:Cc:Subject:Date; b=OL9AnkYjttvE5w01JCwJuCUB0nGTOUKeQ2FkTUHDaK19Mq6Czn5gR2pHf1vqlLs/33la3CoO8ROAB0fX7/JK0Tsq0eccupEnwKVogZjUPyiHgShBrHWkCC3yYeM+uHaT7evIdDbh20EmomPRqING4KmIvGspdDVqXnH4tA1+i7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sollMiRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42774C4CECC;
	Fri,  4 Oct 2024 21:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728079118;
	bh=NWJ2ejRwVxbuD9Q92StrJcn2VdD1Fw1ly1MZiLiQyf4=;
	h=From:To:Cc:Subject:Date:From;
	b=sollMiRt0XJKe/6kc1MzoGKYy86jrW8iUS9YSBUIKzbHBtjwsss/9TiC7YY9IRD7s
	 /Vu7YRQfHJi85F2SX9Wq7dXRbqnNgMCmgOCWMvHQ+9g5xRmSvd+nc5IaCZNSkf24iL
	 cYppvM5eB3SoyuNqwfe2gr6pKNSZqcmzHugMaKkk5URNBJFWWwsfP1Hsghl4TbDzvR
	 mFxtPcr4GmFhix5XYBiNGEaqGu+uwzRIAfYjB4QB6w1wnsXBpac0Yn6oWybHDQ45IX
	 GlNJvUMb3RHYLOdfo+l9fUxgOO+rV2RrzE9qTnoh4IAOP14AUMU5Lfur7TyJWWVqus
	 Cz4nS9QhXnY9A==
Message-ID: <bb073282a3cbc0a5349db87260957934.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.12-rc1
Date: Fri, 04 Oct 2024 22:58:22 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.12-rc1

for you to fetch changes up to 65fbec3121eb7a10a839784496357f5a833af69b:

  spi: Fix pm_runtime_set_suspended() with runtime pm (2024-10-02 00:24:48 +0100)

----------------------------------------------------------------
spi: Fixes for v6.12

A small set of driver specific fixes that came in since the merge
window, about half of which is fixes for correctness in the use of the
runtime PM APIs done as part of a broader cleanup.

----------------------------------------------------------------
Alexander Dahl (1):
      spi: atmel-quadspi: Fix wrong register value written to MR

Ben Dooks (1):
      spi: s3c64xx: fix timeout counters in flush_fifo

Jinjie Ruan (3):
      spi: spi-imx: Fix pm_runtime_set_suspended() with runtime pm enabled
      spi: spi-cadence: Fix pm_runtime_set_suspended() with runtime pm enabled
      spi: spi-cadence: Fix missing spi_controller_is_target() check

Mark Brown (1):
      spi: Fix pm_runtime_set_suspended() with runtime pm

 drivers/spi/atmel-quadspi.c | 2 +-
 drivers/spi/spi-cadence.c   | 8 +++++---
 drivers/spi/spi-imx.c       | 2 +-
 drivers/spi/spi-s3c64xx.c   | 4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

