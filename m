Return-Path: <linux-spi+bounces-8923-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF241AEE794
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 21:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EB8441000
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2FE2D320B;
	Mon, 30 Jun 2025 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZm5War7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBD721B8F8
	for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312130; cv=none; b=TohTCZZvU2VQJIXSEZZtJubeoyuez5RaPgcRgsEimyGnX7xCE3dM5Rm0/5ypWAEFPqC7tTbmcHS1vBp1eWsbk5iXk2LVbumBHSG+J6cp+IrVvAfvJK5EAJliBrqTXIdc07cjDZ8pxVuVS64u84u2lkKg0bSoFZLl/pHiKwLhRVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312130; c=relaxed/simple;
	bh=QNwceMSVmMF1Nwg0Ks3Dq86yFnaGmtYCWAfbiAZhQVA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TlJASgtZtnecHNcWPWhQlK6r+J1ZQpUZK5m5M4f7dLrcNPhcjOk5MKG/P6mXPptc4gFH5ymJADBGRil79Z7Y76f3EZU8DmNWKjjOqHr4QcYHl+zYzNZkBjIYqe9xqNr5m9zQkmuFa5zu4WaC9QJyWMbML4N8wtvapXgYBLM9k5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BZm5War7; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2d09d495c6cso904307fac.3
        for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751312127; x=1751916927; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSnBBrW7DyQ9uDD3D8W9h8fjOrHlTZaIJ8+vrX+84dc=;
        b=BZm5War71MaHdwNXfnbyn8EWVV08/8zVwr2fc7uDPEXEvJyFM8n2ZZMljxyQGsXEN2
         JHBArk5vN0mUzyFWVOaWhmvfbapBB7kZA3vextrK82N1vG71vnFY0XReqeN+gZxOE1uQ
         GEqIt0zE0IAoEvgaQQclbW2clY+hRVKbXPpD0+J6Pd7Tuo+ySzJqg+MBu0n60rZnctfA
         FWDiwbFViBOrBc1D8rUgwX/8EFpsuUjBO9+xbGJmIlqzMN6dNmsDjqyw2GTsWEtdFXaO
         YDOKtiepkGIH34Yom+lR8J4EG0NRfAsEwyvdKDt4cv7eN1A+6TaVUUpP0PM9YMbxW9XJ
         0ckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751312127; x=1751916927;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSnBBrW7DyQ9uDD3D8W9h8fjOrHlTZaIJ8+vrX+84dc=;
        b=jludpHYiBFM8rdfUsrDamV+66JDEagt8SnaG1pmMZ3E3msPtOPe4smVpYrJq8va2o/
         R89SdBup1S3mHns3ejL47Lizuu2PQLKuKP0M2a/C6XEwIGighKCw6Hl0vUvNCAUWCXvo
         /T5Uo0l4f4hkI6nioruMMnLO8HzbRb7ktSUTJrw2+8aRQZCX04b/1qvf0UKzjiafYXWf
         SJKtYguOpnDHaugMDjZisVXs0oa5g7J7QeYrXoWvAYkZ4PShh2C6k5CTKaWlik+WF4KN
         QJXYTPvBD02Bh08/K0f4dKXNyUNyaQWNXQY7fpbTScLDLd+z8jU8/qIR//do/vKeHb/F
         LSqw==
X-Forwarded-Encrypted: i=1; AJvYcCWSRxkEmruO1NRpEKE/kCsY7GRI5BIRBK7FP4tPUwwbl8hMhMjxqEIp/kgTlVi7GViTiM5fdUwVGpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykbZuOZ4kms/uYa30vZmRI1p9zRWyQlG54sK6cq+Wx7DuTv2mi
	NmdtYlaMq1YD5P912WWYcU6mWIMZg+9qsfxorGWSLvKxDZayZTpiQg6cryVDpevCaE0=
X-Gm-Gg: ASbGnctWbNfO2MTLKJzVElyH84mfq1LucaHBxq/AKc/xVJpQU7b42CjTw77VsPKQ+HI
	gZE6ydBb5gBlONZKxhsFhDrZBqadVIrnkr9c8txhFM+vcVsuTZNaXvrF3ZMgFrKMOWzxTT9MNok
	xYxlMlmUlkgQPR/xUUmO+KeDIhTHOaVuclVYmgh1vPnClqFOM4BhEmO0zhb9zKic45c7ye6Axb1
	Bsa5b5Nt3XE9kcp93X5Xdx1qI9pb3eJd1RECR2HjsW49/5Qezmc8Q1ZsuQYXatjGLP+pKSF9jXS
	Jnadey1cX/gJBxv9wMv2Ro73FAh4I4pzwIPlkrtS+SUNk5NM4AR/EFfZ/d9Mtisdzlq16kUGFev
	6q4Y=
X-Google-Smtp-Source: AGHT+IFjeReXBA3k7+eClk/ifIE93Uzbc7oaZBkcYmdYTh/N0ppG05eqByPpmkkuYUzt5s/KtcZ0Xw==
X-Received: by 2002:a05:6870:783:b0:2eb:adf2:eb2 with SMTP id 586e51a60fabf-2efed7a2a73mr9014336fac.36.1751312126689;
        Mon, 30 Jun 2025 12:35:26 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:49cc:1768:3819:b67])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2efd50f7f6asm2908403fac.36.2025.06.30.12.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 12:35:26 -0700 (PDT)
Date: Mon, 30 Jun 2025 14:35:25 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: stm32: delete stray tabs in stm32h7_spi_data_idleness()
Message-ID: <2033b9fa-7b0f-4617-b94e-7b0a51c5c4b1@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These lines were indented one tab more than they should be.  Delete
the stray tabs.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 3d20f09f1ae7..afb54198bde7 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1895,8 +1895,8 @@ static void stm32h7_spi_data_idleness(struct stm32_spi *spi, struct spi_transfer
 		if (spi_delay_ns) {
 			dev_warn(spi->dev, "Overriding st,spi-midi-ns with word_delay_ns %d\n",
 				 spi_delay_ns);
-				spi->cur_midi = spi_delay_ns;
-			}
+			spi->cur_midi = spi_delay_ns;
+		}
 	} else {
 		spi->cur_midi = spi_delay_ns;
 	}
-- 
2.47.2


