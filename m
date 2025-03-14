Return-Path: <linux-spi+bounces-7144-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C59A60E4B
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 11:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB9B1B609D9
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 10:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1081F3D5D;
	Fri, 14 Mar 2025 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYSZJ0Gc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B67225D6
	for <linux-spi@vger.kernel.org>; Fri, 14 Mar 2025 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947022; cv=none; b=PybQN2JM+HrAbjGA0bSFx9Hmjkxwat2FUcwBenRL64AS2UQjL+qRoJEakaq3PqRpmyV2H6LHPts74WZlqUDylYfFylDZPkaWG5repmeiy1fcKV0xklUh5j2PYc5gy6VGJ+ItggjbRvwKONugUrb1Jj6HiJ0qC6bNE/Z6nD2+O2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947022; c=relaxed/simple;
	bh=npAfM/D95DLWrhMgnpbK79dbd/8CwbndFi8Um7n00Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tVOEj7lE7FF1cU/A7lq9MVr92lIV6x38s4OP6oA/ZC34qYIOxBN/6YD6JJPEI9JIZxVk//3RwTx1Vk1bY0INh8pJRetzg+I97iAa58kyJ1nEGBwuv2BC4MxGLU4aisB3G9OpLNRm/6K4puQ4njUoRCMTQPIH9ZaY9CRtkmDf9sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IYSZJ0Gc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3912baafc58so1673029f8f.1
        for <linux-spi@vger.kernel.org>; Fri, 14 Mar 2025 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741947019; x=1742551819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHBf1AZS6BuzpUz3+oCl4k1y+Tt83Lx+NAGAApql9uw=;
        b=IYSZJ0GcC4Tt/T1mE/KQCrBINIPgH6b0TK15f9SvL+ESzUoL1DBQUBKtE3DawSce3R
         IRscePDvLL90NWvTbDJiMcCrzHNbsoiMN69NkIcfrVNNW0av2UdoxyxMrlJ+yueI3Aws
         L4n0PivRAzaMA/bI1ozolp8JFstkefxob8li+i7o4fjKcGyJ+eAQmCay6lq5joofcbKh
         Ay2xGuXglzd6ijL4wdb3fQa6O6dRJpDa3uVAbGWYFGl8l1y1kVtijREm5GJMX64cNqIg
         bXkqJfYvCrM7IcuWXd/n7QdwZd2ly6YJayLFnaZ84h4AJwXm/59NuyjWAF0VWzjrxOtc
         LqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947019; x=1742551819;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHBf1AZS6BuzpUz3+oCl4k1y+Tt83Lx+NAGAApql9uw=;
        b=FKP7vYu7KSz5Ani4r1lt1D8NvsrS79P0qzz2frdlNaadjOO7Y9CUloYh+Il4KKgcIh
         qOK6SOudfq5ov7GT0mFWE7d8Vkm0POG8Yd9aOfY/lnZYt1TEwmk2FVf62iPrAOVWZ8zW
         E35UL6Mv5Uef2zdOjCAGUW2EsANrKUb9ZtVHoTG/xtaZfZxsImhAeYJVTbEFtgK6EUt3
         SxtG1HeLqqBooFW8RJzn8E4OMxIOijOvFxKpqnGW/VFrMyKGCG8e3WdzmvnSTi7M61Uf
         wl1UILZUHqN7F4jgkI4DjfknND1Xivh9VZaQveGR7uGG1UIDbm9pkM6ZyOiCiVtk2Dhl
         xp1A==
X-Forwarded-Encrypted: i=1; AJvYcCUrk+jYrVnpPMctGayXeivKwRtdmqiJ06yvYCY2u+53UAAgbaXDEK9HQYSsDcgKJSD6jdpUHUm9o6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzX9MLERIc2jyxyg6VRdLS70B3IeeOIjodvjkOaVavd/h6kqjc
	pbDpBlNO08TT6YBEF7rSwDob1a1lqUOlmY4YHL/KT51UMAOZ/yQ5IYHBnkLxg6E=
X-Gm-Gg: ASbGncvXq7Uk3XTg5JyOj118DE/nbHQoiwGC8YfNhCHvVRt624opVEzU4+waQsGNEVt
	0BvQRk9xeeDyEXbZ6qAN+W47z0Txt5wjzKJ0Ij+5sRvkFyCK/PXwuzV3rSzNB6OdX7MUSCdTUh2
	SZKhbTMETCa4UNRfYjbAcBg4jMwC9ckfZN+HDG/K9RzylNCWGUvVPjvLxJw9ITrnTN4c5p5q3br
	n3RGDwlQC+lEZpPLW6Ptofq1O8ElmexTUhqnLtUC73A4HUHOt9FLHKL845C6pGZPCHFPxGgLiYw
	ozNJB0RE/f5MXAt+FWLssEZ1gldkihyvIYEIzE4dCk75yA8H7nQiBGsgnoDn
X-Google-Smtp-Source: AGHT+IG1sxTE6WTNjzIQp91HxiQTObGusic65wZslfKY6Ot3KoscqKikKk9/AjhiDq2kcsqvmeb41A==
X-Received: by 2002:a05:6000:2a7:b0:391:13ef:1af5 with SMTP id ffacd0b85a97d-3971fadbdb5mr2747764f8f.48.1741947019105;
        Fri, 14 Mar 2025 03:10:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb318a80sm5127616f8f.61.2025.03.14.03.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:10:18 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:10:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] spi: sg2044-nor: fix signedness bug in
 sg2044_spifmc_write()
Message-ID: <4e16e1bf-e5fb-4771-bc92-c5cba9aac473@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79c71b81-73a9-407d-be6f-481da27180bc@stanley.mountain>

The "ret" variable needs to be signed for the error handling to work.
It should be type int, since it only holds zero and negative error
codes.

Fixes: de16c322eefb ("spi: sophgo: add SG2044 SPI NOR controller driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-sg2044-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
index 454153a63b42..baa4cf677663 100644
--- a/drivers/spi/spi-sg2044-nor.c
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -216,7 +216,7 @@ static ssize_t sg2044_spifmc_write(struct sg2044_spifmc *spifmc,
 	size_t xfer_size;
 	const u8 *dout = op->data.buf.out;
 	int i, offset;
-	size_t ret;
+	int ret;
 	u32 reg;
 
 	reg = sg2044_spifmc_init_reg(spifmc);
-- 
2.47.2


