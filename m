Return-Path: <linux-spi+bounces-5031-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41484989470
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 11:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFABA282F8D
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE54F14B940;
	Sun, 29 Sep 2024 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ihucZZvq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A030813AD29;
	Sun, 29 Sep 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727601757; cv=none; b=M0Tw3zq3pc1rlGltn4xYM9e60+MLxVXvH9iHimXKTudbvLnZa3XiDatU8C1BbC6oMNd1yM9oxNgQwXQXWaPWxFuLWV0CrpKrYBzc1XYMTwMt4oymmhIOJMJdgDcXjtpAuY+NuXksY2aokag1Uy+njigN83iAaBI/SlGzn7fj9sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727601757; c=relaxed/simple;
	bh=08RR+wQb6KtKJbC3nK8ooBlj2AzEf9kghzfHmbsdhMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fCndJeKE35rV03PZnaIj+OeL4DnH4hM8gPus08rB+Oa2d/sU2Obrj+jbvxnVTs4b3v0T8W+0/x/e7EuAysD8KQf4ezQfmnLiBSZwJXjo1TLYsGAorNVuahlpEzMR8D/2A/KKIi8FgaRChOn2TgRLOrFgYw5yzDll7152jFz2XfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ihucZZvq; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727601741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IOgiRyvba8Y4cnx6yoRPaNn/yxrNbxMiZ1Dl0tI3O6s=;
	b=ihucZZvqz6UCEjRr+2z7P5frZEl8Ik2GtHJ1yn0uFWNAq+0/zQ0pBEPAwRa8F2FWgoZFc0
	acYvUOltHnNxBY0THxDyCFYSX+f7V5pfocrJCVMDffZy6XA/Su4QF+6x7VtpLwEOf0OTop
	rMZFYLNoeXRMuQM+CcOXO3PLzp6NxiF9id67ks/ZutAUtWIpLjoaMzX01rxCFZsYHTelJf
	rLgrgsIAcDktkMMT3SkHHl+VBIcCszw67XpP55Z8xVdj6bAmcMxXL01ztBjYGG+yO4im+p
	pvKYM/i9sWaVd9FQDZs2xnKQvVXkCXbQAIs1abN2kYDa9ENhb1ZQWzqzuA3VIA==
To: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org,
	heiko@sntech.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	oss@helene.moe,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Add dev_warn_probe() and improve error handling in Rockchip SPI drivers
Date: Sun, 29 Sep 2024 11:21:12 +0200
Message-Id: <cover.1727601608.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This is a small series that introduces dev_warn_probe() function, which
produces warnings on failed resource acquisitions, and improves error
handling in the probe paths of Rockchip SPI drivers, by using functions
dev_err_probe() and dev_warn_probe() properly in multiple places.

This series also performs a bunch of small, rather trivial code cleanups,
to make the code neater and a bit easier to read.

Changes in v3:
  - Fixed a couple of rather embarrassing issues in patch 4/5 pointed
    out by the kernel test robot, [7] one of them using the va_copy()
    workaround approach already established in the commit 3fbcf75bb41a
    ("efi/printf: Factor out width/precision parsing"), but all this
    really made me think how didn't I notice those issues myself before
    sending the patches, which perhaps slipped by because I didn't take
    the specifics of x86_64 into account :/
  - Added a somewhat lengthy comment to patch 4/5, to explain the newly
    introduced va_copy() workaround, partially reusing the comment found
    in the above-mentioned commit 3fbcf75bb41a
  - Added underscores to the name of the "worker" function in patch 4/5,
    to additionally emphasize its internal nature
  - Adjusted some of the variable names in patch 4/5 a bit to use what
    are seemingly more commonly used names

Changes in v2:
  - Collected three Reviewed-by tags from Heiko [1][2][3]
  - Dropped patch 3/5, [4] as suggested by Mark, [5] improved the check
    to use dev_err_probe() and folded that into new patch 5/5
  - Added new patch 4/5 that introduces function dev_warn_probe() that
    produces warnings in probe paths, to avoid the promotion of logged
    messages from warnings to errors, as noted by Heiko [6]
  - Adjusted the description of the series and of the individual patches
    a bit to reflect the changes, where appropriate

Link to v2: https://lore.kernel.org/linux-rockchip/cover.1727496560.git.dsimic@manjaro.org/T/#u
Link to v1: https://lore.kernel.org/linux-rockchip/cover.1727337732.git.dsimic@manjaro.org/T/#u

[1] https://lore.kernel.org/linux-rockchip/6085918.31tnzDBltd@phil/
[2] https://lore.kernel.org/linux-rockchip/2285557.3ZeAukHxDK@phil/
[3] https://lore.kernel.org/linux-rockchip/10409403.0AQdONaE2F@phil/
[4] https://lore.kernel.org/linux-rockchip/ce2e7f90e62b15adc2bed1f53122ad39c3a9b5ac.1727337732.git.dsimic@manjaro.org/
[5] https://lore.kernel.org/linux-rockchip/ZvUmk48R4hZYlO71@finisterre.sirena.org.uk/
[6] https://lore.kernel.org/linux-rockchip/6673004.tM3a2QDmDi@phil/
[7] https://lore.kernel.org/linux-rockchip/202409290910.55WdSCMH-lkp@intel.com/

Dragan Simic (5):
  spi: rockchip: Perform trivial code cleanups
  spi: rockchip-sfc: Perform trivial code cleanups
  spi: rockchip-sfc: Use dev_err_probe() in the probe path
  driver core: Add device probe log helper dev_warn_probe()
  spi: rockchip: Use dev_{err,warn}_probe() in the probe path

 drivers/base/core.c            | 129 ++++++++++++++++++++++++++-------
 drivers/spi/spi-rockchip-sfc.c |  21 ++----
 drivers/spi/spi-rockchip.c     |  55 +++++++-------
 include/linux/dev_printk.h     |   1 +
 4 files changed, 135 insertions(+), 71 deletions(-)


