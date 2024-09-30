Return-Path: <linux-spi+bounces-5039-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8183B989E47
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 11:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0451C21F6F
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 09:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256E518871E;
	Mon, 30 Sep 2024 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="mfdwHh6m"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF378C9D;
	Mon, 30 Sep 2024 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688682; cv=none; b=i/F54OIAfcJXU81D7dEnpwBW9J2Odv5TQy6V5Nc77hTwt461yrl1WYi0o+HGYoZacs+OLoJ7kURV+OewVLXoLk+5NOmZXDX8oB5gdrI/sfDoe0E0WqXmUwFoMEpOVn2f5vUJJ62HBwUD/s2XKcWHq8OjEB+zaMl3C8TH+H2CCHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688682; c=relaxed/simple;
	bh=7juPeHgMm/hkGGRs8wL8YRPemyw12fV8KWGYWB5f2uE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R6cuPf8OJMzsOYNZvAxcY6bcjY3Wq5XIGwT2BQ4U/PBwcUnz+pNYpSme5Hp/mmgkGjteiLHiFuX7YdjVDQdpq+ITSz47gNgpZzdau5ZJMPxY9kerFLNXHV+vO6tDBry4hjKvhMAwA02RRK7pviAKiaZ04hYoru0yeOQrMVq6+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=mfdwHh6m; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1727688659; x=1728293459; i=wahrenst@gmx.net;
	bh=IZnHv/RgvzeYV3uzmA6kz/gXBAAORwLBuWyDnXCRNF0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mfdwHh6mfZseMdBzY4Y9hsVBaIbQlMGlyng1wxhHjSpaUNsUPLA+lyscU3vK36eO
	 68wZ/KlcL8bhaWC8ElKuSEQVFbI0UYYB9d3eVq4BdEa6eCmtpPuUNEIrK27TzbKTl
	 N7KzOi0xN5iphDojDCIg/oAIvMexrbMh+CrdkbtwK2Yvx0dSNuCGkP3G103UTwaOL
	 gu0sUcVHHdDotza0A6I76NnKctf9TpuaaFG+EDO8cTHXLvVzpJ19CQjQ0mx02iO4p
	 lDlT0YK6+keDECGVprSnc+q8RaJ30ZJM2Wmrufno83rEpRa7ZyqcQQtlbXRyn+7Of
	 /4IaPj/2X/j14g5owA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWASe-1sNYlt1fSM-00SoQI; Mon, 30
 Sep 2024 11:30:59 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Mark Brown <broonie@kernel.org>,
	Carlos Song <carlos.song@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	"imx @ lists . linux . dev" <imx@lists.linux.dev>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 0/3] spi: spi-fsl-lpspi: Some calculation improvements
Date: Mon, 30 Sep 2024 11:30:53 +0200
Message-Id: <20240930093056.93418-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ctLek0nGFhy7LJsXbx9lkpiShaCF9HIsO+v5L4WJsV1XSn851+P
 dQ+AT6Jpz6k0nSSf0kB8KiUv0phYB6Aewsc6W7GqlY4xP0pbFfPRmjoLxUOYwP/Jw/tljdI
 jzaO3DVTDFk1KLSRWj0cgiYPeA0EzvCC6vscsbGu9Zrz3PetLpJ+QrU0DmbMS4lSheQZLXE
 ww9O/R8+63NWoFTBjBs2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zAN84iu1REs=;AEbWaILX4i9BzVoD7d5s68Y5QRn
 PjtulRTzZYycMqraxerC1MlIdfCr+zVQIQuU/xcFcJGtCaTTHQEbhiBgTbbH2a2U4ykB9xtxk
 JfoZ6/LYptuN6xBq208bUJkl/aPZ8rjycEhZfvDAesKGAOcnuheE/wNluAypkD+N4rGSkDIwh
 rTMFSGWq1cBUGfv3wpEX7XY6EoFRqbJFEJ9hwKFc6xpwCB90FkKzWr00np/bzsy3xZg7q4/yb
 3hkyRQIpxHGbo8HN+tomb7TBBl7xTnn5VPr7r3nxQdSS49eMFoK7TMnG+NMJk6NWTyW4l4Bsz
 pCEt9xqaDiChAvMLPHes04lfwL6P0rsN8APIpo/aSEaUReenifqh9hRlzH6182x0XaxEHWD3O
 2eUeaQjRuIzDWfLcx732uvF8rGzhXGrRFojJI+5LooBlncbudaF0kBycs2Fj2Oa7+BufSVvZV
 qf+SOwx+FHcXgPcwCKSSLjuPwg3A1t0PKRp/BRC6d2adJmvoPMwvzmm0FU9XH4+ioYmU9u2fF
 +2gCxFpUp6DOxy/DgeJ9qgXbnMtbpzzhI9NAXltYoitPFN20M8TZdoQmhzlw1o4bFjWEtRXXB
 LtQitTioX9hhreOtmVtTiScMLyQn3qjqhMC77bZZf/RUCw9AuR11U2T1wWtyYqGF7jCU/TJrU
 bS9e3GbhZBBY4Ch8ENnR6M93mUcCqsDrjhMZIH8qzxIksXWDIMD6gWM0HNhXLUhyD4VTw1GJn
 tESs3CkUHKOHAUbhu+53eGbS9nMT2BjgcoEhprN7MZi009Q0AgPA8JCI6IgHZHWLh7rqBbGhW
 uv5+euhtld0NOHaSJvgWw10A==

This series contains some improvements for spi-fsl-lpspi which are
related to the calculations within fsl_lpspi_set_bitrate.

Stefan Wahren (3):
  spi: spi-fsl-lpspi: Adjust type of scldiv
  spi: spi-fsl-lpspi: Fix specifiers in fsl_lpspi_set_bitrate
  spi: spi-fsl-lpspi: support effective_speed_hz

 drivers/spi/spi-fsl-lpspi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

=2D-
2.34.1


