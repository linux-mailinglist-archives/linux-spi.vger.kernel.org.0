Return-Path: <linux-spi+bounces-4772-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD53973FFD
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 19:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7401C220E0
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 17:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145E01C0DD5;
	Tue, 10 Sep 2024 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTQF81pB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C371C0DCD;
	Tue, 10 Sep 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989039; cv=none; b=CwdMBTUeLUpijmGux2Cz3yEOkJIoTkSqGlFEIQm1Qtia2Y3I750nHEwhTMrlpFoSol457olWFma6Dylltt2xbCUIqjRArbzDSTOZTueDLaFFuhi8+KH+KeiYlc62CPTYxrMzD8DskyvNDoPPp+FOdb6xMvw/I8YqPlIW/SUkank=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989039; c=relaxed/simple;
	bh=FUKeRmE6BFe4XXkctFyJAIGZZXQNUr6MILo4sD+IpVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Am08LdXZczsNxYtidXSroWZI6kRl70DJEAk52bPT2Of5iX3d90HCVvW6nM8A4hkKylYLsRjfaS2BJqhVmtzbSbNDXdBo9n3OOldicFwDP3O3gxP5w9EUBdqru9XhRqGV/HIQwTk+dox7JFJexhfLdCee7tqhLBfAFnBOW4eP0t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTQF81pB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6D5C4CECC;
	Tue, 10 Sep 2024 17:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989039;
	bh=FUKeRmE6BFe4XXkctFyJAIGZZXQNUr6MILo4sD+IpVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sTQF81pBt5UDwTA2tpkQ/EXIUcaXZr7JaxLbCAajl2lOuoHGqFO+JBtVPMFFRRHkc
	 LQ2UGWHNCXC1Fu3iwvz9Qjh1Tjnb4119rSANgq/9bGjR+ggoxKArsY1y6kOhnt6lWU
	 oqKUsbUt39cJJVGY1r9RBVT9biv/1mkq8ovplNysHsfj65Zf0bqwl6S+xl3sdDcNwu
	 VmN+tCYRbbMGCUG1ECrwoiMJneAYVqrxV4Ikkh2IMXRFDtraOwHizy8E4ar4aoo03d
	 IVmf99V9d4GwWON20uCcrjFwTKTqQYOv63z5VzOd2a5I4jxHoMmwfzxQPK6mSH6JZo
	 gwlyf9xsD87jQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/5] spi: spidev: Add an entry for elgin,jg10309-01
Date: Tue, 10 Sep 2024 13:23:47 -0400
Message-ID: <20240910172352.2416462-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172352.2416462-1-sashal@kernel.org>
References: <20240910172352.2416462-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.166
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit 5f3eee1eef5d0edd23d8ac0974f56283649a1512 ]

The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
The marking on the LCD is JG10309-01.

Add the "elgin,jg10309-01" compatible string.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20240828180057.3167190-2-festevam@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 0b97e5b97a01..8570cd35b7e5 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -712,6 +712,7 @@ static int spidev_of_check(struct device *dev)
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
+	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
 	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
-- 
2.43.0


