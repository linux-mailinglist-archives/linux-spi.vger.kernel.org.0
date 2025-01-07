Return-Path: <linux-spi+bounces-6251-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E23BBA04BBC
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 22:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F0618886A8
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 21:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4D51F9EB8;
	Tue,  7 Jan 2025 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Q1SPhU6t"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m127210.xmail.ntesmail.com (mail-m127210.xmail.ntesmail.com [115.236.127.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0361F8911;
	Tue,  7 Jan 2025 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285452; cv=none; b=exY5cogK2fMmGwQx79ahjv216M6R7LQF+XUBD/qmXxRGzupkqBmQ1U9QAddIqyEQcri50iKOrTGbDJHdvVI94/Hd2QcGOwckMZVuFAVECbsEGzZq+Is3LXAIHObUqpWAsuE8e3HVcIvCBAa2wQ2MOCPB91wmoJdsBML3gAzd3zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285452; c=relaxed/simple;
	bh=nH/1wRDyA7KeH/VKNyivsjsQ/njq/lgzXcYYLGgrsRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Leo70oRRqAKT2uM/KqXGe1gQ6w1huxGU8cYlRNPK+8OO8EulATC4367bTLPu4UzXLmdX/ImZeQ6qayCLGlG//v/HQhGo4p0MC9z3D6AQvosz0OYAIrl+m9jIhW6YXzi5nLXZlsApKASRZYqtwHGO8htxHgiNtwI6I/6QQzPz+1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Q1SPhU6t; arc=none smtp.client-ip=115.236.127.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 801e0ade;
	Tue, 7 Jan 2025 23:48:00 +0800 (GMT+08:00)
From: Jon Lin <jon.lin@rock-chips.com>
To: broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de,
	jon.lin@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH 2/2] spi: rockchip-sfc: Add rockchip,fspi compatible
Date: Tue,  7 Jan 2025 23:47:55 +0800
Message-Id: <20250107154755.2037197-2-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107154755.2037197-1-jon.lin@rock-chips.com>
References: <20250107154755.2037197-1-jon.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk5LS1ZJTR9LHhoeSh4dGkxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a944173916109d9kunm801e0ade
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OQw6LAw6DjITHxEUKSpMKAwz
	KzFPCh1VSlVKTEhNSU1PQ0NKSExMVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
	QVlOQ1VJSVVMVUpKT1lXWQgBWUFDS083Bg++
DKIM-Signature:a=rsa-sha256;
	b=Q1SPhU6twQ0nlv+ONHZXIjROcWiO8EYPGXr0HcXOR4Y5jXa5x3mny0tkRHyAlgi6XYY7IdOachcnCVczX6fhx3mVsC5oqg9RKhoo9xLAaxcgiBxN/WdiTPQiEGp4e+ot6+IX0vbsWOdZNtd4e7b9Z9s5BDAX6/DMdaqyCodsMH4=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=XJLawlfMWnWq2XaeHw3MAcM0toNaZ6iL2XtcMfjanUw=;
	h=date:mime-version:subject:message-id:from;

FSPI is an SFC upgrade IP, support new feature like XIP. But RK AP
SOC FSPI early version integration implementation is the same as SFC.

Add rockchip,fspi compatible to match with RK technical reference
manual.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip-sfc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 59de351499a0..88fbde27925e 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -808,6 +808,7 @@ static const struct dev_pm_ops rockchip_sfc_pm_ops = {
 };
 
 static const struct of_device_id rockchip_sfc_dt_ids[] = {
+	{ .compatible = "rockchip,fspi"},
 	{ .compatible = "rockchip,sfc"},
 	{ /* sentinel */ }
 };
-- 
2.34.1


