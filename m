Return-Path: <linux-spi+bounces-2660-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C5D8B74A8
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 13:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4422820D0
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 11:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB49713D257;
	Tue, 30 Apr 2024 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="YVaScdHd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F033128816
	for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477314; cv=none; b=R9P9sBcfsiaw6mWt5lhj95V8IqkHnydP/UhG+PrK/aO/hwssD0HQ9sUzq67bxghWTH+1qmO5kbjNL5U746AIyY/8uDdnrTWgI16ewnj6ERxdfK5IXmeCf+/pO5fQNZtjMjVtmKpSbybeFLjk8kV5e2p3ZJiSxm/fVoKi21QnV7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477314; c=relaxed/simple;
	bh=buuRF42DJssebm7HzkIfm5mRwFuurTcBlXSr2N2zCB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VHRt6Edg4KOz6JNxSHNp/U5OZOP2jhtV0VLUINb2Wwii/dl2kQAGWNyF8eERpyqiVofm4J/0wQB1syJp5qzCUwiRDa8oO2SFoHWJb6gYdPl6An1VIjaRAVgh2QNmNRykrlG0anlpwCrnzOAYGNVzetlsyw5iKEwCVbeOrmxbB9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=YVaScdHd; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=kPt/8jXnSYDJet
	xC6X9ogQ5fhnFm9dtkiEVM3GdRJns=; b=YVaScdHdY4NjORBPNe4rjE3++GOIgS
	mp3Xp40IjXOJL79qL/N5AuU9Kuw/D7jU7bTQlh92OMpduNDuJmGpfMy0F1G3hmPy
	ItucPd/CXExTI3q97YTlNii0io20qNExkKqc7vGJgcwhkOmpusUZ7HohfE1yEKXZ
	7nHdANP5rHWiEZupg3j8cWwPY8CAGgREcLwZcjE16z7WrBdYZfTUNyOaDGTFc2Ju
	F331rzsBI5SLvh5CZCWqzg3sNGhfysNDIXxkPttln6oqKMckPnNeSVVOQYwtY0VE
	utfvK3wLlflit7svPcNnW0jr+9XbqAZyVq6aQAxnMGDWj2zAkROVvheA==
Received: (qmail 2617714 invoked from network); 30 Apr 2024 13:41:43 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Apr 2024 13:41:43 +0200
X-UD-Smtp-Session: l3s3148p1@99ih2k4XpOhehhrb
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Chen-Yu Tsai <wens@csie.org>,
	imx@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 0/8] spi: use 'time_left' instead of 'timeout' with wait_for_*() functions
Date: Tue, 30 Apr 2024 13:41:32 +0200
Message-ID: <20240430114142.28551-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_*() functions causing patterns like:

        timeout = wait_for_completion_timeout(...)
        if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
obvious and self explaining.

This is part of a tree-wide series. The rest of the patches can be found here
(some parts may still be WIP):

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/time_left

Because these patches are generated, I audit them before sending. This is why I
will send series step by step. Build bot is happy with these patches, though.
No functional changes intended.

Changes since v1:
* tags added (thanks!)
* white space issue in sun6i driver fixed
* add maintainers to coverletter

Wolfram Sang (8):
  spi: armada-3700: use 'time_left' variable with
    wait_for_completion_timeout()
  spi: fsl-lpspi: use 'time_left' variable with
    wait_for_completion_timeout()
  spi: imx: use 'time_left' variable with wait_for_completion_timeout()
  spi: pic32-sqi: use 'time_left' variable with
    wait_for_completion_timeout()
  spi: pic32: use 'time_left' variable with
    wait_for_completion_timeout()
  spi: sun4i: use 'time_left' variable with
    wait_for_completion_timeout()
  spi: sun6i: use 'time_left' variable with
    wait_for_completion_timeout()
  spi: xlp: use 'time_left' variable with wait_for_completion_timeout()

 drivers/spi/spi-armada-3700.c |  8 ++++----
 drivers/spi/spi-fsl-lpspi.c   | 14 +++++++-------
 drivers/spi/spi-imx.c         | 20 ++++++++++----------
 drivers/spi/spi-pic32-sqi.c   |  6 +++---
 drivers/spi/spi-pic32.c       |  6 +++---
 drivers/spi/spi-sun4i.c       |  9 +++++----
 drivers/spi/spi-sun6i.c       | 17 +++++++++--------
 drivers/spi/spi-xlp.c         |  8 ++++----
 8 files changed, 45 insertions(+), 43 deletions(-)

-- 
2.43.0


