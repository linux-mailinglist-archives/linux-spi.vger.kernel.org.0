Return-Path: <linux-spi+bounces-5018-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419EA988DC9
	for <lists+linux-spi@lfdr.de>; Sat, 28 Sep 2024 06:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698391C2125C
	for <lists+linux-spi@lfdr.de>; Sat, 28 Sep 2024 04:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FD415EFA1;
	Sat, 28 Sep 2024 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KxO0WnHS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E672AD38;
	Sat, 28 Sep 2024 04:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727496789; cv=none; b=Ojc0AcTDAHLJPNW6V1NJD9iNctf6eKLKYXWGBc++1n7l0YH8VCEdghklfe2CSevnaKvkaWMz8M58VP6GlWvhu0vnMtLOmvQM0h6qwlVeh/OzUKgXCrQyRGed4Mj6qYjrZcvkGw2QnVRU6eQNnXEErioW+8yXPy+y0rrU0ibU+w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727496789; c=relaxed/simple;
	bh=aN1p2OFdjo9KJyjFdmoRux9EaVeGyuGdG/IeP2DAHO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DRT5iNgYBo5QBCcYuznWYguZ0lYGYf4U2QkieqlT7cW5ms5yK4I0dxghaQQbGgbnsRDCOB3S/nzcjh0eAw+4DvyS07dciXAEVmUeDR0cXQf26iN7LOn8twziCkep8FaiLrEYv2gCipWIKuNV/pEJODov45d+k/8G22bwVxluLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=KxO0WnHS; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727496777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qS5nkhcrH6/JPE0N46P3G0z3ZV7o8bVGZuynbcKGW2M=;
	b=KxO0WnHSIFgSno8fx9WrJMLd/EXOM67M3/NwdWWc+IKTam0akO+1oZZYYSU+Gl9RV/2+N3
	1OjfQucYTD69xHPDM3weaOYl/1nSd4Sh8dPRpK3p6wlpkNsCe85a4nCrAWEKly7Q6PUE/l
	WxanNhmbFoiNxNs4cZfknw/c7bxNTrRYZfSyuJV+ePZkGrIrkdzr196sL5AEqLNmId5fnf
	of/JJuTBKdEH51miIjglNKbRdwArsI2KIYGhiXzwXmaNCXxG3YroiVEhTc6bHUABZW22xO
	iRLi/3AGz9LBo0+caa2Op/B/sUE0skdDBq/o5tDyRGkFrjxYz0XGFInoJzD5yA==
To: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org,
	heiko@sntech.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	oss@helene.moe,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Add dev_warn_probe() and improve error handling in Rockchip SPI drivers
Date: Sat, 28 Sep 2024 06:12:44 +0200
Message-Id: <cover.1727496560.git.dsimic@manjaro.org>
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

Changes in v2:
  - Collected three Reviewed-by tags from Heiko [1][2][3]
  - Dropped patch 3/5, [4] as suggested by Mark, [5] improved the check
    to use dev_err_probe() and folded that into new patch 5/5
  - Added new patch 4/5 that introduces function dev_warn_probe() that
    produces warnings in probe paths, to avoid the promotion of logged
    messages from warnings to errors, as noted by Heiko [6]
  - Adjusted the description of the series and of the individual patches
    a bit to reflect the changes, where appropriate

Link to v1: https://lore.kernel.org/linux-rockchip/cover.1727337732.git.dsimic@manjaro.org/T/#u

[1] https://lore.kernel.org/linux-rockchip/6085918.31tnzDBltd@phil/
[2] https://lore.kernel.org/linux-rockchip/2285557.3ZeAukHxDK@phil/
[3] https://lore.kernel.org/linux-rockchip/10409403.0AQdONaE2F@phil/
[4] https://lore.kernel.org/linux-rockchip/ce2e7f90e62b15adc2bed1f53122ad39c3a9b5ac.1727337732.git.dsimic@manjaro.org/
[5] https://lore.kernel.org/linux-rockchip/ZvUmk48R4hZYlO71@finisterre.sirena.org.uk/
[6] https://lore.kernel.org/linux-rockchip/6673004.tM3a2QDmDi@phil/

Dragan Simic (5):
  spi: rockchip: Perform trivial code cleanups
  spi: rockchip-sfc: Perform trivial code cleanups
  spi: rockchip-sfc: Use dev_err_probe() in the probe path
  driver core: Add device probe log helper dev_warn_probe()
  spi: rockchip: Use dev_{err,warn}_probe() in the probe path

 drivers/base/core.c            | 110 +++++++++++++++++++++++++--------
 drivers/spi/spi-rockchip-sfc.c |  21 +++----
 drivers/spi/spi-rockchip.c     |  55 ++++++++---------
 include/linux/dev_printk.h     |   1 +
 4 files changed, 117 insertions(+), 70 deletions(-)


