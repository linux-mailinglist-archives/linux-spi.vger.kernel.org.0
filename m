Return-Path: <linux-spi+bounces-10854-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CF4C0E096
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 14:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C1D334DBAF
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 13:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D6F24BBEC;
	Mon, 27 Oct 2025 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="XFwbodya"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A4A1F09BF
	for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571821; cv=none; b=jrvBMVobOUEKFdxDRjfui6XFbObGJhjhsEkAS1AKlU8dkA4yx1+NgaYvmt1Qa9sTAHKByIrjIIuxnH1VSyjIiI2WIDDWdol2Udpzol/PR3jvPxz/IynYv+akdptgn/0ToEL1SX2ADPmKkBFrwbe71qh+p16E65irbVbIfPN+sbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571821; c=relaxed/simple;
	bh=h91Mh4hoPgByHdcKd6/RneQUViXMJHcN0u0JxmaBjQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiEs/LncyJIzaeULy0Os/VEkcOG/TCuhizEr8nUhKoJGrIvFmV8NHjMDCZ4crqGJyJfJVHGbSHFcBZKf8BKwr14+fZodpVDE+Y26Ft6ZSvn+pahw2zGtevhzOprFyRXEpj9Jk5/lCSS7TKr4u4uzT8Jl4jqAQMJ65ni57kAKa2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=XFwbodya; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-430ca4647c7so20109775ab.3
        for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761571818; x=1762176618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXEnNR948aKFzOMEVavf8q+kCpka+pPq8yUEtfNzTFc=;
        b=XFwbodya7ASLTFrUJZnH3e1+gvWRhoQYr9B1ytUZYVTRuhQ0fQ8Af/Kgkf4IoxcjTI
         IDzoVpEMe2y3pL0bpfCA+b+BZMGcDVOGC3n3pzNob865kA95FqDEMfZvLWmNTDUQFNmR
         BalfJVwRT2Hrx+atarXkRwsQO3Lz/dig9tKQt2mAL0RLQ0MsKo0I5T/mKqgIZiD0kfj7
         LTaz1U0Hb/oMjZ+KzcDNBMvUDbPWdpjHybLnemSExi0Bvn2PlYK/ghNmCe27+7gLAiIL
         LhN9JgyPh89uYKcNMyaxk0VoGIl4H6FJsughZjRHhitwC2Cs16715B7Kh8+AZ6X07kSA
         CEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571818; x=1762176618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXEnNR948aKFzOMEVavf8q+kCpka+pPq8yUEtfNzTFc=;
        b=OJ6CmRC3OHy1vVrTUCVP1r9SlnKcdZmHTmx53X/CPBE+rgW3YS9NNR2ebdVXejZmEq
         bjFiv328KS6HC7uQrIN98PV/Y2xenkBkdzSOoRdUJM3aoPFojtb3X0KCOcQkqK+7eOFB
         s2zRtXTk9CmlrE1A1Uo+I2AYHdHzKYi9wXf2r4O3Q4o4SUg6HpbViIhmNMX/3y+SRw1i
         V/s2JnruiiwrNHD/xsscIwaeW952GegTKhDmMuIJrWNN+Gpj0MW+Hb54AvKlmjUCXGmN
         oz/DcFP+XjaoWNVU2pZLMVMEuJ9e37KH8IwwvFLF3C4XkU0OPb+FU/Wh66csjbi7kepy
         aULQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoJ/DmcTULrL0seMmq2oXEDO9kjgTZBQrDj4b5Ab/y2uo3TikGgK1EErsmK0mbWo0U8WZUFfsmYNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC0ssWY8Pz9aadoAV/eWaP+9oURFBQmiYehFTJR8r+5J7tcjoW
	VfDl6k2FvphgpN1Zq9GAPkrjOqusftwFtUoSPoNuJAEx5JjKHmDl3lj9Os61aiAa0Ew=
X-Gm-Gg: ASbGncs37Pac/tQ1xUFeFZ5AGGt7k5snjUKwHacH2YxF6Dn2PEvo91MO8c9Lgz1UeW0
	KPpG2ygJYE3dkYQjgS9JnKu/MmTRYpvKZckJ3ih5pgES8EI8sJ9BxvhlPfVB9WqWBT/i7hAF4Q9
	+Di+Zs5h6FMMdGlu/tycn/KhmGk9xJ7f6oIw45FeRcp7N3/7ZUqR3vPzNesrhaGglSSmq9BegZu
	3/KuZ1Bxyero1STr8+UGMNEFNj/G8vSKnkvrPPHJdF1kqUVtkTAuGlsM9Dj59MtdF6S5UW7Ev6l
	2Og939EqQE85ERIZYQ4xlmUgK/elTS+YYPOqGXawGPjpLV245vVIJV49GD9Sa1C2F4fH38vRDzH
	6XC9MQU21e36RLAMfKsEpWBol2shLKmqenOEp7ddB0dfDtD17/c8SWssn8msNzCTD9gNGi1WkLA
	G7wtJiniIeXXYat9399o1PIN/GwEhliA9AkwJnafBZxU0=
X-Google-Smtp-Source: AGHT+IH0glKysst9aA3Dl1hO2CkWup00aLcqDqNV6Kijix8yVXf6s0ExlLzii7wtaTpwbQLaOSZlgw==
X-Received: by 2002:a05:6e02:2689:b0:430:aea6:833f with SMTP id e9e14a558f8ab-4320f6c7f59mr1567415ab.8.1761571818580;
        Mon, 27 Oct 2025 06:30:18 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e2fd4sm3093057173.26.2025.10.27.06.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:18 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org,
	p.zabel@pengutronix.de
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 3/9] spi: fsl-qspi: add optional reset support
Date: Mon, 27 Oct 2025 08:30:01 -0500
Message-ID: <20251027133008.360237-4-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027133008.360237-1-elder@riscstar.com>
References: <20251027133008.360237-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for one or more optional exclusive resets.  These simply need
to be deasserted at probe time, and can remain that way for the life of the
device.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/spi/spi-fsl-qspi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index c887abb028d77..1e27647dd2a09 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -36,6 +36,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
+#include <linux/reset.h>
 #include <linux/sizes.h>
 
 #include <linux/spi/spi.h>
@@ -267,6 +268,7 @@ struct fsl_qspi {
 	const struct fsl_qspi_devtype_data *devtype_data;
 	struct mutex lock;
 	struct completion c;
+	struct reset_control *resets;
 	struct clk *clk, *clk_en;
 	struct pm_qos_request pm_qos_req;
 	struct device *dev;
@@ -857,6 +859,8 @@ static void fsl_qspi_cleanup(void *data)
 {
 	struct fsl_qspi *q = data;
 
+	reset_control_assert(q->resets);
+
 	fsl_qspi_clk_disable_unprep(q);
 
 	mutex_destroy(&q->lock);
@@ -902,6 +906,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	if (!q->ahb_addr)
 		return -ENOMEM;
 
+	q->resets = devm_reset_control_array_get_optional_exclusive(dev);
+	if (IS_ERR(q->resets))
+		return PTR_ERR(q->resets);
+
 	/* find the clocks */
 	q->clk_en = devm_clk_get(dev, "qspi_en");
 	if (IS_ERR(q->clk_en))
@@ -923,6 +931,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = reset_control_deassert(q->resets);
+	if (ret)
+		return ret;
+
 	/* find the irq */
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-- 
2.48.1


