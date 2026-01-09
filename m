Return-Path: <linux-spi+bounces-12237-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AF4D0A23B
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 14:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C8DC31BAF19
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 12:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3A035B15F;
	Fri,  9 Jan 2026 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tA0DWOni"
X-Original-To: linux-spi@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563BD33C53B;
	Fri,  9 Jan 2026 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963008; cv=none; b=hKlAn2bmWSq7bWqkbzzPRu7IU+JiNmwpLL+cNLuppBe7zIwzA3bsAJolM2onBZQh5B2SJt80p5Ha333lJiMw6K236/diOcOcrKFhUDvN8d011P1dUEOUcVppHjGSFgDKU/ewT2Oo1k6/bZYz1NkWhs1VC1HsCx0dvn5EX5OYcII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963008; c=relaxed/simple;
	bh=UfcDvTJAM2/ZgGLm5oUfvAxX2WdqB6d7zSlNFSlbzeQ=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=hoycYhqqHMwYM22JwV7jSb9PFTKW8aiYS405KS4zQNNgaN/l0GFt2a6tf+L6ztFS1EgGD8vox+ZEF7LWQzlxu8PMUqSJyXdtI0usnPaWscRaiZME8qFYUkbdWDOXoY7Orm4i1rlZX4YTDKNAruUi22GiDonN2pKAy5y6uYPdXo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tA0DWOni; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767963000; bh=XdJR1FeGz/gLDuOtRouRwTzwlS7mZmmQeKaB/b1WBZo=;
	h=From:Date:Subject:To:Cc;
	b=tA0DWOniy3O+kOBalHIThJkYd9rYD0cCayORxvoVI1b0wt53npMJHOzAmjBkx3EKv
	 0mc6RmGuflLgp1Xvp0nIy2Cd+YwBDpi2jkRGBnSxLPs3xDS+CpdPyLl0wKI2oXIyhF
	 IDyyhcdTAl0mtwfKb3Zvlj6DNkj+XgCPJW6OT458=
Received: from junjungu-PC.localdomain ([2408:820c:9008:ba52:b9ed:ea53:dd50:fcf1])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id C7A3BA4F; Fri, 09 Jan 2026 20:49:58 +0800
X-QQ-mid: xmsmtpt1767962998t7u2zvyz6
Message-ID: <tencent_AC7D389CE7E24318445E226F7CDCCC2F0D07@qq.com>
X-QQ-XMAILINFO: MxfNzk1nLQcY9ab4kWVfQ5BzAj/b+3pztMQb6rJICbOs2UxrRKEVVo5e9mxQwM
	 X9RiiebCvRiQtLJij/zZw2mZEdxJSgCJYmRIvnlBxiyHPQd7r/9vce2MFy86J4juK25RvvuAQ8FS
	 qzbAa0xVK/yKQDJZxIW+PIqS1so3bAIwEwy1K9B2zRTMhd0sYgyz5KuIAiK5RV6vk0dAyl3t5koJ
	 z+IJrXNXmaklEFoyPZNUOCSeMUe4N6px2xZHLIw4c9LhZw0OzF61SsQh+FDR8IKaZ0+rtjEJndjL
	 LygzReRgeby+gB3NWN5jhRRNzH8OTXbzhUAgbqR04hKO3pgI41OkSii3NUMimeLOxWqrowTaLwhL
	 GOjStvpFSLo0Mu3CMrnmokG0qn5fM2g8KpQREHKfV1YDtZoCT89qKS/R3FuyOJOh/ILUWzxov+3O
	 kahjmAKGiAUFl5elLXNcCJV7MRS1dNju/sMPqDjIJPBqI83VUtbxWnF4pMjr/N7hZC5/wTRzFRNL
	 EK5FIF7ykMAkQanEB180pWnjaJ3cDuW+J3jcbg9NG9rdvSAXRw902mS6IJkaymxpsqmI3wTquBj3
	 kGMxTQAv36s6jMHyPL3IHxT35jthG1rjvKuAVRikGaKFZDzd6mfVKoWZztDLE3ylJOlI/ATQqBix
	 UiU0Fvy0NGUObGQ45JBjOf7qBCOPzOuyC4jMahnnIpLqNlkOUF7kXjmCudqs16d8SwsBzAIwQgXm
	 1xMsKxyK1poFm4knzhnAxDqHZBjKVpLqb/HH5SDp/nvnCNhgZyRh6CLxNrI9986/WKQGRR+jiF/3
	 ZB7ZBQwPfpY82OP4cCTJ3s3qcrHIz2L/Umj3g4NkTB/IGCOI/cRpi6By+s7r66EzbPd0kKxBJNw3
	 26lha7kxNPpPgWZxApvQwv/vSBk1L/7qIvyVGrbqXI2v8pTfyoCDu3P3gfXNrwjZstha6zrPDhcL
	 29Z8+Fag4sXdpzz9PZQ75sduzsZUNOCszz6B9Usvxe7/wLRJmIkEB2AQiqLID6/Epv2zhF9O75Nx
	 fR8kCaomj0ibu4ixL0N3Yv2Hch+SZlyNww7r7y80mTDwrg7tU6cf0cbZVRBM733JfuuGQaYSWs5G
	 psNbaclayETrTxg0pxAtNtBQMm/AcCg9uBBgzW8GmDx3smOvwFFlqdjK+N9ktu5+GM9NxQpMdPvL
	 iQVGnEihQInkcIrUv2VkKoZ+BgcHHVwrIsB3+1DjKorrdM3A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Felix Gu <gu_0233@qq.com>
Date: Fri, 09 Jan 2026 20:49:53 +0800
Subject: [PATCH v2] spi: spi-sprd-adi: Fix double free in probe error path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260109-spi-sprd-adi-fix-v2-1-289270fbdc22@qq.com>
X-B4-Tracking: v=1; b=H4sIAHD5YGkC/2WNOw7CMBBErxJtzSKvRUKgyj1QCn/JFsSJjSxQ5
 LtjIlFRTPFGmjcbJBfZJbg2G0SXOXGYK8hDA2ZS890h28oghewEiR7TwjXRorKMnl9oxJm0J3n
 SvoM6W6Kr9a68jZUnTs8Q3/tDpm/7k13+ZZmQUBlNvWy99rod1vVowgPGUsoH3D7+wq0AAAA=
X-Change-ID: 20260108-spi-sprd-adi-fix-c071bf124bf6
To: Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <gu_0233@qq.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767962999; l=3633;
 i=gu_0233@qq.com; h=from:subject:message-id;
 bh=UfcDvTJAM2/ZgGLm5oUfvAxX2WdqB6d7zSlNFSlbzeQ=;
 b=Q7RTbHl4RgxGv6dpD0qifLOZ1SF2oecKvwYF230Crxp4soFmApY3aVylp4j8S7e2oZw1yWdQG
 p6kVqRP/HAkDXu+Zis35CVeNUlr3lrfO57ypUmJR5K1YvpfgufBkOO0
X-Developer-Key: i=gu_0233@qq.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The driver currently uses spi_alloc_host() to allocate the controller
but registers it using devm_spi_register_controller().

If devm_register_restart_handler() fails, the code jumps to the
put_ctlr label and calls spi_controller_put(). However, since the
controller was registered via a devm function, the device core will
automatically call spi_controller_put() again when the probe fails.
This results in a double-free of the spi_controller structure.

Fix this by switching to devm_spi_alloc_host() and removing the
manual spi_controller_put() call.

Fixes: ac17750 ("spi: sprd: Add the support of restarting the system")
Signed-off-by: Felix Gu <gu_0233@qq.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes in v2:
- Added Fixes: tag.
- Added Baolin's Reviewed-by tag.
- Link to v1: https://lore.kernel.org/lkml/tencent_4588081F26734D4306AEE239F31016318205@qq.com/
---
 drivers/spi/spi-sprd-adi.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 262c11d977ea..f25b34a91756 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -528,7 +528,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	pdev->id = of_alias_get_id(np, "spi");
 	num_chipselect = of_get_child_count(np);
 
-	ctlr = spi_alloc_host(&pdev->dev, sizeof(struct sprd_adi));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(struct sprd_adi));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -536,10 +536,8 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	sadi = spi_controller_get_devdata(ctlr);
 
 	sadi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(sadi->base)) {
-		ret = PTR_ERR(sadi->base);
-		goto put_ctlr;
-	}
+	if (IS_ERR(sadi->base))
+		return PTR_ERR(sadi->base);
 
 	sadi->slave_vbase = (unsigned long)sadi->base +
 			    data->slave_offset;
@@ -551,18 +549,15 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0)) {
 		sadi->hwlock =
 			devm_hwspin_lock_request_specific(&pdev->dev, ret);
-		if (!sadi->hwlock) {
-			ret = -ENXIO;
-			goto put_ctlr;
-		}
+		if (!sadi->hwlock)
+			return -ENXIO;
 	} else {
 		switch (ret) {
 		case -ENOENT:
 			dev_info(&pdev->dev, "no hardware spinlock supplied\n");
 			break;
 		default:
-			dev_err_probe(&pdev->dev, ret, "failed to find hwlock id\n");
-			goto put_ctlr;
+			return dev_err_probe(&pdev->dev, ret, "failed to find hwlock id\n");
 		}
 	}
 
@@ -579,26 +574,18 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	ctlr->transfer_one = sprd_adi_transfer_one;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register SPI controller\n");
-		goto put_ctlr;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to register SPI controller\n");
 
 	if (sadi->data->restart) {
 		ret = devm_register_restart_handler(&pdev->dev,
 						    sadi->data->restart,
 						    sadi);
-		if (ret) {
-			dev_err(&pdev->dev, "can not register restart handler\n");
-			goto put_ctlr;
-		}
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "can not register restart handler\n");
 	}
 
 	return 0;
-
-put_ctlr:
-	spi_controller_put(ctlr);
-	return ret;
 }
 
 static struct sprd_adi_data sc9860_data = {

---
base-commit: fc4e91c639c0af93d63c3d5bc0ee45515dd7504a
change-id: 20260108-spi-sprd-adi-fix-c071bf124bf6

Best regards,
-- 
Felix Gu <gu_0233@qq.com>


