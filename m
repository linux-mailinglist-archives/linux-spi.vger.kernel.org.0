Return-Path: <linux-spi+bounces-3384-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5304905757
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 17:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704C71F26307
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEE11EB2A;
	Wed, 12 Jun 2024 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX7YQziI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DBFB65E;
	Wed, 12 Jun 2024 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207331; cv=none; b=L08tyo0PjBXle/6acKVvk8milD9nNL6RzWfptDj21pk74KoaRyjGyuWnFZFAqgaYLhzeo04z9L0ISkvkFxSXtIQqv2zQlfooG/hpaMuHGnZ2aORWUWcNRezROqsks09GdOR+AHtDMKLm515oxJpKbfTBkdhHscNjhp+/rYjHa5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207331; c=relaxed/simple;
	bh=Zv5RO+ev5GfuXBQM8OVvJacsGQmGXoAme99ziwuiEck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p3h7mFzV9nCp47Yr3lJgvXOamm5+wcxap4XXzjuUmTfWwCUkNiTr6ohDNPoEKZkqjSvgzfKu4f67YvvIlOGT82RJVoMjL+adyCTgQGIt9wXf4ZRTb9fW7J7GazT59G/mDL+xOIxkVF1eE33cIZ7nfuAfQqFCPocNXYhWsiua3B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX7YQziI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4F4C116B1;
	Wed, 12 Jun 2024 15:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207331;
	bh=Zv5RO+ev5GfuXBQM8OVvJacsGQmGXoAme99ziwuiEck=;
	h=From:To:Cc:Subject:Date:From;
	b=BX7YQziIjwMZfXU0YaZomh/upatYQYZUGXQ/gieuDsa9lHHH6IXuLe5CWwi8zvEiO
	 4MVnoIG7zXqf/0d24cWmZHPf3kTevU7tUBOj26/3MnuklimKVGk5huSRgKYwztRmu/
	 GgkcV19g3+RW982sqldDpHHAyHvbiGqO4/GwXUcplKhwhc1jhFSXMOFwjOAeS/uY2g
	 UURuFkVVoi6LncNTPzj390R3bL4rqB7DQ5N9JiXHB2HBpnNkuAw2AP6yUK23Mddplw
	 L+GDRo7hirnaWDCQs9G5tvMOJL78qu04pnRH/U7EWVNQWmfqsfvDi7Kk7dRbB9Dxri
	 UMWjj3YilADrw==
From: Conor Dooley <conor@kernel.org>
To: linux-mmc@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	cyril.jean@microchip.com,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [RFC v1 0/3] mmc-spi - support controllers incapable of getting as low as 400KHz
Date: Wed, 12 Jun 2024 16:48:30 +0100
Message-ID: <20240612-brigade-shell-1f626e7e592f@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=jUBdCKFRhPbdoAZJHxpB1biK3nMfNT3Pp93RB7R03bE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmZh31+Pm/g6ohf0duw6nVeD9Per0uMtwtxV56d+SrMv b92nZBlRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbytpbhr8Bf9Si3ZXVFdZVd x49dWL3xPsN13mz1GY8DrmmEx8WwlTL8L+kS/R9c+YftQeCvP85rHr7O8L3xseH8jP878tVe9mf sZAMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Yo,

RFC for some stuff that I've got in-progress for a customer's board
where they want to use mmc-spi-slot with a QSPI controller that is
incapable of getting as low as 400KHz with the way clocks have been
configured on the system. At the moment, if a controller cannot get that
low, linux continuously reports that queuing a transfer fails. The first
couple of transfers will complete on this system, until mmc_start_host()
kicks in and clamps the frequency to the larger of host->f_min and 400
KHz.
Doing something like patch 1 of this set would allow the mmc-spi-slot to
function for some sd cards, an improvement on the current none. I don't
have any sd cards on hand that don't support the 5 MHz minimum frequency
that this controller is limited to, so I amn't sure at what point this
will blow up if such a card was used.

Is this sort of change something that would fly?

Patches 2 & 3 are just here b/c without #3 the qspi driver for this
platform doesn't support anything other than mem ops and #2 is required
to set the minimum frequency for mmc_spi to pick up.

Cheers,
Conor.

CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: Conor Dooley <conor.dooley@microchip.com>
CC: cyril.jean@microchip.com
CC: Mark Brown <broonie@kernel.org>
CC: linux-mmc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: linux-spi@vger.kernel.org

Conor Dooley (2):
  mmc: mmc_spi: allow for spi controllers incapable of getting as low as
    400k
  spi: microchip-core-qspi: set min_speed_hz during probe

Cyril Jean (1):
  spi: microchip-core-qspi: Add regular transfers

 drivers/mmc/host/mmc_spi.c            |   5 +-
 drivers/spi/spi-microchip-core-qspi.c | 224 +++++++++++++++++++++++++-
 2 files changed, 226 insertions(+), 3 deletions(-)

-- 
2.43.0


