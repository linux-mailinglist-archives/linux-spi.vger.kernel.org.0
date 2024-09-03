Return-Path: <linux-spi+bounces-4526-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E6F969DA9
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 14:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333191F246C9
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 12:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3311C9877;
	Tue,  3 Sep 2024 12:32:39 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CF3188001
	for <linux-spi@vger.kernel.org>; Tue,  3 Sep 2024 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366759; cv=none; b=fGVA5OSUFAqY6MMlEzkS7GQUTnwbIqkfnqd1/sLBXISd0OZgDCsRLEi7hvctp5I/n/FwbFPaOuE0+GOcm2ryyEbWMaBNv5cv0qXSWPxcUXCkpWeFDmocBi6xKIvjb1idyS3g0UxXsUp9JyUmvp3i4HRUPtIactJN9vfsEfGez58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366759; c=relaxed/simple;
	bh=xM3WCpqMkk53YEJiJ0+jOJwolKONm0MaJ9xI6hm5k3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kbGLI4tgEW2qTMHqFu4yHSOhTd+sNT31WcH5HZf3LkjKGo4MShF8ZHeokVDS7xlnO7HqOal0WefDxwWD/s5UobZhdcMTFwPRJu4PfmOBpUmJ07mVcAkZ3Jh82feswRnztXiJ8gvtSRTuSRPcQLR4TufP0nmmYYb0Ryx+r1tSr1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b015:4053:6b25:396c])
	by baptiste.telenet-ops.be with cmsmtp
	id 7oYU2D00S0nYyzV01oYU4U; Tue, 03 Sep 2024 14:32:29 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1slSht-001z5k-TV;
	Tue, 03 Sep 2024 14:32:28 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1slShw-003ixp-JX;
	Tue, 03 Sep 2024 14:32:28 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: spidev: Add missing spi_device_id for jg10309-01
Date: Tue,  3 Sep 2024 14:32:27 +0200
Message-Id: <54bbb9d8a8db7e52d13e266f2d4a9bcd8b42a98a.1725366625.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the of_device_id entry for "elgin,jg10309-01" was added, the
corresponding spi_device_id was forgotten, causing a warning message
during boot-up:

    SPI driver spidev has no spi_device_id for elgin,jg10309-01

Fix module autoloading and shut up the warning by adding the missing
entry.

Fixes: 5f3eee1eef5d0edd ("spi: spidev: Add an entry for elgin,jg10309-01")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
What is the protocol used to talk to the LCD on the rv1108-elgin-r1
board?  If the LCD is just an HD44780 character LCD connected to a shift
register, it should be modelled as such (see [1] for an example), and
commit 5f3eee1eef5d0edd should be reverted.

[1] https://elixir.bootlin.com/linux/v6.10.7/source/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 14bf0fa65befefe0..face93a9cf203569 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -702,6 +702,7 @@ static const struct class spidev_class = {
 static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = "bh2228fv" },
 	{ .name = "dh2228fv" },
+	{ .name = "jg10309-01" },
 	{ .name = "ltc2488" },
 	{ .name = "sx1301" },
 	{ .name = "bk4" },
-- 
2.34.1


