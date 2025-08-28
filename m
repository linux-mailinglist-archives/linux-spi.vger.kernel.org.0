Return-Path: <linux-spi+bounces-9693-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A68B39961
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 12:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F18A165167
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 10:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A5030C365;
	Thu, 28 Aug 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYxTGnJd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108E30BB96
	for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376137; cv=none; b=s2OcDB6n9UPqJdxikKRnOVXUkk+HcYHAdj4VYYroIZG9IWPMfhCvgy3UqgwmN1A4RRJvr6Zn1YUBRZWB3PUJluV2Yk+02S5kV9I/ySzwWOm00OmLjXl19JcIPUZh1YjYwf83jH+UdlkYApv2HQLX75+lVEsmQAZJYMZQ81ge0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376137; c=relaxed/simple;
	bh=wV99yE6O3aUV6aiHyiCHUEH5emPMYemriCvZoRjSOR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0cUDWsT/CqyK8fczdlAKVoBHwslI7utJMaA8i+KANes/69S5pMdRVWoN+CBLNiyXCDj53tUjc1TGauLB/LUDuBphY2YeFPnHDhU+Lady4J6tLdknVfdNpQBH4m0vixaHFReoccSU+lu5tEMqEsa36W6s17H4PdZamJ0SmNynLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FYxTGnJd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso4473085e9.2
        for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 03:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756376134; x=1756980934; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDhhY5HvG69Xs1o6vbgfFhudFKBTjzhr8voCZkOZ5X0=;
        b=FYxTGnJddW77i8/7E9Ca1hNJwnsidYn5dKsKuP2QOPdUzsZehKxIgemVczAYzHz051
         2svi+KDijkj0adXHGof7TK7GS5szw2c2vhKKRlOpkIGJVwr/bcKucT3Hu0wt5O1cnr6r
         Bx+i9vsmLR+KA2k+/FNAm4C90K8ckVXkigCKHrsjoSWc8vCgWGcDBWq6FEpX/VoDJHf9
         ruA5WAUR55M3SgIN6QoaD3B7s1SKdZYpwV2kU4y0E3/NsMS5LbsFPQwR0hNh3PO02LpH
         +I2+muukPGKdCd8LbQLBPzxLdxP6oKb5T6DbegV+B494WbCKZ9Yg7GS5wMhvXpXpVMw8
         CrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376134; x=1756980934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDhhY5HvG69Xs1o6vbgfFhudFKBTjzhr8voCZkOZ5X0=;
        b=PYYeH8Npn64KwryU0aPIU4liV5kWLmaX2KxwCmKDkIQzcO3DSjdXXl0hPGre7FXR6M
         vw1zNVu90lzhnMwjEXOCXdFVfUBPN4u8QqJTOoE0p6hQRguMJUFTmtv/sKC/JvN/LfqU
         MEbVKv8AGXbiNVsW6ZGS34rNIfPU2Q5Dna/E3bTPQ0GMagP9h43o46q6TaZLKXE0T6DA
         YP2LAsnNC+WmzPCIFFR5KKrfBg9//ynOSUfaG+E73s437QN6fF7dFNpyEuo9jYdjVstv
         1vsYv6gFBNuzBRsVaX1fn7UWcJP8DtfP7Y/UoU/q3++WOx17aV/wGUXircArkAMt02X5
         pUOg==
X-Forwarded-Encrypted: i=1; AJvYcCU/Ceysk6IY+UKGOILHScYKscaLVjbW17qYrSzprevB7xDhNDD7317UK33kWOJ3DM4dGmBSeFpQVWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvhIC9wASDmw4GfeBVOTZPoYq/kQ37292YVs+4LwXmI3LWPs3L
	Pda04L5zBRTVrkFHsKe+J+QxwYrZHd0DStgGbS37kimg1ph6XlTQlm57LuA+beWmO70=
X-Gm-Gg: ASbGnctTdGKxHFBhr+CWFkKaz+QO98LClnG+WTMq2xLYm83eKXjE5IWT9ryBJh4FEpC
	hDVv85L7KCpNRU3BEuprAlezaVmvt9Dd4WoXgC02rR7Sca68xlLfVhF97NZAOUzNVlrDEpWTO1K
	gLTvkXngZW1DLPUapaYUg+6YEQquJLE3gOiXKZggWb7QHwA0t+qAjO7IJXY8YK0C90O+lq4j/nX
	DSsWFqLtyuhtROyPeuM+DnYCX9T3taDHWSOgOni0C5SxFl8OXZiKnQCI9Z8A7oAUqZrzaabjU/N
	1RLNKEaTGSe81nqup/eltH54HgO5ReF1X84sh00UhqAnRP495c0je5YPHOU1wfpg3JH6hXLdfr7
	GHw7IMBKIrJr36ojM2fMA68XeSWDtqTK227MAvFGGXg==
X-Google-Smtp-Source: AGHT+IGrzpI1g4LHphInRHv2NogHJqDObuPLPd+CQOWu2AaDbp8EhCxG65HZRkwGpUMdtcy8AaZQJA==
X-Received: by 2002:a05:600c:19c9:b0:45b:6334:3526 with SMTP id 5b1f17b1804b1-45b633dcae5mr131802235e9.31.1756376134524;
        Thu, 28 Aug 2025 03:15:34 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66f2041fsm49976305e9.5.2025.08.28.03.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:15:34 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 28 Aug 2025 11:14:45 +0100
Subject: [PATCH v2 6/9] spi: spi-fsl-lpspi: Constify devtype datas
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-james-nxp-lpspi-v2-6-6262b9aa9be4@linaro.org>
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

Add const for all devtype_data.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index fc4d49f0717e..f16449cf42bb 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -135,11 +135,11 @@ struct fsl_lpspi_data {
  * ERR051608 fixed or not:
  * https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
  */
-static struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
+static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
 	.prescale_max = 1,
 };
 
-static struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
+static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
 	.prescale_max = 7,
 };
 

-- 
2.34.1


