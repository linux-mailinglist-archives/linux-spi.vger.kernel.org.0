Return-Path: <linux-spi+bounces-9427-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A51B26C32
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264FEAC18DC
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 16:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03481302762;
	Thu, 14 Aug 2025 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ScnZ+PFe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF9301460
	for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187636; cv=none; b=BQ/aWnr6BuJnfAQWyKj60CpjcH1F+mCisxKthhh4IMzxR71uR2/l1yl+qLXsqxJP5HwpD/hem7G/RYjEnKpfxl3zmDEtIw1AM+83Ai1ihVmGbB8jjAKSxBo93N6vtGzzmdChPwYEjr6E7CIR0RDEV0NpCk3Sz1XO+72jn+T/T1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187636; c=relaxed/simple;
	bh=SFon36ABMtRsmD5ilgjDyUKNSBjeuJpo2bI25Qgo1Ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7vQwVohM9WtDV7688oM1PeGDppxNo+C2Wr+i9668AWdXPKuMxDdpiEObjSw8+tQTs3WQR5XoTIwOvFxUuZl9DVGBXRjY7GXiDvcCQksM/Vck5GgUuIM+Bhw4DQFibcI7WZW8FmzG/3b0xYwASUmA/s3ru/PRGXxG+23GVtCc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ScnZ+PFe; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9dc56ff66so599225f8f.1
        for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187633; x=1755792433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VfumknsBYh2IzrO2lYrQcKgYbnTHwmFJ/9yneF90CH0=;
        b=ScnZ+PFej4bEDz5jrt5paBeDqTfU3Kyjynh1fiNoccfwnZzrqyiE8IjfzCyyMoNft0
         Yh9UbkvqwrFgNDmuh4cul4+F66PZjwNxuj+pn6hSrNuTB3fyIBGUQew7XQwqJrSgij2y
         SxQE1tdRrp9cjPqYanTgxn+AhAZZcwSohXmQrJT0DbuWaFv2qsbcta2joamRhdzSnA3L
         xGOaiJ1cqoGFVhaYI0FTl7w9z1R1incFngchKy9hIHU63xC8pGwg8aSOsU01ai4v+TG2
         8V3rMHP1PA9IzpGKSNIEwKFR/X8jdVlpMvGtViAM43omFIeNLjOzw9JlOBfbfMBsE8no
         B1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187633; x=1755792433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfumknsBYh2IzrO2lYrQcKgYbnTHwmFJ/9yneF90CH0=;
        b=t2v2ZwyC5UYsZoBn9VIcg2uOtIb4ZEHoSQ/49uat/MSxuKNbpxOBZglZshir0zX/Ly
         G49hjUU27pFKRWXd7tCFOHJTxB+1UMXmrCYKC+wjl7fT87h/JZUbvfvoec0m2/3yOwrW
         hCemLGKviSRpogjSQ33jaRp1WabEpeDvo0JFyxbuWFTXkamzXY2604e5smMWz9UvBLS5
         YBDp1FZwy4f6TBC9yiA61XDvpnosIFhx7RuhVItHGCK8ScFOvsMFqPTg1cTpsiCmJ8UY
         LskN84b0R+EIi8GO526HAOzY6jscDwlTxoAtDV/9ic+5Y958u4mSXoWE3CV9ToNg21Ez
         PoyA==
X-Forwarded-Encrypted: i=1; AJvYcCXLi0GzDjnJfZvgGs+xutjsTIqmGssN4g05xDeSkMrxoRHDH9QI+YlTauuuQ3NtJn0x0ywFVDNFTRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYVUKDlpGtCg8d0SEYT65dwxXV5vqdvtirbBrPIMP43mrm7MK7
	fGBV4QSKW3InbtS1De0h2IEgTsqUVe0/6fhA56MOu8k/fuCCsOH3/Z5s00dxVjve9eg=
X-Gm-Gg: ASbGncu/CbXaWp2R35GJtf+pw5hBU0WsgQGVFF3TdCbkLhj6g4T062U9LjNuI8f8J8b
	+D1Jt6Mdcg2Yb2zEUMllH99uIhzmC88nmhnxkaTTLmPSGNUYc0qjU/NmfOsNo/UW2jhwzmQ6UjH
	BRySPtMNnZ0zlHPgG75ZpaejMkmd1bXEw8X5j2lzO/TeSCwVyzyGgKlceNV7Vk1uTd0Ht0+1mbs
	ogfi8AsurCh5Y2eGgSqkEMD8jmzMtpL4FL9/lPSNbd00H3QUCy2VJvDrcuQzGyYEhkL4SgRSC4y
	/5OfU2/uwb8PuC6dmU1/NEfnuIZjCrmcmemv10uNU0mAZ551Fg46ltR+HsiIJLHNmEVJplWFeFL
	PwuIZWf9S5yX8un8OKMiJQVf4VBdR2mctjfFSXGp0MA==
X-Google-Smtp-Source: AGHT+IGmcHiTNvo2snzvvx3pgNCl27xtRPoj1Whp77k0Jwwx8FV68OpPTATGMjohvUNhCC5M4Zx3aA==
X-Received: by 2002:a05:6000:24c2:b0:3b7:974d:537b with SMTP id ffacd0b85a97d-3b9fc3597c2mr3324954f8f.35.1755187633092;
        Thu, 14 Aug 2025 09:07:13 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:12 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:50 +0100
Subject: [PATCH 10/13] spi: spi-fsl-lpspi: Add compatible for S32G
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-10-9586d7815d14@linaro.org>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
In-Reply-To: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Fugang Duan <B38611@freescale.com>, 
 Gao Pan <pandy.gao@nxp.com>, Fugang Duan <fugang.duan@nxp.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
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

S32G doesn't have the max prescale erratum and it can query the max
number of CS from hardware, so add those settings.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 6d0138b27785..a4727ca37d90 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -159,9 +159,15 @@ static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
 	.query_hw_for_num_cs = false,
 };
 
+static struct fsl_lpspi_devtype_data s32g_lpspi_devtype_data = {
+	.prescale_err = false,
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


