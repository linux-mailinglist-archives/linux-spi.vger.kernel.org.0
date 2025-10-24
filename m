Return-Path: <linux-spi+bounces-10831-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD65C07DDA
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 21:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDE13B9849
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 19:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F9230B511;
	Fri, 24 Oct 2025 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="XpNiWDaY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5877E36A61B
	for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333361; cv=none; b=s3oti6d+sOH78kthJDTQFMSBphrqeO3F8/tHHu1j/WCKAT2gJniirJANYQSCWyFN3o51DkipPvInh6mXV8uOAcq+DmbsPyxk5Rag3E5T0AR5HwjluoL7lnQWU7+3Bq46kxq6oKQzkKR8hhVfecj3k/wuyXp9Hb/zazwk3+OgmI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333361; c=relaxed/simple;
	bh=h91Mh4hoPgByHdcKd6/RneQUViXMJHcN0u0JxmaBjQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obB3SHdltiUd/QbK/q4t3lUpfyswKkYo5HyvEJZOMBCJ0Nk1QKvDKhfibmjk+2w0iiPxc7hLmL/Paml0sm+z9FdygoRtLUyBy8Wn6SjlCJ+W26dReNAvDsTNc67KewMbFQPRUlubsXelOSWFhpT5J0RJLn4dO/6gk0vXTi8UwL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=XpNiWDaY; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-9379a062ca8so102700939f.2
        for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 12:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761333358; x=1761938158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXEnNR948aKFzOMEVavf8q+kCpka+pPq8yUEtfNzTFc=;
        b=XpNiWDaYdXhBpbLYVgyZi+XkvNFkLhEmE8vp+ILBHEEuP079SIOxJSQnElBsFgYgLu
         U47BPAle3pLtchrhvjS6xijXG3FKCHPTstc/svM4GewBgf8bcAbbtX+D7bjtqZc1YerI
         DHcz8m/8UkYsNZdLNA0/vfn4zskuHvbmX1YN+xh08UdC22o84OdXnxx6XV7VDLonhH3W
         6fj+vVlkPq9tjXFrGULzCRuRX4iWoxq33Ovt8nnbgpFtclD/ktH4tjARCjc38CcnfpV/
         gWKlDgvR/VVLmLWzt7A7S2B2EYZsAV1i+v9vkqjOiPw4aQaTcjQEp3RqihzFRZEbBaj8
         sQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333358; x=1761938158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXEnNR948aKFzOMEVavf8q+kCpka+pPq8yUEtfNzTFc=;
        b=Oq5T3Ml+bbLxi0Dn0dsUb6ybXZ7e4rw2kZObptKEqgQhnvQagn1deaTb1a0zmmQLGg
         qB0xlvryKpieB3s77REKnw4JSGLvxILry6n8eHKP17NtAa8hpzs3BK5a/BJbVkIZosXV
         TjKdtVuj+th0CRSzKodSgbHlXCzY0AYRbKGkkoJHGqVLFrE664SBsSG5EybSVJnb+WuW
         DaYFZ1npmIi6RDjI/KJ94OuRtmTpujdtRLAqTM4elXUx5PLSXyZKivmSsOtcFAxneEvs
         n2ggBI7XWlfuD/anFEDMqLV+VB6dDXPa0bouh/pQZoOgebKARzkG53OwExV8YUwJCD3v
         sVgg==
X-Forwarded-Encrypted: i=1; AJvYcCXoWQYG0VArKy4ZPXwwsHjsrwfDqNn6MtMvPkewd9AkyJ+OmTssW0aq7l92S2fAogOdMmy56KaZfmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbSsj0aolc3SV4gwUINU8/yuhvoepA9rNX2Mwko0yQtRLp8Ni4
	E+MWw3sSegaHPMpKGlaDMbAm2ChmiDGcKAvcJGER+aA710+2BGnks72YOnUImhS4QII=
X-Gm-Gg: ASbGncvcs7nbwlZlP7PaKLm4cjj2OL+oKQ59JNXMcsA9OixJGq0G2hKZ7X8Jp8nwMLC
	xIeDMM3K+Q+8GyBdWWcn33KL5CJ3Lze3UURUBSOOx3ms08szMq8smRLePCqfAxTKIprD6EdqQWZ
	yfkoV3aIxxcFafJfarruLZdWhq+/ZGY85Mi0Uy+SJEgHPit7PS+IDY6JAKvWADly+LPewEYTIuI
	lNA3pDInJkkcL9NUQlt2ycYyutTgEVIlUHFYingcVoomKj2hFufq3M7m8I9tv9UGTJmc0zR09dd
	Tr95AaN98O2sEiWWF08t3NKa9U4limlunZK+yH1M+kkGNPNAH1kYZGxPcqD4ZJF2rM+Q8cBPupQ
	+w+LZqty0lgwMpiVMI0h/KR+0G//XILsN9+gb3bphVC7w9PhpEeFc//sq4TJ4y9l73wnxHxAJqx
	c/GEMiMAE76p3twfs2wq/2gGR51JsJsX5OZToczIdnkKw=
X-Google-Smtp-Source: AGHT+IEtD+Cr8mACF/K0NonNKa9lBHI7Tp+o5Vfp1juGLlBk90z7fTUTAMVH9dichKlDp3Ypt60Lnw==
X-Received: by 2002:a05:6e02:148d:b0:42d:bb9d:5358 with SMTP id e9e14a558f8ab-430c527f7a5mr415578465ab.27.1761333358489;
        Fri, 24 Oct 2025 12:15:58 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fdb7c7sm2427824173.44.2025.10.24.12.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:15:58 -0700 (PDT)
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
	Frank.Li@nxp.com
Subject: [PATCH v3 3/9] spi: fsl-qspi: add optional reset support
Date: Fri, 24 Oct 2025 14:15:43 -0500
Message-ID: <20251024191550.194946-4-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251024191550.194946-1-elder@riscstar.com>
References: <20251024191550.194946-1-elder@riscstar.com>
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


