Return-Path: <linux-spi+bounces-4982-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E66986EFE
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 10:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0636D1C21C8A
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 08:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7D31A38E6;
	Thu, 26 Sep 2024 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MwEgWUG0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ACC1D5ACF;
	Thu, 26 Sep 2024 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339908; cv=none; b=I+i8wcQK3RaD7lXe/Lp8OCEkmVTP+nwo3VKJ+fG2Q05vUcjNJTBc+SE0nDlUC+TVDVJi8ahkwP/TbNYQ/aoCZwbqn5mP1rgisd2K2T1HNOyuVL05/yscT+FobOuU857lbyWxSMwa7ytuiecqcjMN6HdLzIWkpFyjPEpwc8tA9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339908; c=relaxed/simple;
	bh=6kPBvlalmSMLHMRzrRnPCMPoPStCACX5Z43/fzamOvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QuaS4q5i1eCAFwCfZNGMyQ+g/3s9hvIkpG/70hwbcFE8TiT/JyRo4ZucQIK7R6QILhscJNszIbE0g6wJ+qPYgwLY/0MPU4IZvCKHmjQcgs84gxCTt95GPfY4otB8rzNYsjFGDk5uD+zbSAD4dIxOweZ0f3JilVRA91fE0/HoXxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=MwEgWUG0; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727339904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JyVuCIrRcBjtbj1uJvQkCOOG4PUr556iRdy/26xsPOc=;
	b=MwEgWUG0W8rwROkafIYlJAMV08BIxbtgZPgy9jX2TbDoeWO8T2YyLkT6YYYytGsy/ZjuMG
	5l1IeHVIH87u54SXF2Iqs6v5igxprjFF9k7cm7sTo4Ut3DZwUDlIflzM6PVveGfAbVp7PP
	QHbKXTWWG8xOWYESmu7cBO4Yc6Kb+iMx0LW5ZHqZ+HOR3Bp2pB3WCUKZcApgH0dkDKJjlb
	W6Zk2EoEMtaYQmtcVTfGvF3/AqNu89KwDqSfU4x2s5zV+n10IuGA7H0FwpZLpz9VY6wR6y
	T2O1r3aRKwyTlmQ1SpSQcK2NsvCJFK9qwFLX2lQ3+tjwfdybLeOTdulwTW1H8g==
To: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org,
	heiko@sntech.de,
	oss@helene.moe,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Improve error handling in Rockchip SPI drivers
Date: Thu, 26 Sep 2024 10:38:11 +0200
Message-Id: <cover.1727337732.git.dsimic@manjaro.org>
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

This is a small series that improves error handling in the probe path
of the Rockchip SPI drivers, by using dev_err_probe() properly in multiple
places.  It also removes one unnecessary check of a function return value,
and performs a bunch of small, rather trivial code cleanups, to make the
code neater and a bit easier to read.

Dragan Simic (5):
  spi: rockchip: Perform trivial code cleanups
  spi: rockchip-sfc: Perform trivial code cleanups
  spi: rockchip: Don't check for failed get_fifo_len()
  spi: rockchip: Use dev_err_probe() in the probe path
  spi: rockchip-sfc: Use dev_err_probe() in the probe path

 drivers/spi/spi-rockchip-sfc.c | 21 +++++--------
 drivers/spi/spi-rockchip.c     | 57 ++++++++++++++--------------------
 2 files changed, 32 insertions(+), 46 deletions(-)


