Return-Path: <linux-spi+bounces-7055-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2175DA546D9
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 10:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4867A5A9A
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A8420AF9B;
	Thu,  6 Mar 2025 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xeP4T/se"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218D20ADD5
	for <linux-spi@vger.kernel.org>; Thu,  6 Mar 2025 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254522; cv=none; b=V4XN7NTe6ikxPtaJzIotsipzEoIYWBSKEGdCTnuEQuNZq4OCZYjMn3xoqviQTiwUwdqoneYRvgetA066FuwfwUxvZkcms7F2AOSo77Xo+bSqVRk9/d8So+rqo12Y8SYN4RthrLlrBBomfTWN9v3jUU7QXhLBgcR2SQY9i8UMApc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254522; c=relaxed/simple;
	bh=RJEAUzoNnPjXojDrx1lfGnTyV5utsglqX5RvWoQNM3o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ji07XQ0dgb6/5TdkvRw+/CwS86rrdLYizyS7+auHf6np9YcVpJiCaQY2CGz9uWky41x1a90DTpCoLXbQxalx0u2q4DRrVMkcUwDlZ7aMsQi/KI9twF6zqNQ6B3ic9mtUSDhsgWcJgiPIyGRXXmhi/UqiDwUhOXMMEQ7oweA9/E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xeP4T/se; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3910e101d0fso248434f8f.2
        for <linux-spi@vger.kernel.org>; Thu, 06 Mar 2025 01:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741254518; x=1741859318; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYb6T/3vLosF9o5q+Y5UiX2/6xC2fpf9CrlM4eItM9w=;
        b=xeP4T/se9LH8ndz4Z61G3FKvdCQlcnEL7DSi6csfa3TbdnIlLsFbivnOiwI1Du52kx
         cwfkJNoXXCMgUIMq933n/oyyXy4rgdFz1TGw+s2SsEbe0aUc8QhlUl2kTOF8V5N6lqfd
         96TSlKT3SbAGge8aINCkOHiekbL4M+Q1BJcoqclUmJEUya1DnT8wrPp8R36aurMHnWkT
         zgtps8ModMJYBrO4Qzabx8Z39Z7KocHwtDoikxTZH2lV+4pwCWRP5k5wqyqHyzuQEdj1
         8zdZeThdz4AdE+0qfmgpqpSFdofGm9EZTZ1DcNyAHe4H46CPrFMa06AWTZQndp8ndWM6
         bPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254518; x=1741859318;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYb6T/3vLosF9o5q+Y5UiX2/6xC2fpf9CrlM4eItM9w=;
        b=hqg1NV15KaKO9xAYrJlxXP+laH3bEPIdxS6igR/tbJZ8xrNNgmVpxnvkfwAmftTUbE
         g/i1YCmO5rFaP6DfCj4mJerustRC3W0OhG1wLOmgnxwXvdXKnglRwGh6qElPsOp2d1vR
         hyaFpCyVJVc3wrEFCU5XeooOFvdGJnHDDpP4O3qJGNm53jcRKxGKhCr+ZmHVRIjBBftv
         5oBAC1uOhBzDI618qtwMZXQG9No9e9DRMu0KuaPcJwQ+yrJ/gpMoNhcc6SEO5ud/PknT
         e+scAwhoinb0htY+I+XBhiN/nLjTUSKvVRbLikivXetH+2z3K2UMV9554CBvZeldjr0O
         uTzg==
X-Forwarded-Encrypted: i=1; AJvYcCUikBApFJtHApPLlhs7ZcVirTCrwLyQLn2qrKfj3bPm6NlUMh003OvtAm0pLVAZ7DyOu9CEjybnUDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2sH06OC44m9L+wt2G6a5SutVY/KhcoI1GUF+EXykl+X5C25b
	3OpvHFRaKUpDNwMRSSmfOnBqITdMwa6GR4mKDLfOcvb84dR5OJjykqyBINLhipSfwUAR01IhPzM
	y
X-Gm-Gg: ASbGncvaXc0e7CbYkz4Oz7ifd653dcaM18JHHNUaVswyQveRk+Atlnq/xxBikkk/ThU
	4hY5eJWTJLp7DwP8qYSJIlAkYFDtl2SLrUq7ng+DJ8lxXzjQhpuaUZcWSrNRx5FFBwTjn1utSbw
	Ee89yRRTPvYgfOV5gMh54GL+pGe2iHxjiBy9qJCGKamSRHKMpnHkQoS4YyeFluC0OTtBrGl9jVa
	rVydgrzQ5bvWKcNb6acg+MO+3bLFG985TtDmPbnhw3FkhpcHD3YCYpcg+5W/q1WzdnqUqtBaOOf
	Z3VN7OPSK6F2gKXy2uK3WMTMrve4nYkjpbmF2ARBBBQZRLFEig==
X-Google-Smtp-Source: AGHT+IFBd/ryvsqo4SuH5AoV+P7wyT4wM81i1izptWSUavGGlpTSK4T7eUmgeLPy3GMlZioDo8QvWA==
X-Received: by 2002:a05:6000:10d:b0:391:225:9521 with SMTP id ffacd0b85a97d-3911f7bd8b2mr4846113f8f.38.1741254518181;
        Thu, 06 Mar 2025 01:48:38 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfba66esm1527318f8f.18.2025.03.06.01.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:48:37 -0800 (PST)
Date: Thu, 6 Mar 2025 12:48:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] spi: stm32-ospi: Fix an IS_ERR() vs NULL bug in
 stm32_ospi_get_resources()
Message-ID: <bc4c9123-df43-4616-962f-765801d30b4c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_ioremap() function returns NULL on error, it doesn't return
error pointers.  Fix the check to match.

Fixes: 79b8a705e26c ("spi: stm32: Add OSPI driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-stm32-ospi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 8eadcb64f34a..a544d7897edf 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -835,10 +835,10 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
 	if (rmem) {
 		ospi->mm_size = rmem->size;
 		ospi->mm_base = devm_ioremap(dev, rmem->base, rmem->size);
-		if (IS_ERR(ospi->mm_base)) {
+		if (!ospi->mm_base) {
 			dev_err(dev, "unable to map memory region: %pa+%pa\n",
 				&rmem->base, &rmem->size);
-			ret = PTR_ERR(ospi->mm_base);
+			ret = -ENOMEM;
 			goto err_dma;
 		}
 
-- 
2.47.2


