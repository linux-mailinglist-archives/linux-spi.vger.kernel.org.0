Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE1E2A83D5
	for <lists+linux-spi@lfdr.de>; Thu,  5 Nov 2020 17:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgKEQqL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Nov 2020 11:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:48874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731591AbgKEQqI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Nov 2020 11:46:08 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD20021734;
        Thu,  5 Nov 2020 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604594768;
        bh=wtWcZImzIvis+6s4aqj2PVanmzHYRehKf1m1UvMPp/c=;
        h=From:To:Cc:Subject:Date:From;
        b=I5gqClIjo+ksRu2iDogMyo4TCPk+CjZLCSdtasb7QVCNo5BPFCOaALgRktqsAuIY9
         +ynSfOyti7fKDM2sEoiIR6iZoC/4++dFtf0gl+w2lFlmBn9JcsZTzrCZB+wQTLSrVa
         9AUzihQdOx0A0mqMxwt0La0oCtSWfzBRLODRuBDU=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.10-rc2
Date:   Thu, 05 Nov 2020 16:45:46 +0000
Message-Id: <20201105164607.AD20021734@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.10-rc2

for you to fetch changes up to 9bd77a9ce31dd242fece27219d14fbee5068dd85:

  spi: fsl-dspi: fix wrong pointer in suspend/resume (2020-11-04 17:50:24 +0000)

----------------------------------------------------------------
spi: Fixes for v5.10

A small collection of driver specific fixes that have come in since the
merge window, nothing too major here but all good to ahve.

----------------------------------------------------------------
Mark Brown (1):
      Merge tag 'v5.10-rc1' into spi-5.10

Martin Hundebøll (1):
      spi: bcm2835: fix gpio cs level inversion

Sascha Hauer (1):
      spi: imx: fix runtime pm support for !CONFIG_PM

Zhao Qiang (1):
      spi: fsl-dspi: fix wrong pointer in suspend/resume

 drivers/spi/spi-bcm2835.c  | 12 ------------
 drivers/spi/spi-fsl-dspi.c | 10 ++++------
 drivers/spi/spi-imx.c      | 23 +++++++++++++++--------
 3 files changed, 19 insertions(+), 26 deletions(-)
