Return-Path: <linux-spi+bounces-6195-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8DF9FDCBC
	for <lists+linux-spi@lfdr.de>; Sun, 29 Dec 2024 00:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB70B1882A3E
	for <lists+linux-spi@lfdr.de>; Sat, 28 Dec 2024 23:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1804819AA72;
	Sat, 28 Dec 2024 23:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIRPr5SZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEAC198A07;
	Sat, 28 Dec 2024 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735428780; cv=none; b=OQeoWyfPUVgB0jLiEtu0fIi7HhNH74kVB4LvwAKWyc6/NMPa2R2NVI37U0ntPubHjUuzxH2j0Ie+uwcEyt/ZtVNRsTyxAGPzcsqmUkfngyZEqmgkxYnwyx5+D4gMY+7Jn+Vy1HifFbYNI+Ap6CfRul8FPPXxLSk6h10abOoEbOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735428780; c=relaxed/simple;
	bh=0LBKnKFkf/CBAf2vV5CqDxilt6OKT0uPTamcOeeAqdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WhnlaFlh313hgVtbo+GJXscWvl1HC+LDUdr58GqWS5epXDBI62TFFpUV8eBGB+lCU36+QcsDsqJC1sxkxKeFHAISMvRufw5TIaSPFAd5xRgtHZi/1630PbKHMcN2zRVZ96Rs74kygqZ0LOa1P8soIpiUQ4Zwz6MWq6sayoo2UaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIRPr5SZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4368a293339so40158785e9.3;
        Sat, 28 Dec 2024 15:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735428776; x=1736033576; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKu4EPBvLsopgOFZpl7wz7qwa3Ue5APX8+1kt9ZJzXY=;
        b=hIRPr5SZJECh5H2mCWGhxYTlsRQ3WMhzG4z9VHImVjFeQ5pLtXmz1kqMQ/dm/tRxIG
         2oeumPtmIUpaEhe9OX2Jnky1+iKdmiS4WhAL4aL3qqDDAmBrRS8HZNizBSUX/ajDFb2D
         5zu+1ZSGPRgjwPqQLe0GULYbE4nkt6b4fdOGFjWfJNx1Fxlu8XQa/O7G9j3AJ4S10dUl
         r9Dqh6jN14cWJTGULvpP7LA2z79EfPMpdw4CfGucHYLWLXHczgMfgANYBJOtGPJxUoPR
         srs+PaQEDHGvj6tiWn/nXtVIybVLT+56GdeCYBfdBbtnAEGdMnX/QXyhD1tFYzN+n+fA
         ZmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735428776; x=1736033576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKu4EPBvLsopgOFZpl7wz7qwa3Ue5APX8+1kt9ZJzXY=;
        b=nCjWsgQawf1cf0xM5uV0Ef2z2r2W8uYetZxJBrUAogbnnndUrjsOElro1EX4iZYBJ4
         2sXQtpNt9gCTvAF9VJcFXnMwFOcUfJx/ru2askpN57HJG4lzW9imUqsbaXwdGBeO0vlh
         WzGBu1TB0044G8GLhYpQ5z4bvHWcsb9PMs7YN8T2jMYcW4Ef/Ud/oeWSo3MrPO6nXy6l
         0/OwjgX7LTaTT7+VvilrwDlOB2YvF/GupNw2xTybfjTIB1RvZislDcNP4pJq6yWx5Dek
         n0MPQBIPznOLCPV7oDZXwR4kuALBtK9belYbyXkH50hWqPIKDATqRGbwVZERVEZQTjor
         wneg==
X-Forwarded-Encrypted: i=1; AJvYcCUYbLicokbTBZ6lHOHFLW/vmaV7s4czugK5DTeQP3H0OvD3k6p9UUNeBniCGVhp326/leWKNgqU@vger.kernel.org, AJvYcCUi8aW0r9eIEiDsJ3vtQvePhVL7ehF43wCo8WgBF8LXN2Dbn9wG54nQ4QE5hmlFx0w2STkNZZf68zm7@vger.kernel.org, AJvYcCVBZGJat8+okSRt6xhagY/YlVCJDcWe1/KjVI+VLSNGvzbah0Bxp1wyGANBKFR/pszV5vW8rAcsXvFj@vger.kernel.org, AJvYcCWDpZ9nncLx68dVzVIsBYLsAtt5VOoT9y9g0vot6aU5Iyw3wInLzmOM3KppwfaNvdyx1hXGEBhb+dFx3s6o@vger.kernel.org, AJvYcCX3O37RdN3yulDvhYLAQe7KR1AGhsCiFqRGca/fo02GXaf4QBDXjjZUIPvZF/3KOs5kwaNy2DYW60+V@vger.kernel.org, AJvYcCXzxAmTGubB47IsJH6PFnK/00WrYfxHo6Eff6/01lSGToybFQe2IzeWf7ochpyNQUTthPFtdgrfuRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaoMzIfiFL3v5qqna+ksNb+abkF4oA80Wrt/YWEle2KTOqe4qK
	soMvBfYr5BovbrUAJmWRwHVuIarYNDqHN+/pkxF58XWV7uJs6dUu
X-Gm-Gg: ASbGncvSE4/9TbznlwSsEwqROYRrXopLvUhllOkqtQLtnH6XURkGokqOQjNL9mkPUtt
	K0dPGVQCi3l5a94XoGiN8LA701JIKKNcOyThSK4odHd7sK7cTPrQSNKEZfHB7JXQD126lb0QTtk
	GHawfpDyhlxIR0s/JpO65uOubNlIjwQAHwfBrH4jHA8fD1sI4XLXQG+F9mI3C9IR+3bWtZgSRhT
	LH33dR4QjmQzu7qfv1t/2rNqNoCom62G33KYoHmiR1Mxprm4ShZeql1cA==
X-Google-Smtp-Source: AGHT+IEFMVt9avPwZbEkQECNlih0Tj5apwRe3kcAhJ6WkS9XD2NmI7QYDZOlN1PK+TzmG7eJVzqslw==
X-Received: by 2002:a7b:cb14:0:b0:436:90d4:5f3e with SMTP id 5b1f17b1804b1-43690d46037mr104959305e9.6.1735428776211;
        Sat, 28 Dec 2024 15:32:56 -0800 (PST)
Received: from localhost ([2a01:e0a:d9a:4c20:d6da:7147:f20e:31de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a08sm312165205e9.25.2024.12.28.15.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 15:32:56 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Sun, 29 Dec 2024 00:32:41 +0100
Subject: [PATCH 2/6] mmc: sdhci-st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241229-update_pm_macro-v1-2-c7d4c4856336@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=0LBKnKFkf/CBAf2vV5CqDxilt6OKT0uPTamcOeeAqdk=;
 b=owEBbQKS/ZANAwAIAechimjUEsK1AcsmYgBncIqkV+oVyk//zTE8gZslpR+kKKOstF8wTCVuV
 TKvMYBC/MeJAjMEAAEIAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCZ3CKpAAKCRDnIYpo1BLC
 tavPD/4vrOzvBtiiJvKt9sC4OUwOCDInW95G7gdKLGetgoMPL841oWQyr9G/28XQniPi4LdT6m7
 v0phn8UdBtytA77ajXuapY2/8ME5HKafYbBvhAVJsbGqHwDq4uTWZDV38h40Ll7odOwUniCSWHm
 Bt03pyV6HdwF64lkyn0pGoDN579sNaOHWW1uzn07Yo4mE+bV/Aa96/I87xWaMtiglRUNBuDWMeK
 SHLmnTlNcvlBc3MjUhsPmtAeTnd9Hevaw5MHK5Kq2jyg4Ixm5eLx9Afar0rxLpPZiO7U89upIRG
 UZLL89qGSMcgBh4TXwESAAnZ48AiwQ1nCxhXne5Nug+Y+XVvpA1qIZa3qvecraz8aTQ0W6lqPEm
 yZ+U7m770MJmH9PWsNGpGQkbpV/m0m/mpqZwmonu9Lqdr1qz/4pewLG3+ZT1658XgOqwnj+cls8
 ZqtnvNYqKMurs9OupShrezeNUioevn5bHYv8QlHIqU8KvmJhhd6ybeqchpUPz/n/kuMIyh3YHJ8
 mToQrF1qUoCjt8RAZfqivZo5GVNIK0Bw8t677CoM5UhnFNbPZmQ934JFNbbdJCbYtwj0XfrIhBD
 MAzzXA+NSAoqzC4S+u2/GKJYki+n9kBcqr5N2nbH46jPNqxOsf+vz1K+b+BDhfuedcCzn0ES8mQ
 K9j1SwhQL4jmseA==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based kernel configuration guards.

Link: https://lore.kernel.org/all/20240716180010.126987-1-rgallaispou@gmail.com
Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/mmc/host/sdhci-st.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 4973e08a98f87380325566a6b18878dd45e1dc30..901e431976ced68d5b6e374c2dec93c9fa821d38 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -447,7 +447,6 @@ static void sdhci_st_remove(struct platform_device *pdev)
 	reset_control_assert(rstc);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sdhci_st_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -494,9 +493,8 @@ static int sdhci_st_resume(struct device *dev)
 
 	return sdhci_resume_host(host);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(sdhci_st_pmops, sdhci_st_suspend, sdhci_st_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(sdhci_st_pmops, sdhci_st_suspend, sdhci_st_resume);
 
 static const struct of_device_id st_sdhci_match[] = {
 	{ .compatible = "st,sdhci" },
@@ -511,7 +509,7 @@ static struct platform_driver sdhci_st_driver = {
 	.driver = {
 		   .name = "sdhci-st",
 		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		   .pm = &sdhci_st_pmops,
+		   .pm = pm_sleep_ptr(&sdhci_st_pmops),
 		   .of_match_table = st_sdhci_match,
 		  },
 };

-- 
2.47.1


