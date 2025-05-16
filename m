Return-Path: <linux-spi+bounces-8152-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B3EAB9B14
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 13:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DABF3B7318
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 11:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BC922E3F1;
	Fri, 16 May 2025 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cA5TQeWO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B981DFE8;
	Fri, 16 May 2025 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747395111; cv=none; b=kIKLNkDiNrfgAYtjWCdDTnmzSvp/FuTFPn7LYUScJ0efgbzPvQNJIYwsvQz4yKlWRj0lj8pq9UEopBgpi0/c+48EJaYec0JGazqq/a0mxhhPzZzl7NNdsYhBChYUmbEwOu9r2NQYlDWf/ND9+69VZJE6QoXP/wtdzg0HjeKgZqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747395111; c=relaxed/simple;
	bh=bhFQgFuU56x+TlAYS3ijnTHcX9Q2XNFi54Wmnexs0g0=;
	h=Message-ID:From:To:Cc:Subject:Date; b=pyg6IWB/BVLrYR7/in/Wa0zhlqjzyDx+VIzudt/8UpDlyB65KG9yCEmyx5YvgZbiLMwvnwRWZ5znCJU6etKnxOwBJUJlhNidz+JhQyDFyot5qmYBf/usToGWn6OgdIkLbwRL0YmhFuMCk8ct2mzhgIPqsYZHQpmtibFBuKyrkUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cA5TQeWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196A3C4CEE4;
	Fri, 16 May 2025 11:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747395110;
	bh=bhFQgFuU56x+TlAYS3ijnTHcX9Q2XNFi54Wmnexs0g0=;
	h=From:To:Cc:Subject:Date:From;
	b=cA5TQeWOJbHPeRXKe6JOoZnTeweIzMkIx07olpBF78ZGVj7qoPN4Kiw1hQbgdHFtB
	 8HcoTxxzEZ8QFixu1hXlDXpw8LaSHS9lhgX8T7hgDw6VreH4OiHTldi6yUyZP9cvx4
	 iFiaXPfa99yqQ61I0ekWBrlNLkVj6TVov8vQBYNISpemW9PYu3xlluaplKCa0it9Dn
	 by2gEbxoZio0mHjUmZ390yu0caWlZQ+lh2djb3nsRrNvE2oAmctqq6wG3iauOzg27s
	 awpc27nL3Xj5fdUEX19jkINm7VysK2jitAGfawqKajy+qWngOghiqVMAYbc2NsK5Jg
	 1g14llAvtOpWQ==
Message-ID: <8c0c7f276b6ea8988bd8b824603cbe99.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.15-rc6
Date: Fri, 16 May 2025 13:31:40 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 92a09c47464d040866cf2b4cd052bc60555185fb:

  Linux 6.15-rc5 (2025-05-04 13:55:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-rc6

for you to fetch changes up to fb98bd0a13de2c9d96cb5c00c81b5ca118ac9d71:

  spi: spi-sun4i: fix early activation (2025-05-14 10:56:43 +0200)

----------------------------------------------------------------
spi: Fixes for v6.15

A few small driver specific fixes, the most substantial one being the
Tegra one which fixes spurious errors with default delays for chip
select hold times.

----------------------------------------------------------------
Aaron Kling (1):
      spi: tegra114: Use value to check for invalid delays

Alessandro Grassi (1):
      spi: spi-sun4i: fix early activation

Geert Uytterhoeven (1):
      spi: loopback-test: Do not split 1024-byte hexdumps

 drivers/spi/spi-loopback-test.c | 2 +-
 drivers/spi/spi-sun4i.c         | 5 ++++-
 drivers/spi/spi-tegra114.c      | 6 +++---
 3 files changed, 8 insertions(+), 5 deletions(-)

