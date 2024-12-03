Return-Path: <linux-spi+bounces-5886-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B42F9E10DB
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2024 02:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3405AB2237D
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2024 01:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906EE2A8D0;
	Tue,  3 Dec 2024 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jfakQW/D"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m21470.qiye.163.com (mail-m21470.qiye.163.com [117.135.214.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA42615E8B;
	Tue,  3 Dec 2024 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733190036; cv=none; b=GJLHDwq6LJPepXcBTzoUzkov4DxKz5yUwgTt7QuuIlXnP0Avd6JIS1vqqUwWD0bsOjmz2tccZu5Gdh8ayFglbiWPAOnE0iKSHM1DzEuNV/Ha2lYaR0ofNKBaQ4mhdM1zJonWsE/KYILEJqdn7X1B8mN5X9D9rIDeWfJ8ioaVZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733190036; c=relaxed/simple;
	bh=ETXhdS9fvXnJlfXHPLtikH7l7BD4FcrqgztckfLBXPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CNV6eEor2ZuTpsuqmqLDXzXrRhdk9n4cwRoyfC44A8HFvLDjI8i/9G9uPaVVR89Npq+cPVufw0qAOdgJ9h4HZpFwh4FCmEUHUM1hC68S7SXeGgh55NobJm1J9hUGlrC3oWDgwlIgoQwKcDKaGPB/JqyfgZxVicAJvk5YHTe5dVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jfakQW/D; arc=none smtp.client-ip=117.135.214.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47ff938a;
	Tue, 3 Dec 2024 09:35:15 +0800 (GMT+08:00)
From: Jon Lin <jon.lin@rock-chips.com>
To: broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de,
	jon.lin@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: rockchip-sfc: Optimize the judgment mechanism completed by the controller
Date: Tue,  3 Dec 2024 09:35:13 +0800
Message-Id: <20241203013513.2628810-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9KQ1YZTUtLS0NDSkJLGk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a938a28453909d9kunm47ff938a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NT46Mjo6KDIaThAMMzYuCQoX
	URMaCUpVSlVKTEhISkNCTEpNSEpMVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
	QVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0xNNwY+
DKIM-Signature:a=rsa-sha256;
	b=jfakQW/DxzWDCeZTFJ2qwv2/HsVuQYqgzlaPYegq/OXq4isHh+F6aAHyLpNRSw4WLNvJsq4pAnNrWnXWq7n8ufzjxVUWIVUEycO5veT9MxLfRRv4/UZQgLvROOjRtjTeXvX1MbmYZKf4Bjjzb3JdKB6hEGWulwKbSrPtO7vWLfg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=hywco0EOZS8UPtB5JNfLuOnac/kvQFRPXPjTcGdkjTc=;
	h=date:mime-version:subject:message-id:from;

There is very little data left in fifo, and the controller will
complete the transmission in a short period of time, so
use readl_poll_timeout() for busy wait 10us to accelerate response.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip-sfc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 138508d2c736..14f5b9346050 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -472,6 +472,16 @@ static int rockchip_sfc_xfer_done(struct rockchip_sfc *sfc, u32 timeout_us)
 	int ret = 0;
 	u32 status;
 
+	/*
+	 * There is very little data left in fifo, and the controller will
+	 * complete the transmission in a short period of time.
+	 */
+	ret = readl_poll_timeout(sfc->regbase + SFC_SR, status,
+				 !(status & SFC_SR_IS_BUSY),
+				 0, 10);
+	if (!ret)
+		return 0;
+
 	ret = readl_poll_timeout(sfc->regbase + SFC_SR, status,
 				 !(status & SFC_SR_IS_BUSY),
 				 20, timeout_us);
-- 
2.34.1


