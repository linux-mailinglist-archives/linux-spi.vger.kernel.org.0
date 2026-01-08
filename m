Return-Path: <linux-spi+bounces-12220-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 74418D0447E
	for <lists+linux-spi@lfdr.de>; Thu, 08 Jan 2026 17:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 426C8304D01D
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jan 2026 16:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7A5226D1E;
	Thu,  8 Jan 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bsdKaEOv"
X-Original-To: linux-spi@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1416423370F;
	Thu,  8 Jan 2026 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888792; cv=none; b=o3BuXtdh0LZixXhD6/ZTGGo2309aF23EUJRz5NblHC3h1I6Nsk5eQPkKMYhI9T2qMQdC6UeiTqMHPPrrfyquEp0q/Pdtjvz3PUKnXHiY6qqSkajMi8kcBPyOxybkQCZv3UA+r3mHIc026M+frzizngGBEqvieIeObd5KinNDkuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888792; c=relaxed/simple;
	bh=kH8S9vP17GGJNWng1lDd1GpEYK1MC6zSkbNrZbInKvY=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=OYGPe0VCocqHNV7Sxi4kQSsiSyofDcHFXSyArqRPNO/0ww3qyxXHWPu3ul9VygF0r+K6woimwNMNw4fD03h0OWPdbR2FlNhx8Ty5AIK8Yk8cHOO451aV8h3T0MYn+Sode40Lnn6faABxlXnMitfGWpyQROiBBui7Nc4xgn+KWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bsdKaEOv; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767888782; bh=OoN0aYxSy/v3aNV/r7JQCUeLxofiSuOYROxXZTkm5h4=;
	h=From:Date:Subject:To:Cc;
	b=bsdKaEOvhiGoHTGVfRlFPb9j1XuV83QHshsF16SGmQ0ivzEE0V3CTrBoBufIllKeE
	 3T0lD55wmL4jSDIjO8PAocyMTVFamFmHv01htuVoe1y8ZzP9XV5osaPnV6c9PlAfuj
	 42duRa3N+S4qsXPwXOguaQ7xMqNIaz6kmrMW0uss=
Received: from junjungu-PC.localdomain ([223.167.147.103])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 340B1609; Fri, 09 Jan 2026 00:13:00 +0800
X-QQ-mid: xmsmtpt1767888780tzdgmb5eh
Message-ID: <tencent_4588081F26734D4306AEE239F31016318205@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+9RToujcwd5D/Zv0B/XmJIlzT98TCV8Lp1WtRygQ4GK0GXjcyyJ
	 LYfkGRNG9nRukJp8CDCCjF8ie73LtiNdBW9m+Drq0eBDlOWfUwjR9QmyZYz63CIwd7rQEaHR8j0f
	 weKc7SpCaTyzk2lBjCH2y1Hf6KZ3AoFswWvtcsZLMYPGcnuhHrH9tVirQLvVospC4+gvW4H1nEgZ
	 XUsBF0uETXp8PiUgXpFGYPP6aiRE+iCEeQ8HAoAarZfe/PdyV4TzMEtqypbgtSaOUDXVvsTK6knH
	 9fsZo+8HCjHuJ8CH3weXqkwpNuv3Hd9wECqWZd0QoNJp7RLIGv4gq3M/54aNRWP2mcFBE8IVrl6S
	 w+6VjvpPjQP8szQouR4lQP1wlVQmOtFJ6nJCu7pIqFhbmZY3b1/9zE7/mMgjSnSmBopwARRbIzMT
	 n0KJWF2+sJl9jDhijrl2RBC/rB7Xu2hfCgbTY9PQB0ifkm0vih+ZTnKoXBKNGhH7fgNrem5hIrkH
	 HYfXXt3ylkOH1vxHIfwNS4bStOMVjjxY5rRrdH8YFpUXvbf97Py3zcTxLBxNKMSn6kgm6xGcLt8F
	 MUQlOsecywHqdl+Pnmk4Epi3zXU3Ip3CRHh6V+KCKoxxmj7IusQ8ffi5rgdfvVejNIP0ZT3FAol6
	 kC9SBdKJNxRaL1EK1Jp1FEphnb/O4z+GYDTp/h0LzbMNzby5nkYscJLupVSAGX5u6B31IldUW+8G
	 nnYGVVo8GyMBA7Adm3YABE2wCyMkDLlq4kGR5k9bUscArpibU33A2A6pwyEXFnxaYPZsP4Dx8xyi
	 iDkdvAWUICuVZSBGUFnIqAQpBAfXuT5NodrkupsD0EFOWGpgijee+jt6sYVMDPE1kVEUO+kT5ApU
	 dLFBHoYhDeotAfrfGFvscnj1chrWUn5IxCuhtqABvbxtmUT6iHrFIICoLrS4Vna9AybLDrmDlECe
	 fqmxt3J7nzvshNtFgXL059AaNJomkzQNlTmkahegPNhr/95Wulf+CanyHTgc2JRa/n6Qp8PYGGj8
	 gRSYwhPodkcs/GCAeff0IpGsKpSSXu7q/YBT3kcBtk1kDDqyLK
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Felix Gu <gu_0233@qq.com>
Date: Fri, 09 Jan 2026 00:12:59 +0800
Subject: [PATCH] spi: spi-sprd-adi: Fix double free in probe error path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260109-spi-sprd-adi-fix-v1-1-acb1825fbfb5@qq.com>
X-B4-Tracking: v=1; b=H4sIAIrXX2kC/x2MQQqAIBBFryKzbkAlLLpKtEgdazYmChGEd29o8
 Rbvwf8vNKpMDRb1QqWbG19ZxAwKwrnng5CjOFhtnTZ6xlZYqBH3yJj4waAn45Oxo08OZFYqSf4
 v1633D+14ARpiAAAA
X-Change-ID: 20260108-spi-sprd-adi-fix-c071bf124bf6
To: Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <gu_0233@qq.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767888780; l=3329;
 i=gu_0233@qq.com; h=from:subject:message-id;
 bh=kH8S9vP17GGJNWng1lDd1GpEYK1MC6zSkbNrZbInKvY=;
 b=o8pabK1z+e5ByvtKpAz3hh/y4M2lmGdtpm9LlLN8Y+MOWmPYGgDHDlfEfOf0P8CzjrsAfJ+A0
 80VZOM8USADDfTW6I9uSSnmHfoCoy6c0rpuGBe9N0Goka4OhRWbtD+n
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

Signed-off-by: Felix Gu <gu_0233@qq.com>
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


