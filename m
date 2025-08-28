Return-Path: <linux-spi+bounces-9696-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E19B39977
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 12:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCA687B97CA
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 10:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857330DD23;
	Thu, 28 Aug 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAE90OZ3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD7030C63C
	for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376142; cv=none; b=OFbfLJAGlHwnNFEDPdzRtxWg/f7aAPJjf9fFhGNWOcUwMTtRAoYbaMWoauCVbmKlF7kEWZebT8BjJJWipGlD3sRQi0kTgHrb312MTMxhrgRLJ+1uAqb2g1clTj5xSPo4pDSLweMRpYr9A4Z/AYIL12+MNBjHhszHj9o1JLLw6AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376142; c=relaxed/simple;
	bh=+vua32+ZisCIKoZtgwxULPWaV1MKJPVYFqaHRCFc2jA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uv0h3hvq5f9qZ9B354BUW3sjSTD9Q21F0/j7a7dEYIq+3eOBBsgOLL18lYCQ5/P1HmzkV73ud3hXVkuPK9G6qFh5Is4QM8pApbh4IHTAfDgJlRMhT2RQwAe/zKm+B/4LsyyZfEuKmajQGPf3DEjvz5OVcxkhXzFfvQryZzDtzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CAE90OZ3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3cbe70a7923so663834f8f.2
        for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 03:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756376139; x=1756980939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yp6uP3SnVVC8UtclhAtZ36zVvCvjaZ1bDiL+uis450g=;
        b=CAE90OZ3Qzj/FsXu8/0AiTYsX3CWwXbGh8fdvH6Khzz0an2MHTDVVg9D2Cg1y8GO54
         LP5qRnN+Uqd5aoAO9WVroxXPsuOc4/XmdV6d5oL0nle2/8CGYMg9adhk5fb9UcsizpoH
         Tc1QAsgTDyBRdnvMIEA3hjQRH3+zemfQeUjSPxSKiY8O12wEbzuG0xiRhRiCo6PI8zFd
         BhShIKUwI/kX4QpTvYYmBaGO9+kpgqp6awbS/vgaNnnaYgzEuGFrnvB9+mjR3TBFIQeN
         zOMxRqaoKT81c37Ydh3bFFR2kbp3mWPxHlcYfnex5Z7U7A0zQq/GmsCNNyas6gWIPnTq
         59aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376139; x=1756980939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp6uP3SnVVC8UtclhAtZ36zVvCvjaZ1bDiL+uis450g=;
        b=sMuK5jG1DykTLUtgxMP84LCLoNIdDi9rXpZkJs0PtTmzI2YNhnbtu9JRf8kkiFHVN0
         o1I9KxgbQjmkmz3zIQzqYSPKA4uCstDA3aLPAAcmNHA5iKcbQhIuYPjOLs1f1JxQomis
         MHV2gBDuxLFoPxikSM1UsVcWUgXZpcMZhCcn9OSeE8MYC3FkoN6uxgR0WkLYHPJo95jD
         xDdU6dAHK/bO6kdFVW4QKd+opZkz997t0UcGKlKAfOMAv4tZilesvw3H0EDNWO+l8knz
         tEpVoNPVZLaMOkYPmJ5c/CHQBsXeRMjUuLssJhG1qhgx6394SsbQso9D9PPRIbRtrq/d
         Lilg==
X-Forwarded-Encrypted: i=1; AJvYcCUbvxr7FeOE6hzJHO/jEMyzR06Qlz9BtDROs4gotHPcJSfJQZ84ueoGy6RN/FavG/vpxUmVcjrrAbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywez29lLIr9p9UOdwX5VoFn+h247j1lu3C9fdZQ2WVcZlvqSf4d
	QJs9skVfLaImKGZyAgA2SBCFudkWRci/4oyQc9TKoAvALc4CdkrB3qeHfi23T5gZCW8=
X-Gm-Gg: ASbGncvsLU2oxJ3V/qqrxV3Ek0S94WzdWe6WxWulUKO981cMi3H5LuTYB/4bEJBO1my
	d4sIqCUIz6tkFl5UIus0ki/o0Fg/Atk2vZW+bRoWcg8emeD9c5J1sZlo5GGbc/TOd5wa5Y0UN1K
	Oia0tOoYN4KyRwR+7x7+kjWT/4fnVE9r+hZSSMZpgvyLLReoGGqf0F7yvPoU/wZpzO6+xvfYmMd
	ECX98tYoSsznwbzEf5hgFNaTebGL4AWkSUIF88755KMYMvRoBl5eCipLYP9mg8m9Ro9rBbUBP77
	1LcqSoiGDwSx1LFmce22DdaLBSbnks9vsj8da2JhvPLJtUozW6tt1ZmrAID7AMneteGiUz57A8e
	RMOl9glNJckmYiAbrhXBRw+iCUl7rwaBRo6cqsonsow==
X-Google-Smtp-Source: AGHT+IHt/hz7pSxKUT3aLdo/Gb/ZNoVM9J+1IsQAvEnajR37wO8sFmm+lOvT+aASpbunKjjiXbYm8Q==
X-Received: by 2002:a5d:5887:0:b0:3c4:2005:fb9d with SMTP id ffacd0b85a97d-3c5dcdfd700mr17926935f8f.31.1756376138965;
        Thu, 28 Aug 2025 03:15:38 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66f2041fsm49976305e9.5.2025.08.28.03.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:15:38 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 28 Aug 2025 11:14:48 +0100
Subject: [PATCH v2 9/9] spi: spi-fsl-lpspi: Add compatible for S32G
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-james-nxp-lpspi-v2-9-6262b9aa9be4@linaro.org>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
In-Reply-To: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Larisa Grigore <larisa.grigore@oss.nxp.com>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, 
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com
Cc: James Clark <james.clark@linaro.org>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

From: Larisa Grigore <larisa.grigore@nxp.com>

S32G doesn't have the max prescale erratum (default) and it can query
the max number of CS from hardware, so add those settings.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index ce347cdbb009..431439d4cdda 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -145,9 +145,14 @@ static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
 	/* All defaults */
 };
 
+static const struct fsl_lpspi_devtype_data s32g_lpspi_devtype_data = {
+	.query_hw_for_num_cs = true,
+};
+
 static const struct of_device_id fsl_lpspi_dt_ids[] = {
 	{ .compatible = "fsl,imx7ulp-spi", .data = &imx7ulp_lpspi_devtype_data,},
 	{ .compatible = "fsl,imx93-spi", .data = &imx93_lpspi_devtype_data,},
+	{ .compatible = "nxp,s32g2-lpspi", .data = &s32g_lpspi_devtype_data,},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_lpspi_dt_ids);

-- 
2.34.1


