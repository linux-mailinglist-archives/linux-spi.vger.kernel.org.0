Return-Path: <linux-spi+bounces-6197-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992B79FDCC8
	for <lists+linux-spi@lfdr.de>; Sun, 29 Dec 2024 00:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D35161CB9
	for <lists+linux-spi@lfdr.de>; Sat, 28 Dec 2024 23:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B67C19D090;
	Sat, 28 Dec 2024 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXakVNvi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB9419ABAB;
	Sat, 28 Dec 2024 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735428781; cv=none; b=jdpigNwPZxhbcrN5FXvdcScjkkNgOk4eKqxqYWlEg/caus4Vo9F2Opsa4a66/I7ryuINaN/GrQNx2FsUd7gEnMY3Ihay4EvvW604mUFd0Gnbyf5QcueGMVMj3KFS4HnDtnpDpdk/QP+BsOa1QWeMOgaui8xZLzzQE7FC4GajFZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735428781; c=relaxed/simple;
	bh=puiG5xEDdJCtQ8qmQzW/cyD8qGWndW0XH0vnx7xw1nQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=blCUz35mab/BfhVt7KNQucdBbmsgN2F2OlaR8EMzCySQoDSTjtdWpc4iRSrUDDigSUgadVjRvSrQKoFAifhNeaI+53yCZTaX+m1ORPsEvfWdbmGV7k0H1QUZU9OzVICxOiV/srkeL7IfvPGF891iE0I7P+iZa+M2FKeXUALfXmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXakVNvi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso82351385e9.0;
        Sat, 28 Dec 2024 15:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735428778; x=1736033578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfubF/yufWY092c2cPTjDejWqTWBBJxWn/OStLH2dG0=;
        b=IXakVNviFcgiBsuX+vS7TeyEw6xXFx+ppP/0sx23IbgX0DqnM7zT1NOiQcbE9GX84B
         EfCp7FNdWVK3reW0wuMlan/+OMk+o4cxaOEmywm6eB160acR3mkuhxC4sN6Wm184c/F6
         zQ+9CygjMj8DOuvZ8JRC2jRuNHRikLk3FlSOISp5bwMsDnEVYxlcZDikyk81bQG7igfo
         sFvleq8tAiBJRk4a6ElS0QTALPjVoANo//lw7wJggrc0icg8C3sm5E/D8T/B+qQqcHya
         Of6IMh6clT2kJfyVSET8ppcdzVdtz2lIP/Ld7BSzuz2AM8vQCWdPsoZ5OxKJKNY4RJTa
         0+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735428778; x=1736033578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfubF/yufWY092c2cPTjDejWqTWBBJxWn/OStLH2dG0=;
        b=bCL2lI6wRkhTR/0PM6vLmHFdc9sbQ0rcxTroL7C95ebNX6vVKUlrTRkbTc5cCshXHn
         XbGM651nm4U7zZJuxuFHbla6zfAH/IqK+dpKHtv0ExSe130S/7crxH7oWbW93V2RMXOs
         qMo4Qc/2YZwroIIy6WtIlX4X1vMLVsmEkAGC7Bl+Cs6tyFNjrkGfeXLWa8ccoIoE505n
         fU51+CuFLrCMaDU4u9aCN8z1Uc8+1heyaLzwA1C9eDgOThW8BEmQa+ryugc2l0B6MskB
         EtdVqaabPtD34XYcl7Pq/+4tiTZIeGLsK4OlBh4isPOnCeISXsorfAbkzJvRyunJZ6A/
         OS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmHvpX3ufmqD3BWcQlm3oRTqZ4TCfiiqH5/4iKPj3x2YSxCyS14lR7QhpLcex7qjbuQUFAMf5TOCkN@vger.kernel.org, AJvYcCV0kf+Xy5phGLJjEcCLHFaOt1+ghG8aFmCP+En6I9iwuZfvZhuRcXf317fVfbTnNCkTnWiQ6415JaAqIQQ9@vger.kernel.org, AJvYcCW4oModkrX+U9XoXZD4QNZoENIVLkdF2xaCAzbITIDVT1KzfeVadRXCpCdn/tNNqwU3ZngK+Pu3uo4K@vger.kernel.org, AJvYcCX0v0ol+4g/KdqJrX4x8iZgScU4G1kBePFG60W53sTo6b/p0//+kJsQmGe1e3Qo9JgmpISEEvKelzuH@vger.kernel.org, AJvYcCX5Dt4r30YXZy7pfP0BuOmnq+O65tmV5YO9muylX7U9Bq4THhmGZdodibCNXFGGk6w93BJWO+qh@vger.kernel.org, AJvYcCXWMN6BkvnAz7tpFktD39pPoNzXkE7RPcE4fC4n8mtDFBQFLi1c1cSK28DL0iYCdH9ov1Qu1J4bKTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysvOterIebQz4F5q5sYwkl0g09X15Q2pYqXYc6z/qdzUJuXkI+
	nj7PmKEVqQ4cvZXOXbvfxhESYLN4REM/5h6tbAjoQrYCGhor28NYgnXOLw==
X-Gm-Gg: ASbGncvI4gF33yzzoa7c0cEDupQ5GiCmynRYqhYhsuAv7QllGqTQwRSuNkgqCkmvgE0
	p/kmqrm3YkR40LnxSTrKhgfE9SNsFBSXi/PIYFbq0w8eH6neoxIMN4qfO+FACfZHhtQDryMFyvk
	4UkAzD7c2OLXv/2TQ5267VCvib6KHwABL56fAxoApT2Qzfj/mnR2AwvC43ZopLvlJMnZ+pjXyMU
	cbB3xCUpy/nGLttHw8qzjw7qjFz2jwnYaVrNlNp+PYMZeBMIvew0bLqow==
X-Google-Smtp-Source: AGHT+IF2ClbgecNehGE5fWNtec9ewXlro34blBIKLgyQx5qEfdd7BFdxq3aJXVLuA8KbNB+TQ/BMPg==
X-Received: by 2002:a05:600c:1c9f:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-43668642f9dmr262491285e9.14.1735428778151;
        Sat, 28 Dec 2024 15:32:58 -0800 (PST)
Received: from localhost ([2a01:e0a:d9a:4c20:d6da:7147:f20e:31de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436612008b1sm307077615e9.15.2024.12.28.15.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 15:32:57 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Sun, 29 Dec 2024 00:32:43 +0100
Subject: [PATCH 4/6] ahci: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241229-update_pm_macro-v1-4-c7d4c4856336@gmail.com>
References: <20241229-update_pm_macro-v1-0-c7d4c4856336@gmail.com>
In-Reply-To: <20241229-update_pm_macro-v1-0-c7d4c4856336@gmail.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-spi@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=puiG5xEDdJCtQ8qmQzW/cyD8qGWndW0XH0vnx7xw1nQ=;
 b=owEBbQKS/ZANAwAIAechimjUEsK1AcsmYgBncIqkWao0M4f63BMEsxa8BRIQnaXQWygL0phkf
 tdecngcH0aJAjMEAAEIAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCZ3CKpAAKCRDnIYpo1BLC
 tQJWD/9qfpDmwRN6zrCJNqZMU53EqDWlK+stpQdz2PxOgWM3IiMDfRC+jyRnvxeiWM9DBojy3CM
 eVzk/pzBMVdce6RrqEdBvSXEOhqvQtC1rwivdehnng1VXuGW7/WzqQ16lvPoYhaOeOSnH7v4S/Y
 5OJd33Yy8upYHZK+CHEDoRw7Y1JJcLzOGrgX4WjCVSnnCwzlncx6xZwhUkwtvI1FO18X5Jhgjh1
 yX6RZxXVxYc+3wdbKn6W9rDZZlfws37B0DfFdap3GBWMTfkNCgs+DGNgoEuYhZcMQxmwx66wb2o
 0BwEpi5PF9IGK6bHuLEEX2cr4gV9784GayGuaSythX1VMWzo4yVE6o9ETY0gdEdQUx5oxA+R5iZ
 QkPazXjn8VJIjnJgxjrVaVcCjDt/PomoWdeLWNdPtcslOtcTqTWVA3PxK3YuF/r4p+9hHbaizB2
 gnOwVzHIaLIKng0moZCBSHKUejWzwgkT/D692Qnwo1jzezsRFXBAHYBXxYC47FPUqrrNVLZ1IGW
 LSc+5kqpqWoJbf/J6FUi77wzfUAa7wwVSAr/kgt0ep2DMsyTxaWYy8N5KKmBIYr4eXWmdCr5IUv
 4HsYTrNo1Tx7bDH04sfmhHiXxDpwdR5kjuWexjioIGfPKVsju98eeYPPJy1R6MG0pnsXFTTm3AW
 1UCYQhk+nmIQ2hQ==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based kernel configuration guards.

Link: https://lore.kernel.org/all/20240716180010.126987-1-rgallaispou@gmail.com
Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/ata/ahci_st.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index 6b9b4a1dfa15bb6f395cc742f25251376b869a21..4336c8a6e20871fe25b61d6e2043fa15902b3559 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -176,7 +176,6 @@ static int st_ahci_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int st_ahci_suspend(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
@@ -221,9 +220,8 @@ static int st_ahci_resume(struct device *dev)
 
 	return ahci_platform_resume_host(dev);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(st_ahci_pm_ops, st_ahci_suspend, st_ahci_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(st_ahci_pm_ops, st_ahci_suspend, st_ahci_resume);
 
 static const struct of_device_id st_ahci_match[] = {
 	{ .compatible = "st,ahci", },
@@ -234,7 +232,7 @@ MODULE_DEVICE_TABLE(of, st_ahci_match);
 static struct platform_driver st_ahci_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.pm = &st_ahci_pm_ops,
+		.pm = pm_sleep_ptr(&st_ahci_pm_ops),
 		.of_match_table = st_ahci_match,
 	},
 	.probe = st_ahci_probe,

-- 
2.47.1


