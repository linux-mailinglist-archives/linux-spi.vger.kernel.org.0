Return-Path: <linux-spi+bounces-8377-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08157AD0437
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jun 2025 16:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB56617A315
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jun 2025 14:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3823155326;
	Fri,  6 Jun 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLSoODYy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C987C154C15;
	Fri,  6 Jun 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749221157; cv=none; b=XrNwtcBOE9IVyXl9MxXoa9JsLYkpS6JON4ibvNluum7eAaabCSi6TIcptGLgJq6E4hNlNe5piQp7Do4zGBzhlPncMUbaZLubED+5FVOMZn2FBOlBH9NuSvIuX1AX0ET90ySp4oSXq0S/Ozst8axBFQ/ThJdDpNbsrNUSeq8GYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749221157; c=relaxed/simple;
	bh=Txq8jZISiD417d1zn4QS/b/3RuXK6f39JxVjGQCMMzw=;
	h=Message-ID:From:To:Cc:Subject:Date; b=d0IsVljV4HrD0l6SLGt99hkn5jQw0PVSHNMTW9Nbxj4pT6wM963gzwKzibtAwIUVf3TovKCACLm/yWJ+8MtrxcLny98X3Xei54mIbYSvu/B+Nxf/cB9qazCL2WwLFSWsTR40mmYGbiBgIezsLKHW0RoKKhQrgvHtFvNZV2dnTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLSoODYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA19C4CEEB;
	Fri,  6 Jun 2025 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749221157;
	bh=Txq8jZISiD417d1zn4QS/b/3RuXK6f39JxVjGQCMMzw=;
	h=From:To:Cc:Subject:Date:From;
	b=lLSoODYyUWOjbIT/MJaSXDFdj/X8T2IQeyfUj4kuXvC+xGkqxyGtRn3xejGQu3Yob
	 WgJxnL89yynfl0UKQRZCplV1GVDKR72WAMWjPBiH3orZQJtLTORpuUDvg7DCx8+D43
	 xozmngCgTPGWKxosO4YI+kkokSw2HhwfldfNQZAeL4d4Xa7tuEeVB8wRoFpkgDUyZN
	 2ZeOtuBXRhR2eS8OVSyElmPoh7TuhkmosGzckobKX3n79afmvqTslKcDIZGJe5RBfl
	 KBvNZBq5WHPPgon0gbVHfS9ObugpUElgvVyZ1KmefFdccsBUIpSm8xF/xkiMlTkP5h
	 oo4Gfn3txAyUQ==
Message-ID: <6cc76c26f4d4cca79b1f6fa9c7152f91.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.16-merge-window
Date: Fri, 06 Jun 2025 15:45:47 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit b00d6864a4c948529dc6ddd2df76bf175bf27c63:

  spi: spi-qpic-snand: extend bitmasks usage (2025-05-23 16:51:35 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.16-merge-window

for you to fetch changes up to 57cf46cd1fe351846e1b065ca9546eef66675ecd:

  spi: spi-qpic-snand: document the limited bit error reporting capability (2025-06-02 12:27:51 +0100)

----------------------------------------------------------------
spi: Updates for v6.16

A small set of updates that came in during the merge window, we've got:

 - Some small fixes for the Broadcom and spi-pci1xxxx drivers
 - A change to the QPIC SNAND driver to flag that the error correction
   features are less useful than people might be expecting.
 - A new device ID for the SOPHGO SG2042.
 - The addition of Yang Shen as a Huawei maintainer.

----------------------------------------------------------------
Gabor Juhos (1):
      spi: spi-qpic-snand: document the limited bit error reporting capability

Thangaraj Samynathan (1):
      spi: spi-pci1xxxx: Fix Probe failure with Dual SPI instance with INTx interrupts

Yang Shen (2):
      MAINTAINERS: Update HiSilicon SPI Controller driver maintainer
      MAINTAINERS: Update HiSilicon SFC driver maintainer

Zixian Zeng (1):
      spi: dt-bindings: spi-sg2044-nor: Add SOPHGO SG2042

Álvaro Fernández Rojas (2):
      spi: bcm63xx-spi: fix shared reset
      spi: bcm63xx-hsspi: fix shared reset

 .../devicetree/bindings/spi/spi-sg2044-nor.yaml    |  7 +++-
 MAINTAINERS                                        |  4 +-
 drivers/spi/spi-bcm63xx-hsspi.c                    |  2 +-
 drivers/spi/spi-bcm63xx.c                          |  2 +-
 drivers/spi/spi-pci1xxxx.c                         | 48 +++++++++++++++-------
 drivers/spi/spi-qpic-snand.c                       | 14 +++++++
 6 files changed, 58 insertions(+), 19 deletions(-)

