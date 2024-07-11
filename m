Return-Path: <linux-spi+bounces-3833-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6936B92EB08
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jul 2024 16:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED18282EA0
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jul 2024 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA09D12C489;
	Thu, 11 Jul 2024 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXSO7ohj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE32F46;
	Thu, 11 Jul 2024 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720709242; cv=none; b=hssKqlEMig7O6XjVIOXY5S4H/mx4I2rfcv0TBAI1ynB9p0pKUOACYkSpnFKhxn1WQEtz06dFZ5mt6nhMeFK5cl4UqxabLphNd8VNFUAYaZUywROSg789bV41W9gB6AadfhL72P6la2jgPbycptuzoi3OvLPBWFodXfOeUBJqwww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720709242; c=relaxed/simple;
	bh=hM5QweryAJkWIpPmNGoqk5/juhbNP9xVhAPxnCDBzIM=;
	h=Message-ID:From:To:Cc:Subject:Date; b=GOWxdZ0qrQdVclrnXpaZrpRHsdeJlgtN+alqKq8uB9fjJyMwz3b6WaEiD9iu7TcJ4nSBDiI1MVIsJwxUcCLWwj9upKjCId0pXy3AjX3R7NiDrI6wNhoZI/7uh7oMp4xG4nq8uRsfixuhvzHfz28uREhsgwbiutLjAOfDvhuFN9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXSO7ohj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF05C116B1;
	Thu, 11 Jul 2024 14:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720709242;
	bh=hM5QweryAJkWIpPmNGoqk5/juhbNP9xVhAPxnCDBzIM=;
	h=From:To:Cc:Subject:Date:From;
	b=nXSO7ohj4s1KEm+feokGgsBkZgIDF6Z8ioFdhmbQoTVyDSXAgSJFKbXwNCT3Hxz7K
	 9nZk/Vq0/05iBSJ55/qzQJbiOC/b5pWUJY1XSmcb/WXPlOR3eqkt1fij4hZYG2uWWH
	 f4mzHR/kXJf7hEF72cVk5/wAAq9JDp42AixUxUsXpMYMZWPxmte/O2zGMOn3nej/Nb
	 45kdg2vBd+svc03mrWcR72LqUSrfZBOjZLeWWYG+YCZyaMSkaWobImPhkK+2rd4HLX
	 wGeKdeG9d4WC3zx20dBt+I4tPNkpIv8rpwssDk2D6njn0OU2IMC1lO2Wy9VFMNZW/2
	 T9h6TP1poyJAA==
Message-ID: <95eeaec80e22a55026b3aaa94d2a7ad6.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.10-rc7
Date: Thu, 11 Jul 2024 15:47:10 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.10-rc7

for you to fetch changes up to c8bd922d924bb4ab6c6c488310157d1a27996f31:

  spi: mux: set ctlr->bits_per_word_mask (2024-07-09 17:42:33 +0100)

----------------------------------------------------------------
spi: Fixes for v6.10

This pull request fixes two regressions that have been bubbling along
for a large part of this release.  One is a revert of the multi mode
support for the OMAP SPI controller, this introduced regressions on a
number of systems and while there has been progress on fixing those
we've not got something that works for everyone yet so let's just drop
the change for now.  The other is a series of fixes from David Lechner
for his recent message optimisation work, this interacted badly with
spi-mux which is altogether too clever with recursive use of the bus and
creates situations that hadn't been considered.

There are also a couple of small driver specific fixes, including one
more patch from David for sleep duration calculations in the AXI driver.

----------------------------------------------------------------
Bastien Curutchet (1):
      spi: davinci: Unset POWERDOWN bit when releasing resources

David Lechner (4):
      spi: axi-spi-engine: fix sleep calculation
      spi: don't unoptimize message in spi_async()
      spi: add defer_optimize_message controller flag
      spi: mux: set ctlr->bits_per_word_mask

Mark Brown (1):
      spi: omap2-mcspi: Revert multi mode support

Uwe Kleine-König (1):
      spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices

 drivers/spi/spi-axi-spi-engine.c | 26 ++++++++++++++++++--------
 drivers/spi/spi-davinci.c        |  6 ++++++
 drivers/spi/spi-imx.c            |  2 +-
 drivers/spi/spi-mux.c            |  2 ++
 drivers/spi/spi-omap2-mcspi.c    | 15 +--------------
 drivers/spi/spi.c                | 20 +++++++++++++++++---
 include/linux/spi/spi.h          |  4 ++++
 7 files changed, 49 insertions(+), 26 deletions(-)

