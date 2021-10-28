Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8479E43E0DC
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 14:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhJ1M0b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 08:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhJ1M0b (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 Oct 2021 08:26:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 031DD610C8;
        Thu, 28 Oct 2021 12:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635423844;
        bh=FhsU/JUmjM3yQSaI1P6ZyROxrwHmJWAWlY7zoKGNVdM=;
        h=From:To:Cc:Subject:Date:From;
        b=MCDP17rEWu69wuqgoV/MeWPuFeRsu7yM5CCSspO5ekm1+x18CfQ8ALE4/3W0DUJn5
         JV63dFwziZouKaPdktNYUnZQK+C/4EHmX/FUJHXq2dlTpunamZacqfkwHRr8zmvlQi
         cSDmuMrfgmJ7mfcySTgOOkSenWsMk/FFuiZI0cU768un21KuFZYjHBIXiYhy4JUTbs
         hQVEMD0+w1rcWXCcl8cqu8+x9g5Yzxm4IKcEKpVXuBP4D8I63S98MLU9o8R7wsyb7d
         vB9jqiB1NdOCxDCHRjl86cHkevkJHDgJepZaMkzvRUsz1wXGgmcBN71VMlYkbJeZCT
         KcKR6bTmFhO1g==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.15-rc7
Date:   Thu, 28 Oct 2021 13:23:47 +0100
Message-Id: <20211028122404.031DD610C8@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 16a8e2fbb2d49111004efc1c7342e083eafabeb0:

  spi-mux: Fix false-positive lockdep splats (2021-10-14 13:32:19 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.15-rc7

for you to fetch changes up to d81d0e41ed5fe7229a2c9a29d13bad288c7cf2d2:

  spi: spl022: fix Microwire full duplex mode (2021-10-26 11:53:57 +0100)

----------------------------------------------------------------
spi: Fixes for v5.15

A couple of final driver specific fixes for v5.15, one fixing potential
ID collisions between two instances of the Altera driver and one making
Microwire full duplex mode actually work on pl022.

----------------------------------------------------------------
Russ Weight (1):
      spi: altera: Change to dynamic allocation of spi id

Thomas Perrot (1):
      spi: spl022: fix Microwire full duplex mode

 drivers/spi/spi-altera-dfl.c      | 2 +-
 drivers/spi/spi-altera-platform.c | 2 +-
 drivers/spi/spi-pl022.c           | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)
