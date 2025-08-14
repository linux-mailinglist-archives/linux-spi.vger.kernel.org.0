Return-Path: <linux-spi+bounces-9424-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCE9B26C28
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874CCAA73D7
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 16:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E92E30100E;
	Thu, 14 Aug 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o++eq/c2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD0253B52
	for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187634; cv=none; b=V3D0/J0qKisHf9obM33VLcuhvhvRpYbyKGx6pLFgzWXhWr8IknrccGwr76K+2vRygp9jmCa2l+FAt0bHw9S+hIOeVeK9UyiGH2R/u6SSDEJSZoGntjituuyPH7YSVqJt27QGUHNTD1RaWyxI37Yl4P43Z4etrTeuWGGZzLKFFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187634; c=relaxed/simple;
	bh=x6+cgJsB3/bivyB/8CpTvAXJFzLNyeY5QyOEcAO/NHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=opwsbF46gIFh0ZZiiLb2Y3/TPx2HMZjnuopovoYLtEZqYjEsbyiHyCo29uJa5GRamr7M36XOegFvnsUaOYqbitmHtqTRseSuD57Nkys0Bx6hetndrFxs5jgDm44TQtPqG1UCGEPvOuL1Ffg58DrmnOBlKKX+U5YylDQO71oCUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o++eq/c2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b05a59fso7234285e9.1
        for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187630; x=1755792430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEY/dtRV5XlPcMpsbJUXrg5ckl8gnLAS3vBlRMh6s4M=;
        b=o++eq/c28Jh842+yI3UYFqPaH6Ns8nTnJCs0JuIhwpsl9AD0zF6Y5S5rodvefXJmq3
         dP61B3sz8/Fir1F7SQ1sQmh9+cA7JUg23oHzpuf6s51oMY+/Eznqn2T+u8Swd8RC6TuK
         Q8pU7hNv5j+gawd6Cwf+TPLJDF/VPXKzesYLd3a+HKk2tSXqAfPKjapFrW61KjlboOWF
         ++XfQYeJt2ioIBPFAzDG0NSV3FFgEWv/ghd3e70DC8M7zVkGnYNDqK5cFvhu2HN8G/6n
         eAV394D+hsKhoWRDtB6AkPOFQ8G9LEcZiZMlJougH57VRDvWaDMbWwEEs5MMkW19oTYp
         d8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187630; x=1755792430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEY/dtRV5XlPcMpsbJUXrg5ckl8gnLAS3vBlRMh6s4M=;
        b=Rf+YvUyS32bQ49rATH9GgUqVYs0q9LvB8zQiFj2ssgnB2sF2C1EHaiLcy+PA0NEQq5
         zYfE5gSrsTnTFaXi455Mq+IVHRoc4IDsMdilIVGnr8Tenx07vImAtpyOO445nZ1AgId0
         NCg9jcv27Eui+nFqCQ+nWER68zRo1DPlkDa3H+c1SsigDCpEtDsr8Dg7lpMO+wSR9k5B
         gzpm17FgGmfKSxjbJ9SOrGmKwIqjvqZVfzPKtYF4mWXYq31vodMrXVmdVv2tVbQLck29
         4QmWdupldE1BUWBhPBu7TkBLOvmgQOoj4VRsrfvukMJjrfFFLdOwtth3kmybaSTc5D6x
         e0yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN5snCWRCRQpIlNWQk45W5Gk/fisi3SsWhdrjFfmZOB+234VrB5N83Dn68IE5HYDoeIlMb6Mix358=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw70SUUsqXlMlRAnCI2x6U23enXJcE6xybBHNbuR22b1nCD5/5k
	iSwYLyZsfDiNYpJxNPp7nMOgDJVt4xTaofnny1boOZkld+VayBWZIGd4Fb8xu1FRJDI=
X-Gm-Gg: ASbGncudyq+bBezXToobqL/Ss09ImrsJMQLjOYsUb+criw2wyrPOmRZTB+NVOeAzf+7
	YLU+PEZykv3WkD41Y3xXguWx43hf95jXdS3W0JiE+kCP2Zd8j4WPx7ZIbIUMRGv0UVWXsXRcw2c
	YvjBG80eID6v/X/IYXM8GAnuTBwb4RBjL4f4B4fiockuP9Vwq4zNLKt/NFDaOrriR8BEYPyh0n1
	P1ab89VdKP7Lx8vrU1VkW3yWwrj6Y7kafE6pOBONFEvnWKgqvkguPC6QjWGZRuETvho1QFzovfj
	9PwWJynmJl4nit/e/o5qudpB+GoRnfow3OY2t08KxiZ61Ph/tRUGyRMekJqQ3r4H1l7GU1fUF/p
	PJ6AtYVf5w/Jv6LpYKMywJ3Lz7WpnbzRhBPz407kcuQ==
X-Google-Smtp-Source: AGHT+IFs/lEP4IWVBoJgkpoH19R4IKvmXIZCDViCWIe4I0U2tewRdOz/LgHXlcznz0VkzRUCVVfEsw==
X-Received: by 2002:a05:600c:19c7:b0:459:dde3:1a33 with SMTP id 5b1f17b1804b1-45a1b66e81emr29035635e9.26.1755187629543;
        Thu, 14 Aug 2025 09:07:09 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:09 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:47 +0100
Subject: [PATCH 07/13] spi: spi-fsl-lpspi: Constify devtype datas
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-7-9586d7815d14@linaro.org>
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

struct fsl_lpspi_data->devtype_data and fsl_lpspi_dt_ids that point here
are already const, so these can be too.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 98da6a5d7013..332a852b746f 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -145,11 +145,11 @@ struct fsl_lpspi_data {
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


