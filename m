Return-Path: <linux-spi+bounces-2482-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2993E8B0838
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 13:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68342B21515
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 11:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D335015A480;
	Wed, 24 Apr 2024 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bittium.com header.i=@bittium.com header.b="uR0Y8ycD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpgw1fi.bittium.com (smtpgw1fi.bittium.com [185.171.177.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F33142E62
	for <linux-spi@vger.kernel.org>; Wed, 24 Apr 2024 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.177.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957501; cv=none; b=U0fldJ5WPegx4HfiKxnXOCpl+IH8oiKR8sXDk4/9EAsgfJnL8kxRakVt+CVSPkq6dh2HTShywWJUEthqzxVGKIOoPcOZ3QuRhasSCmr0drdHtrUCb0CCC96vMR0LEIGx+QaCPmhzBnOqGCP1+Bn632mCtV5SMujJRHCT2M1CLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957501; c=relaxed/simple;
	bh=CDEcke5pl2ThWrCll0K5xxCN+k2ReZcRsHz2gAnfRN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LQJFAlZHZdfbDXq4n/3BWvIDCamIa8VWjXNQ6ewvW7Az32sxe7/O1wmHO9RNO07ihiiRHzr39N+ZQPoWDqzpf9zWN5fZizQi10FHsbrLlQfxmpwhzBTJV3a9TAYRsZM4K01Slcyq3vdnT3bJpU7M3DfsI67ELpmzOIrYqUOVtuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bittium.com; spf=pass smtp.mailfrom=bittium.com; dkim=pass (2048-bit key) header.d=bittium.com header.i=@bittium.com header.b=uR0Y8ycD; arc=none smtp.client-ip=185.171.177.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bittium.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bittium.com
Received: from email.bittium.com ([10.237.64.162])
	by smtpgw1fi.bittium.com  with ESMTP id 43OBI0C9025417-43OBI0CA025417;
	Wed, 24 Apr 2024 14:18:00 +0300
Received: from fil664211.bit.bittium.com (fil664211.bit.bittium.com [10.237.12.249])
	by email.bittium.com (Postfix) with ESMTP id B87767FFD2;
	Wed, 24 Apr 2024 14:18:00 +0300 (EEST)
From: Heikki Keranen <heikki.keranen@bittium.com>
To: andy.shevchenko@gmail.com
Cc: broonie@kernel.org,
	heikki.keranen@bittium.com,
	linux-spi@vger.kernel.org,
	petri.tauriainen@bittium.com
Subject: [PATCH v2] spi: mux: Fix master controller settings after mux select
Date: Wed, 24 Apr 2024 14:16:47 +0300
Message-Id: <20240424111647.81286-1-heikki.keranen@bittium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZieRYJat7Y0ISbks@surfacebook.localdomain>
References: <ZieRYJat7Y0ISbks@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.237.64.162
X-FEAS-Client-IP: 10.237.64.162
X-FE-Policy-ID: 18:4:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=bittium.com; s=smtpgw; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version;
 bh=mIkSAPDRgi08b030Wgfbbcl1T1vn1+5Of3c1pcMKm/4=;
 b=uR0Y8ycDCt2OOv7YPF2WM13Asss2k+PKEdoiaNubOPtb9gb+oineAaowx60imQTVgTwTG5JJNk4c
	gty5SlMYBakX31UN+d7cEoF7hwYoFLh5GFjOBqgCkIBVNgN46/PkeX5LjzihMarw97ovilSIBYb/
	EPzzqFwj+Ig4B+E3awecCXWHLiP7O6Ns9EeXkzdT/+gRwZX+DuwICZOSOgCEyXob6dhDPFP4T75S
	+YQaMCX6ccK8W1NR6Fk7RJAi3OM1dQMlYXtS3n3mTMf1GwVOS9CKd/d5TIgIwGnfdPYKcj2rBGU6
	+40gtLGOI7zjzC2Hneygmt4LQCmS0EDCj49fcw==

In some cases SPI child devices behind spi-mux require different
settings like: max_speed_hz, mode and bits_per_word.

Typically the slave device driver puts the settings in place and calls
spi_setup() once during probe and assumes they stay in place for all
following spi transfers.

However spi-mux forwarded spi_setup() -call to SPI master driver only
when slave driver calls spi_setup(). If second slave device was
accessed meanwhile and that driver called spi_setup(), the
settings did not change back to the first spi device.
In case of wrong max_speed_hz this caused spi trasfers to fail.

This commit adds spi_setup() call after mux is changed. This way
the right device specific parameters are set to the master driver.

The fix has been tested by using custom hardware and debugging
spi master driver speed settings.

Co-developed-by: Petri Tauriainen <petri.tauriainen@bittium.com>
Signed-off-by: Petri Tauriainen <petri.tauriainen@bittium.com>
Signed-off-by: Heikki Keranen <heikki.keranen@bittium.com>
---
Changes in v2:
- fixed Co-authored-by -> Co-developed-by
- added Signed-off-by for co-developer
  both suggested by Andy Shevchenko, thanks!

 drivers/spi/spi-mux.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index bd988f53753e..5d72e3d59df8 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -68,6 +68,8 @@ static int spi_mux_select(struct spi_device *spi)
 
 	priv->current_cs = spi_get_chipselect(spi, 0);
 
+	spi_setup(priv->spi);
+
 	return 0;
 }
 
-- 
2.30.2


