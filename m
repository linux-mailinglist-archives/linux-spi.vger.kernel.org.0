Return-Path: <linux-spi+bounces-5927-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D2D9E794B
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 20:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6572B1888162
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 19:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2A4192B76;
	Fri,  6 Dec 2024 19:51:02 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7951C5484;
	Fri,  6 Dec 2024 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514662; cv=none; b=SgJkJTXbvPggQZzb/+o1WoWXwwZU4DL7gubPk1i6xiOuIhK5f04EjHp4fUhkq7rD309Vp823uRXW2vAQjNgyKkrmBvpA2CosI0LHwJKR4wRcs7DdyyUsemghqOj2esehINXs83mvSJyISH1xCJZ4ugV0To/+CV6jt6v3FE5JZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514662; c=relaxed/simple;
	bh=5HDlIGzoCBu+z5RIKlAZo4R/96IfVcAh4By7vQj2Pgk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=neAzUpjcHC0LYuPcRnhZpFf2c3kokT2dYnfk/lZBtaaC/KrcHKz2wKt+l9w8OThj5JKf/BKWGYQp3i2pbTUttGoeAe+2U6uYmk8/ur48wleR5dX8MyJkCF+M2w1s4cHtjHVEXXjU06l/3brJI8Dne3oKm0I8VIDHLEgLZsT0TJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE32B12FC;
	Fri,  6 Dec 2024 11:51:26 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CF733F58B;
	Fri,  6 Dec 2024 11:50:57 -0800 (PST)
Message-ID: <1f2b3af4-2b7a-4ac8-ab95-c80120ebf44c@arm.com>
Date: Fri, 6 Dec 2024 19:50:55 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, heiko@sntech.de,
 luis.dearquer@inertim.com
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] spi: rockchip: Fix PM runtime count on no-op cs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The early bail out that caused an out-of-bounds write was removed with
commit 5c018e378f91 ("spi: spi-rockchip: Fix out of bounds array
access")
Unfortunately that caused the PM runtime count to be unbalanced and
underflowed on the first call. To fix that reintroduce a no-op check
by reading the register directly.

Cc: stable@vger.kernel.org
Fixes: 5c018e378f91 ("spi: spi-rockchip: Fix out of bounds array access")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
Not particularly happy with it, it's just the most straightforward
fix for the issue at hand. I couldn't quite convince myself that
no-op rockchip_spi_set_cs() are 100% ruled out just from spi.c after
the first call either, but maybe someone more familiar with the code
can. I have only seen the issue for the first call / during boot FWIW.
Any more elegant fix suggestions welcome! The other host controller
drivers don't need the read before CS change, so this shouldn't really
either.

 drivers/spi/spi-rockchip.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 864e58167417..1bc012fce7cb 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -241,6 +241,20 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 	struct spi_controller *ctlr = spi->controller;
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 	bool cs_asserted = spi->mode & SPI_CS_HIGH ? enable : !enable;
+	bool cs_actual;
+
+	/*
+	 * SPI subsystem tries to avoid no-op calls that would break the PM
+	 * refcount below. It can't however for the first time it is used.
+	 * To detect this case we read it here and bail out early for no-ops.
+	 */
+	if (spi_get_csgpiod(spi, 0))
+		cs_actual = !!(readl_relaxed(rs->regs + ROCKCHIP_SPI_SER) & 1);
+	else
+		cs_actual = !!(readl_relaxed(rs->regs + ROCKCHIP_SPI_SER) &
+			       BIT(spi_get_chipselect(spi, 0)));
+	if (unlikely(cs_actual == cs_asserted))
+		return;
 
 	if (cs_asserted) {
 		/* Keep things powered as long as CS is asserted */
-- 
2.34.1

