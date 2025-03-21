Return-Path: <linux-spi+bounces-7274-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C99EA6BD44
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 15:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7385E1891A71
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 14:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB51A1D9A5F;
	Fri, 21 Mar 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kz673sOF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26201D9A49;
	Fri, 21 Mar 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567960; cv=none; b=WNFCT55BaVIaATEikzKw3LVPCpsOXUvXXovKe6gY5bJmIwIikDVAVhfaajhnk8wV1msdmIDUXs9lFuuSa+GwPLNnUSaFLi0KgqhDvBEbNt93Qx1E4P1lumk9GhdLcyeUn3OULdsHQI9tMcV/NS8iP3g8wJ7FoQyr7Xm+jLDgH24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567960; c=relaxed/simple;
	bh=OzByUk6wcpOVnzKDjHdKCDH8vJtiuPw6fD6qEWqMJXc=;
	h=Message-ID:From:To:Cc:Subject:Date; b=d1GTqU16qYJM7Ojmm/4fl000miQvyuvdAD5hWJJ6+lLXYMEQfncJqf/WK6wbOAL0dzcw9t1Tcbszy9kLXlvpKNuU7gSYtG0+BORz1rYXLk9NtzA8UmrDZl7mqfi05tz6+lAb0vLvkA+iuRS5nhS+zOVMjM7Ia0OWtj/pL9rQqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kz673sOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3B0C4CEE3;
	Fri, 21 Mar 2025 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742567960;
	bh=OzByUk6wcpOVnzKDjHdKCDH8vJtiuPw6fD6qEWqMJXc=;
	h=From:To:Cc:Subject:Date:From;
	b=kz673sOFyDIw/iG+hs3LQqKaWIhpxDRzaqxp+NHjHR0KiH3SFlK7H+5v7sGMLLfKt
	 PJiQsSt068JjW1iSwBzOOGeNKGoD5mOF2yLihan8TcyxFYrwQN5z+QQLu2+K6/JGQY
	 8BfNekhf1UP/PlFOI1h5kgYm1NeM7EXNXHK2rkUeNGzm8PQm+ElyVzOctC8pTUAdtL
	 YryQLY5E8yd+ISfr7YSVs324/7ymYZM4RBwulEohyZQnLRCIBD3+HuZ79hWGoZcxqz
	 Bsiv5X05U4nNd6VVqMlT6aEIlkxEAtS/dfZOhxLyHHb0Xlswa+m80eZoCrg/rehe36
	 tC8cKKvqolZUw==
Message-ID: <a63096e1e044f828a77f611d7ef76140.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.14-rc7
Date: Fri, 21 Mar 2025 14:39:10 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 4701f33a10702d5fc577c32434eb62adde0a1ae1:

  Linux 6.14-rc7 (2025-03-16 12:55:17 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.14-rc7

for you to fetch changes up to 176fda56d72a267731f82aa4a3aeca430394f10e:

  spi: Fix reference count leak in slave_show() (2025-03-19 12:47:50 +0000)

----------------------------------------------------------------
spi: Fix for v6.14

This is a straightforward fix for a reference count leak in the rarely
used SPI device mode functionality.

----------------------------------------------------------------
Miaoqian Lin (1):
      spi: Fix reference count leak in slave_show()

 drivers/spi/spi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

