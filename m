Return-Path: <linux-spi+bounces-4809-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69BA9787E8
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 20:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CDB5281352
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 18:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAD47B3FE;
	Fri, 13 Sep 2024 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILbKFi3x"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D865A2940B;
	Fri, 13 Sep 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252231; cv=none; b=D1PBulVMhxAvUvDgw2rRnFO6MInXb6T6VESfnFZTGW/sqEcdBzo2RCf0HI00n3U4NR66qOTF9+iK6I55TRKfAVRu+GQ/Jm3PmlHR6XMn/nUnR3ILNjadZMqFX+/vQjtfc9uB4SREYM1PDKDxNyCjZskrF9+oRIR3empJwduMT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252231; c=relaxed/simple;
	bh=lC+yCqmaayxHFv+ELfhQ9BthPr0FYGzcmXF+orwqZNc=;
	h=Message-ID:From:To:Cc:Subject:Date; b=c8GlP5KrcAcbgGbX/F3K4WZtJJBrTN4IQhIHjmK4Ipo1OHCHdM1dJ6sUQEQUlSTM694VnpVX39tXRvAjX3pkcMwYlz/yUZEqTzgToYl8dsR+9FufCq4xf1gnEFLqnT/IDqgBe1B150J3Baak+fIzhY4bh/j9E0wjL9vnN5hmaco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILbKFi3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82205C4CEC0;
	Fri, 13 Sep 2024 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726252231;
	bh=lC+yCqmaayxHFv+ELfhQ9BthPr0FYGzcmXF+orwqZNc=;
	h=From:To:Cc:Subject:Date:From;
	b=ILbKFi3xDCW2yd5b6yNLrOQ0twRXp0FowLAvxej147U8swOblKHVzV81Pm/21rCmU
	 qAjDQGQ9QuYPBfajopMJTq1mLRw091KuIk5BZT5byCVhQFxRGVYqgXKyCKciTdEq5A
	 z/MAkZ7DJKn8mXk/BWNeOkbpQCZoc8xAe9jcJ50JNLWhXkrouhIMJugbsS/PyYWpqh
	 iXgsJFqtHw3Gl5Y54zznhm2BBVe03kGhY/XBBOahnRm0UMIse2XQ6FCeMjGz682Y34
	 LpdR4kx86lHQsZm6+rYIewqj4MeJmiuyQTMoa7aMu+rjquqR0CVMCPrBUMkFtCvLGq
	 UnUIX8JQhD9MA==
Message-ID: <ba736f747a1d58f7043b187c2d1dd97d.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.11-rc7
Date: Fri, 13 Sep 2024 19:30:19 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit c9ca76e8239810ccb08825a7b847c39d367410a6:

  MAINTAINERS: SPI: Add mailing list imx@lists.linux.dev for nxp spi drivers (2024-09-05 19:15:45 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.11-rc7

for you to fetch changes up to 2a8787c1cdc7be24fdd8953ecd1a8743a1006235:

  spi: nxp-fspi: fix the KASAN report out-of-bounds bug (2024-09-11 22:25:44 +0100)

----------------------------------------------------------------
spi: Fixes for v6.11

A few last minute fixes for v6.11, they're all individually unremarkable
and only last minute due to when they came in.

----------------------------------------------------------------
Han Xu (1):
      spi: nxp-fspi: fix the KASAN report out-of-bounds bug

Jinjie Ruan (2):
      spi: geni-qcom: Undo runtime PM changes at driver exit time
      spi: geni-qcom: Fix incorrect free_irq() sequence

 drivers/spi/spi-geni-qcom.c | 17 ++++++++---------
 drivers/spi/spi-nxp-fspi.c  |  5 +++--
 2 files changed, 11 insertions(+), 11 deletions(-)

