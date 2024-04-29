Return-Path: <linux-spi+bounces-2582-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAFE8B5691
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 13:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBC01C2121E
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 11:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A4345024;
	Mon, 29 Apr 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mFsf7TdV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A806A40878
	for <linux-spi@vger.kernel.org>; Mon, 29 Apr 2024 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390135; cv=none; b=oBc67DYiVMGIyhD0yPvpRXLHeyP6WeRjX9T0Ag7HpFXi7SdWSMvybE0GMGFQJSCFqNPESm9Ptn8SZYo3SO1ok4mjV+2G0j805gDnGKXShjZLpCC/ibVlC/inBruxll4fX7eZlvpBC6dtr1IQAyEUTQoxz4mKFXEaWbEWSHk84Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390135; c=relaxed/simple;
	bh=60QpStQOhAZIW9mb3S0HOBlCt88AByrWdkN0ZXP5wz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Frlek7Bg0rXHA6rbCDK1IQwl11Grp4fOhKmMKSzuKbUZ4KzAuRqME6IoVRIXcxRsD3vyRAlu3wJopDaK6U9L3b1WpxU3lIuLQ2mdSeBtfzkAmQWhZ1DnMSPdQZ0myFKD8sOBFV1uDDfr4IPYL1EkzYIAwE5f4uOtHgI+txnQub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mFsf7TdV; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=fAVKMqRoK3GEyb
	zsjMIQAuD5pNP2sMiRqK4blj9QPNs=; b=mFsf7TdVwL/397rbVrkXr2nBV8tMCW
	XHy9YScgS2ZQnBjtt3TOVqzHClpOGhxN7qMbIZThDZKEib3yuxqbiXJQ/RVQOXhi
	XVq61D9hQBt9dSB8QxIxvI9PENpSZqPTazwt6LYp2ADbtXc5hvCP0CnmexUQ8Aw5
	yB5auSBygdg8jQfpPFdkzf3QvCFon727ZkRfED6dggWW0NiKQquqVJXObAfixcxg
	gz3L0ZILg/RiGoDHPTO71G7W1Tc8BXMAhs+XBl/Y4VQ9Pr/IBC9bvop6Zw4zn5Ia
	9wKlUKh+HFHuI1/d6IqP6AGauU2movDEBKcWjjXKkFi8KuD3M+ORlGyg==
Received: (qmail 2279485 invoked from network); 29 Apr 2024 13:28:43 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:28:43 +0200
X-UD-Smtp-Session: l3s3148p1@KkJPjjoXgAptKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 0/8] spi: use 'time_left' instead of 'timeout' with wait_for_*() functions
Date: Mon, 29 Apr 2024 13:28:33 +0200
Message-ID: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
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


